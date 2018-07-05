Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFF9C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B07C21AA5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XMNBJ/Zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B07C21AA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753751AbeGEKt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:49:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50586 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbeGEKtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:49:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so10370079wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 03:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RYpZrycSekEvEyrwu+DsIf+0dd2kbMFqHOfU7EaVvso=;
        b=XMNBJ/Zxf6J7b+Y2GRVEjwWSt5ryaW7bYFqETS4D1LLeQ74ZjkphWDR/wKLj9UyJyc
         8NCD1ykt8V9KbNM9HC7bD/9xA9c1eStatTxdnoxevwyGomsrdFY7M80n7MDzH+D8rrZM
         0qfDcim+G1swHdnWIp3xsjU8JFJCaqk/h/jHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RYpZrycSekEvEyrwu+DsIf+0dd2kbMFqHOfU7EaVvso=;
        b=bEWkPzEiAxPfh5GKTdUQFOxfXbqkyjHWTBtbyylQWwoZKD1o3x10eFSColxoQhNJPX
         nZTG3tQUX0fXbw2bZhn0UdypklvRLK0yXess4XD3xFjh8KeTWVbHxUYhlp5Ode/4m3Uv
         U58j4BSg2G6WeufRbxgr7nnxl3t6fR9iufpqaFRiERfTVWsTdRNOg+dinbf8e0fTQ3h9
         Dh8ergUsRIWj7P+FLfbl1G+bgUOAkY/NASLrNbJMlvoZHCVHy5Y70yMyV4X6wud79wDJ
         ip97eGy/MCAIjqSouI71avXtcKDvpRUIav4Z+6D65lsBudPm0LsqxCQHnoeny6d+Ugac
         ADWA==
X-Gm-Message-State: APt69E3KMR6FTjsShW6HHpYzMUCTGS3aPbI4KEDIei7a/71RPbNtM6jG
        Qfw80T5KTlFLTFoR1w13wtHG6Q==
X-Google-Smtp-Source: AAOMgpc/+GWDGh5bUmlM1O2gfPdS2kQ+VOa8JeTCA5+u7qd0PaThqXw4CzlaSFiUbCNY7dd8ikStWA==
X-Received: by 2002:a1c:9c0b:: with SMTP id f11-v6mr3746121wme.148.1530787762314;
        Thu, 05 Jul 2018 03:49:22 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id a124-v6sm5104276wmf.7.2018.07.05.03.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 03:49:21 -0700 (PDT)
Date:   Thu, 5 Jul 2018 11:49:19 +0100
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
Message-ID: <20180705104919.GM496@dell>
References: <cover.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <87cc68c82c3c95e82797e0ce3d401a4f1d6daf25.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <20180705092444.GL496@dell>
 <20180705103919.GB8426@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180705103919.GB8426@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul 2018, Matti Vaittinen wrote:
> On Thu, Jul 05, 2018 at 10:24:44AM +0100, Lee Jones wrote:
> > On Thu, 05 Jul 2018, Matti Vaittinen wrote:
> > 
> > > Document devicetree bindings for ROHM BD71837 PMIC MFD.
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 67 ++++++++++++++++++++++
> > >  1 file changed, 67 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> > > +		clock-names = "my-clock";
> > > +		clocks = <&pmic>;
> > > +	};
> > 
> > Do you have a real example to give?
> 
> For clock consumer? Sorry, no I don't.

Might be better to drop it for the time being then.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
