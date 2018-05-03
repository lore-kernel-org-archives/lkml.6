Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbeECM7f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:59:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:43553 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751064AbeECM7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:59:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="52089931"
Date: Thu, 3 May 2018 15:59:26 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: "Kang, Luwei" <luwei.kang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>
Subject: Re: [PATCH v7 05/13] perf/x86/intel/pt: Introduce a new function to
 get capability of Intel PT
Message-ID: <20180503125926.watdzpaleo27awuk@um.fi.intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
 <1525349323-9938-6-git-send-email-luwei.kang@intel.com>
 <20180503105032.h73n5lcrwkdbahgm@um.fi.intel.com>
 <82D7661F83C1A047AF7DC287873BF1E167F6DDCE@SHSMSX101.ccr.corp.intel.com>
 <20180503121301.nlbm4cotbv26tc7l@um.fi.intel.com>
 <82D7661F83C1A047AF7DC287873BF1E167F6DFFA@SHSMSX101.ccr.corp.intel.com>
 <349c6c61-6b6a-31b8-c8c5-24aed5716929@redhat.com>
 <82D7661F83C1A047AF7DC287873BF1E167F6E0B4@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E167F6E0B4@SHSMSX101.ccr.corp.intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 12:50:48PM +0000, Kang, Luwei wrote:
> > >> Can you elaborate on this, what information do we need besides
> > >> MSR_IA32_VMX_MISC[14]?
> > >
> > > Enable Intel PT in guest depend on SECONDARY_EXEC_PT_USE_GPA, EPT,
> > > MSR_IA32_VMX_MISC[14] and the capability of " PT_CAP_topa_output" on
> > > hardware. PT driver will return " -ENODEV" if hardware not support
> > > "PT_CAP_topa_output".
> > 
> > I actually don't understand why PT_CAP_topa_output matters for the purpose of enabling PT in the guest.  However you still need
> > __pt_cap_get() in the CPUID checks.
> 
> Hi Paolo,
> I think we should expose Intel Processor Trace to guest that can be detected and initialized. But without "PT_CAP_topa_output" Intel PT can't work in Linux.  So I add this feature as precondition. 
> About why need this check in driver I think Alexander may know the reason.

The driver only operates on ToPA at the moment, so if PT doesn't support
it, there's nothing for the driver to do. But other things, such as
simple_pt, might still be functional without CAP_topa_output, so it still
makes sense to virtualize it.

Regards,
--
Alex
