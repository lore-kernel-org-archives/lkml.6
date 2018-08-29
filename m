Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED204C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 05:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8993420659
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 05:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="r5BcZn0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8993420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeH2JCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 05:02:01 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:57495 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbeH2JCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 05:02:01 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 2f7ee2f3;
        Wed, 29 Aug 2018 04:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=+/H235g0EyT+zZXsuxyqRNYzH4I=; b=r5BcZn
        0k79Hmo8EzxlHhoarKL8Il0ewuRMSPzO90o8pA2pH6ENw5IRjQQuztommK1LOiNh
        3ShuY5Y2p6lYvqvUHHwCvydbhMcsHByd6bbPQ/iEJG69OQ6vCyKn7nL03TK5lEve
        zzJO+DRxBtB3OV8lOagh3S31/N/1yool5dNtdSCiJwFXIjyoMuiLhR+ADA+Tqyxh
        0y7NQCeRAU2uST6JnuwZ6VN+P2uigiC+x2qW/fKT5d3ZlVQsM0xUd5iy0riCkBXh
        OfjaHZJLyk4kUIHoN0ND7WQDajCdYsOKEMawwFXQ8ZoGSN+e62fXRA4HNWujnXK1
        IWNh2e7EqvZSgfGg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3a384976 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 29 Aug 2018 04:51:56 +0000 (UTC)
Received: by mail-oi0-f49.google.com with SMTP id b15-v6so6941441oib.10;
        Tue, 28 Aug 2018 22:06:55 -0700 (PDT)
X-Gm-Message-State: APzg51A8e2pHLG2wRJTqgiEXQz1VY8lOxDidUHL6XtYPwFGwDYXU3yDD
        LbseBHqmYgzcWEpC7eaN1kEJYmciDai6MgDh0rU=
X-Google-Smtp-Source: ANB0Vdbg9nmANdX4mha03upHg/V2g9JGKfugHiWPPG20PKNZ4pNEsrsSXpTrLE2RqJzdS0oG5oCtmcMDQQJlse+11jE=
X-Received: by 2002:aca:2e86:: with SMTP id u128-v6mr1138879oiu.132.1535519213446;
 Tue, 28 Aug 2018 22:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-16-Jason@zx2c4.com>
 <CAKv+Gu-WVOBZ1sQwOKo29P_jWL86wOnzd1-sB_6mTbPX1Lz0NQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu-WVOBZ1sQwOKo29P_jWL86wOnzd1-sB_6mTbPX1Lz0NQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 28 Aug 2018 23:06:42 -0600
X-Gmail-Original-Message-ID: <CAHmME9rs+8kynZym=E4btqOu+Sh7MFn3kq7EPDXP27WzC9j_ZQ@mail.gmail.com>
Message-ID: <CAHmME9rs+8kynZym=E4btqOu+Sh7MFn3kq7EPDXP27WzC9j_ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/17] zinc: Curve25519 ARM implementation
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        "Daniel J . Bernstein" <djb@cr.yp.to>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ard,

Thanks for the thorough review. Very much appreciated. I've
incorporated nearly all of your suggestions into my development tree:

https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/tree/lib/zinc/curve25519/curve25519-arm.S?h=jd/wireguard

These changes will be part of v3.

Regards,
Jason
