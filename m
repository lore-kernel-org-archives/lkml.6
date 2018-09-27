Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3690EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 02:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CE121570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 02:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CE121570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeI0Ior convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 04:44:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58960 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeI0Ior (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 04:44:47 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1g5M2s-0004wH-79
        for linux-kernel@vger.kernel.org; Thu, 27 Sep 2018 02:28:50 +0000
Received: by mail-wm1-f71.google.com with SMTP id a69-v6so3993266wma.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 19:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MOHsVTItP7K4W+cz+BT1+YHPuQ3I7f97g5h1bFF7Fdo=;
        b=tgHvcYIQqOfUrEn9fwD1AxX6UErnV/WG7Z7f/do2eD5sze9Za+f0W/8f6OX/ijexn3
         PGxInUZHznyjqGpSC6q4c7rrpsZQWlinaUgiEhKSMdi56ust4LtR/hnATngcugzK0fqJ
         OwFHmTbysAJKmOb2ZD860N0sArSNRMO/73Fo503eOEKhDF2BD0P4/E9qnDTFNV8qqJD9
         SxruyIK6bIoCXcGEpEuupnrM52dUTa+fiH0xLs/c2bFCKCdiXS16TFuOi7TH+SVeIQzZ
         CHEY9+3gKKPVoG3V/RYeMY8z8wSvUPFVGrKkhkmUf3SZpkscg0/DkBPhByqv5vOp5mv5
         /tOg==
X-Gm-Message-State: ABuFfojvzTzGJUwvL2DMsqH/OuHMFeo9StaJ6sgmpVYuBbC8Kt6Od2da
        zKyhtXTsCb/kD6F4TIIwK4RJ7zrhqk5PN+HM2xyU8vUY/mDE/9Yr6pJCSuPKC42kzN6kqTT7DPk
        PJ3KeiZQKJu80U6TkkJMohOaOo1KDgQhVjocxLr3365bSCnjNUr06M3EJTA==
X-Received: by 2002:adf:f7c8:: with SMTP id a8-v6mr7350234wrq.86.1538015329788;
        Wed, 26 Sep 2018 19:28:49 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61H2s2YbrteX5WmeuEGgqI8wQBoR+xfdWQJ1vRGlwcBZ7elzjsMD5Ra4oGCK44OA8GrX+FTxMRJGcxZbtwW5Vg=
X-Received: by 2002:adf:f7c8:: with SMTP id a8-v6mr7350220wrq.86.1538015329421;
 Wed, 26 Sep 2018 19:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180920070940.14773-1-acelan.kao@canonical.com> <Pine.LNX.4.44L0.1809201037540.2141-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1809201037540.2141-100000@iolanthe.rowland.org>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Thu, 27 Sep 2018 10:28:37 +0800
Message-ID: <CAFv23Q=xUFxwgXZZ_Q6G4CoHx_-Hs5PJRxcrUmcqutV9Ovrg1g@mail.gmail.com>
Subject: Re: [PATCH] usb: core: disable USB2 LPM when suspending
To:     stern@rowland.harvard.edu
Cc:     felipe.balbi@linux.intel.com, Daniel Drake <drake@endlessm.com>,
        joe@perches.com, mathias.nyman@linux.intel.com,
        linux-usb@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> 於 2018年9月20日 週四 下午10:43寫道：
>
> On Thu, 20 Sep 2018, AceLan Kao wrote:
>
> > We found a S5 current leakage issue on Dell DW1820 WiFi/BT combo card
> > which uses Qualcomm QCA6174 SoC. It also comes with WiFi and BT failure
> > when encountered current leakage issue.
> >    1. Power on, both WiFi and BT work.
> >    2. Power off and found a current leakage issue(consumes ~0.5W)
> >    3. Power on, no WiFi and BT devices can be found in lspci and lsusb.
> >    4. Power off, there is no current leakage issue at S5.
> >    5. continue to 1.
> >
> > From Qualcomm's report:
> > Based on the USB sniffer log, the difference between Linux and Windows
> > is USB LPM setting(no LPM transaction on Windows) which may leads to
> > the voltage leakage on Linux S5 state.
> >
> > After checked the LPM related code and found, when system is going to
> > enter S5, it resumes the USB devices from runtime suspend and enables
> > USB2 LPM, and then it calls usb_dev_poweroff() -> usb_suspend(), and
> > leave USB2 LPM stays enabled.
>
> But usb_suspend() -> usb_suspend_both() -> usb_suspend_device() ->
> generic_suspend() -> usb_port_suspend() ->
> usb_set_usb2_hardware_lpm(udev, 0).  So why does USB2 LPM stay enabled?
Right, after checking the normal case, it calls
usb_set_usb2_hardware_lpm(udev, 0) eventually.
In the buggy machine, it doesn't reach that part and stops somewhere
after resume.
But unfortunately, I can't duplicate the issue after doing some
experiments anymore, so I can't get more info about that.
I'll dig further and get back to you when I have any progress.
>
> > Disable USB2 LPM in usb_suspend() fixes the issue mentioned above,
> > and try 30 times of s2idle, S3 and S5, the USB devices keep working
> > well. Disable USB2 LPM seems do no harm to the system.
> >
> > Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> > ---
> >  drivers/usb/core/driver.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> > index e76e95f62f76..ac5e60d7104f 100644
> > --- a/drivers/usb/core/driver.c
> > +++ b/drivers/usb/core/driver.c
> > @@ -1463,6 +1463,9 @@ int usb_suspend(struct device *dev, pm_message_t msg)
> >       struct usb_device       *udev = to_usb_device(dev);
> >       int r;
> >
> > +     if (udev->usb2_hw_lpm_enabled == 1)
> > +             usb_set_usb2_hardware_lpm(udev, 0);
>
> At this point the device may still be in runtime suspend.  Is that
> really okay?
>
> Alan Stern
>
> > +
> >       unbind_no_pm_drivers_interfaces(udev);
> >
> >       /* From now on we are sure all drivers support suspend/resume
> >
>
