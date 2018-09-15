Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4C1ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0749920866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XxxrCdpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0749920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbeIPEmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 00:42:47 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:51347 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725199AbeIPEmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 00:42:47 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id ba2d2aab;
        Sat, 15 Sep 2018 23:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=U56Xo5xCge8Q5vc05diG5NZX+0Y=; b=XxxrCd
        poQLv9b2kovk9fSEEI8xHJN/tu7G0S07ZSCEP3gCJuIRnHfsD52iyNy235EA+JVq
        pFTixL0e1VrqbRahghDFhd4pOQTZIpP5+Pwovp92KynanJSHAyraO+S5uBVidLRH
        FfSr+ubLFbsC9nq7IUqmcy4GF3ABibcmHFw2ttGMkK3NInLVmSaUzXi/mdiV0sGY
        Yzqo7zo9IegRiwBo+zMCV4JXrRCqcSRHn6JhvYm3F/5OaOn/ydi4Ys9mmd9JHgs8
        yv/TzG4+A4IaPdpnhYNUYsNUYbjIz7EV9L3vL0xR+A7iTeIqVQQFYKgTjqnmFcyL
        3FfzCIWtyNFtg0GQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ac6a9956 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 15 Sep 2018 23:04:48 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id v44-v6so7913053ote.13;
        Sat, 15 Sep 2018 16:22:02 -0700 (PDT)
X-Gm-Message-State: APzg51DpwM80cTIJvGHoibfGfRGCLG5FZzfxcxNbUMrlfODN4ZYWIcUF
        2Qkx7TSEmccpXYHjvvxz4CBKRhK/Hd2Zw196Bv4=
X-Google-Smtp-Source: ANB0Vdbwp/0SeqM0tjM20ZCz52cc3eF+f1cQy7xzUruWT+zwkyBmmktdpSkntqD65rwJOr2ycry3OSZtrA4kAdyLZk4=
X-Received: by 2002:a9d:3a34:: with SMTP id j49-v6mr8297034otc.317.1537053720005;
 Sat, 15 Sep 2018 16:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180914162240.7925-19-Jason@zx2c4.com> <201809160711.HzjdJedZ%fengguang.wu@intel.com>
In-Reply-To: <201809160711.HzjdJedZ%fengguang.wu@intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 16 Sep 2018 01:21:48 +0200
X-Gmail-Original-Message-ID: <CAHmME9qGDvSDmxAjz767fbV82Q9a1MLL1rWxqRhqQzwhCbAi_A@mail.gmail.com>
Message-ID: <CAHmME9qGDvSDmxAjz767fbV82Q9a1MLL1rWxqRhqQzwhCbAi_A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 18/20] crypto: port ChaCha20 to Zinc
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mr. Ro Bot,

On Sun, Sep 16, 2018 at 1:14 AM kbuild test robot <lkp@intel.com> wrote:
>    crypto/chacha20_zinc.o: In function `crypto_chacha20_crypt':
> >> crypto/chacha20_zinc.c:55: undefined reference to `chacha20'

Looks like my Kconfig change didn't get squashed in as intended. Fixed for v5.

Thanks,
Jason
