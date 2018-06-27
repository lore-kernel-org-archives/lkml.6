Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA02C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098ED2666A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="ICrp47SP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098ED2666A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932999AbeF0Hv6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:51:58 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:10095 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932470AbeF0Hv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530085914;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Yo7zgxDlfAKcg591MsOTqYEZ1Hxvbqyxl7ffvsGmxzk=;
        b=ICrp47SPJT0O/PIiQ6xNp3vcQpyWX89UMTR5Ax9CTt+3SohbVIrcc1Pw6OuJZ5znpn
        yrJcOYnQqQOa65W2OK27LsMJBXO8sAZDzU7IBtEgFEvKpOZesenx0mlaV2/XcgasA/6r
        kANg158Ib9bo5R6ERiDKSrHvMCCv/XkR9ZgSODxRdrwIvk2ShsRLKLHvoqFzR/QjhPYu
        OZgwDbcwyfjatqBKxtIyqr+iU816OdrvdQGmiig9RgCQzx7OXuTphZjSzlyOlCGIIa0s
        zXRF7UCXgJTt4CtK+motdO+pFUhi5cc8YFL9wmKJK7mglFx6QfM2StrTneVcXziSnNH2
        +Vtg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zW4DNhHoQE+naq/Tly14H1nAt7oghSPofJc0EJAN2fP8qsY44dqiWA=="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 43.10 AUTH)
        with ESMTPSA id a09e74u5R7pn01B
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 27 Jun 2018 09:51:49 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Vinod <vkoul@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
Date:   Wed, 27 Jun 2018 09:51:48 +0200
Message-ID: <3762582.fWXRAqm3bE@tauon.chronox.de>
In-Reply-To: <20180627070144.GG22377@vkoul-mobl>
References: <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au> <170012246.0U45yCEtus@tauon.chronox.de> <20180627070144.GG22377@vkoul-mobl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 27. Juni 2018, 09:01:44 CEST schrieb Vinod:

Hi Vinod,

> > > Currently am doing bunch of initialization in .probe (platform driver)
> > > and I think recommendation would be to move that to .cra_init, which
> > > seem
> > > plausible but I don't have pdev to read hw_resource etc.. so would still
> > > need to get that.
> > 
> > It seems that your allocation during probe relates to the hardware
> > resource
> > where you only have one in the system. Thus, doing the allocation here
> > makes sense. And, you do not want to perform probe or such resource
> > allocation once per crypto API RNG instance allocation. As said, there
> > can be multiple or even they can be allocated and deallocated frequently.
> > This in particular applies if your driver's "stdrng" has the highest prio
> > which means that it will be allocated and deallocated frequently.
> 
> Right, that is how I visualized it.
> 
> Is there a way where we can tweak the register API to pass hw_resource
> pointer and get that back? Would that work with the security model in
> crypto.

I would not see an easy way for that. The core register API of the kernel 
crypto API would need to be changed.
> 
> I do not like globals and somehow don't feel that we should do it that
> way

Granted, I concur here.



Ciao
Stephan


