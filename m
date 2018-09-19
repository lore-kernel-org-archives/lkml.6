Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B968C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E154E20877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FMSww1Jp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E154E20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbeISKN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 06:13:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34686 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeISKN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 06:13:27 -0400
Received: by mail-io1-f65.google.com with SMTP id c22-v6so3428694iob.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 21:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iE0f1D4TiQ5+52fjPmSbVeVen2uhngENxBoAF50U9zg=;
        b=FMSww1JpzfOxOSL3cFZsj9MyD3jdTqBLVHj2A5X5RVO3zqoa2xjEa1QeVJr95FVXtG
         rB9rOg0CtLkxoJHUkwwO8dt9AyU5uZOFKn+8rmin1qjZnUfg/KKvpLlVbwytV6ImRpmv
         4gHWBmZVpaIMM9hIz89cIyAuO3pQctzidO3bI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iE0f1D4TiQ5+52fjPmSbVeVen2uhngENxBoAF50U9zg=;
        b=TfrMROseMywkBCkrg14aQGAZxpoeDLOCvjFXzJFf/q+NEdzPxfM7qq2Dp2s5ibDzIt
         UhuPJXpWgdnsTzWMZ/5ueZjYbrb9ZcmBklOX7UTnm+GMVoNM2LYmXAO5GadVZE+hf0fX
         5EXOiv+5+ATnZUOPxa5TnF5mNCb5ZO7hpFqJXh2AaBBFtLq1wd/fCUeyURJqHCkgtnVM
         1hqUX76NTa9qrWPzYLOm8yC0igkmoi0GG1Q/WUulqW6aDwb0wgjDPBls2DH2kakSxaYf
         XbWX7qTVX+41jEVvKm5J9+ApLve6qY4pXr+41SGpc5dGFB28gTLFDsAuW7LiHvEJuXcK
         q70w==
X-Gm-Message-State: APzg51BOR2CC/y2Hf7QHGoWd2Kv2P6nlMVnMdZd8vRT2a2hiA4llfrci
        IHMUYuvkWu8f4n8GjyGE2z+D
X-Google-Smtp-Source: ANB0VdYhJHdHB4Z7v9p9oY+fO+ZhZ0kmIzgzvYMvnlJ/AoKJj8tLV7xTdqrzz7+Z02JzTLldAAR40A==
X-Received: by 2002:a6b:b44e:: with SMTP id d75-v6mr27873992iof.63.1537331844179;
        Tue, 18 Sep 2018 21:37:24 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id v13-v6sm5874726ita.38.2018.09.18.21.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 21:37:23 -0700 (PDT)
Date:   Tue, 18 Sep 2018 21:37:22 -0700
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/22] Unify MediaTek pinctrl in preparation for
 MT8183 and MT6765
Message-ID: <20180919043722.GA14181@Mani-XPS-13-9360>
References: <cover.1536404280.git.sean.wang@mediatek.com>
 <CACRpkdZtVBjYGs5C7-HWEyX7f7pnCqvnRYBH=fFmLKhN4FGymA@mail.gmail.com>
 <1537325650.572.9.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537325650.572.9.camel@mtkswgap22>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 10:54:10AM +0800, Sean Wang wrote:
> On Tue, 2018-09-18 at 15:07 -0700, Linus Walleij wrote:
> > On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:
> > 
> > > v2 and changes since v1:
> > 
> > I had trouble applying the last patches in the series so I applied
> > all on an immutable branch (ib-mtk) then merged that into devel
> > and added a patch on top to fix up some GPIO includes (just sent).
> > 
> > Please check the result!
> > 
> 
> Sure, I'll take a look and and test on the devel branch.
> 
> On the top, I'll add a fix for the issue recently reported by kbuild
> test robot about implicit declaration and a new MT6765 driver based
> on the series.
>

Hi Sean,

Do you have any plans to add support for MT6797?

Thanks,
Mani

> > Yours,
> > Linus Walleij
> 
> 
