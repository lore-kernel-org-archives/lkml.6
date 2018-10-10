Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA32AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B652075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mNtiSimj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B652075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeJKDvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:51:49 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:36463 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbeJKDvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:51:49 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a2e0f955;
        Wed, 10 Oct 2018 20:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=AqSuYorsOoYuVwNLU57lRGJi/Vw=; b=mNtiSi
        mjW4fRJ0JEzkPfhg8BVPDPUk1OilkbF9ZviGAcC+hOFTsaYvcVB+zpA/w/xfeBUi
        nderSkQeoCZtoNcRKAjU2T2w7dXSNb4f2cA4xkp7H/VDYBstXe2BIA55exYVrPqr
        GG2jaggSV2dtRB1gKg14Qw3AI5nKl7mtdJauwqHKLlctOe3vwNRvp1aMicIKJW65
        4iRlTiHII+gryF5eCh8qOqR9SXUVg2/JMCh1tK3+2GvA79ej0u8x8Bj3iLCtLiBb
        XAdncPrZHdd2j+EFAOYDP/HSBeY7StBweOort7bx3DeFtJxg3avZ/MLzA1F/mPiv
        vzKHX0Jl2jERhyhw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 26ea1a9d (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 10 Oct 2018 20:26:55 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id 14so2697971oth.2;
        Wed, 10 Oct 2018 13:27:59 -0700 (PDT)
X-Gm-Message-State: ABuFfogMrE8MYIzlSyiZv/IvVG9/QsmVAqlq5cvgseepHZ45mLDdNyBs
        rcFO97aCBYJI506mXEwFFCD2VohfWXZ6C+of18Q=
X-Google-Smtp-Source: ACcGV608V3tivvjKxzeWEwZROfM9pOFd+OHz8fxvAqVJB6mBg3Q5JhFovBTfncHdq33Gjj5OUPPf8pjzR6whZ3G3esA=
X-Received: by 2002:a9d:30c2:: with SMTP id r2mr20112358otg.143.1539203278529;
 Wed, 10 Oct 2018 13:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181006025709.4019-1-Jason@zx2c4.com> <20181006025709.4019-29-Jason@zx2c4.com>
 <20181006065819.GD3061@nanopsycho.orion> <CAHmME9pKvUOaAHhe7gb3yH4jdkdTtLv+gUqdnh3bJZcN776UWQ@mail.gmail.com>
 <20181010091358.GB5027@nanopsycho.orion>
In-Reply-To: <20181010091358.GB5027@nanopsycho.orion>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 10 Oct 2018 22:27:46 +0200
X-Gmail-Original-Message-ID: <CAHmME9o_XjDXqRTGSxAjdNj9RXaHwgC_ZFYLUB8uD6mWvj=aEw@mail.gmail.com>
Message-ID: <CAHmME9o_XjDXqRTGSxAjdNj9RXaHwgC_ZFYLUB8uD6mWvj=aEw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 28/28] net: WireGuard secure network tunnel
To:     =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jiri,

Actually, in the end I went with the suggestion from Andrew and Lukas,
which is to follow Dan's guideline:
https://lkml.org/lkml/2016/8/22/374 . It looks like this:

https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/tree/drivers/net/wireguard/device.c?h=jd/wireguard#n280

Jason
