Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3A0C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5165219ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YcegU8tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5165219ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733290AbeHGB1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:27:54 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:47203 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733134AbeHGB1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:27:54 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 13b2a031;
        Mon, 6 Aug 2018 23:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=AsPT6yrHznTEGHP2KZcVei6BUQY=; b=YcegU8
        tn6GATRIBNNzCeCi6mQrygK5Mfubva2QbJUQjKFpGblRnjvMWw/7y077kM/1mPJV
        RdVagzc6RyVe9y+0ghJs0kbhWivJnyKfSsWtIP9ZZ4F/NlAP3tWMifSgqNY75gRR
        TvbV+mXBFMfN2uZtwBSPdropiammZc0FCscYqng9mN+CYFHfbD63THDrO5RcVgKM
        4eHoIMB9rpwbg9XqFXP/SISRNYpst+040qYp3HHJ0WvVQZbnsSzqi7szHr8Qyptk
        lazKRTR169+NzBFhAjDT2QXC+DAfCMi/d5XT0EygBdyqpH81dECC7Wogpg2hojfj
        OkVixY5AY4U40UUg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5a39af2c (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 6 Aug 2018 23:04:23 +0000 (UTC)
Received: by mail-oi0-f54.google.com with SMTP id b16-v6so11865346oic.9;
        Mon, 06 Aug 2018 16:16:31 -0700 (PDT)
X-Gm-Message-State: AOUpUlE5tQZU6dIK8XEohodQcXAWe1jluRo7vU0vEgm5FtO2yif6V4sl
        iajW6LBpv8SLcqRSJoQ9/3h4iaR4lKj6QASR0g4=
X-Google-Smtp-Source: AAOMgpdMNlXDA4cJrdlmbrtXaMK1cPPh6+vj71hmgc0tp9xzHDEjaLAg4YoJC+CHrDD+6CnFEpHMlD4KGm8kzfrhOxI=
X-Received: by 2002:aca:7596:: with SMTP id q144-v6mr17701006oic.105.1533597390507;
 Mon, 06 Aug 2018 16:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180806223300.113891-1-ebiggers@kernel.org> <20180806223300.113891-4-ebiggers@kernel.org>
In-Reply-To: <20180806223300.113891-4-ebiggers@kernel.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 7 Aug 2018 01:16:18 +0200
X-Gmail-Original-Message-ID: <CAHmME9rbe6eT6dkUqKnp-GxcqGrp-tvMfTMr8kZtsn=S3cmP8A@mail.gmail.com>
Message-ID: <CAHmME9rbe6eT6dkUqKnp-GxcqGrp-tvMfTMr8kZtsn=S3cmP8A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] crypto: chacha20-generic - refactor to allow
 varying number of rounds
To:     ebiggers@kernel.org
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        samuel.c.p.neves@gmail.com, tomer.ashur@esat.kuleuven.be,
        Eric Biggers <ebiggers@google.com>,
        "Daniel J . Bernstein" <djb@cr.yp.to>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Eric,

On Tue, Aug 7, 2018 at 12:35 AM Eric Biggers <ebiggers@kernel.org> wrote:
> In preparation for adding XChaCha12 support, rename/refactor
> chacha20-generic to support different numbers of rounds.

I'm interested in learning the motivation behind going with ChaCha12.
So far, the vast majority of users of ChaCha have been getting along
quite fine with ChaCha20 and enjoying the very large security margin
this provides. In some ways, introducing ChaCha12 into the ecosystem
feels like a bit of a step backwards, even if it probably still
provides adequate security (though ChaCha8 probably shouldn't be used
or included at all). I realize the simple answer is just, "because
it's faster." But I'm wondering specifically about the speed
requirements and on what hardware and in what circumstances you found
ChaCha20 was too slow, and if this is the kind of circumstance you
expect to persist into the future.

Jason
