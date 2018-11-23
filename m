Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452D4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1189D20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1189D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393073AbeKWQqn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 11:46:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39448 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389704AbeKWQqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 11:46:42 -0500
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gQ4ZI-0000jD-9l
        for linux-kernel@vger.kernel.org; Fri, 23 Nov 2018 06:03:56 +0000
Received: by mail-pl1-f199.google.com with SMTP id v2so3646733plg.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 22:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=65ncplSQ78uC8X2G8FK4pd+M8TCV8XEj0fwGQE+ZgBs=;
        b=ChaOZREFYwOxUoADYDlZYIUeH3VSPZv5eDWSH+c6HD526sGL6y6fKecLh86aD+vgHB
         6eoRmA2ksFWb/a5+X2JzpZua4zYVtEKc2YW5XDa+Q60lTRcn5na0wQR5eOEHDZQkPN1h
         7yYrY5MwP9v2Y7vsRZRajNPWjpBhnTjV62Mo+8nQcNcsyhb2cHXsl2HSMKk90I/SzmQ2
         X+HCrNMZrqZxgE96ejH+1eQygbpQB9auZBfLnsP4WegnGyeGvHczD2+Pw7NY7h/ikH/w
         LWQAvjal5pJ6ONlTlLN7bLJjQIIUqCVXryq6n+BHJ8ZGLyMvc9zwrgjyl3ukEPjM92kC
         edxg==
X-Gm-Message-State: AA+aEWYGf/QVKdvCbSWJ87lSH988/Jbp2R5yggjreiIYiZvGOm8xerm9
        6JGZm2ESGVgs41UNXT++qbw8Q9V2V5tlk81VZiEBoN1efMFMtw+OmCwl+0u8fcrBqJ23rxR7yvS
        juNvVhWtfNZx7vz5Cr0s4WVLjjcN7NaqtJoScOPN1aw==
X-Received: by 2002:a63:6483:: with SMTP id y125mr12627556pgb.91.1542953034974;
        Thu, 22 Nov 2018 22:03:54 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VkV8Zowu4s0yzDRGLw3joFEQEG+FUO2Y0otU/k4uz8l7/k4ANEq8MtkQMg9rip9PX+zhkRmA==
X-Received: by 2002:a63:6483:: with SMTP id y125mr12627535pgb.91.1542953034618;
        Thu, 22 Nov 2018 22:03:54 -0800 (PST)
Received: from [10.101.46.245] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id n65-v6sm61636106pfi.185.2018.11.22.22.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 22:03:53 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH v2] USB: Don't enable LPM if it's already enabled
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20181031055209.11031-1-kai.heng.feng@canonical.com>
Date:   Fri, 23 Nov 2018 14:03:51 +0800
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9E364A4D-AEC7-42A7-B6DB-8EC79B0DF517@canonical.com>
References: <20181031055209.11031-1-kai.heng.feng@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> On Oct 31, 2018, at 1:52 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
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

Would it be possible to merge this patch?

Kai-Heng

> ---
> v2:
> -  Check udev->usb2_hw_lpm_enabled before calling usb_port_resume().
> 
> drivers/usb/core/hub.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index c6077d582d29..02fa574e98ce 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3523,7 +3523,8 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
> 		hub_port_logical_disconnect(hub, port1);
> 	} else  {
> 		/* Try to enable USB2 hardware LPM */
> -		if (udev->usb2_hw_lpm_capable == 1)
> +		if (udev->usb2_hw_lpm_capable == 1 &&
> +		    !udev->usb2_hw_lpm_enabled)
> 			usb_set_usb2_hardware_lpm(udev, 1);
> 
> 		/* Try to enable USB3 LTM */
> -- 
> 2.19.1
> 

