Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE792ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5B820869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aSjdQuG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5B820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeJTAFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:05:34 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:57833 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbeJTAFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:05:34 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 895d9314;
        Fri, 19 Oct 2018 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=daGgA772UPnfYGuXtkaT2VNFif8=; b=aSjdQu
        G2hqBonl0n0bURM+8WnMiTZWsZyKkwNR2747UQbZlG+eW0LGRE6pnzqFO4w5wzZH
        5thqKQT0DYiMma6izHNoyweceoeKN5Hg3e8RC16y1baKVfSstsDf51uWKFqTy6NZ
        1Wz5IUdifOMkGG1yll+ZUPg4yjteOmoLLcnNuMtXBBHu6PfLM3HRKzfpfN1TBaqY
        +nhzE1l4oLX10hr4v9zt06A3hE4aHV+2JGsZxsuTRJeFiVl2HLx+bnMweH+7bnsK
        I/NIXGT/tqwWjCf5Y1fwdjR1iOHAlLwwCEJ9Xa8AI8HZxTJrvpDh4Lo9aMSTRd2F
        KZO53mcZ8cAqz4Dg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 71656bb5 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 19 Oct 2018 15:56:39 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id l197-v6so27184755oib.8;
        Fri, 19 Oct 2018 08:58:48 -0700 (PDT)
X-Gm-Message-State: ABuFfogwh4oYyO+kUEG3dWRE7PR9ISyrVeG0VrmZLXHZC4dFq0zWBT8q
        znv1/b5+pQrB0yxL3qbGlML7u8+HjLCK2YtLG14=
X-Google-Smtp-Source: ACcGV63RrtI02kX4Ei1p0N2a3/SIl92k/Wn5+KuUCcMb5YkPppHSYgBol3vSzVx1dGWsLLmArf0+wAhRyuaJgWI0+SA=
X-Received: by 2002:aca:1111:: with SMTP id 17-v6mr19511053oir.278.1539964727505;
 Fri, 19 Oct 2018 08:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181015175424.97147-1-ebiggers@kernel.org>
In-Reply-To: <20181015175424.97147-1-ebiggers@kernel.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 19 Oct 2018 17:58:35 +0200
X-Gmail-Original-Message-ID: <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
Message-ID: <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/12] crypto: Adiantum support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

> As before, some of these patches conflict with the new "Zinc" crypto
> library.  But I don't know when Zinc will be merged, so for now I've
> continued to base this patchset on the current 'cryptodev'.

I'd appreciate it if you waited to merge this until you can rebase it
on top of Zinc. In fact, if you already want to build it on top of
Zinc, I'm happy to work with you on that in a shared repo or similar.
We can also hash out the details of that in person in Vancouver in a
few weeks. I think pushing this in before will create undesirable
churn for both of us.

> Therefore, we (well, Paul Crowley did the real work) designed a new
> encryption mode, Adiantum.  In essence, Adiantum makes it secure to use
> the ChaCha stream cipher for disk encryption.  Adiantum is specified by
> our paper here: https://eprint.iacr.org/2018/720.pdf ("Adiantum:
> length-preserving encryption for entry-level processors").  Reference
> code and test vectors are here: https://github.com/google/adiantum.
> Most of the high-level concepts of Adiantum are not new; similar
> existing modes include XCB, HCTR, and HCH.  Adiantum and these modes are
> true wide-block modes (tweakable super-pseudorandom permutations), so
> they actually provide a stronger notion of security than XTS.

Great, I'm very happy to see you've created such a high performance alternative.

Before merging this into the kernel, do you want to wait until you've
received some public review from academia?

Jason
