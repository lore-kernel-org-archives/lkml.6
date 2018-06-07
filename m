Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dVLrKGM9GVvzQAAAmS7hNA
	; Thu, 07 Jun 2018 14:12:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 973DD608BA; Thu,  7 Jun 2018 14:12:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 22C27602FC;
	Thu,  7 Jun 2018 14:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22C27602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933263AbeFGOMt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:12:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:63462 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932520AbeFGOMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:12:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 07:12:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="48072335"
Received: from um.fi.intel.com (HELO um) ([10.237.72.212])
  by orsmga006.jf.intel.com with ESMTP; 07 Jun 2018 07:12:40 -0700
Received: from ash by um with local (Exim 4.91)
        (envelope-from <alexander.shishkin@linux.intel.com>)
        id 1fQveX-0005Ha-V7; Thu, 07 Jun 2018 17:12:38 +0300
Date: Thu, 7 Jun 2018 17:12:37 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Luwei Kang <luwei.kang@intel.com>
Cc: kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, chao.p.peng@linux.intel.com,
        thomas.lendacky@amd.com, bp@suse.de, Kan.liang@intel.com,
        Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, mathieu.poirier@linaro.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, david@redhat.com,
        bsd@redhat.com, yu.c.zhang@linux.intel.com, joro@8bytes.org
Subject: Re: [PATCH v9 10/12] KVM: x86: Implement Intel Processor Trace MSRs
 read/write emulation
Message-ID: <20180607141237.ruhg44wuepkf4nhz@um.fi.intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
 <1526964735-16566-11-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526964735-16566-11-git-send-email-luwei.kang@intel.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 12:52:13PM +0800, Luwei Kang wrote:
> +	/*
> +	 * Any MSR write that attempts to change bits marked reserved will
> +	 * case a #GP fault.
> +	 */
> +	if (data & vmx->pt_desc.ctl_bitmask)
> +		return 1;
> +
> +	/*
> +	 * Any attempt to modify IA32_RTIT_CTL while TraceEn is set will
> +	 * result in a #GP unless the same write also clears TraceEn.
> +	 */
> +	if ((vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) &&
> +		((vmx->pt_desc.guest.ctl ^ data) & ~RTIT_CTL_TRACEEN))
> +		return 1;
> +
> +	/*
> +	 * WRMSR to IA32_RTIT_CTL that sets TraceEn but clears this bit
> +	 * and FabricEn would cause #GP, if
> +	 * CPUID.(EAX=14H, ECX=0):ECX.SNGLRGNOUT[bit 2] = 0
> +	 */
> +	if ((data & RTIT_CTL_TRACEEN) && !(data & RTIT_CTL_TOPA) &&
> +		!(data & RTIT_CTL_FABRIC_EN) &&
> +		!pt_cap_decode(vmx->pt_desc.caps, PT_CAP_single_range_output))
> +		return 1;

Ah, I see. But afaict this is still wrong: PT_CAP_single_range_output is
only about allowing !RTIT_CTL_TOPA, FABRIC_EN should be checked separately
against the new capability that you added in 4/12.

Regards,
--
Alex
