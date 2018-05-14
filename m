Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpzvHVIydKSKSUqH4Vplft+Kine8YrAuI5JHbzJ6r7jyGSf3vMPWaw1jN5IfK5CVcH3IkHP
ARC-Seal: i=1; a=rsa-sha256; t=1526282396; cv=none;
        d=google.com; s=arc-20160816;
        b=ATt79FuF+Jjvvootmbed9ysIatVitGYFgCYq9ha9TteobeGlprgtBQGPkp9wMH39CY
         JBfsBhxG4W1tDZYUa+vG3/50Hl328zkOLEOOkqEVQdnji1vkf4lNAcD+qMPrs422ryJ5
         PHR958p89kt91qE9EcgekQD+qpGK4lFMMvsW54MQiVH9NfENY/Ns3SQpmGQJnkJc6Fhh
         cRM39bH8NKpDs7MBYoSkobkNHQ9sJu2QQxnR1Uv1H0S1w0WwZOO2QMMkdlikRZXxXvs8
         LVJDlalWufa1JdCEtOOw/cBE9mpJu+SyB1bm6FdeLpI5t9LmvVeolM/sKE+CbKv8a+U+
         CQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=a6KI1gIF8jCOpzGNI/YP1UohhiE3JD+xSvwwip8hxxg=;
        b=FuU77av345Z7RmRznZadH3A33fUIlJuZdCJiRaTXpRU8hBGnJwLSFWInGwZ6EopDTw
         pxFywscS7h6DvTcLbIEO7M9mdYRSBeSFe3P33JbFZFvGeGNLkvGPExkRPQz+CBJ4/IH0
         lCy1baWHI6aQft+0UiygHCGk4eBtGLOzrgyV6tP24xO6ANcILJ7SGr5AsCd5DFIjMfoj
         FIKEyj5l16DnIMOsBy02ekRgVW40NY/PQL64OOdflMLSdcjW/Hw4HufKHj2DkOEweLUC
         tEDp2fi8P4wEJnMMlmc5DTX9dGpTtsqIIRHiRrsiJ7b4m1ddBuwH2wxZYaoRTS9CjJWc
         B7rQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vFYZ3Lmp;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vFYZ3Lmp;
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
Subject: [PATCH 4.16 72/72] perf/x86: Fix possible Spectre-v1 indexing for x86_pmu::event_map()
Date: Mon, 14 May 2018 08:49:29 +0200
Message-Id: <20180514064828.121897585@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600422464525970940?=
X-GMAIL-MSGID: =?utf-8?q?1600423090479059529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
