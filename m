Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE2C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FCB223A8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4idH3Ym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FCB223A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754042AbeGEMol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:44:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40799 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753886AbeGEMoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:44:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so10619319wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3rSpZ+LkUrSLF9GTzYEEThQrwnAjPFC9yrDB2GjLHzI=;
        b=U4idH3YmX5W7doL+iNm5+U6AsdmzIEtXHutbegp8NxlruQK7tdoLh2KbVLP5oP1aVb
         25CTikTxyHsW+jxWIVDeD+zdZCjXc/prKZPr5EWzCyYK0Sz0OSAQukrOPv9RVlE8ABCt
         G8laHrrHyOReuBgwU+YP/XQkXVOUADK6Mugck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3rSpZ+LkUrSLF9GTzYEEThQrwnAjPFC9yrDB2GjLHzI=;
        b=WiAWzhC9sfqiaiadXYORp9oXhM+uSLjpqCPxhjoW3Vd0EeXflQpXQQiVUuxhP+PtJY
         2W22UcZVXgRg4nK5Yy3QnKFHWva0LtQ0+megW+rhHe5OQSiQfNUYbo0rRU2hvamRBRCq
         J+cO3hAwS5pZAQ9/lCszYEbwm2G6KxpHGj+8KS2oZcEN5+0V9Mao3kSARdAIIdHyVyEo
         QP0V2sxK4AetH9YV+brcO+gGMgc9Q4/rGsNOXwJB9Rtut5+RpVYVwrLPLT3bm2Khltry
         Auz3xjyZtyj/8uCGrkudMofh1U4oMckiZ2uRI+XNRqzvpGxUEo4yQG2NW15wAE8Y3+BY
         oDpw==
X-Gm-Message-State: APt69E0y+SLAK+1DalqhIpyE2HDbRY4RgnJIvTxwmNMh+8D5aE3PUq1p
        B3kkJugdIsPSaxTW61XiW1SvWQ==
X-Google-Smtp-Source: AAOMgpfjS+Qur3RNUtbom7AbRcAbzoH8x2C3ZxykwXd44zs/ukPH1kIeYYfQZQQMuhT+0FwVNP1apA==
X-Received: by 2002:adf:92e7:: with SMTP id 94-v6mr4421477wrn.70.1530794677667;
        Thu, 05 Jul 2018 05:44:37 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id i190-v6sm9975357wmd.33.2018.07.05.05.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 05:44:36 -0700 (PDT)
Date:   Thu, 5 Jul 2018 13:44:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        arnd@arndb.de, dmitry.torokhov@gmail.com, sre@kernel.org,
        chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org, eballetbo@gmail.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v9 2/2] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180705124434.GP496@dell>
References: <cover.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <87cc68c82c3c95e82797e0ce3d401a4f1d6daf25.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <20180705092444.GL496@dell>
 <20180705103919.GB8426@localhost.localdomain>
 <20180705104919.GM496@dell>
 <20180705115143.GC8426@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180705115143.GC8426@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul 2018, Matti Vaittinen wrote:

> On Thu, Jul 05, 2018 at 11:49:19AM +0100, Lee Jones wrote:
> > On Thu, 05 Jul 2018, Matti Vaittinen wrote:
> > > On Thu, Jul 05, 2018 at 10:24:44AM +0100, Lee Jones wrote:
> > > > On Thu, 05 Jul 2018, Matti Vaittinen wrote:
> > > > 
> > > > > Document devicetree bindings for ROHM BD71837 PMIC MFD.
> > > > > 
> > > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > > >  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 67 ++++++++++++++++++++++
> > > > >  1 file changed, 67 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> > > > > +		clock-names = "my-clock";
> > > > > +		clocks = <&pmic>;
> > > > > +	};
> > > > 
> > > > Do you have a real example to give?
> > > 
> > > For clock consumer? Sorry, no I don't.
> > 
> > Might be better to drop it for the time being then.
> 
> I have tested the clk driver using this dummy consumer. So in a sense it
> "works" and can be used as an example on how to write a real clock
> consumer node. Thus I see some value in this example node - even if it
> does not match to any real world HW. If I had to use the clk from this
> PMIC and write HW description I would appreciate this dummy exaple. I
> can drop it if you insist - but I would at least like to hear what is
> the downside on having it here?

My suggestion then would be to make it look as authentic as possible.

It is only an example, so it doesn't *really* matter, but the current
foo,bar one just looks a bit crumby.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
