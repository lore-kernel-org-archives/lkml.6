Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EF4C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2413720870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+TpKqvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2413720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeLLOq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:46:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35998 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeLLOq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:46:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so8987743pfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 06:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sN19sOJAgXqIh/Xw5W4LqYIsDRDpzgbdAarXMCE4msw=;
        b=K+TpKqvLaN7TYP48ABWktdYCk8yn0z/C4SpzNCtNMXAE21zhQliZ+OTANIExTaEKEa
         OxJUrGFfKlYtQQ/vuqgUoadd/8UhrlyGmIsjBmm35iIoUR5/MHKSVJiRujn9rge8hkA+
         OCNXuEa6S1H6CrC38hXN/+vQRi7oxMfakxLik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sN19sOJAgXqIh/Xw5W4LqYIsDRDpzgbdAarXMCE4msw=;
        b=JRhmA2LKTgKqjwogKYbvWiwkH0YeupCyK5M89Z7tGav2AQa7RNQCAz1Wys4xywyVvn
         kgSHWuP8TwvrT0Eyq//2KUaKoUcS7LLViMdDqdFeuTT3JPegqxBGLC7YsHyF0yXj3/GZ
         ex8RcvbSAp8uRhe2Uk1tMSDhDZNeORJ/+e1tbacfWU82Ulp/AgE0rg/n0FQSG0H6hIyj
         VPGHVYu5usI2fuMuU4qHYnS1dwyydtWilTBTR8wOdw6z+L1+aQE3VGWoiZRNl8uC0caG
         1cmiydBczLAe3UBY1/tGkwqMEeW/NfRA8Ow0V2WDDiJoNAZ4JiNTZI2U6/E8f+AcsvL7
         zbsA==
X-Gm-Message-State: AA+aEWZtGpPkbCakIogDbF73/VAMfraATFLIkhNvn14inl4efg2An57q
        GNIhNOhbBFUQVemCIvcscYXA
X-Google-Smtp-Source: AFSGD/UoCrTMWYmn6BeOk5sdZCPFueZVQZuDIRjIVmrBXFQYy1NL7aZA5Pj4W5OByRjgc+Ug0h2zNQ==
X-Received: by 2002:a65:448a:: with SMTP id l10mr18485589pgq.387.1544626017185;
        Wed, 12 Dec 2018 06:46:57 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6190:e546:e5b2:257b:c83b:98e4])
        by smtp.gmail.com with ESMTPSA id x27sm41958565pfe.178.2018.12.12.06.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 06:46:56 -0800 (PST)
Date:   Wed, 12 Dec 2018 20:16:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org, linux-unisoc@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 15/15] MAINTAINERS: Add entry for RDA Micro SoC
 architecture
Message-ID: <20181212144646.GA27625@Mani-XPS-13-9360>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
 <20181210173550.29643-16-manivannan.sadhasivam@linaro.org>
 <3e4b7143-6ed8-6006-cb07-d72bca40ce5f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e4b7143-6ed8-6006-cb07-d72bca40ce5f@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Wed, Dec 12, 2018 at 02:53:42PM +0100, Andreas Färber wrote:
> Hi Mani,
> 
> Am 10.12.18 um 18:35 schrieb Manivannan Sadhasivam:
> > Add MAINTAINERS entry for RDA Micro SoC architecture with myself
> > and Andreas Färber as the maintainers.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  MAINTAINERS | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6c3fbbb361f8..6411fb222590 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1945,6 +1945,21 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
> >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >  S:	Maintained
> >  
> > +ARM/RDA MICRO ARCHITECTURE
> > +M:	Andreas Färber <afaerber@suse.de>
> > +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> I'd suggest you swap the two of us here, making you the primary
> maintainer. Or drop me, as I should be copied via linux-unisoc anyway.
> 
> I won't realistically have the bandwidth to drive review and more pull
> requests at the moment, with Realtek already stuck in irqchip regression
> for too long and LoRa making only slow progress.
> 

Okay, no issues. Will drop you from the MAINTAINERS entry so that you
won't get bugged.

Thanks,
Mani

> Regards,
> Andreas
> 
> > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +L:	linux-unisoc@lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	arch/arm/boot/dts/rda8810pl-*
> > +F:	drivers/clocksource/timer-rda.c
> > +F:	drivers/irqchip/irq-rda-intc.c
> > +F:	drivers/tty/serial/rda-uart.c
> > +F:	Documentation/devicetree/bindings/arm/rda.txt
> > +F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
> > +F:	Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
> > +F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> > +
> >  ARM/REALTEK ARCHITECTURE
> >  M:	Andreas Färber <afaerber@suse.de>
> >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > 
> 
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
