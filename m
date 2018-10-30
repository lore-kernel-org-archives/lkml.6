Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E934C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE987204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE987204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeJaABo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:01:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53775 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeJaABo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:01:44 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gHVcW-0002Lz-Du
        for linux-kernel@vger.kernel.org; Tue, 30 Oct 2018 15:07:52 +0000
Received: by mail-pf1-f198.google.com with SMTP id g63-v6so10775621pfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ps8ixr9LtwFtMi6SbFiH2t0jlsGg0Zq5b5LNCeySn/M=;
        b=DjdAh4+GpmDYpIfOnzbkT9xgoEpOjOLCb08bf07Ua5mZoMOslAcsxvYF285B/WBMEV
         CWSn+a4UDxqAxGVr79zd9EFtms2XaB3oUiNz/eQQyfvb+Te8ddlqTZRyXmaLQTdLtJQa
         lvJxzTSx0BHhLarVI63oAT0OQf6edcUaIWjUbKEa64pLoABxsx+yuymAr7aLkhyPCqUd
         mNNYuzgenkQhJrkaNG/9LuKkWZScgr9HTbXfIBpcjAc3Fq/u/IlQeoPerXiRsalXowEx
         mOyKy7XUpPtAOiyS/gAZCS3XJpYDR7xZAcN96yz1Z03rK9ev4jwKoPJpKq0TnaAykjNY
         btjg==
X-Gm-Message-State: AGRZ1gIPzDrzT8OI47JG+6P9uRi4w7z4i077aS+zKvA7tuBAgEWl0wez
        7/35cBsbvqTg06Ms6HmdGUlWQINReeyg6CIA5IacgVlo/bA8IQZ0F4fLhESH2frhI6gPBTfqTnQ
        Ip7r43N/vuqbKs3PG6qN54+WypiJ1qI1yplx5wj2JZw==
X-Received: by 2002:a63:fd09:: with SMTP id d9-v6mr18791549pgh.164.1540912070978;
        Tue, 30 Oct 2018 08:07:50 -0700 (PDT)
X-Google-Smtp-Source: AJdET5e6lhiWdbO/3+1HT94ffmGR4U6HiGLoHYwPnrwbuEaaOn3cEUfqOa+aj5H26gBLLy7/PtEEDQ==
X-Received: by 2002:a63:fd09:: with SMTP id d9-v6mr18791501pgh.164.1540912070492;
        Tue, 30 Oct 2018 08:07:50 -0700 (PDT)
Received: from 2001-b011-380f-1f39-25e6-f27b-5378-368e.dynamic-ip6.hinet.net (2001-b011-380f-1f39-25e6-f27b-5378-368e.dynamic-ip6.hinet.net. [2001:b011:380f:1f39:25e6:f27b:5378:368e])
        by smtp.gmail.com with ESMTPSA id x23-v6sm25347121pfh.56.2018.10.30.08.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 08:07:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] USB: Don't enable LPM if it's already enabled
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Pine.LNX.4.44L0.1810301058540.1515-100000@iolanthe.rowland.org>
Date:   Tue, 30 Oct 2018 23:07:47 +0800
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DDDD403E-601C-4AAB-B872-21781D9DA822@canonical.com>
References: <Pine.LNX.4.44L0.1810301058540.1515-100000@iolanthe.rowland.org>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 30, 2018, at 23:00, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> On Tue, 30 Oct 2018, Mathias Nyman wrote:
> 
>> On 30.10.2018 07:54, Kai-Heng Feng wrote:
>>> USB Bluetooth controller QCA ROME (0cf3:e007) sometimes stops working
>>> after S3:
>>> [ 165.110742] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
>>> [ 168.432065] Bluetooth: hci0: Failed to send body at 4 of 1953 (-110)
>>> 
>>> After some experiments, I found that disabling LPM can workaround the
>>> issue.
>>> 
>>> On some platforms, the USB power is cut during S3, so the driver uses
>>> reset-resume to resume the device. During port resume, LPM gets enabled
>>> twice, by usb_reset_and_verify_device() and usb_port_resume().
>>> 
>>> So let's enable LPM for just once, as this solves the issue for the
>>> device in question.
>>> 
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>>  drivers/usb/core/driver.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
>>> index 53564386ed57..e11d2eac76b6 100644
>>> --- a/drivers/usb/core/driver.c
>>> +++ b/drivers/usb/core/driver.c
>>> @@ -1901,7 +1901,8 @@ int usb_set_usb2_hardware_lpm(struct usb_device *udev, int enable)
>>>  	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
>>>  	int ret = -EPERM;
>>> 
>>> -	if (enable && !udev->usb2_hw_lpm_allowed)
>>> +	if (enable && !udev->usb2_hw_lpm_allowed ||
>>> +	    udev->usb2_hw_lpm_enabled == enable)
>>>  		return 0;
>>> 
>>>  	if (hcd->driver->set_usb2_hw_lpm) {
>>> 
>> 
>> Something like that would probably work.
>> 
>> Would it make sense to skip USB2 hw LPM enabling in usb_port_resume() if
>> port was just reset (and thus LPM enabled)?
>> 
>> something like this:
>> 
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -3520,7 +3520,7 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>>                 hub_port_logical_disconnect(hub, port1);
>>         } else  {
>>                 /* Try to enable USB2 hardware LPM */
>> -               if (udev->usb2_hw_lpm_capable == 1)
>> +               if (udev->usb2_hw_lpm_capable == 1 && !udev->reset_resume)
>>                         usb_set_usb2_hardware_lpm(udev, 1);
>> 
>>                 /* Try to enable USB3 LTM */
> 
> Why not simply test whether udev->usb2_hw_lpm_enabled is already true?
> 
> 		if (udev->usb2_hw_lpm_capable == 1 &&
> 				!udev->usb2_hw_lpm_enabled)
> 
> Or even put this extra test into usb_set_usb2_hardware_lpm().

I think it makes sense to merge all checks into usb_set_usb2_hardware_lpm().

I’ll resend one with this suggestion.

Kai-Heng

> 
> Alan Stern

