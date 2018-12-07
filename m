Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F92DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB2120868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HrQw3MD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB2120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbeLGTWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:22:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40733 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeLGTWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:22:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so4815427wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 11:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ysP7s+sex9xFiYQskl1NZKqHcv3pRjBZq4JZULgpbZQ=;
        b=HrQw3MD3mSftAp84C823mWhToMqauyVqPok5egsGDyx1yWD5uKLcZ2VjnXP3vttp50
         PIxv6ZkOEEoHmY/JJhRomsoa+vIm5IMz6C8tphPp9wWJYClfAdUUxTG/mNU0gF6YP2sU
         fDKeMVGL5+S8FvOjs3MEQtXK3FUmTlxMcPgIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ysP7s+sex9xFiYQskl1NZKqHcv3pRjBZq4JZULgpbZQ=;
        b=uEk/kWX230Awq31w/rO2OJveVqg1OXEj7XkRfnXgshHvcegM1eL/vS4AwwtlPE7fR4
         RUBBwJjnezpuOK7RbhGEkbCvoPZn3ADV2vlieAW/hEVgQOsP+XW2hEPYNCKoVlTtNLtP
         bYDnrIJIvpVTaT439+JjtnVEM5o1xJtAbik4y8i/Fr7b7mmPPPawb5w5X+GFzoxewE+d
         3deFshe1HsrHCUzA4YANbso0nYv90PTanbOeD62P3Q2fg2F2R+659REBzocGrguSWcP2
         FtyNp6N98oJY2ppgmkXznmBcxM1KyuOXFCKuSIjW7x62b0weBmohYriypuTPChaEvIBJ
         Um2w==
X-Gm-Message-State: AA+aEWbZQgLZuGhiy9fHgWxJf9FKNMjC9hVso2p653uspOQAOs6NDsog
        Px3cZrI+/ZC97gT21BhYf23+HA==
X-Google-Smtp-Source: AFSGD/XgSLJ+aPCRJ1vvPs+V/kvW2Yaar9W232+gzsv5CllYbD3Ay/+B+tprZ72fnwUOxTYWyFzr/Q==
X-Received: by 2002:adf:bb8d:: with SMTP id q13mr2799896wrg.183.1544210559924;
        Fri, 07 Dec 2018 11:22:39 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id p6sm2997172wrx.50.2018.12.07.11.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 11:22:39 -0800 (PST)
Date:   Fri, 7 Dec 2018 19:22:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Oskari Lemmela <oskari@lemmela.net>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        quentin.schulz@bootlin.com, linux-pm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181207192237.GK26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
 <20181207164011.GI26661@dell>
 <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Dec 2018, Vasily Khoruzhick wrote:

> On Fri, Dec 7, 2018 at 8:40 AM Lee Jones <lee.jones@linaro.org> wrote:
> 
> > My OCD-dar is going crazy.
> >
> > Why haven't you used the same alignment as is already there?
> >
> > If it starts to run over 80-chars then bring the others back.
> >
> > Also why is there a single liner shoved in the middle of the
> > multi-line entries?  Please move the singles to the top or the
> > bottom.
> 
> Hi Lee,
> 
> Could you please reformat it in the way that makes your OCD-dar happy?
> It would be really nice to get

I'm afraid not, for a multitude of reasons.

The most important of which surround testing.

> AC and battery support for APX8x3 merged -- it'll make Pinebook and
> Teres-I pretty well supported by mainline kernel.

That's great.  A worthy cause indeed.  So I'm sure you guys will want
to turn the patch around in short order so that it's applied in time
for the next merge window.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
