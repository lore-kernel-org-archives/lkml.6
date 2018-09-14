Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CD4FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B8E20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TeIfAq1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B8E20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeINXKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:10:02 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:38409 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbeINXKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:10:02 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c8013f50;
        Fri, 14 Sep 2018 17:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=4a9oHvQikWZlmEcDqcGc23axdBg=; b=TeIfAq
        1ch0oQB2GNE0dVhU4hUoafrg9aQRzr2KmrDrFD5MZUNCgv2yfq3EZPEWqUdhB8JX
        tss6ylxn2qphxrPBJcGREkJOmNfthgKPP+1Ne8zGrhAv06sqBKInvr6/Itx4tRsC
        M/UJ0Wdsd65mq7IAvH94W+4sVZks3TGBUvsXPg6cHtDnzSW8FPu/FmRB2A7zGbZE
        Z/m5HtO2mrrcZoqvn1cw0ML8ZrIf8VaVhqfQxFGee7tefMrqHxivmNLuJ82WR1fW
        vzi3UNN6zerXTCIOwnWO9SonuCxwA/RcbUI7/qW5/0XpCqNJ5WEFQvDuoB5ORj5I
        ycRz+ygtcJpIPNTQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5187f760 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 14 Sep 2018 17:37:21 +0000 (UTC)
Received: by mail-oi0-x230.google.com with SMTP id y207-v6so13525739oie.13;
        Fri, 14 Sep 2018 10:54:25 -0700 (PDT)
X-Gm-Message-State: APzg51C2sOrZml/n8zV9Sz5H7wGJuh7Cl62KYC6b2Q4OoGbLRJaBhrtl
        lSjX7+5Ze8oqTQKf3kzl8HuvHUGPHa1CpXc1Jao=
X-Google-Smtp-Source: ANB0Vda09I3k6bei8PFmEZq8ZNHZYLbgviHNq2XLBGXDl5z73IQms0p7NhaUJJmc6FCDQTcPBpsFxacDVrtM+Uzxz6g=
X-Received: by 2002:aca:e795:: with SMTP id e143-v6mr10410482oih.252.1536947364438;
 Fri, 14 Sep 2018 10:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180914162240.7925-1-Jason@zx2c4.com> <20180914162240.7925-19-Jason@zx2c4.com>
 <CAKv+Gu-wwFJOL82+iJYCu8rbzeDWLYH=5PtGOJBUouB1zdiZjg@mail.gmail.com>
In-Reply-To: <CAKv+Gu-wwFJOL82+iJYCu8rbzeDWLYH=5PtGOJBUouB1zdiZjg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 14 Sep 2018 19:49:13 +0200
X-Gmail-Original-Message-ID: <CAHmME9o737NcFNobmJf8LVq51-Vd9gqR9jntgSAtJSP5gnBdTA@mail.gmail.com>
Message-ID: <CAHmME9o737NcFNobmJf8LVq51-Vd9gqR9jntgSAtJSP5gnBdTA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 18/20] crypto: port ChaCha20 to Zinc
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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

On Fri, Sep 14, 2018 at 7:38 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> so could we please bring that discussion to a close before we drop the ARM code?

My understanding is that either these will find their way up to AndyP
and then back down here, or Eric or you will augment the .S in this
patch at a later date with an improvement commit that includes some
benchmarks.

Jason
