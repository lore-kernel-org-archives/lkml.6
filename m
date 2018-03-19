Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932365AbeCSHRR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 03:17:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:34010 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932134AbeCSHRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 03:17:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,329,1517904000";
   d="scan'208";a="43254018"
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 03/11] perf/x86/intel/pt: Introduce a new function to
 get the capability of Intel PT
Thread-Topic: [PATCH v5 03/11] perf/x86/intel/pt: Introduce a new function
 to get the capability of Intel PT
Thread-Index: AQHTtCVARCdsr0U3aEqOEtIdb43mBqPSqd+AgASQlpA=
Date: Mon, 19 Mar 2018 07:17:07 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167EFC0C8@SHSMSX101.ccr.corp.intel.com>
References: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
 <1520165241-15819-4-git-send-email-luwei.kang@intel.com>
 <98515f5f-9c8a-8e1a-4fef-c9a8a0e9e8f5@redhat.com>
In-Reply-To: <98515f5f-9c8a-8e1a-4fef-c9a8a0e9e8f5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzE1MTNkZTMtYjliNy00M2JjLWEwM2YtOGM5NjQyYWU0MzAwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJrZXNOWFhLT0NTSTBKcHZhVzR5TDllN3RJcUxMdlJcL05lMnV5bUtjeFhxSTNiTTAzSlhpbFhyQWZ5b3Boc1JsWiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2J7HMYV018255

> > +u32 pt_cap_get_ex(u32 *caps, enum pt_capabilities cap) {
> > +	struct pt_cap_desc *cd = &pt_caps[cap];
> > +	u32 c = caps[cd->leaf * PT_CPUID_REGS_NUM + cd->reg];
> > +	unsigned int shift = __ffs(cd->mask);
> > +
> > +	return (c & cd->mask) >> shift;
> > +}
> > +EXPORT_SYMBOL_GPL(pt_cap_get_ex);
> > +
> 
> You should change pt_cap_get to use this function.  Also, "_ex" is not a very common suffix, so perhaps you can call it
> __pt_cap_get.
> 
> I don't have any other comments on patches 1-3, so when you resend we can ask the x86 maintainers for approval.
> 

Hi Paolo,
    Is that like this?

--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -76,14 +76,20 @@
        PT_CAP(psb_periods,             1, CPUID_EBX, 0xffff0000),
 };

-u32 pt_cap_get(enum pt_capabilities cap)
+u32 __pt_cap_get(u32 *caps, enum pt_capabilities cap)
 {
        struct pt_cap_desc *cd = &pt_caps[cap];
-       u32 c = pt_pmu.caps[cd->leaf * PT_CPUID_REGS_NUM + cd->reg];
+       u32 c = caps[cd->leaf * PT_CPUID_REGS_NUM + cd->reg];
        unsigned int shift = __ffs(cd->mask);

        return (c & cd->mask) >> shift;
 }
+EXPORT_SYMBOL_GPL(__pt_cap_get);
+
+u32 pt_cap_get(enum pt_capabilities cap)
+{
+       return __pt_cap_get(pt_pmu.caps, cap);
+}
 EXPORT_SYMBOL_GPL(pt_cap_get);

 static ssize_t pt_cap_show(struct device *cdev,
diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index 2de4db0..3a4f524 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -27,9 +27,11 @@ enum pt_capabilities {
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 void cpu_emergency_stop_pt(void);
 extern u32 pt_cap_get(enum pt_capabilities cap);
+extern u32 __pt_cap_get(u32 *caps, enum pt_capabilities cap);
 #else
 static inline void cpu_emergency_stop_pt(void) {}
 static inline u32 pt_cap_get(enum pt_capabilities cap) { return 0; }
+static u32 __pt_cap_get(u32 *caps, enum pt_capabilities cap) { return 0; }


Thanks,
Luwei Kang
