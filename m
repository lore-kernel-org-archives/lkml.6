Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C40EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EC82077B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EC82077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbeKMEGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:06:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:34028 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeKMEGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:06:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 10:12:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,496,1534834800"; 
   d="scan'208";a="273411131"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 12 Nov 2018 10:12:31 -0800
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 49E505803C5;
        Mon, 12 Nov 2018 10:12:31 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/1] usb: dwc3: Fix NULL pointer exception in
 dwc3_pci_remove()
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <2972befa36441a5dea1de9efb1e1355f8406d7b6.1539801494.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <5cbf08e5-6c6a-4817-a370-8b193b04314a@linux.intel.com>
Date:   Mon, 12 Nov 2018 10:11:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2972befa36441a5dea1de9efb1e1355f8406d7b6.1539801494.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe/Greg,

Any comments ?

On 10/17/18 11:40 AM, Kuppuswamy Sathyanarayanan wrote:
> In dwc3_pci_quirks() function, gpiod lookup table is only registered for
> baytrail SOC. But in dwc3_pci_remove(), we try to unregistered it
> without any checks. This leads to NULL pointer de-reference exception in
> gpiod_remove_lookup_table() when unloading the module for non baytrail
> SOCs. This patch fixes this issue.
>
> Fixes: 5741022cbdf3 ("usb: dwc3: pci: Add GPIO lookup table on platforms
> without ACPI GPIO resources")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>   drivers/usb/dwc3/dwc3-pci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
> index 1286076a8890..842795856bf4 100644
> --- a/drivers/usb/dwc3/dwc3-pci.c
> +++ b/drivers/usb/dwc3/dwc3-pci.c
> @@ -283,8 +283,10 @@ static int dwc3_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>   static void dwc3_pci_remove(struct pci_dev *pci)
>   {
>   	struct dwc3_pci		*dwc = pci_get_drvdata(pci);
> +	struct pci_dev		*pdev = dwc->pci;
>   
> -	gpiod_remove_lookup_table(&platform_bytcr_gpios);
> +	if (pdev->device == PCI_DEVICE_ID_INTEL_BYT)
> +		gpiod_remove_lookup_table(&platform_bytcr_gpios);
>   #ifdef CONFIG_PM
>   	cancel_work_sync(&dwc->wakeup_work);
>   #endif

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

