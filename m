Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELse575AeUaIpaojndakR+WriJWOzjb/IkugK5m5fBeo/fFXiH5ArtNpEGYPZJtQPVf+BMUx
ARC-Seal: i=1; a=rsa-sha256; t=1521483139; cv=none;
        d=google.com; s=arc-20160816;
        b=mgYWIxc7/Bykd2VAPgPsw/W0HfWC/n0TVtwnXb5z06nbnk9Ug2+gL44bq86Z3neSCR
         SJRI5s52ZLd+f1MDKoTtqYhmtilA7rnaqV8q4qniCIe2jG9sB/9D9hk1h3JmyGfhn8Ef
         W1po+6v2qL7/rxXVWPm8AWw8b1F96O8oOKrZx7dFjF9UkiosjCfsSFNEHgTfaR214NUo
         K++26304w6k0F1SiYplzsUstU8s8X/qkOJTfAqOzRlGldnZeB0CNMEz/hE8te+Oi8llf
         QNVsNQxW29VPYJouwUVd+DWw0PXy2s6lwDNWpSM98jXNEHnE5Mk/xkxAIJAWNVodOdx/
         XoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bk1HLHx+YB244Ttet9fjA0bfhtLlwUIwEwChn8HYx2E=;
        b=Ux+D+i8sPAfNgEtitWfLPRsVtND9FNNygNnvezYMk/x35jKEOwlkV/LeAzxj5gByKi
         kibT2IajoClpIm1TaI3BgiFqFxyLmnJENIjGxF4VNsQYbTHIrTG0tPmm4uZzN4BLB/vS
         wYGT9EWvjg6JJLLxB+bs1dRoRA0T7jr05rhmDppRh7dZYgKbPPRNQelejHTfZo0jK/67
         0fLVjfceYh6EqBEFTgEuA7AlAslPO3K+X+3CWb7Fg8ToAh27xFb+5h01V0g+m7IIXYTS
         7Hrk8Zshda+B3MDedGwK0oVz4XYgbiuoVpQLQEGxhAyXV61vAjjZzL8IzRnFK4xtiaYS
         hzTQ==
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
Subject: [PATCH 4.4 014/134] perf tools: Make perf_event__synthesize_mmap_events() scale
Date: Mon, 19 Mar 2018 19:04:57 +0100
Message-Id: <20180319171851.147448695@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390579832084983?=
X-GMAIL-MSGID: =?utf-8?q?1595390705091096907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -234,8 +234,8 @@ int perf_event__synthesize_mmap_events(s
 	if (machine__is_default_guest(machine))
 		return 0;
 
-	snprintf(filename, sizeof(filename), "%s/proc/%d/maps",
-		 machine->root_dir, pid);
+	snprintf(filename, sizeof(filename), "%s/proc/%d/task/%d/maps",
+		 machine->root_dir, pid, pid);
 
 	fp = fopen(filename, "r");
 	if (fp == NULL) {
