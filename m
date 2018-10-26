Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118D7C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC9A2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9Vk3Y0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC9A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeJZRPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:15:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36441 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZRPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:15:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id h192so314788lfg.3;
        Fri, 26 Oct 2018 01:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J2egS45e6qZY2BBa0rvqmfICs8KEzUd2RHaRN5ToITc=;
        b=M9Vk3Y0Q9+KPFcKqSBBRb825zJSbZnk+FTAiEpliEOIYF0KgZVCZv57hGo37+PGuiL
         qxQxEM072GpZQWK2+OS8akIx7rirKcx9eS3KdJD8o/Ctkyn1FFUgvhZx8LXo/6atYu/x
         d76SWWXBNM/q/E8OKR4VGtYZEFUziGvBfSBYEIR+lyZJWYiX5vPOPQz7ly/5C/aTkwj1
         /MBjyfHBmdh4kXtJU2EpkzrtzjwOp84Mhcs9jmDanf07QwuNumK9ybXzMNHaMZZQANMy
         hGVWDXGlubbCfJOtX2uAL5Z6uVOj42AyBrzgmngKBHwUY7+wowswbQGwuCAC1ebVqqHE
         QRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=J2egS45e6qZY2BBa0rvqmfICs8KEzUd2RHaRN5ToITc=;
        b=sXdev2n/p3544/w0yxF/5W4zpCVW7nsqrK1/AuNCNKMxzu5NeXDtHPJ7K8ns9lk0VZ
         Pl5ut28Mg9g8gREzaAlmShvvoG4bkjnsovBGOvznJZLworYhrRx/PEDyUoO9m5vdHDMC
         ut6Hynd2NRRCvBucuiAC3yRHmOiRB6ORgFMGxyPWyStVsScwZpjSnPZtkgyYu27SVmgW
         /QNPUujfQoerPE6JQuCLul/GibS5D5dcGpSKVAVrWI6Gxndv/SNm4VNzcrsjyL3IdtSc
         yrbGOjJLPDA/gZnl06Iby9K69SvdPOzuNvXeFT0J30W4aylNS13deO+UAUFXd2csLJw0
         dGDA==
X-Gm-Message-State: AGRZ1gIoBcn5ocaP2H+U/h+61xhzJ6ZwvsXXxnO+1iJTDJPuraK9KAxa
        XqVbHlMwMEztbPO07r4zdPY=
X-Google-Smtp-Source: AJdET5e/jjU1UfXkTD/4+XliRNnAjutQzsjozZ+37635Wrczkmj0Xx+CgapByUI5iM0IrGjiuYgyqw==
X-Received: by 2002:a19:d8ea:: with SMTP id r103mr940325lfi.146.1540543172304;
        Fri, 26 Oct 2018 01:39:32 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id c4-v6sm1481385ljj.41.2018.10.26.01.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 01:39:31 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gFxeT-00082g-QD; Fri, 26 Oct 2018 10:39:29 +0200
Date:   Fri, 26 Oct 2018 10:39:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremiah Mahler <jmmahler@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH AUTOSEL 3.18 36/98] usb: serial: handle -ENODEV quietly
 in generic_submit_read_urb
Message-ID: <20181026083929.GA27852@localhost>
References: <20181025141853.214051-1-sashal@kernel.org>
 <20181025141853.214051-36-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025141853.214051-36-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Thu, Oct 25, 2018 at 10:17:51AM -0400, Sasha Levin wrote:
> From: Jeremiah Mahler <jmmahler@gmail.com>
> 
> [ Upstream commit 04f9c6e6d17584340fb6c8a9469a0e6df28876d2 ]
> 
> If a USB serial device (e.g. /dev/ttyUSB0) with an active program is
> unplugged, an -ENODEV (19) error will be produced after it gives up
> trying to resubmit a read.
> 
>   usb_serial_generic_submit_read_urb - usb_submit_urb failed: -19
> 
> Add -ENODEV as one of the permanent errors along with -EPERM that
> usb_serial_generic_submit_read_urb() handles quietly without an error.
> 
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This isn't a bug fix, but more of a clean up patch and hence does not
qualify for stable. So specifically the stable tag was left out on
purpose.

I never got a chance to talk to you in Edinburgh, but Greg mentioned you
had an opt-out list for your autosel work which I'd like to be added to.

I always mark bug fixes that qualify for stable as such so anything else
that your process picks up would already have been considered and
rejected by me.

Thanks,
Johan

> ---
>  drivers/usb/serial/generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
> index c44b911937e8..54e170dd3dad 100644
> --- a/drivers/usb/serial/generic.c
> +++ b/drivers/usb/serial/generic.c
> @@ -287,7 +287,7 @@ static int usb_serial_generic_submit_read_urb(struct usb_serial_port *port,
>  
>  	res = usb_submit_urb(port->read_urbs[index], mem_flags);
>  	if (res) {
> -		if (res != -EPERM) {
> +		if (res != -EPERM && res != -ENODEV) {
>  			dev_err(&port->dev,
>  					"%s - usb_submit_urb failed: %d\n",
>  					__func__, res);
