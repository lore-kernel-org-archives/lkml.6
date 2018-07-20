Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0924ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F542064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F542064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeGTJDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:03:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:30774 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbeGTJDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:03:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2018 01:16:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,378,1526367600"; 
   d="scan'208";a="217572367"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga004.jf.intel.com with ESMTP; 20 Jul 2018 01:15:06 -0700
Subject: Re: [PATCH] usb: xhci: Fix memory leak in xhci_endpoint_reset()
To:     iq_132@sina.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheng Xiaowei <zhengxiaowei@ruijie.com.cn>
References: <1531120365-44810-1-git-send-email-iq_132@sina.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <fec4a873-9367-9289-9e49-20cad7387f77@intel.com>
Date:   Fri, 20 Jul 2018 11:17:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1531120365-44810-1-git-send-email-iq_132@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.07.2018 10:12, iq_132@sina.com wrote:
> 
> From: Zheng Xiaowei <zhengxiaowei@ruijie.com.cn>
> 
> If td_list is not empty the cfg_cmd will not be freed,
> call xhci_free_command to free it.
> 
> Signed-off-by: Zheng Xiaowei <zhengxiaowei@ruijie.com.cn>
> ---
>   drivers/usb/host/xhci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 2f4850f..68e6132 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -3051,6 +3051,7 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
>   	if (!list_empty(&ep->ring->td_list)) {
>   		dev_err(&udev->dev, "EP not empty, refuse reset\n");
>   		spin_unlock_irqrestore(&xhci->lock, flags);
> +		xhci_free_command(xhci, cfg_cmd);
>   		goto cleanup;
>   	}
>   	xhci_queue_stop_endpoint(xhci, stop_cmd, udev->slot_id, ep_index, 0);
> 

Thanks, adding to queue

-Mathias
