Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv5KDs9GgpQtmzB/IfOt7NIRE9jyEl+oDdhbyPPB/ZTSGoQ5bWH8XApjelk0f6DQQejrdfE
ARC-Seal: i=1; a=rsa-sha256; t=1520955030; cv=none;
        d=google.com; s=arc-20160816;
        b=hNAlIJ9C7nYGnc0zu6n0yBFexFJa2qVe7ZUdJyRV3xKqCl5KN1mxqutcWHnYh/4nNk
         xYTucYh8084OqlpHN+l+0d/jnIbrxybakKaOdBNtYfXwBNTAOHVig1DF68LUKqbq+JIh
         Fony7ZHcYlVS7A47qVq7gkdS7eIqQjusDT6jkWFXvkoeCCSwMj0MoDa+NCewbXjKRwk+
         Ya31u5xwLdor9rJxDX1JnnrA+NwNC9r97w/+81BG52hAWQd7tCZ4GzZRFVOHbiCHBLaS
         qEg0+5jZXyNB/84XiH/FJAOqyJDDa95hLWj/5xfVt24TM3nufXpV5Px1NX1tyzRni6Zy
         Qy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M7wcaG2OZIU+sYZxUb5RIUv0sVul3N2fLQhp4bHJXK0=;
        b=fl4umSwiqADIc2qQVKyZb9p0uvcJAB03KLfqiLJXAljQ4NPa9aq5iki1Yl7rsdvMa0
         1dgfIq7qyAZzWm/q8FG/z+9yNa8kTmh5hjFpvXdkfnqRdTCmaKN8gV1aYMT6zTbj12D/
         t+1SfuI7Zk0LLPrQnHTI3q8WmFaxxAOLDP28Uk4M8rtjmVMk8ayKSQovwP+kXShXME5K
         hPH9Q3urS88Ll0SJCUoFVGrk4HFMk8sHKcQ7II6q+j2CWNjP3IKjP61cyDCORE0hlMKI
         vg1p3B7lWTp9lo6SJMxQucIdUnVmJcG94nZrs/WbVABr7QYxBdoiiuJlbjyxYnlmw5gB
         WW9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Wang Nan <wangnan0@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.15 064/146] perf tools: Fix trigger class trigger_on()
Date: Tue, 13 Mar 2018 16:23:51 +0100
Message-Id: <20180313152325.626383901@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836942562590972?=
X-GMAIL-MSGID: =?utf-8?q?1594836942562590972?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit de19e5c3c51fdb1ff20d0f61d099db902ff7494b upstream.

trigger_on() means that the trigger is available but not ready, however
trigger_on() was making it ready. That can segfault if the signal comes
before trigger_ready(). e.g. (USR2 signal delivery not shown)

  $ perf record -e intel_pt//u -S sleep 1
  perf: Segmentation fault
  Obtained 16 stack frames.
  /home/ahunter/bin/perf(sighandler_dump_stack+0x40) [0x4ec550]
  /lib/x86_64-linux-gnu/libc.so.6(+0x36caf) [0x7fa76411acaf]
  /home/ahunter/bin/perf(perf_evsel__disable+0x26) [0x4b9dd6]
  /home/ahunter/bin/perf() [0x43a45b]
  /lib/x86_64-linux-gnu/libc.so.6(+0x36caf) [0x7fa76411acaf]
  /lib/x86_64-linux-gnu/libc.so.6(__xstat64+0x15) [0x7fa7641d2cc5]
  /home/ahunter/bin/perf() [0x4ec6c9]
  /home/ahunter/bin/perf() [0x4ec73b]
  /home/ahunter/bin/perf() [0x4ec73b]
  /home/ahunter/bin/perf() [0x4ec73b]
  /home/ahunter/bin/perf() [0x4eca15]
  /home/ahunter/bin/perf(machine__create_kernel_maps+0x257) [0x4f0b77]
  /home/ahunter/bin/perf(perf_session__new+0xc0) [0x4f86f0]
  /home/ahunter/bin/perf(cmd_record+0x722) [0x43c132]
  /home/ahunter/bin/perf() [0x4a11ae]
  /home/ahunter/bin/perf(main+0x5d4) [0x427fb4]

Note, for testing purposes, this is hard to hit unless you add some sleep()
in builtin-record.c before record__open().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: stable@vger.kernel.org
Fixes: 3dcc4436fa6f ("perf tools: Introduce trigger class")
Link: http://lkml.kernel.org/r/1519807144-30694-1-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/trigger.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/tools/perf/util/trigger.h
+++ b/tools/perf/util/trigger.h
@@ -12,7 +12,7 @@
  * States and transits:
  *
  *
- *  OFF--(on)--> READY --(hit)--> HIT
+ *  OFF--> ON --> READY --(hit)--> HIT
  *                 ^               |
  *                 |            (ready)
  *                 |               |
@@ -27,8 +27,9 @@ struct trigger {
 	volatile enum {
 		TRIGGER_ERROR		= -2,
 		TRIGGER_OFF		= -1,
-		TRIGGER_READY		= 0,
-		TRIGGER_HIT		= 1,
+		TRIGGER_ON		= 0,
+		TRIGGER_READY		= 1,
+		TRIGGER_HIT		= 2,
 	} state;
 	const char *name;
 };
@@ -50,7 +51,7 @@ static inline bool trigger_is_error(stru
 static inline void trigger_on(struct trigger *t)
 {
 	TRIGGER_WARN_ONCE(t, TRIGGER_OFF);
-	t->state = TRIGGER_READY;
+	t->state = TRIGGER_ON;
 }
 
 static inline void trigger_ready(struct trigger *t)
