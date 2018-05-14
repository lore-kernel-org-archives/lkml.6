Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq3Z60cToSHnXSBrddJx9R3wT+Vs6kAWerkqp4aL2x++nShwLqPFhy57l7VxBhRFJ0GfYuN
ARC-Seal: i=1; a=rsa-sha256; t=1526282290; cv=none;
        d=google.com; s=arc-20160816;
        b=tfqIhlHWWC42oKKY8NDT/MW4jYng5S658o4pxFxwRIUDDrYfuD9owh42T8Rlpk/2Yw
         M1FgH8KIOBfw+n2mJPR7MWK3W91/SIh/5o/Wjc5NV2UQvMNkfgapJrahPiHgO87e810G
         y1KS8Qn93NmX2eaCTCNxzt6KEtToWnf/NxxGktEif00MaEWUO91dAwcQ8c0pxnsuooxn
         5+1MdMuvKUi4d3bhqxDe7OslYVlpgCYTEf33mKn1A1qdBYA1g9febXy8y7urb0FsFxJG
         Yb0XmlN8+p3trIP9+Pk9BlvxPoWSEyVW5AcC1msx1Kmgmbh4z39rttd4wpN0IfnswFma
         fXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=DDjiv8J3r1pwTHOLuXoTHn7uVBR9huvQMQIz7XyNHmw=;
        b=nzB5ySWmOsenO1+7wV4Xeu/ExXtj00RteiFMynaD7vePY1iLLm4zDm7poW+5RGTQQX
         lmXxi+y5MDFOrCw8MIuGndOyBwz3UmSXZ03DIjhcnaebMTE2S2Cp9urgvevRTr+Jg4YP
         h+M9qncSEA4TKkHSjcC43xRfkN41mVB6TfUOg/uudU3Xs54e2d7JxVUOSY4myPlvWxya
         6vAkNQJTgW3o6ML12yXl7dTp7VONcJ5GbGP6riZ6ACOPi8NOo01WbDxf+k2kqnbFkP/+
         h1zIcS4e1hk7TGbt5TFOmhddlhJ7prKcX2ueb0e6DiyB9B084hKuLArzBeNyUmSXGgxd
         8Waw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=q34Sgsjo;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=q34Sgsjo;
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
Subject: [PATCH 4.14 60/62] perf/x86: Fix possible Spectre-v1 indexing for x86_pmu::event_map()
Date: Mon, 14 May 2018 08:49:16 +0200
Message-Id: <20180514064819.830537656@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422464525970940?=
X-GMAIL-MSGID: =?utf-8?q?1600422978902773876?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -27,6 +27,7 @@
 #include <linux/cpu.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/nospec.h>
 
 #include <asm/apic.h>
 #include <asm/stacktrace.h>
@@ -424,6 +425,8 @@ int x86_setup_perfctr(struct perf_event
 	if (attr->config >= x86_pmu.max_events)
 		return -EINVAL;
 
+	attr->config = array_index_nospec((unsigned long)attr->config, x86_pmu.max_events);
+
 	/*
 	 * The generic map:
 	 */
