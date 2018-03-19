Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsq4tJJ8i1VN7StiKc/U2bAfF1j7MR9rS474RraHnRkHZ0sNz/hf48sFcSJfo2puUWT4q/6
ARC-Seal: i=1; a=rsa-sha256; t=1521483020; cv=none;
        d=google.com; s=arc-20160816;
        b=ZJCvJAUcs5ACJRgs+eRP3GkIeauCQoLitoQLP4O+eTdBz115oEZ2En5+KJbNjWkook
         6YadjaMWdA8yahjvsxN3iOUDsjQvhAsLdOJmam9roj+A+arBsuSqFvoVuUMsRcm1OuTq
         0ZFCEA0qnT0rutwpwR9DdyNfNfQnDKlSFLQ6YcF+LR4/73bB3+P3gKwqCfmxhvq+itAH
         KbUzAoreiRUbeaaEu8bVJUmLRV8m+Hkt8um8GUyxarE9+LWAQcrwQlYMIY+LmQnmyvEo
         mBpFX/D9HWeAmjquDweXW7MP84PUJlyo08RaRrl/KQcAX47WseGZ0i3Vu81tS2O1czfz
         O36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZhOPmIvDOpvfz02H5ADPheLOI/218iunbNS4N7l4vIU=;
        b=ScoKqPoVbnSWnUr98FVK5+0WaCfLEUuX3mQ624VqMbj2JtBQp6O4Ql37Y2t2Hu4jIr
         JzKHCybqMFdrHp9EhyY3e0Zkv2nXjAcuvlcKYpcE1BxK6uNQzRlF97Y1Q2zatSImZ12G
         PCryoKyaDMCWZmd3nwIpy57NHVtbk4QsgboQ12aWBCiWJvjdMLVpINJB+a9UdUA4Wrxn
         fC2D6kPc958r4/LisfMB4eWgaD8Kx//q+KhY2MHQeh2YvzXbbv7xsgrc9bd5iJF+h/vp
         N+bSth3bJG85aKoN5/tXbxHw8jLC3JX6P8/GdD35cLaj5Mg4d6EEQlglyIIR1es/DclH
         RA1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 06/68] perf tools: Make perf_event__synthesize_mmap_events() scale
Date: Mon, 19 Mar 2018 19:05:44 +0100
Message-Id: <20180319171828.814018415@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390579832084983?=
X-GMAIL-MSGID: =?utf-8?q?1595390579832084983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephane Eranian <eranian@google.com>


[ Upstream commit 88b897a30c525c2eee6e7f16e1e8d0f18830845e ]

This patch significantly improves the execution time of
perf_event__synthesize_mmap_events() when running perf record on systems
where processes have lots of threads.

It just happens that cat /proc/pid/maps support uses a O(N^2) algorithm to
generate each map line in the maps file.  If you have 1000 threads, then you
have necessarily 1000 stacks.  For each vma, you need to check if it
corresponds to a thread's stack.  With a large number of threads, this can take
a very long time. I have seen latencies >> 10mn.

As of today, perf does not use the fact that a mapping is a stack, therefore we
can work around the issue by using /proc/pid/tasks/pid/maps.  This entry does
not try to map a vma to stack and is thus much faster with no loss of
functonality.

The proc-map-timeout logic is kept in case users still want some upper limit.

In V2, we fix the file path from /proc/pid/tasks/pid/maps to actual
/proc/pid/task/pid/maps, tasks -> task.  Thanks Arnaldo for catching this.

Committer note:

This problem seems to have been elliminated in the kernel since commit :
b18cb64ead40 ("fs/proc: Stop trying to report thread stacks").

Signed-off-by: Stephane Eranian <eranian@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170315135059.GC2177@redhat.com
Link: http://lkml.kernel.org/r/1489598233-25586-1-git-send-email-eranian@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/event.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -167,8 +167,8 @@ int perf_event__synthesize_mmap_events(s
 	if (machine__is_default_guest(machine))
 		return 0;
 
-	snprintf(filename, sizeof(filename), "%s/proc/%d/maps",
-		 machine->root_dir, pid);
+	snprintf(filename, sizeof(filename), "%s/proc/%d/task/%d/maps",
+		 machine->root_dir, pid, pid);
 
 	fp = fopen(filename, "r");
 	if (fp == NULL) {
