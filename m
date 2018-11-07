Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8214C46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8245B20883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MlLHKAAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8245B20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbeKHC3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:29:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46706 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeKHC3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:29:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id c16-v6so6566747qtj.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 08:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=U+ReFA8lStBjKrskJnos8Rq1GeNKX0AwYgAKm549ynE=;
        b=MlLHKAAnzILkd6zR7a1ltIyVJLEigwD5Z4mvdbhdSHqFtSZlVvxHnG1NdzqZBLMsEL
         KpW64/r54HLsAlELM6BX7JSVAhki+endKrkfnX89ClYsyJbEEdDNqIFk6oC9laa1irGK
         ElhUQ5PJ+wBvzD5RdkJC4VmzCMrWxFUGQHkpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=U+ReFA8lStBjKrskJnos8Rq1GeNKX0AwYgAKm549ynE=;
        b=d5jPuMOO/VbBV3AvWjjb2SR7sxy7PlMZ5cZyl4792tqRXyY7N4+kf/kk8CplVIe0d8
         AB0oeBvGwJb1ZIv4Lg5AkluMSRnMl+gxJMhm4lv82Sv0DTtGxTPrFYxkHNiTbn2hwzKW
         RZ9L4TSX+UFhFgcte0DQgm75ifEqLaEW8qaZEhHzFKUQKoyfOKHkAm5RXx0oQwDO51iK
         vBOaBcHVbx6Quh6gmvyOlwSNkfbIg4ezI7zay46Ak5tnNjs0cBWQM2aEIPu+LMUxa9+I
         u0cgNeXvqxvzC95LJ9fGXC4+zGxFVw6MjleLy/MSH9DovOEdHeWwDMtBbVNfBKkVeDNX
         P4kQ==
X-Gm-Message-State: AGRZ1gKiKTsSe1tceJLrEgLCu9+TeL8Yqrk9S7Qw4orhInhZQpSFLPPc
        tvHGvDr5162DCt12qURyNy4EvRt+1m8=
X-Google-Smtp-Source: AJdET5d5LkliHWJIBur1DQ9qgXr8dtsh38BR8QmBZ91ks+Ha1jN9QqDwXvxMkoA2OtGUocHiZV/z1g==
X-Received: by 2002:aed:25f2:: with SMTP id y47mr959135qtc.217.1541609907930;
        Wed, 07 Nov 2018 08:58:27 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id u16sm649227qkg.14.2018.11.07.08.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 08:58:27 -0800 (PST)
Date:   Wed, 7 Nov 2018 11:58:26 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Stefan Agner <stefan@agner.ch>
cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Roman Yeryomin <roman@advem.lv>
Subject: Re: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands
 list
In-Reply-To: <806401fd406b1391fd3a9f5e072c107a@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1811071154590.23219@knanqh.ubzr>
References: <20181015221629.13924-1-stefan@agner.ch> <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com> <20181016084416.GF30658@n2100.armlinux.org.uk> <nycvar.YSQ.7.76.1810161357580.1498@knanqh.ubzr> <fe7595f5d02424c9d92e437cd20361f9@agner.ch>
 <nycvar.YSQ.7.76.1811052231220.1498@knanqh.ubzr> <806401fd406b1391fd3a9f5e072c107a@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018, Stefan Agner wrote:

> On 06.11.2018 05:49, Nicolas Pitre wrote:
> > So here's the revised patch. It now has full compile-test coverage for 
> > real this time. Would you mind reviewing it again before I resubmit it 
> > please?
> 
> Compile tested all copypage implementations with the revised patch using
> Clang too, everything builds fine.
> 
> FWIW, I used this defconfigs:
> copypage-fa.c: moxart_defconfig
> copypage-feroceon.c: mvebu_v5_defconfig
> copypage-v4mc.c: h3600_defconfig+CONFIG_AEABI
> copypage-v4wb.c/v4wt.c: multi_v4t_defconfig
> copypage-xsc3.c/scale.c: pxa_defconfig-CONFIG_FTRACE
> 
> The changes look good to me:
> 
> Reviewed-by: Stefan Agner <stefan@agner.ch>

Thanks.  Submitted here:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8805/2


Nicolas
