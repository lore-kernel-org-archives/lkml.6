Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC56ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C40B20833
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C40B20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbeITU1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:27:30 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:33384 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730984AbeITU1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:27:30 -0400
Received: (qmail 3520 invoked by uid 2102); 20 Sep 2018 10:43:40 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Sep 2018 10:43:40 -0400
Date:   Thu, 20 Sep 2018 10:43:40 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     AceLan Kao <acelan.kao@canonical.com>
cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>,
        Joe Perches <joe@perches.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: core: disable USB2 LPM when suspending
In-Reply-To: <20180920070940.14773-1-acelan.kao@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1809201037540.2141-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2018, AceLan Kao wrote:

> We found a S5 current leakage issue on Dell DW1820 WiFi/BT combo card
> which uses Qualcomm QCA6174 SoC. It also comes with WiFi and BT failure
> when encountered current leakage issue.
>    1. Power on, both WiFi and BT work.
>    2. Power off and found a current leakage issue(consumes ~0.5W)
>    3. Power on, no WiFi and BT devices can be found in lspci and lsusb.
>    4. Power off, there is no current leakage issue at S5.
>    5. continue to 1.
> 
> From Qualcomm's report:
> Based on the USB sniffer log, the difference between Linux and Windows
> is USB LPM setting(no LPM transaction on Windows) which may leads to
> the voltage leakage on Linux S5 state.
> 
> After checked the LPM related code and found, when system is going to
> enter S5, it resumes the USB devices from runtime suspend and enables
> USB2 LPM, and then it calls usb_dev_poweroff() -> usb_suspend(), and
> leave USB2 LPM stays enabled.

But usb_suspend() -> usb_suspend_both() -> usb_suspend_device() -> 
generic_suspend() -> usb_port_suspend() -> 
usb_set_usb2_hardware_lpm(udev, 0).  So why does USB2 LPM stay enabled?

> Disable USB2 LPM in usb_suspend() fixes the issue mentioned above,
> and try 30 times of s2idle, S3 and S5, the USB devices keep working
> well. Disable USB2 LPM seems do no harm to the system.
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  drivers/usb/core/driver.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index e76e95f62f76..ac5e60d7104f 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1463,6 +1463,9 @@ int usb_suspend(struct device *dev, pm_message_t msg)
>  	struct usb_device	*udev = to_usb_device(dev);
>  	int r;
>  
> +	if (udev->usb2_hw_lpm_enabled == 1)
> +		usb_set_usb2_hardware_lpm(udev, 0);

At this point the device may still be in runtime suspend.  Is that 
really okay?

Alan Stern

> +
>  	unbind_no_pm_drivers_interfaces(udev);
>  
>  	/* From now on we are sure all drivers support suspend/resume
> 

