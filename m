Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60612C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E57206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AmpBZ3BL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E57206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeIZDNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:13:18 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:55375 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeIZDNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:13:18 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 47fdc031;
        Tue, 25 Sep 2018 20:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=MMQkR5HHFfip9P1xQBEsapuKSmA=; b=AmpBZ3
        BL2d0nnst3lJDdWlvZ1O7jcIxTjmsZdSVKkhuOb2ja/LnVFks7ZAGbBb/7XorEu7
        fTjJyk/RST608Mf7MBzY2Y5BI9bHMpRk5/zv9NqLgDmKb5xRShd7NBt83S4dgS2G
        TSbii3lGgg3Qs15tn9YySfnS4WEcQgJXaNBpIRHxwVwtaXHQO35Pq5AYM0KgHHxG
        dahpbafknMtVzD0wrvktYTqGuVIthu/UhEm1BLuN2Nfpy1IhqdCiSLoxc8FKG2E8
        OFxr6Udusgsg5YW2yeOf+ekRre6nuhB7GZxdxQacxKhPYVdSuaZ39xmwjEKwmIUE
        opIHCV0oM868RELw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7d2e4163 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 25 Sep 2018 20:45:22 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id a203-v6so2718958oib.0;
        Tue, 25 Sep 2018 14:03:50 -0700 (PDT)
X-Gm-Message-State: ABuFfoi9gEDzxSywCFXIO623BpqTkyza5zyAmO5GlZ0vsm/L4fy48A/D
        6COGDQ5B15jf86XHP14d/TfalM2A801dEyFNISI=
X-Google-Smtp-Source: ACcGV63PKFzUbKFVcVcByQoIJ+0uBkHIT3s9BCGVN18hP9wRlJPMom2JrGks4Nl/+9LC6SjJ0/s/l2e36fVGW2FNOTA=
X-Received: by 2002:aca:df42:: with SMTP id w63-v6mr1715993oig.295.1537909429546;
 Tue, 25 Sep 2018 14:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-3-Jason@zx2c4.com>
 <2b5f2df2f1278c118a913259a44efdf589719293.camel@perches.com>
 <CAHmME9qLzFHPm2aaEKOmjBA95-c3CZuT+kQiuksLRRWQ_ad2sw@mail.gmail.com>
 <748429eee2fc77afd01630c24bd2cf66a545aec5.camel@perches.com>
 <CAHmME9peVqXDq7hmFZ+4cus+Y97NHS-TyBKF9GkdLvixdmq6hw@mail.gmail.com>
 <abedae13e59e01200531931e530b46e937501c4a.camel@perches.com>
 <CAHmME9qp0_jQn5PeDHJc+Vs003vyqqMTdPmnchjBxxNMvHcJWA@mail.gmail.com> <102e1673681b4efb2079befa8d3fb532ed4e5285.camel@perches.com>
In-Reply-To: <102e1673681b4efb2079befa8d3fb532ed4e5285.camel@perches.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 25 Sep 2018 23:03:37 +0200
X-Gmail-Original-Message-ID: <CAHmME9pq1hyC78jVFnSjYu2=EDXaFiNU3bnzd4n7GcxQo3NWcw@mail.gmail.com>
Message-ID: <CAHmME9pq1hyC78jVFnSjYu2=EDXaFiNU3bnzd4n7GcxQo3NWcw@mail.gmail.com>
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

On Tue, Sep 25, 2018 at 11:02 PM Joe Perches <joe@perches.com> wrote:
> Then you should change the CONFIG_ZINC_DEBUG option too.

Yes, indeed.
