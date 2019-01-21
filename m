Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5534EC31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E4821721
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548096021;
	bh=KaRe+iCEbi6Zp7JyQuYjPSd2vbF0B0jgnKOQSN056ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AEAq61IA3BB8xIf5PvvxnOKqIBvrTQ7+5d7QuDLLV7yfMf0UoZP1WlkSH9HAPrHIi
	 RxHd3aRN88dvLmmlXwxXfl90RE54k71jUmaKahiVHJkkN0ubjramSKtlwwn1e+c5Hm
	 l5YfxNAa171k+/osXl36RhZ37vqjjhclNhbnD3Ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfAUSkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:40:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40247 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfAUSkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:40:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so9844821pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 10:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qa7lfM2OzHY3GvJ3M1a0KTGD5ilIB3ESchxH+qvFVXY=;
        b=tYJdb/tzibR4yju3xFy3Uyyp9sa+Ft8JqZYgD/Uerj4xAwb+aQbfW/8L7xzGToVDKF
         KriFcX2qnPxu91j5+I3tdaengv+ifOP+sCi+k8RWqsEA+rx9N/83mlWeOTaAtujfdtE0
         toJWG1Tm7ZR9yz3qd2+hdbr63SqJ3dvDgjN5BLwIT+5nWaDISSolLIBW+ZGAR6CD0r+7
         nfD8wmx400xECPNm5BeeQ61Mfe0uGXm6uPY+ihoLbBJGe8Pc2UXG9F7rcdmHNH2LeUfq
         +QekgAXk4Zv2CAT0LXo8FWu1QdjOFFhXSoZQz7F3ZHr788ZUQFDZsHewRzlrt5ZgczWc
         hu6Q==
X-Gm-Message-State: AJcUukeITCks8MWl++DzL/UPPRY3EJuNA9ij6Tguch9SLWzXfqz+YIoX
        Jm7DEfHZMm9kWHMB7LfVbr3BqA==
X-Google-Smtp-Source: ALg8bN51ynqCFI56W2A54FWW2dVWnAC9q4Lb/89O695GR4+I1puTzZ5rtTZZW+2D8vkjBwsveQo9sw==
X-Received: by 2002:a63:e516:: with SMTP id r22mr29469332pgh.256.1548096018543;
        Mon, 21 Jan 2019 10:40:18 -0800 (PST)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id v184sm17793967pfb.182.2019.01.21.10.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 10:40:17 -0800 (PST)
Date:   Mon, 21 Jan 2019 10:40:17 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, moritz@ettus.com
Subject: Re: [PATCH v3] platform/chrome: Add cros_ec_readmem() helpers for
 I2C/SPI based ECs
Message-ID: <20190121184017.GA5761@archbook>
References: <20190110043653.25901-1-mdf@kernel.org>
 <CAFqH_53Mdh6chEDTkNH_ZGC6scHhXXgp7zdDaSS2Xfd--dfrNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqH_53Mdh6chEDTkNH_ZGC6scHhXXgp7zdDaSS2Xfd--dfrNQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

On Mon, Jan 21, 2019 at 06:32:48PM +0100, Enric Balletbo Serra wrote:
> Hi Moritz,
> 
> Missatge de Moritz Fischer <mdf@kernel.org> del dia dj., 10 de gen.
> 2019 a les 5:40:
> >
> > Add cros_ec_readmem() helpers for I2C/SPI based ECs.
> > Unlike the LPC based ECs the I2C/SPI based ones cannot just directly
> > read the mapped region, but have to resort to EC_CMD_READ_MEMMAP.
> >
> > This is useful for things like accessing fan speeds or temperatures.
> >
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >
> > Hi all,
> >
> > This can be used for a hwmon or thermal driver such as [1], but also
> > alone can be used with 'ectool' via the ioctl() interface.
> >
> 
> ooi, did you try this with a Chromebook? Or only with your device?

Nope, mine has a dead battery (and no fans ... :-/) 
> 
> I was a bit worried on the side effects to expose this command to
> userspace, so I did a quick test, and to be honest I didn't like the
> result. Issuing the ioctl resulted on a reboot on the Chromebook I
> tested, which is not good. I didn't investigate more but I can say
> that this change, at least, will need some rework. I'll try to
> investigate a bit more on what is happening.

That sounds bad :-/

What chromebook did you run this on (so I can look at the EC code it is
running and figure out what's the difference). Maybe it has a different
configuration. It wasn't an x86 chromebook, right?

What was the ioctl you ran?

Thanks for testing,
Moritz
