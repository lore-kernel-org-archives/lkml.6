Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41750C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0791B206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbeLQNze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:55:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:8003 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbeLQNzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:55:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 05:55:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="99357328"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2018 05:55:31 -0800
Subject: Re: [PATCH] xhci: fix 'broken_suspend' placement in struct xchi_hcd
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     oneukum@suse.com, sandeep.singh@amd.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181217133740.5342-1-nsaenzjulienne@suse.de>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <7ea44e0c-5268-b898-4d27-048921eaab69@linux.intel.com>
Date:   Mon, 17 Dec 2018 15:59:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181217133740.5342-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.2018 15:37, Nicolas Saenz Julienne wrote:
> As commented in the struct's definition there shouldn't be anything
> underneath it's 'priv[0]' member as it would break some macros.
> 
> The patch converts the broken_suspend into a bit-field and relocates it
> next to to the rest of bit-fields.
> 
> Fixes: a7d57abcc8a5 ("xhci: workaround CSS timeout on AMD SNPS 3.0 xHC")
> Reported-by: Oliver Neukum  <oneukum@suse.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>   drivers/usb/host/xhci.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index c3515bad5dbb..011dd45f8718 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1863,6 +1863,8 @@ struct xhci_hcd {
>   	unsigned		sw_lpm_support:1;
>   	/* support xHCI 1.0 spec USB2 hardware LPM */
>   	unsigned		hw_lpm_support:1;
> +	/* Broken Suspend flag for SNPS Suspend resume issue */
> +	unsigned		broken_suspend:1;
>   	/* cached usb2 extened protocol capabilites */
>   	u32                     *ext_caps;
>   	unsigned int            num_ext_caps;
> @@ -1880,8 +1882,6 @@ struct xhci_hcd {
>   	void			*dbc;
>   	/* platform-specific data -- must come last */
>   	unsigned long		priv[0] __aligned(sizeof(s64));
> -	/* Broken Suspend flag for SNPS Suspend resume issue */
> -	u8			broken_suspend;
>   };
>   
>   /* Platform specific overrides to generic XHCI hc_driver ops */
> 

Thanks, not sure how I missed that.

Greg, in case you want to pick this simple fix to 4.20 still:
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>

Or prefer me to resend it?

-Mathias
