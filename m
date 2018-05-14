Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqxOfaD9xzJmohl++v2hhR3wy96xLJw7Zs/s6eWwIInJh8tUn+e14IxhyTJ665HDcZosDKn
ARC-Seal: i=1; a=rsa-sha256; t=1526282274; cv=none;
        d=google.com; s=arc-20160816;
        b=rjILOiMKrzRS2YVq7yM1BJ14VVhWi83VQoU0U+H3apWP3gxx0DOdb2y0EzBOqETNjW
         O3Obp9PZf1LlT1MXGHrZ8ycYuRb9avKlNerZt6iWLc3/2JvoNdt3CSkewSZ5Z8OU2t3t
         qStjT0SzNWeABygnh5DlfjsXuoT5z1ZZ9qPJMtE6BP2PIjvTBv21TwQchgTYux2OS7BX
         51TB5ApvCGs/UnT1HaxywQVMkLAB6WLWbnOnroRZxfxt5EW1X21SWnLdRCFKxhgUw6Wm
         iZFAp2iPXp/PpeuIalbHPXUYIVgFBmMqdEelpZL8h0+m9OWXi52y6ICY73W6BjX5NZt3
         Hr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=sZ6aLd1Rq76u12AZxNvRSAPBjrVvxHv2elVBIvcEYXc=;
        b=BmfpHsvwLv2w3UVxI6yao7J5QHXpuPLRCfY2N5VlW/wUureLOIqfOKt7FV4+oEukcY
         uF3Lo5gttSfYoXgJ8qsEWt5ZowuwFrHn5kClAVQUQrnkIODeMBdBn0OqX5A07nafwlPb
         0hqkURKoSZRxD1fFswZDZjBJ/f+jdd7GGpNVR6SijW0Z9LU57e3Gb2UOw0v5E3nikIM0
         KRwQNERiWRRw+ddY7UVsTMxMfYknT0neVUhqlCsBTseS/kT/I/kGBr1fWhwx77xzOwTo
         7kAGGeylLKLx4DU+I2mucG/2KMhmtf3XyWJk9epjBLW6i05NL9a7iz/ZNz0jsI9PDK2j
         89/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=WkxTUzBs;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=WkxTUzBs;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vince Weaver <vincent.weaver@maine.edu>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 36/36] perf/x86: Fix possible Spectre-v1 indexing for x86_pmu::event_map()
Date: Mon, 14 May 2018 08:49:10 +0200
Message-Id: <20180514064807.048279765@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422464525970940?=
X-GMAIL-MSGID: =?utf-8?q?1600422962091191401?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 46b1b577229a091b137831becaa0fae8690ee15a upstream.

> arch/x86/events/intel/cstate.c:307 cstate_pmu_event_init() warn: potential spectre issue 'pkg_msr' (local cap)
> arch/x86/events/intel/core.c:337 intel_pmu_event_map() warn: potential spectre issue 'intel_perfmon_event_map'
> arch/x86/events/intel/knc.c:122 knc_pmu_event_map() warn: potential spectre issue 'knc_perfmon_event_map'
> arch/x86/events/intel/p4.c:722 p4_pmu_event_map() warn: potential spectre issue 'p4_general_events'
> arch/x86/events/intel/p6.c:116 p6_pmu_event_map() warn: potential spectre issue 'p6_perfmon_event_map'
> arch/x86/events/amd/core.c:132 amd_pmu_event_map() warn: potential spectre issue 'amd_perfmon_event_map'

Userspace controls @attr, sanitize @attr->config before passing it on
to x86_pmu::event_map().

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -26,6 +26,7 @@
 #include <linux/cpu.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/nospec.h>
 
 #include <asm/apic.h>
 #include <asm/stacktrace.h>
@@ -423,6 +424,8 @@ int x86_setup_perfctr(struct perf_event
 	if (attr->config >= x86_pmu.max_events)
 		return -EINVAL;
 
+	attr->config = array_index_nospec((unsigned long)attr->config, x86_pmu.max_events);
+
 	/*
 	 * The generic map:
 	 */
