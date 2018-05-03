Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751493AbeECMJi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:09:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:56112 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbeECMJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:09:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="225490995"
Date: Thu, 3 May 2018 15:09:28 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>, kvm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        rkrcmar@redhat.com, linux-kernel@vger.kernel.org, joro@8bytes.org,
        peterz@infradead.org, chao.p.peng@linux.intel.com
Subject: Re: [PATCH v7 06/13] KVM: x86: Add Intel Processor Trace
 virtualization mode
Message-ID: <20180503120928.gsqwreqnu5sllzw2@um.fi.intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
 <1525349323-9938-7-git-send-email-luwei.kang@intel.com>
 <20180503113223.x2ykby6wglppgdwf@um.fi.intel.com>
 <c44f948b-21ab-fbcf-4d8c-eb426684814d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c44f948b-21ab-fbcf-4d8c-eb426684814d@redhat.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 01:52:16PM +0200, Paolo Bonzini wrote:
> On 03/05/2018 13:32, Alexander Shishkin wrote:
> >> +static inline bool cpu_has_vmx_pt_use_gpa(void)
> >> +{
> >> +	return vmcs_config.cpu_based_2nd_exec_ctrl & SECONDARY_EXEC_PT_USE_GPA;
> >> +}
> > 
> > I can deduce the meaning of the previous one, but not this one, and there's
> > no explanation.
> 
> Within KVM, GPA always means guest physical address.

I see, thanks.

> >> +	if (pt_mode == PT_MODE_SYSTEM)
> >> +		vmexit_control &= ~(VM_EXIT_CLEAR_IA32_RTIT_CTL |
> >> +				    VM_EXIT_PT_CONCEAL_PIP);
> > 
> > Ok, so what we really want to know is: is there an encompassing PT
> > event on this cpu when we go into VMLAUNCH/VMRESTORE, right?
> > We can find this out from the pt_ctx and avoid the pt_mode entirely.
> > IOW, instead of having the 3 modes that you describe at the top, you
> > can use something like the following:
> > 
> > 1. Do we have an event in pt_ctx?
> >  * No -> Set up the context for VMX.
> >  * Yes -> 2. Is attr.exclude_guest set?
> >              * No -> Guest trace goes to the host's buffer, do nothing.
> > 	     * Yes -> Set up/switch the context for VMX.
> 
> Can you explain this more clearly?

Let's see; in the intel_pt driver we have a per-cpu PT "context", from which
we can tell if there is a host event that wants to trace the guest. This
should provide enough information to make a decision whether we want to
context switch PT MSRs or not on the spot, instead of having a module
parameter.

Regards,
--
Alex
