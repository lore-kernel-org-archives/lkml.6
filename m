Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63611C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C422081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iA50/dXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C422081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeLJHEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:04:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44815 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLJHEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:04:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so9221305wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 23:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=l3c5fRTXs67eQRKWMdaSSRPs43Nqu/ShmikYsV8fbyw=;
        b=iA50/dXjA1qHwyNN6Z8WNpPgeoWLBj+mbMx47VXmdGYCzs40xDlUOCldCfiOeXShjC
         DAbVKXoYx+ap9NXCG2nOx+xLm8HklrqMtOcmiVhj70lMfIZFWqfO2/0tnD9k46ZO4bEa
         eXVVE5uv03dVr98RtbtszEFD++huZlHVstxkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l3c5fRTXs67eQRKWMdaSSRPs43Nqu/ShmikYsV8fbyw=;
        b=NH7d3VuDQ+UFVe6mRrCITAQ+xorl2eg8EvQQ0GGGb/ds3WkESRClfgQyrc7NGtBYg+
         hcdJMb0crbZYYCq6+fTDP6BWYvzFh77GotiHlzJ0k2bcswh0bV/sJVfu+VcpEt2payiZ
         ScZdjjyMf1vSTMa9pbGcKKjr8aQ0B+5ev/AizjbhZ4gIFmM2IHe4n9jk7qR1IIyu5PeH
         zIpCX3LnqgNO3JtBKjm0UZh5RNUPgwftAbmFAgdcBfQte9LZOHa84caeIoh18+S/rIbd
         ucGD3KKlvqwUOBQGNmQ4nPppJc6VfPnfN0jzIWI4m0/02/fC8Yt9rcjpty76mnZv/vWd
         FskA==
X-Gm-Message-State: AA+aEWZEi1fmY9ORCF493XBhAC1+vtAi4CFf203Ue06/jUFCiHqU9fgX
        dYB3QQSoOQtbih8Spo3OYy1PVA==
X-Google-Smtp-Source: AFSGD/Um/ZUUIqoBW4sOx9zScGIbE6yzpVLynKKjqAGNsfDCjFasqNwWLwVnZApTjkbZR5vNCXobVQ==
X-Received: by 2002:a5d:6487:: with SMTP id r7mr9086848wru.263.1544425448883;
        Sun, 09 Dec 2018 23:04:08 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id h16sm31710016wrb.62.2018.12.09.23.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 23:04:08 -0800 (PST)
Date:   Mon, 10 Dec 2018 07:04:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     oskari@lemmela.net, Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/2] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181210070406.GV26661@dell>
References: <20181208175847.32068-1-oskari@lemmela.net>
 <20181208175847.32068-3-oskari@lemmela.net>
 <20181210063534.GS26661@dell>
 <CAGb2v6797iHnQ_JxU6yheO1YSOeEgVcXMbXAgnsroE8PaJ=YJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v6797iHnQ_JxU6yheO1YSOeEgVcXMbXAgnsroE8PaJ=YJw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018, Chen-Yu Tsai wrote:

> On Mon, Dec 10, 2018 at 2:35 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Sat, 08 Dec 2018, Oskari Lemmela wrote:
> >
> > > Parts of the AXP803 are compatible with their counterparts on the AXP813.
> > > These include the GPIO, ADC, AC and battery power supplies.
> > >
> > > Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > > Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > I'm happy to fix this, but ...
> >
> > Can you explain these tags for me please?
> >
> > Specifically the last one.
> >
> > Why does Chen-Yu Tsai have an SoB there?
> 
> I picked his patch to rebase off the previous one, and reworked the ordering.
> I then pushed it onto GitHub [1], but didn't get around to sending it to the
> mailing lists. Oskari said on IRC that he would handle it.
> 
> I'm not sure what would be appropriate here though? Oskari's first SoB should
> be kept, since he's the original author. Maybe he should've added his SoB
> again as the final entry? Either way I suppose it would be confusing without
> any explanation.

Yes, I agree, but thanks for taking the time to do so.

Let's leave it as it is.

> [1] https://github.com/wens/linux/commit/951afe2dc32086174ab07a1a997d748f69bf5bf2
> [2] https://freenode.irclog.whitequark.org/linux-sunxi/2018-12-08#23644905;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
