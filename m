Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeEDKaF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:30:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:37558 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEDKaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:30:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,362,1520924400";
   d="scan'208";a="43059825"
Date: Fri, 4 May 2018 13:29:58 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Luwei Kang <luwei.kang@intel.com>
Cc: kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, joro@8bytes.org, peterz@infradead.org,
        chao.p.peng@linux.intel.com
Subject: Re: [PATCH v7 09/13] KVM: x86: Implement Intel Processor Trace
 context switch
Message-ID: <20180504102958.u6c3mqackl4kzd54@um.fi.intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
 <1525349323-9938-10-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525349323-9938-10-git-send-email-luwei.kang@intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 08:08:39PM +0800, Luwei Kang wrote:
> +static void pt_guest_enter(struct vcpu_vmx *vmx)
> +{
> +	if (pt_mode == PT_MODE_HOST || pt_mode == PT_MODE_HOST_GUEST)
> +		rdmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
> +
> +	if (pt_mode == PT_MODE_HOST_GUEST &&
> +		vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
> +		wrmsrl(MSR_IA32_RTIT_CTL, 0);
> +		pt_save_msr(&vmx->pt_desc.host, vmx->pt_desc.range_cnt);
> +		pt_load_msr(&vmx->pt_desc.guest, vmx->pt_desc.range_cnt);
> +	}
> +}
> +
> +static void pt_guest_exit(struct vcpu_vmx *vmx)
> +{
> +	if (pt_mode == PT_MODE_HOST_GUEST &&
> +		vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
> +		pt_save_msr(&vmx->pt_desc.guest, vmx->pt_desc.range_cnt);
> +		pt_load_msr(&vmx->pt_desc.host, vmx->pt_desc.range_cnt);
> +	}
> +
> +	if (pt_mode == PT_MODE_HOST || pt_mode == PT_MODE_HOST_GUEST)
> +		wrmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
> +}

This means that a host PT event won't get the guest traces and won't get
any notification as to what'd happened or why. At the minimum we need to
send a PARTIAL AUX record at the pt_guest_enter(), when we turn the host
tracing off.

Regards,
--
Alex
