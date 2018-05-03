Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeECLFR convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:05:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:6508 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbeECLFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:05:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="52065466"
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>
Subject: RE: [PATCH v7 05/13] perf/x86/intel/pt: Introduce a new function to
 get capability of Intel PT
Thread-Topic: [PATCH v7 05/13] perf/x86/intel/pt: Introduce a new function
 to get capability of Intel PT
Thread-Index: AQHT4sefaepgQr78WUqju+HNtlv5nqQdTXEAgACIG+A=
Date: Thu, 3 May 2018 11:04:52 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167F6DDCE@SHSMSX101.ccr.corp.intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
 <1525349323-9938-6-git-send-email-luwei.kang@intel.com>
 <20180503105032.h73n5lcrwkdbahgm@um.fi.intel.com>
In-Reply-To: <20180503105032.h73n5lcrwkdbahgm@um.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmUzNjBhNTAtYTE5MC00OWYxLTk5MDItMDk3ZmQ0M2RlYjIzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJuYlpCcDZ3cG1taWpuaWthZzBmd3JoNTJqcVwvU1gwSGlCY0xJcWRDZTlBQmh2R3RqVnVhblRqMTk0aXVvdnh1VyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > New function __pt_cap_get() will be invoked in KVM to check if a
> > specific capability is availiable in KVM guest.
> > Another function pt_cap_get() can only check the hardware capabilities
> > but this may different with KVM guest because some features may not be
> > exposed to guest.
> 
> Do we really need both in KVM?

Yes, KVM need get host capability to estimate if can expose this feature to guest and get guest capability to confirm if some bits of MSRs are accessible.

Thanks,
Luwei Kang

> 
> > diff --git a/arch/x86/include/asm/intel_pt.h
> > b/arch/x86/include/asm/intel_pt.h index 2de4db0..3a4f524 100644
> > --- a/arch/x86/include/asm/intel_pt.h
> > +++ b/arch/x86/include/asm/intel_pt.h
> > @@ -27,9 +27,11 @@ enum pt_capabilities {  #if
> > defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)  void
> > cpu_emergency_stop_pt(void);  extern u32 pt_cap_get(enum
> > pt_capabilities cap);
> > +extern u32 __pt_cap_get(u32 *caps, enum pt_capabilities cap);
> 
> I'd call it something like pt_cap_decode().
