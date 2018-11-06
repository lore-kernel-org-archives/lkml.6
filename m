Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7897BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D5E2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dD46OG3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D5E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbeKGHII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:08:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43700 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeKGHII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:08:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so6819678plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 13:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ty+48kKCpNwflUDwMg4vt+kPJdAke6Yks0mUdaaiFo0=;
        b=dD46OG3nzuYWboZgJV1Q4+6sVFdXK7CQNMocA5vOla7m8Ox8GFjZqa7Ky0WuVOpb/x
         HGfabqo43eKqBcoVowZa3XNDm8BU+DdX69hp6L3ZtuhVgRpw/lrtt9iZtOZ9Txz1vGY0
         ienGpUX6uhuzw1U1ZEoDK+fOw+ZeQzaOszGGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ty+48kKCpNwflUDwMg4vt+kPJdAke6Yks0mUdaaiFo0=;
        b=mUALliEsebwPJqB8JgS5w/W8VrLZ1Epi2bDTZSKDrv6d9lSwTw+BsiyhbWhI94O7uq
         iM8cB4qOPDEd/i2oJdiC651NJWLD4/6oYgNeGaNr98nJs3GyaPHXuu3sIa36xrB9Nwsz
         +A3Xp//6nudkHciwxbZluUkLy8R2c5oHozUg/o3UOD3yUqTDD1zll+Fe/D6qLDtYS+ra
         83e+LLRC8mIF6pp3Ar2+LmRpMNdRrFoE4MaudYsVFY3l740uZHM2ePVuaNDDlUx/iJAC
         6YjVaf9v89LtoBR0VS0HZORdH1OVRVeoaXlvj9nse4eC+SOLCMVTgAoNVQ7qzog25DCC
         9Law==
X-Gm-Message-State: AGRZ1gJ6Ftkeq0/SGvybl5PxKqRTT678O9HjMvomDdI8XbjsgdrZuJri
        ZF/yaLLAdvSWl9D50+/sI+jg
X-Google-Smtp-Source: AJdET5fU3Bs6A0/bBSJ1uVEnQUemgHFXqEoasix2eNlpaTj7E82HbkMkkhBs0/frHPOiu3zfeej+Cg==
X-Received: by 2002:a17:902:ac8f:: with SMTP id h15-v6mr19845326plr.46.1541540451672;
        Tue, 06 Nov 2018 13:40:51 -0800 (PST)
Received: from [10.28.17.185] ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q11-v6sm25509935pgp.62.2018.11.06.13.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 13:40:51 -0800 (PST)
Subject: Re: [PATCH V3 4/6] usb: ohci-platform: Add support for Broadcom STB
 SoC's
To:     Alan Stern <stern@rowland.harvard.edu>,
        Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>,
        Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
References: <Pine.LNX.4.44L0.1811061105120.1450-100000@iolanthe.rowland.org>
From:   Al Cooper <al.cooper@broadcom.com>
Message-ID: <d077971c-d7ef-d630-2d89-5a06fb481b28@broadcom.com>
Date:   Tue, 6 Nov 2018 16:40:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1811061105120.1450-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 11:08 AM, Alan Stern wrote:
> On Mon, 5 Nov 2018, Al Cooper wrote:
> 
>> Add support for Broadcom STB SoC's to the ohci platform driver.
>>
>> Signed-off-by: Al Cooper <alcooperx@gmail.com>
>> ---
> 
>> @@ -177,6 +189,8 @@ static int ohci_platform_probe(struct platform_device *dev)
>>   		ohci->flags |= OHCI_QUIRK_FRAME_NO;
>>   	if (pdata->num_ports)
>>   		ohci->num_ports = pdata->num_ports;
>> +	if (pdata->suspend_without_phy_exit)
>> +		hcd->suspend_without_phy_exit = 1;
> 
> Sorry if I missed this in the earlier discussions...  Is there any
> possibility of adding a DT binding that could express this requirement,
> instead of putting it in the platform data?
> 
> Alan Stern
> 

Alan,

That was my original approach but internal review suggested that I use 
pdata instead. Below is my original patch for:
[PATCH V3 2/6] usb: core: Add ability to skip phy exit on suspend and 
init on resume
With this patch I can then use ohci_platform.c without any 
modifications. Could you let me know what you think?

Thanks
Al

Add the ability to skip calling the PHY's exit routine on suspend
and the PHY's init routine on resume. This is to handle a USB PHY
that should have it's power_off function called on suspend but cannot
have it's exit function called because on exit it will disable the
PHY to the point where register accesses to the Host Controllers
using the PHY will be disabled and the host drivers will crash.

This is enabled with the HCD flag "suspend_without_phy_exit" which
can be set from any HCD driver or from the device-tree property
"suspend-without-phy-exit".

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
  drivers/usb/core/hcd.c  |  8 ++++----
  drivers/usb/core/phy.c  | 21 +++++++++++++++------
  drivers/usb/core/phy.h  |  9 ++++++---
  include/linux/usb/hcd.h |  3 +++
  4 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 1c21955fe7c0..e67e4d6b3d21 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2263,7 +2263,7 @@ int hcd_bus_suspend(struct usb_device *rhdev, 
pm_message_t msg)
  		hcd->state = HC_STATE_SUSPENDED;

  		if (!PMSG_IS_AUTO(msg))
-			usb_phy_roothub_suspend(hcd->self.sysdev,
+			usb_phy_roothub_suspend(hcd,
  						hcd->phy_roothub);

  		/* Did we race with a root-hub wakeup event? */
@@ -2304,7 +2304,7 @@ int hcd_bus_resume(struct usb_device *rhdev, 
pm_message_t msg)
  	}

  	if (!PMSG_IS_AUTO(msg)) {
-		status = usb_phy_roothub_resume(hcd->self.sysdev,
+		status = usb_phy_roothub_resume(hcd,
  						hcd->phy_roothub);
  		if (status)
  			return status;
@@ -2347,7 +2347,7 @@ int hcd_bus_resume(struct usb_device *rhdev, 
pm_message_t msg)
  		}
  	} else {
  		hcd->state = old_state;
-		usb_phy_roothub_suspend(hcd->self.sysdev, hcd->phy_roothub);
+		usb_phy_roothub_suspend(hcd, hcd->phy_roothub);
  		dev_dbg(&rhdev->dev, "bus %s fail, err %d\n",
  				"resume", status);
  		if (status != -ESHUTDOWN)
@@ -2744,7 +2744,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
  	struct usb_device *rhdev;

  	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
-		hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
+		hcd->phy_roothub = usb_phy_roothub_alloc(hcd);
  		if (IS_ERR(hcd->phy_roothub))
  			return PTR_ERR(hcd->phy_roothub);

diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
index 9879767452a2..0eb12566f1c3 100644
--- a/drivers/usb/core/phy.c
+++ b/drivers/usb/core/phy.c
@@ -45,10 +45,11 @@ static int usb_phy_roothub_add_phy(struct device 
*dev, int index,
  	return 0;
  }

-struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev)
+struct usb_phy_roothub *usb_phy_roothub_alloc(struct usb_hcd *hcd)
  {
  	struct usb_phy_roothub *phy_roothub;
  	int i, num_phys, err;
+	struct device *dev = hcd->self.sysdev;

  	if (!IS_ENABLED(CONFIG_GENERIC_PHY))
  		return NULL;
@@ -58,6 +59,9 @@ struct usb_phy_roothub *usb_phy_roothub_alloc(struct 
device *dev)
  	if (num_phys <= 0)
  		return NULL;

+	if (device_property_read_bool(dev, "suspend-without-phy-exit"))
+		hcd->suspend_without_phy_exit = 1;
+
  	phy_roothub = devm_kzalloc(dev, sizeof(*phy_roothub), GFP_KERNEL);
  	if (!phy_roothub)
  		return ERR_PTR(-ENOMEM);
@@ -161,26 +165,30 @@ void usb_phy_roothub_power_off(struct 
usb_phy_roothub *phy_roothub)
  }
  EXPORT_SYMBOL_GPL(usb_phy_roothub_power_off);

-int usb_phy_roothub_suspend(struct device *controller_dev,
+int usb_phy_roothub_suspend(struct usb_hcd *hcd,
  			    struct usb_phy_roothub *phy_roothub)
  {
+	struct device *controller_dev = hcd->self.sysdev;
+
  	usb_phy_roothub_power_off(phy_roothub);

  	/* keep the PHYs initialized so the device can wake up the system */
-	if (device_may_wakeup(controller_dev))
+	if (device_may_wakeup(controller_dev) || hcd->suspend_without_phy_exit)
  		return 0;

  	return usb_phy_roothub_exit(phy_roothub);
  }
  EXPORT_SYMBOL_GPL(usb_phy_roothub_suspend);

-int usb_phy_roothub_resume(struct device *controller_dev,
+int usb_phy_roothub_resume(struct usb_hcd *hcd,
  			   struct usb_phy_roothub *phy_roothub)
  {
+	struct device *controller_dev = hcd->self.sysdev;
  	int err;

  	/* if the device can't wake up the system _exit was called */
-	if (!device_may_wakeup(controller_dev)) {
+	if (!device_may_wakeup(controller_dev) &&
+	    !hcd->suspend_without_phy_exit) {
  		err = usb_phy_roothub_init(phy_roothub);
  		if (err)
  			return err;
@@ -189,7 +197,8 @@ int usb_phy_roothub_resume(struct device 
*controller_dev,
  	err = usb_phy_roothub_power_on(phy_roothub);

  	/* undo _init if _power_on failed */
-	if (err && !device_may_wakeup(controller_dev))
+	if (err && !device_may_wakeup(controller_dev)
+	    && !hcd->suspend_without_phy_exit)
  		usb_phy_roothub_exit(phy_roothub);

  	return err;
diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
index 88a3c037e9df..34293e11a917 100644
--- a/drivers/usb/core/phy.h
+++ b/drivers/usb/core/phy.h
@@ -5,13 +5,16 @@
   * Copyright (C) 2018 Martin Blumenstingl 
<martin.blumenstingl@googlemail.com>
   */

+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
  #ifndef __USB_CORE_PHY_H_
  #define __USB_CORE_PHY_H_

  struct device;
  struct usb_phy_roothub;

-struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev);
+struct usb_phy_roothub *usb_phy_roothub_alloc(struct usb_hcd *hcd);

  int usb_phy_roothub_init(struct usb_phy_roothub *phy_roothub);
  int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
@@ -19,9 +22,9 @@
  int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
  void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);

-int usb_phy_roothub_suspend(struct device *controller_dev,
+int usb_phy_roothub_suspend(struct usb_hcd *hcd,
  			    struct usb_phy_roothub *phy_roothub);
-int usb_phy_roothub_resume(struct device *controller_dev,
+int usb_phy_roothub_resume(struct usb_hcd *hcd,
  			   struct usb_phy_roothub *phy_roothub);

  #endif /* __USB_CORE_PHY_H_ */
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 97e2ddec18b1..87a104055b5e 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -157,6 +157,9 @@ struct usb_hcd {
  	 */
  	unsigned		skip_phy_initialization:1;

+	/* Some phys don't want the phy's exit/init called on suspend/resume */
+	unsigned		suspend_without_phy_exit:1;
+
  	/* The next flag is a stopgap, to be removed when all the HCDs
  	 * support the new root-hub polling mechanism. */
  	unsigned		uses_new_polling:1;
-- 
1.9.0.138.g2de3478

