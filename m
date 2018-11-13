Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FBFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92EA2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HG+0/S7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92EA2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbeKMSZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:25:31 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44684 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbeKMSZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:25:31 -0500
Received: by mail-ed1-f68.google.com with SMTP id n19-v6so9631005edq.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 00:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wDHNhd9DUBB7/H+seffFiEBFBEGqlwLGeOpo+/qHkaY=;
        b=HG+0/S7oKgQrVpWYlK+FBHnv5AQGllwlAE5aEZQ+G5XA33tT+9hWiaRecKkFSKqFJe
         pQD7RfaBQbQAkFPsYKyNTIPvUvpVZwD6RBPbSMvZvdUhj/AkYBeQbZJ7jB3rhINSVcdb
         dZ6+44b8CHNylvp6ImtveRiCKCTgFyhX0f81w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wDHNhd9DUBB7/H+seffFiEBFBEGqlwLGeOpo+/qHkaY=;
        b=IPWktC1VrMKr0oc9eiePpNm/BhbOuTREZ9QNycgyEESa4jqn3HH2XWJxuLv97QPN53
         Ik8TV4ClWUDFr0iexg4CkGI1583jYxE/pAtiuGGDnZ7Lt0ViS1qGcSPWUdKwNHnt2iye
         MtTjRvmBHJijt4qNYKXCCUXXccCx5XQJIOBmyU5mswY31lZy7iF+sjR/T4z1pv+CRakC
         AENJdHgIIb3ixUp9ZEFVNH9XCnI6L8zuwDRve4l7EWCdU41ejeaODvMsc461Kt5naJJq
         l7Jxc2m4pWAD6JyN3nroursxPNAHUilFCy+QfUFE2z3OCQz+K5XghIqKc1b5ej4AnvbQ
         JZxw==
X-Gm-Message-State: AGRZ1gIbQMEbumxbYsYXkQBBOZENhuHduq6D58cbBQ5axDKZiBeflqF+
        O/Hp92T4gdwCAWPDmv6pRnQB/LYw2Vk=
X-Google-Smtp-Source: AJdET5dtIZdqJmANZAQrFbi5xFHdMkfAlXdno0ZCMZZvpL82FrMyU/GewKQJClznRbNOIEzWBrgQ2w==
X-Received: by 2002:a50:f10b:: with SMTP id w11mr12011382edl.0.1542097708815;
        Tue, 13 Nov 2018 00:28:28 -0800 (PST)
Received: from dell ([2.31.167.205])
        by smtp.gmail.com with ESMTPSA id d6-v6sm5106300edl.61.2018.11.13.00.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 00:28:28 -0800 (PST)
Date:   Tue, 13 Nov 2018 08:28:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, broonie@kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 3/6] mfd: lochnagar: Add initial binding documentation
Message-ID: <20181113082825.GB3513@dell>
References: <20181108101405.14062-1-ckeepax@opensource.cirrus.com>
 <20181108101405.14062-4-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181108101405.14062-4-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Nov 2018, Charles Keepax wrote:

> Lochnagar is an evaluation and development board for Cirrus
> Logic Smart CODEC and Amp devices. It allows the connection of
> most Cirrus Logic devices on mini-cards, as well as allowing
> connection of various application processor systems to provide a
> full evaluation platform. This driver supports the board
> controller chip on the Lochnagar board.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> I have dropped Rob and Stephen's Acks from this patch on
> account of the scale of the changes since v3.
> 
> Changes since v3:
>  - Split the binding up into separate parts for the individual subsystems
>  - Added documentation for the fixed clocks that are done through DT
> 
> Thanks,
> Charles
> 
>  .../devicetree/bindings/clock/cirrus,lochnagar.txt |  89 +++++++++++++
>  .../devicetree/bindings/mfd/cirrus,lochnagar.txt   |  70 ++++++++++

I think these should all be seperate patches.

Code looks okay to me though.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
