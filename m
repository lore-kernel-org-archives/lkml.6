Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A011BC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D482064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ibZo1QuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D482064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJIOKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:10:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53710 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeJIOKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:10:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id y11-v6so633257wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 23:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xnCjN0GiCt/F6FwuspP/Tf7Kb+RJYF9epuxPVppRZB4=;
        b=ibZo1QuQYnw1owT03gqZkFE4q5883qxaziktqgwqaFUC7CqKHGARMC8weHn6aseIbO
         VNyCxlgZbNuKRgqrvu7l/xyEckXTTaJOzTXHoL9FCyNar0pkpVggqUQTF7f0duc1xJfF
         gH0z0G0ZNiwaOw5Vx2Zyg7wUsM4yiEL8UN9ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xnCjN0GiCt/F6FwuspP/Tf7Kb+RJYF9epuxPVppRZB4=;
        b=hToY8r6vPb1ux+iCyhFIXj5fxd6YtJMWohXrN6FAvHQlBvABUcHuFZ/ZpATcP9TaYU
         vHuh4Ch6Ss1pyeTCdpjahWK46fW7G1ijmRc911whC4MEKpask0duFDifBdnblNzz323H
         Kzmeyi/AU4PFeIT+SSznOhkd8G/iG+GRIsprDy9COr9q/9KwF1V4mdQ8uTDEdY7yJtqu
         DTt8JRMYSTD5bXGadGdOgbHJpaTLRFDA3sYlCLtH/cQk5/rUVgD+2jiC7A3M0G7nBiqw
         2N72h3DSzditPZklBzMiyeKqxCDr+U7pKd0uLTJf35e3tqZL/lE854ryRvz14ogGZUWr
         iiOQ==
X-Gm-Message-State: ABuFfohvO/TKWtYiAIeuf0TiA/yzK3sbAtCF16TnGemKBBkPI3m3Z85C
        hLacAeD2U5lENBFbSSyVhF7RyA==
X-Google-Smtp-Source: ACcGV63wQQk729EdyoaFQkUJZl2e3yi4WKUZR/Wy9TpxRpjZ66gRN26ZsBh5+iwVx/IzhW3OVFaJaQ==
X-Received: by 2002:a1c:7614:: with SMTP id r20-v6mr862335wmc.52.1539068124824;
        Mon, 08 Oct 2018 23:55:24 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id j128-v6sm10358338wmb.43.2018.10.08.23.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 23:55:24 -0700 (PDT)
Date:   Mon, 8 Oct 2018 23:55:22 -0700
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] mfd: arizona: Correct link for sound binding document
Message-ID: <20181009065522.GD32033@dell>
References: <20180917153322.29206-1-ckeepax@opensource.cirrus.com>
 <20180926223944.GA30051@bogus>
 <20180928054646.GK8485@dell>
 <CAL_JsqLD=qzXiAptsR4X16_tYwSocFhrLJ=yh6caw1ke8YdESQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLD=qzXiAptsR4X16_tYwSocFhrLJ=yh6caw1ke8YdESQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018, Rob Herring wrote:

> On Fri, Sep 28, 2018 at 12:46 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Wed, 26 Sep 2018, Rob Herring wrote:
> >
> > > On Mon, Sep 17, 2018 at 04:33:22PM +0100, Charles Keepax wrote:
> > > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/mfd/arizona.txt | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Applied.
> >
> > Probably won't do any harm in this instance, but it's usually better
> > for MFD binding changes to go through the MFD tree to avoid
> > merge-conflicts.
> 
> It had been sitting there for a while, so I picked it up. Plus if we

A little over a week is not 'a while'. :)

> have conflicts within a binding (other than tree wide clean ups I do),
> that's not a good sign that the binding is changing.

Not sure I understand this.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
