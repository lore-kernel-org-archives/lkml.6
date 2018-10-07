Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2C6C65C1D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF5920882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG3AEotX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF5920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeJGV0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 17:26:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35997 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeJGV0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 17:26:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id y11-v6so5742517plt.3;
        Sun, 07 Oct 2018 07:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VlgB46bbHj6hm6SbDezxuyW2muDsw6tzh2RFNjn6EAk=;
        b=XG3AEotXxVKCXQnpGiupJJuKY/qoWx6Wn0ZBMeSR1rQ6pbgeVO1EfYlxnYeTaiy4uZ
         JuKjoqgBWc6SeVNHbdcH0YMYZuwO2ga6XEcw3Jorg39SUqQ1BUOB4Sd4QgyFAiicCNrZ
         9xCzWhNqIbtprd123WHMxCVObNP1qFOqATCHnNO7HDFrBHrkjSBG2Rz15SVDtC0qLDnu
         rw75bizdCU9iHCHysVsJKj6ZTtR2+wpIEeTqUCYYjoAa4eQ86durdFqt3Ge9SUtqFh17
         GSAMnFXibbGqq4eL3Wehzekp+/T2ykeMALXUUTqLpjPMs8aFVM+W7UygTSZOaK1eQazV
         uG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VlgB46bbHj6hm6SbDezxuyW2muDsw6tzh2RFNjn6EAk=;
        b=qRQHIQLQudYqQ9nmFoayeM7+Krxanj+7t12ZlkgqLjmwd+8iBFtfSz5peWW84605vU
         6GCdivhyez2sSv6HIzmAxydW4w7uP2Lk2nXgvLktKKgruyFUGK/UoArPIvzlcIw1yhpz
         sTY4BYJJm9t68XpUFj2wBCbVASg73H9zeby3sw74LzKFWYKVHytemRTTcQzZvCUD5IdV
         tBCwgOfn2ciubE70YmdvzEroF1ib7DB75lwzwtuARLXQBorCJfIljJS9qay2nw8H6cvJ
         QwyqBmWX75yTKqAnUlVUO7pP0lIPHlc8U3AwW3lJD/Fpx7p9QSQhByaQLFwS/p2v7dzK
         rSsw==
X-Gm-Message-State: ABuFfoiErYl1sfmBP0CLKeE+3HyWyyRpdx5eE+3X/7ZMGJfaT7w1WSGC
        zaVdoE3SyQhlvLDVMxMcNWE=
X-Google-Smtp-Source: ACcGV61Dl+8/wAH4g/yy9sYad4NBC6yIRN1eMQUjNavtg0//eEMIoMhA0VTZkDQPEuOk1SasdykaqQ==
X-Received: by 2002:a17:902:a9cc:: with SMTP id b12-v6mr19663217plr.198.1538921965818;
        Sun, 07 Oct 2018 07:19:25 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o62-v6sm19542096pfb.0.2018.10.07.07.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 07:19:24 -0700 (PDT)
Date:   Sun, 7 Oct 2018 07:19:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org,
        patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.18 000/228] 4.18.12-stable review
Message-ID: <20181007141808.GA14337@roeck-us.net>
References: <20181002132459.032960735@linuxfoundation.org>
 <af80bbc1-6753-01d2-1ecb-830720b38f48@roeck-us.net>
 <20181003162539.GA4653@kroah.com>
 <20181003172440.GA7955@roeck-us.net>
 <CAL_Jsq+GBDB21tSDTq7p39SvQEGq1R3ZPeH7Yx+9fHttx3v9Ew@mail.gmail.com>
 <20181003180847.GA15682@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003180847.GA15682@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 11:08:47AM -0700, Guenter Roeck wrote:
> On Wed, Oct 03, 2018 at 12:53:11PM -0500, Rob Herring wrote:
> > On Wed, Oct 3, 2018 at 12:24 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Wed, Oct 03, 2018 at 09:25:39AM -0700, Greg Kroah-Hartman wrote:
> > > > On Wed, Oct 03, 2018 at 05:59:09AM -0700, Guenter Roeck wrote:
> > > > > On 10/02/2018 06:21 AM, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 4.18.12 release.
> > > > > > There are 228 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > >
> > > > > > Responses should be made by Thu Oct  4 13:24:08 UTC 2018.
> > > > > > Anything received after that time might be too late.
> > > > > >
> > > > >
> > > > >
> > > > >
> > > > > Build results:
> > > > >     total: 137 pass: 137 fail: 0
> > > > > Qemu test results:
> > > > >     total: 321 pass: 320 fail: 1
> > > > > Failed tests:
> > > > >     powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs
> > > >
> > > > What is the status of that powerpc failure fix?  What's the odds it can
> > > > get into mainline soon?
> > > >
> > >
> > > The fix has been -next for about a week.
> > >
> > > da08d8cb8cfc of: unittest: Disable interrupt node tests for old world MAC systems
> > >
> > > You'll have to ask Rob (copied) if he plans to send a pull request before
> > > the next commit window opens.
> > 
> > I wasn't planning to as it's just for the unittest and has been that
> > way for how long? Why's the unittest enabled for a defconfig anyways?
> > 
> 
> I enabled it to improve test coverage for stable releases. This is how
> I found the problem in the first place. Are you suggesting that I should
> not run DT unit tests for stable release candidates ?
> 
I have now disabled CONFIG_OF_UNITTEST in my tests.

Guenter
