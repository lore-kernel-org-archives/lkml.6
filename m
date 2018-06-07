Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EzfuKiptGVv9UAAAmS7hNA
	; Thu, 07 Jun 2018 17:43:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0A2746089E; Thu,  7 Jun 2018 17:43:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6ADF86063F;
	Thu,  7 Jun 2018 17:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6ADF86063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934860AbeFGRnm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:43:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:28198 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933153AbeFGRnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:43:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 10:43:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,487,1520924400";
   d="scan'208";a="62171926"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2018 10:43:37 -0700
Date: Thu, 7 Jun 2018 10:43:37 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/mce: Check for alternate indication of machine
 check recovery on Skylake
Message-ID: <20180607174337.GA22594@agluck-desk>
References: <cover.1527283897.git.tony.luck@intel.com>
 <03cbed6e99ddafb51c2eadf9a3b7c8d7a0cc204e.1527283897.git.tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03cbed6e99ddafb51c2eadf9a3b7c8d7a0cc204e.1527283897.git.tony.luck@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 02:42:09PM -0700, Tony Luck wrote:
> Currently we just check the "CAPID0" register to see whether the CPU
> can recover from machine checks.
> 
> But there are also some special SKUs which do not have all advanced
> RAS features, but do enable machine check recovery for use with NVDIMMs.
> 
> Add a check for any of bits {8:5} in the "CAPID5" register (each
> reports some NVDIMM mode available, if any of them are set, then
> the system supports memory machine check recovery).
> 
> Cc: stable@vger.kernel.org # 4.9
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---

Has this stalled somewhere?  I'd like to see this one go into the
4.18 merge because it unbreaks some real hardware.

Parts 1 & 2 are nice-to-have, but they just make for better error
messages so aren't as critical.

>  arch/x86/kernel/quirks.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
> index 697a4ce04308..736348ead421 100644
> --- a/arch/x86/kernel/quirks.c
> +++ b/arch/x86/kernel/quirks.c
> @@ -645,12 +645,19 @@ static void quirk_intel_brickland_xeon_ras_cap(struct pci_dev *pdev)
>  /* Skylake */
>  static void quirk_intel_purley_xeon_ras_cap(struct pci_dev *pdev)
>  {
> -	u32 capid0;
> +	u32 capid0, capid5;
>  
>  	pci_read_config_dword(pdev, 0x84, &capid0);
> +	pci_read_config_dword(pdev, 0x98, &capid5);
>  
> -	if ((capid0 & 0xc0) == 0xc0)
> +	/*
> +	 * CAPID0{7:6} indicate whether this is an advanced RAS SKU
> +	 * CAPID5{8:5} indicate that various NVDIMM usage modes are
> +	 * enabled, so memory machine check recovery is also enabled.
> +	 */
> +	if ((capid0 & 0xc0) == 0xc0 || (capid5 & 0x1e0))
>  		static_branch_inc(&mcsafe_key);
> +
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0ec3, quirk_intel_brickland_xeon_ras_cap);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, quirk_intel_brickland_xeon_ras_cap);
> -- 
> 2.17.0
> 
