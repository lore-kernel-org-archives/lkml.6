Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320DFC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAA820878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2B/1bAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAA820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeLEPjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:39:17 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:45792 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeLEPjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:39:16 -0500
Received: by mail-lf1-f54.google.com with SMTP id b20so15031853lfa.12;
        Wed, 05 Dec 2018 07:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h/XFwuE/C9TLle+Bju0W+UKGFFPuBXHWbSsfi3HGwdU=;
        b=Z2B/1bARbGfzrqgYTyMW1Pglc9VC56G5oQ//7NFAHfFj/P8efMo71RDB7SufW2UQYl
         doxZNuy2rM+R6+lokAadGhSz0+R1IZDsf2z8kZlDG7Rx3stN/HCbdTnhXb7o4ZUbmewl
         vsAXQmSJUWPmM9gO07P0gwPcHg90KBEJPVRjSslAiL69FbdUbHAYcxRK4KfMMgSQX0pg
         IcH/Bonpo7v2YctIclHpR87oVuDgq9elWXHs3OqphmN1q1778qSHkhFYMxDX4NIrqZlC
         GPYWTRDzhL03l1TrNURkWR096lU2OkjpLHWbMxqXahUn7rUThY/cXFw15uQiR4qiGZ8P
         ++Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=h/XFwuE/C9TLle+Bju0W+UKGFFPuBXHWbSsfi3HGwdU=;
        b=r3XLy9a/aviS+nU8dx+YrtxiRGPzf5zl88stbsbltPWL9dX55B3hoff2gxr+FMCSYE
         micp+29jYc7CLumikA9keoJGv+N0NY06CrtTl5153JISofmuXAeOpjZbbeMERxcpEiPx
         NZ8axRYI+9rZdLAevRuGCIrN7WfMYRfVJEtbePZRP93Cq+WXhY1eNO7HPs8hR9NNL2pl
         AriG2o5koKD4rdDDzjiM3YN4N9zNWZqF08UjNGzRYGPvDNQK3sou9p39rFRrrS9W9WDY
         xLPRl7sBLOCappfxRafD7oC1TXT104Ps/2LPgNZgVtib9udtGWyOV49KtdmYi5iRrxNR
         e/Dw==
X-Gm-Message-State: AA+aEWYIw97A9EVBfxuINoXtY05FhSjh1q+6hAuby1EUWsGQSVGbjITD
        4biZIr1muyNgWL3H0I51RIY=
X-Google-Smtp-Source: AFSGD/WS0EdryFHjw/4OtoHY5KRgpWH0V3/u3NcXX69ZSV6V3m3U/5aktk+ngSsS+VCplcKdYdR5SA==
X-Received: by 2002:a19:a502:: with SMTP id o2mr14388597lfe.92.1544024353176;
        Wed, 05 Dec 2018 07:39:13 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id r199sm3596313lff.50.2018.12.05.07.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 07:39:12 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gUZGc-0004Cw-Ie; Wed, 05 Dec 2018 16:39:15 +0100
Date:   Wed, 5 Dec 2018 16:39:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anatolij Gustschin <agust@denx.de>
Cc:     Song Qiang <songqiang1304521@gmail.com>, johan@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: usb: thoughts of adding more support for FT232H
Message-ID: <20181205153914.GL15689@localhost>
References: <48bc71bb-68e4-8b29-f609-940c9aedc0a9@gmail.com>
 <20181205161718.7451d98f@crub>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205161718.7451d98f@crub>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:17:18PM +0100, Anatolij Gustschin wrote:
> Hi,
> 
> On Wed, 5 Dec 2018 22:10:40 +0800
> Song Qiang songqiang1304521@gmail.com wrote:
> ...
> >I've been developing some iio device drivers and found that some people
> >would like to test their devices with a qemu system which requires an
> >i2c or spi port on our development hosts. Usually this is achieved with
> >a DLN-2 adapter, while this is a bit difficult for me because it costs
> >~175$ in my country. Then I found that FTDI's FT232H supports both these
> >two modes and costs only less than 5$ but without full support in kernel.
> >The ftdi-sio driver supports FT232H only as a serial converter.
> >So I'm planning to write a mfd driver for it supports both these three
> >modes, here are my thoughts:
> 
> There already has been a discussion [1] about adding an MFD driver for
> FT232H, since the operating modes are mutually exclusive (and bus pins
> shared between different modes), the MFD approach doesn't seem to be
> a good fit.
> 
> >  - This device cannot support these three modes together because they
> >    share some common pins, so I'm planning to add a sysfs entry
> >    'current_mode' for selecting which mode the device should be working
> >    on.
> >  - This device is in uart mode on reset, so default mode would be reset,
> >    too. This also helps for people only want to use this as a serial
> >    converter feels nothing has happened (compatible).
> >  - I was trying to reuse the ftdi-sio driver but it seems like mfd can
> >    only register platform devices, while this is a usb driver. I may
> >    have to copy some functions from this driver.
> >
> >Would you share any ideas? I'd appreciate it.
> 
> There is a patch series [2] adding an interface driver for FT232H-
> based adapter devices, it already supports adding custom MPSSE based
> SPI busses with SPI slaves for a custom USB PID. It already supports
> adding custom CBUS-/MPSSE-GPIO adapters for user-defined USB PID.
> Adding I2C driver/adapter support should be easy, too. Maybe you can
> re-use it.

> [1] https://patchwork.kernel.org/patch/9828985
> [2] https://patchwork.kernel.org/project/linux-usb/list/?series=48255

I was going to refer to these series, but Anatolij beat me to it
(haven't looked at [2] myself yet, though).

Thanks,
Johan
