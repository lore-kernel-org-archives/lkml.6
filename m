Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuoBHEtJ5h8AKTBXcP68TMpWe7ijNlyw7UO8eqHSQe4X32W2ee9o1ucbcZSXA/EU4/gDktY
ARC-Seal: i=1; a=rsa-sha256; t=1520955581; cv=none;
        d=google.com; s=arc-20160816;
        b=OSWmTB6sUue7CjQf4o9Jk/7bTk0jT/IPG9LGaiaKUKYvkvcK8Eftef7Fw4WNBs3WP+
         q6pBu5uEoaoQOy2k86P1lOtfvLn63hAt1aob+b6PjIEPjpxm00fsfATkA0dXc4O68Rv+
         mcvO+JbErsiRPUC7n9Q6SzXTOQ7xW+adVTCfwfKuPXJYR6ysEkTl/Gfn8fFpKQyEcIMS
         /lN/BASKscGM3LmlZgi8Rn5f9BPa347AvUox79Pa0VTwRuf9DWCSMToyceQfJQAoxSR3
         /goEQ5aeUw62eax25r2VuEh2rsOQfCquTs1mYdx8bRV7CwH/OkO2CoU7yQHukHjb02gG
         Ndsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1RQePxLzC+saqqz5nK+zSNS4b0Jd+n5/eilU/2q+FsA=;
        b=vFFZD/vkI7CaAb8M4aDnGdLVhXIsGcUC+X8C13PpvR7lfSdDSK3Bvdgr2dDesOrHae
         9reqjxcL3G9ihdjFZrjOZif7+cworODG6nmqAqOSMmUgvy80PsGspOLD2u0Bgia1WJMl
         oxbYVS85++re3OcbM9CvGDfN5Pz1ongHtbEvsSTbYjC2OIm90mvZuaiSqSM1oumphqg3
         vclcD2Gt2nXYxJqsaJoIo7NCR/Zz65aTBMHFPiHpL3S2qLVYKijN7jgzWqXcRDCTvR+N
         JARRjvtRUFTF5LuqZW5Ji99a87Pug5cBjrjLnKJ9GuRHdmFZSbIksY8+Ha9f+DELDffn
         /AOw==
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
Subject: [PATCH 4.14 099/140] perf tools: Fix trigger class trigger_on()
Date: Tue, 13 Mar 2018 16:25:02 +0100
Message-Id: <20180313152504.810772910@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836942562590972?=
X-GMAIL-MSGID: =?utf-8?q?1594837520115468982?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
