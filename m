Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA6EC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6797720879
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390124AbfA1QmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:42:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33047 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388926AbfA1QmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:42:13 -0500
Received: by mail-qt1-f196.google.com with SMTP id l11so18984456qtp.0;
        Mon, 28 Jan 2019 08:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Seb+vsjeDDo4nWRYcSrSTH7YxWGTcZxRanKkOKBpbKA=;
        b=oyqX8ipmqWxYAmQhHE2jkN38hVPn4UK1KfvsiS1OwifzSvIh1AoDf5Gt0+PHRO2QsI
         rfNHjVwKgr0mKbgt7eyvlc+/pDjnov9WYEPZz3nENwLM5wcMUSav2wHLkYS/v+TRMjC8
         suGRTfvdGOclPsTIVTIqkDkMO37V9OCJLYly+PsX6i+eI5DsM0FjioOp/4tca//d/Kya
         icKNbgYu9AQibh7V4uFolz72lGIr5rGE60Y/Hwn4Ge83Dgv57dpdqmXXx5Yc5HzWnnsW
         umYm/2DywhHZH6ylc3KFH106s/4ZcaNMLWMx6LWtpHrh+uZdhYxpDnbOcCHGHHt7/HCK
         vsEg==
X-Gm-Message-State: AJcUukeDI3EJCjL7yw7880NhOOjYuEnnBbZb7Z8h63tmBUv/At2qE82s
        lXqW+tY6EkLNrAwmcGbwCk9fPCRYejpIBVYpUDE=
X-Google-Smtp-Source: AHgI3Ib9npUIcSYDhZQbOSwoOisbzGQ5ZhH5Pf28jelh3gdFMe/ui1A65deoFjBDFll2IC2RKshrTOja4jA60zXeEuA=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr10791584qtl.343.1548693732472;
 Mon, 28 Jan 2019 08:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20190128154341.47195-1-sashal@kernel.org> <20190128154341.47195-175-sashal@kernel.org>
In-Reply-To: <20190128154341.47195-175-sashal@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 28 Jan 2019 17:41:55 +0100
Message-ID: <CAK8P3a3z8tOxz=Rem6N7m_0_8OaU9Sxf7yViZJP5fmYGeaxUvQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.20 175/304] ARM: mmp: fix timer_init calls
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Lubomir Rintel <lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 4:52 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> [ Upstream commit 12d3a30db4a3b3df5fbadf5974b9cf50544a9950 ]
>
> The change to passing the timer frequency as a function argument
> was a good idea, but caused a build failure for one user that
> was missed in the update:
>
> arch/arm/mach-mmp/time.c: In function 'mmp_dt_init_timer':
> arch/arm/mach-mmp/time.c:242:2: error: implicit declaration of function 'timer_init'; did you mean 'hrtimer_init'? [-Werror=implicit-function-declaration]
>
> Change that as well to fix the build error, and rename the
> function to put it into a proper namespace and make it clearer
> what is actually going on.
>
> I saw that the high 6500000 HZ frequency was previously only
> set with CONFIG_MMP2, but is now also used with MMP (pxa910),
> so I'm changing that back here. Please make sure that the
> frequencies are all correct now.
>
> Fixes: f36797ee4380 ("ARM: mmp/mmp2: dt: enable the clock")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I did not think that Lubumir's patch was meant for stable,
but as you've picked that one already we clearly
want mine as well, so this is good for all stable kernels.

     Arnd
