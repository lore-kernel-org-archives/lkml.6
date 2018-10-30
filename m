Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEB4C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0BA2082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0BA2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeJ3XOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:14:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:31308 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbeJ3XOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:14:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 07:20:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="86882686"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga006.jf.intel.com with ESMTP; 30 Oct 2018 07:20:33 -0700
Subject: Re: [PATCH] USB: Don't enable LPM if it's already enabled
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>
References: <20181030055452.25969-1-kai.heng.feng@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <c5d72c60-c13c-8801-26d5-2fe8ab48d98c@linux.intel.com>
Date:   Tue, 30 Oct 2018 16:24:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181030055452.25969-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.2018 07:54, Kai-Heng Feng wrote:
> USB Bluetooth controller QCA ROME (0cf3:e007) sometimes stops working
> after S3:
> [ 165.110742] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [ 168.432065] Bluetooth: hci0: Failed to send body at 4 of 1953 (-110)
> 
> After some experiments, I found that disabling LPM can workaround the
> issue.
> 
> On some platforms, the USB power is cut during S3, so the driver uses
> reset-resume to resume the device. During port resume, LPM gets enabled
> twice, by usb_reset_and_verify_device() and usb_port_resume().
> 
> So let's enable LPM for just once, as this solves the issue for the
> device in question.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/usb/core/driver.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 53564386ed57..e11d2eac76b6 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1901,7 +1901,8 @@ int usb_set_usb2_hardware_lpm(struct usb_device *udev, int enable)
>   	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
>   	int ret = -EPERM;
>   
> -	if (enable && !udev->usb2_hw_lpm_allowed)
> +	if (enable && !udev->usb2_hw_lpm_allowed ||
> +	    udev->usb2_hw_lpm_enabled == enable)
>   		return 0;
>   
>   	if (hcd->driver->set_usb2_hw_lpm) {
> 

Something like that would probably work.

Would it make sense to skip USB2 hw LPM enabling in usb_port_resume() if
port was just reset (and thus LPM enabled)?

something like this:

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3520,7 +3520,7 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
                 hub_port_logical_disconnect(hub, port1);
         } else  {
                 /* Try to enable USB2 hardware LPM */
-               if (udev->usb2_hw_lpm_capable == 1)
+               if (udev->usb2_hw_lpm_capable == 1 && !udev->reset_resume)
                         usb_set_usb2_hardware_lpm(udev, 1);
  
                 /* Try to enable USB3 LTM */

-Mathias
