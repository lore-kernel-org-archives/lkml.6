Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0C9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89647208B0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm5lsIKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89647208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391595AbeHPRna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:43:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33919 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387920AbeHPRna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:43:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so3880150ljk.1;
        Thu, 16 Aug 2018 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qBxbROM1k9F8/ORuHlv3cnYc9rLSXJYRNrBNVec3jo=;
        b=jm5lsIKAkbED62cthZO810XpXM1vgSsrnoz785s4mfiYaaO4Y6buOVkm5NOJVvynyo
         kV7IMjyJrRgFQ4u51vSYzS5RbpfcLCEVl/d1ewK2vwXZ13kqksJSvP0+aHFOjTMu/L3m
         IPlWyEOpDkMFuQMUYOMCNS9Vn0YqFRu6MQwq5FO7Py6tTY76aw+THbPZuoB7ev5Y3q6U
         YTEbPJTgfm/TvMdXWaVWgxtOcwEP2copTxhbdFFAhuxxY4L2emUt6JTCPokhC34HD1ot
         Dwb2lKduXqdsFAGg9+/0a/aUlMoizV0bgvPi9k36CK+5Wg7vsAYdPfvvJ7DhQlwNStF5
         F/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qBxbROM1k9F8/ORuHlv3cnYc9rLSXJYRNrBNVec3jo=;
        b=pxCd5R/saPaNKYtaSkE0QNFthK5LFnQI+MyROiK0Jb+8AXJOY4a8TD9Y4aLoiruhFG
         Qv1j03RRHRL8jGx6z3b51hgew3j8MGAusGR46ldVXjFYEZvGmyYvRRH6ngoR3WOeths4
         XFVvOFZG47WElZRcNjJF2ZQJVns79Qju8VPjfINST6HNfEQDH+83ucVUYc9EOaCQH87w
         SgCBSVQYzke+GEb5PA2/7Ho9M/6rzrg/giwJ68DAHhFSpVN4qHFuoiY6/442dLq2hftx
         UtS1+D/TZm1KJih5mh5MZsdPgLr8109t99z4PPlT4CftMFugUiZIG512dpqrYPHdN6JB
         IVFg==
X-Gm-Message-State: AOUpUlFqB6muKbwAuSb7n+aF0JqucM/rBKOl92B2Ly1UnNryiUG46LFi
        aOMwzEsq3Ztz9JYpKYuAbI0=
X-Google-Smtp-Source: AA+uWPxTRLDWU/qzvTgCejVA7s5Msn0meMKx+KkcluPIRDFoTSByG/KCvE8+tVeGwm3kNPQ0cIaeWw==
X-Received: by 2002:a2e:9c82:: with SMTP id x2-v6mr22205848lji.131.1534430669578;
        Thu, 16 Aug 2018 07:44:29 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id w12-v6sm4432705lji.63.2018.08.16.07.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 07:44:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Stefan Agner <stefan@agner.ch>, thierry.reding@gmail.com
Cc:     jonathanh@nvidia.com, linus.walleij@linaro.org,
        pdeschrijver@nvidia.co, marcel.ziswiler@toradex.com,
        keescook@chromium.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: tegra: readd gpio-ranges properties
Date:   Thu, 16 Aug 2018 17:44:27 +0300
Message-ID: <1828884.n7pPtpPvFR@dimapc>
In-Reply-To: <2268060.eSddBDDeqC@dimapc>
References: <20180726154025.13173-1-stefan@agner.ch> <2777476.ese58fB1FL@dimapc> <2268060.eSddBDDeqC@dimapc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 2 August 2018 13:35:46 MSK Dmitry Osipenko wrote:
> On Thursday, 2 August 2018 02:11:23 MSK Dmitry Osipenko wrote:
> > On Thursday, 2 August 2018 01:51:42 MSK Stefan Agner wrote:
> > > On 01.08.2018 22:51, Dmitry Osipenko wrote:
> > > > On Thursday, 26 July 2018 18:40:25 MSK Stefan Agner wrote:
> > > >> The properties have been commented out to prevent a regression a
> > > >> while ago. The first regression should be resolved by
> > > >> commit 44af7927316e ("spi: Map SPI OF client IRQ at probe time").
> > > >> 
> > > >> The second regression is probably addressed by
> > > >> commit 494fd7b7ad10 ("PM / core: fix deferred probe breaking suspend
> > > >> resume
> > > >> order") and/or maybe others. Readd the gpio-ranges properties to see
> > > >> whether regressions still get reported.
> > > >> 
> > > >> This reverts commit 4f1d841475e1f6e9e32496dda11215db56f4ea73
> > > >> ("ARM: tegra: Comment out gpio-ranges properties").
> > > >> 
> > > >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> > > >> ---
> > > > 
> > > > Unfortunately the second regression hasn't been addressed yet, this
> > > > patch
> > > > still breaks wake-up using GPIO key. BTW, better to spell "readd" as
> > > > "re-add".
> > > 
> > > You do have the hardware and could test it?
> > 
> > Yes, I have.
> > 
> > > Hm, that is unfortunate. I think this was the patch which should address
> > > the issue:
> > > https://lkml.org/lkml/2015/9/10/218
> > 
> > I've tested the patch and it is still actual, i.e. it fixes the wake-up.
> > Welcome back to 2015 :-)
> 
> Actually, the pinctrl-gpio probe order is easily fixable by reshuffling the
> drivers registration order within the kernel. I'll send patches.

Linus applied the GPIO / PINCTRL drivers probe-reorder patches for-next, so 
this DT patch should be good for 4.20.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>


