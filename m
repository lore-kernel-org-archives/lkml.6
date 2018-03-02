Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuGQR9A0pzf+3Ug0gduxf4TgmvTULqJk7siSRWYoMcI6WVepw5erY+UTxff14rNbToCShl5
ARC-Seal: i=1; a=rsa-sha256; t=1519981396; cv=none;
        d=google.com; s=arc-20160816;
        b=oC5pJNqeBLbWc2GEOUaytVOg0r1b9xTLhEXsM5vUkLmOCUZPiV50+s66nGfm4i43E6
         k9ZXT3NXBi2XmHwja6CfiuxsYK5qBHtYRUCimhsJuv7ufn1V7ga05qEORvjcGeuPEg6r
         e+nxERZzkYiFvCiv1KFCkEfmCk4whrSIzthLvnv75pspqJMW8OHFavXneQB192cpUcEL
         jN/n4PdOYVKJDxcAHv7Deq/A/TWvVyso6j+Ibd5xEYng7Xo5Y2ym9xNz4ef3l8XkjHZC
         2fBYxeZidgIBOxcqXHqfQ1CrsJ6cxGMcUYadiHkWBDP4kyO1VvZStGGiMAxLezNz+pMr
         K5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8N/h2hn20KUvzNJOjooK1mXohmiULaL20df/aK1uxac=;
        b=mCfDZpi4ft9NDAMmEA11A6+UYZxzCeidX2KPguHjZWniv/xFUwhSfLAPkoAkUwNH6n
         6dAanA9jrbt4uxsllWyIDpbe8dVjKJ/DKftNIygMYu7rn62wSPcH/Z9ycKi1Asy3KBU9
         PbZogMfr4NoaxYybgW6F0QWGBa1AowPaRUlU1nuxuF4txfbpv6r6C9jJ9uDVGQgluGCt
         ctQG3CsdAH9bWtVyin0pugG+S0vLulY7H3Ci41OcakcMfBc+IXMDw3rkzDdVIZE4p7zG
         Q2HbKR87ITaVqDRd/yQMWApSUTgzD6j6FMb339JD+lKULBX9jXS7em1Abz/Nnj8qyI/x
         p9HQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tommi Rantala <tommi.t.rantala@nokia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andi Kleen <ak@linux.intel.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 061/115] perf/x86/intel: Plug memory leak in intel_pmu_init()
Date: Fri,  2 Mar 2018 09:51:04 +0100
Message-Id: <20180302084506.350289588@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816012896187188?=
X-GMAIL-MSGID: =?utf-8?q?1593816012896187188?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>


[ Upstream commit 7ad1437d6ace0e450a6c1167720608ad660b191d ]

A recent commit introduced an extra merge_attr() call in the skylake
branch, which causes a memory leak.

Store the pointer to the extra allocated memory and free it at the end of
the function.

Fixes: a5df70c354c2 ("perf/x86: Only show format attributes when supported")
Reported-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3847,6 +3847,8 @@ static struct attribute *intel_pmu_attrs
 
 __init int intel_pmu_init(void)
 {
+	struct attribute **extra_attr = NULL;
+	struct attribute **to_free = NULL;
 	union cpuid10_edx edx;
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
@@ -3854,7 +3856,6 @@ __init int intel_pmu_init(void)
 	unsigned int unused;
 	struct extra_reg *er;
 	int version, i;
-	struct attribute **extra_attr = NULL;
 	char *name;
 
 	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
@@ -4294,6 +4295,7 @@ __init int intel_pmu_init(void)
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
 		extra_attr = merge_attr(extra_attr, skl_format_attr);
+		to_free = extra_attr;
 		x86_pmu.cpu_events = get_hsw_events_attrs();
 		intel_pmu_pebs_data_source_skl(
 			boot_cpu_data.x86_model == INTEL_FAM6_SKYLAKE_X);
@@ -4401,6 +4403,7 @@ __init int intel_pmu_init(void)
 		pr_cont("full-width counters, ");
 	}
 
+	kfree(to_free);
 	return 0;
 }
 
