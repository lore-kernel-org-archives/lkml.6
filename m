Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8AEECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847A0206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez6UvM0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847A0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbeIRPSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:18:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38014 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeIRPSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:18:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id w11-v6so1351682wrc.5;
        Tue, 18 Sep 2018 02:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WOwWukAwtVE/BeI4IHbUqCSzaNBp6OOvtTIiCPQsjKg=;
        b=Ez6UvM0C3Xy9bMqtLf5Mfh1ecgJvAYyu57G8ZldeFO1z4nZMV+iA45xuQcT76u3oJI
         nOzsts/CnDNvJZej0HtmBjM1Gr1NWVwclImK81MWa1y94DUCyxAuh+snj0psN75Fv5Fl
         uB9yxlfws4ou8NrLaKaBBBA8O4Xb2jjhDu4CD6qIdNAY0geDkLHLjSfB4BunpwCe7EYO
         OyXXB1ZiLHYqAwu7KvI0uSaq6ZOJKJ02JvnipbeCZ8jNcXXDjlRoAxOila9bv1JwIRj6
         U85JO8VakztsPMXyuBawiqYZWI0GxkpTKcZ7CHH/GCRDNKhughipO8nJpccium3c/gxW
         B4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WOwWukAwtVE/BeI4IHbUqCSzaNBp6OOvtTIiCPQsjKg=;
        b=O5BNbauezDP9IvaChOY/nTseCtXYLVNYLK7md2iCOf1EAQH/lu08e7Actg6DftLIH9
         cC6qvWJnf7cGYRn2BT8YJOuZUpUpl2bezFlFBJUnMJ0RWXcwLeixiUI7fj2FcX0ZCFyY
         LDcw2TfCWre7xcFnaE4Yx4ay+xPLPOeHKRIohZLr/8zjmB8O1W9IT0PYP4fw93MNZUhX
         7eYO4/h+B7Ijwfqex+XqXQem0Fj9FRdpJxCWNboQXQ4Eoh3XHMeWa4GHjF63n57TzcSV
         /++wZRT9uvzx6J3rSrv64GqIqsS5oN91Q2HsqWelXyMAiIrG16D6xyCfKeRYVpmFtoxs
         0/vQ==
X-Gm-Message-State: APzg51AgKskXFUdurXnu7eznq+iyZLVF3dCwjT6iWjDwvgd9PYM+ITcX
        Cr4sRtoHDcZ39mniz7T/ZCY=
X-Google-Smtp-Source: ANB0VdYp/OdTlG49t1b1TSLl+H1Lf4uFx4Y1t2Go0G0Yg+ANgV2GNA9dKUExmIyEoc4l9hQahgiwiw==
X-Received: by 2002:a5d:4b52:: with SMTP id w18-v6mr22245865wrs.87.1537263979947;
        Tue, 18 Sep 2018 02:46:19 -0700 (PDT)
Received: from pi ([185.208.64.4])
        by smtp.gmail.com with ESMTPSA id j66-v6sm22918092wrj.28.2018.09.18.02.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 02:46:19 -0700 (PDT)
X-Google-Original-Sender: <johan@kernel.org>
Received: from johan by pi with local (Exim 4.90_1)
        (envelope-from <johan@pi>)
        id 1g2CZH-0004LT-Iq; Tue, 18 Sep 2018 11:45:15 +0200
Date:   Tue, 18 Sep 2018 11:45:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v4] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
Message-ID: <20180918094515.GD3943@localhost>
References: <20180918091634.GC3943@localhost>
 <20180916175847.3288-1-pados@pados.hu>
 <ef753ab98cf19ce4482e76864d406c1e@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef753ab98cf19ce4482e76864d406c1e@pados.hu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 09:35:35AM +0000, Karoly Pados wrote:
> >> + goto out_free;
> >> +
> >> + /* Chip-type guessing logic based on libftdi. */
> >> + priv->gc.ngpio = 4; /* FT230X, FT231X */
> >> + if (le16_to_cpu(serial->dev->descriptor.bcdDevice) != 0x1000)
> >> + priv->gc.ngpio = 1; /* FT234XD */
> > 
> > As I mentioned in my last mail: I've asked FTDI about this, but I fear
> > that FTX234XD has bcdDevice 0x1000 and we may need to just always
> > register all four pins after all.
> > 
> 
> To avoid missing 4.20, what is the latest time I should wait for FTDI's answer?
> Or should I just submit v5 as it is now and you'll incorporate FTDI's feedback
> when you receive it?

We'll get this into 4.20 either way, there's plenty of time. But I guess
we could play it safe and always register four pins, and if/when we get
more info about FT234XD we can implement registering just one pin in a
follow up patch.

Sounds good? If so I'll just merge your v5 (registering four pins) next
week.
 
> >> +static void ftdi_gpio_remove(struct usb_serial_port *port)
> >> +{
> >> + struct ftdi_private *priv = usb_get_serial_port_data(port);
> >> +
> >> + if (priv->gpio_used) {
> >> + /* Remark: Exiting CBUS-mode does not reset pin states too */
> >> + ftdi_exit_cbus_mode(port);
> >> + priv->gpio_used = false;
> >> + }
> > 
> > This should go after deregistration or we have a tiny race window here.
> 
> Can you elaborate on that to make sure I get it right? 
> By "deregistration" do you mean deregistering the GPIO chip below in the same method?

Yes.

> Does that mean something can call into our module while this method is running?
> If not, I'm clueless about the possible race here.

Correct, you can get gpio callbacks until the gpio chip has been
deregistered (anything coming in after that would be a gpiolib bug).

Thanks,
Johan
