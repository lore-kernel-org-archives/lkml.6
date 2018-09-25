Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86212C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296B72086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Wfj2JdwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296B72086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeIZDEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:04:09 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:56813 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeIZDEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:04:09 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 6fb0587d;
        Tue, 25 Sep 2018 20:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Rdzzy2thrMrDbLHNdqfzHtyYadM=; b=Wfj2Jd
        wFkKMZHC0pPxabxp+Tb5qUmjVLp9Z7uzD1cF7164EUSux+9yeYGhuZ5SSRRD6d58
        MwVmm7BIYLNh1jtsf0yQVdf7txdnaSybpa4Bs1h8Lw+LazyDYTgzgWF1KYQSizvi
        9NuRbSR3U9tow/sZLri9NR5kSMWfcu1/XxXX7/T9AQLUI1NGgFLPhuZc3mSvqvMw
        ROf2fbne1690YSJ6JwJjA4ocom7Bd+Gqw4wnhp/07FLXFAiZKOQSwlFC2AxUmypW
        sL60uUMwOaW8GV7GtoP2GM7kZbgiKKn9ZY6WeDbO+wUGp2vMhmyLw7eI7ZyExsrC
        OdXwy6XkyePwb6BA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b4ba2e5d (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 25 Sep 2018 20:36:14 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id e18-v6so25896971oti.8;
        Tue, 25 Sep 2018 13:54:42 -0700 (PDT)
X-Gm-Message-State: ABuFfohCMrGJf0QZsMvVjnGS/0IbGPJphQjzlJ/fpqBwfhMvOvqjoTVJ
        Z4h47OFdANdpKn2M/1eagHWi2c0lQo91Oq2xPE0=
X-Google-Smtp-Source: ACcGV619wcVdkmO2Yd5PjirOhPja+OxQ3viLaMnHF1Hcu6fIlMGeysdWDmP4jlyCjVIRQUE+fh+j31uDo3sZWg2QUPk=
X-Received: by 2002:a9d:522d:: with SMTP id e45-v6mr1917398oth.250.1537908881103;
 Tue, 25 Sep 2018 13:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-3-Jason@zx2c4.com>
 <2b5f2df2f1278c118a913259a44efdf589719293.camel@perches.com>
 <CAHmME9qLzFHPm2aaEKOmjBA95-c3CZuT+kQiuksLRRWQ_ad2sw@mail.gmail.com>
 <748429eee2fc77afd01630c24bd2cf66a545aec5.camel@perches.com>
 <CAHmME9peVqXDq7hmFZ+4cus+Y97NHS-TyBKF9GkdLvixdmq6hw@mail.gmail.com> <abedae13e59e01200531931e530b46e937501c4a.camel@perches.com>
In-Reply-To: <abedae13e59e01200531931e530b46e937501c4a.camel@perches.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 25 Sep 2018 22:54:29 +0200
X-Gmail-Original-Message-ID: <CAHmME9qp0_jQn5PeDHJc+Vs003vyqqMTdPmnchjBxxNMvHcJWA@mail.gmail.com>
Message-ID: <CAHmME9qp0_jQn5PeDHJc+Vs003vyqqMTdPmnchjBxxNMvHcJWA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 02/23] zinc: introduce minimal cryptography library
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, Sep 25, 2018 at 10:21 PM Joe Perches <joe@perches.com> wrote:
> I'd still prefer as all these are effectively
> debugging output that you convert the pr_info
> uses pr_debug and so avoid using pr_fmt altogether.

I started to write back, "sure no problem, this will be in v7," but
then I gave it a closer look, and I think actually I'll be changing
these into pr_err/pr_info and not naming this "DEBUG" but rather
"SELFTEST", since I think these are actually very good to have beyond
mere debugging.

Jason
