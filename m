Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpt+rZmTHOptEOmSEyj/3hLa28DZ0iVw8p+VXjVuWZfcyE75Z5yoFGwdZWGrfydLnWfdhdN
ARC-Seal: i=1; a=rsa-sha256; t=1524837884; cv=none;
        d=google.com; s=arc-20160816;
        b=RzqmOiSmydEOFcvoOMoBXbgIBv12RJXHy1WKiEXfQ6j08sk6YVAlWVB8mY2+z3vzTJ
         5KKNilaI97aBp+oV7NO4W0r8l5FQwdACXENSEV1e9XIxTqv5a3TaSOH2LgdiTj6UXOjS
         sHmFhsp0DPPlwoLNNWpuxQFh7EiiESo8WSLMX1YYwT/bjMbNMWsShBUdDbogRO+f/bD+
         2zSs3Dw/SPSqCsfVbDXHIFwHl43+ZzSxjIWXARy0Ug9Xz5ULJIriSTjzj7ch5mLkgoZ0
         Xy8yKM0JurDIofGDgDQQMmpwGJBVNVx7b9TwJblzAV5mS65IqBm3rzTBVxSpFpVE2Dou
         /QSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=jni9b+A83E0BeytYzgde98ADEv1X1baDDp4qc8QIvZY=;
        b=ayCU8CMmgzoOiLYn5QC7XO6ZtyCVMmwC6uYuHloKWIw8oxoJCNuxgmH1AdnoxwsUUi
         vUw8SmTA037CGpGTBFZLXe3XqVemxFTx2yAPLvXJGu5iR/WrBYvAS1oLg5MvU0BPmiYG
         o+NKaGzk9qNyJJYtxyDusJguZCwkIN4ZkMD2/rMvWYYGTy0WDaSwGCp/nVqLjtpwBB4U
         2QnNfSwqxbHcyBtpe9ILIf9dOP3DQ6uwlX+lciTEsZBGqK2/mLzyd4e/I2X+PGznahei
         2sQXgofvLJ0/81m3tYM2dhtfyqMXYsj7NB3lUM/Q0LImTYW2balQhNp/A+97oIekz8Go
         cr5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791B7218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+7c449856228b63ac951e@syzkaller.appspotmail.com,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <andi@firstfloor.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	syzkaller-bugs@googlegroups.com,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 19/74] perf: Fix sample_max_stack maximum check
Date: Fri, 27 Apr 2018 15:58:09 +0200
Message-Id: <20180427135710.702703557@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908409796598846?=
X-GMAIL-MSGID: =?utf-8?q?1598908409796598846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 5af44ca53d019de47efe6dbc4003dd518e5197ed upstream.

The syzbot hit KASAN bug in perf_callchain_store having the entry stored
behind the allocated bounds [1].

We miss the sample_max_stack check for the initial event that allocates
callchain buffers. This missing check allows to create an event with
sample_max_stack value bigger than the global sysctl maximum:

  # sysctl -a | grep perf_event_max_stack
  kernel.perf_event_max_stack = 127

  # perf record -vv -C 1 -e cycles/max-stack=256/ kill
  ...
  perf_event_attr:
    size                             112
    ...
    sample_max_stack                 256
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 4

Note the '-C 1', which forces perf record to create just single event.
Otherwise it opens event for every cpu, then the sample_max_stack check
fails on the second event and all's fine.

The fix is to run the sample_max_stack check also for the first event
with callchains.

[1] https://marc.info/?l=linux-kernel&m=152352732920874&w=2

Reported-by: syzbot+7c449856228b63ac951e@syzkaller.appspotmail.com
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: syzkaller-bugs@googlegroups.com
Cc: x86@kernel.org
Fixes: 97c79a38cd45 ("perf core: Per event callchain limit")
Link: http://lkml.kernel.org/r/20180415092352.12403-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/callchain.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -117,19 +117,22 @@ int get_callchain_buffers(int event_max_
 		goto exit;
 	}
 
+	/*
+	 * If requesting per event more than the global cap,
+	 * return a different error to help userspace figure
+	 * this out.
+	 *
+	 * And also do it here so that we have &callchain_mutex held.
+	 */
+	if (event_max_stack > sysctl_perf_event_max_stack) {
+		err = -EOVERFLOW;
+		goto exit;
+	}
+
 	if (count > 1) {
 		/* If the allocation failed, give up */
 		if (!callchain_cpus_entries)
 			err = -ENOMEM;
-		/*
-		 * If requesting per event more than the global cap,
-		 * return a different error to help userspace figure
-		 * this out.
-		 *
-		 * And also do it here so that we have &callchain_mutex held.
-		 */
-		if (event_max_stack > sysctl_perf_event_max_stack)
-			err = -EOVERFLOW;
 		goto exit;
 	}
 
