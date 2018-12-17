Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D176C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B162133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbeLQLRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:17:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:3770 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbeLQLRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:17:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 03:17:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="102121114"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga008.jf.intel.com with ESMTP; 17 Dec 2018 03:17:45 -0800
Subject: Re: [PATCH 5/6] xhci: Use device_iommu_mapped()
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>, oohall@gmail.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, jroedel@suse.de,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-usb@vger.kernel.org
References: <20181211134343.10664-1-joro@8bytes.org>
 <20181211134343.10664-6-joro@8bytes.org>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <3d5b3bb3-b119-7798-4c26-910782ef1bdf@linux.intel.com>
Date:   Mon, 17 Dec 2018 13:21:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181211134343.10664-6-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.12.2018 15:43, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Replace the dev->iommu_group check with a proper function
> call that better reprensents its purpose.
> 
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/usb/host/xhci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index dae3be1b9c8f..8eacd2ed412b 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -244,7 +244,7 @@ static void xhci_zero_64b_regs(struct xhci_hcd *xhci)
>   	 * an iommu. Doing anything when there is no iommu is definitely
>   	 * unsafe...
>   	 */
> -	if (!(xhci->quirks & XHCI_ZERO_64B_REGS) || !dev->iommu_group)
> +	if (!(xhci->quirks & XHCI_ZERO_64B_REGS) || !device_iommu_mapped(dev))
>   		return;
>   
>   	xhci_info(xhci, "Zeroing 64bit base registers, expecting fault\n");
> 

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
