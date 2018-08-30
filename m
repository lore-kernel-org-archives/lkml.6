Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A89C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE6020658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvbtDhxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE6020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeH3RLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbeH3RLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:11:23 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3669D20836;
        Thu, 30 Aug 2018 13:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535634558;
        bh=kYS66qYia24IcWzTldwoU3RWRivJ9qcaAVOOBwFKaVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EvbtDhxtb5nVvDlQzXDvikQmhR7a+P5adBbcSFCTJcgzyO6TRD9CH8kQ3BHVgbdbr
         15xO9fvTUeMh2rnm4v92Kqrw0w2BpU0RFTIDYKFoe2DPyz0r+ZWUPJFzb17fO/KM7y
         hi2oavvroU2LpJckyhThKxuxoXoPO4TCbURo0G8k=
Received: by mail-wr1-f51.google.com with SMTP id z96-v6so8006367wrb.8;
        Thu, 30 Aug 2018 06:09:18 -0700 (PDT)
X-Gm-Message-State: APzg51DXvJNFweUtJtCyyccazrgaqdY56xuTlAK3owqzkC+Q9AVztZgE
        WikiR5rYWgW7kOwEyURPM5/KLkuIw5wxpQqqywc=
X-Google-Smtp-Source: ANB0VdboEGv/BwVAhPD0+HbbIF+XUMzJsBj+OYVRGJN9aLtC+IGVkhPM+rMcllrhWFxYG74RSOJqz2WRU0Ve7BrM7ZY=
X-Received: by 2002:adf:f24e:: with SMTP id b14-v6mr7051575wrp.184.1535634556708;
 Thu, 30 Aug 2018 06:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPfVXnazraHq-NCCM+h26FFi1U6Z3OSYOX17XH3bj-UDLQ@mail.gmail.com>
 <3053033.se6UkFii4W@tauon.chronox.de>
In-Reply-To: <3053033.se6UkFii4W@tauon.chronox.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 30 Aug 2018 15:09:05 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd7JdzM2_PiHkS1ix1yU9hZmMbGDZaL07vbON0XzORH=w@mail.gmail.com>
Message-ID: <CAJKOXPd7JdzM2_PiHkS1ix1yU9hZmMbGDZaL07vbON0XzORH=w@mail.gmail.com>
Subject: Re: Locking for HW crypto accelerators
To:     smueller@chronox.de
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 at 14:59, Stephan Mueller <smueller@chronox.de> wrote:
>
> Am Donnerstag, 30. August 2018, 14:22:22 CEST schrieb Krzysztof Kozlowski:
>
> Hi Krzysztof,
>
> > Hi,
> >
> > I am trying to figure out necessary locking on the driver side of
> > crypto HW accelerator for symmetric hash (actually: CRC). I
> > implemented quite simple driver for shash_alg.
> >
> > I looked at the docs, I looked at the crypto kcapi core code... and
> > there is nothing about necessary locking. kcapi does not perform it.
> >
> > My HW is quite similar to drivers/crypto/stm32/stm32_crc32.c so it has
> > only one HW set of registers for dealing with CRC. Or in other words,
> > only one queue of one element. :) I implemented all shash_alg
> > callbacks - init(), update(), final()... and also finup() (manually
> > calling update+final) and digest() (init+update+final).
> >
> > Now imagine multiple user-space users of this crypto alg where all of
> > them call kcapi_md_digest() (so essentially init() -> update() ->
> > final()). It seems that kcapi does not perform any locking here so at
> > some point updates from different processes might be mixed with
> > finals:
> >
> > Process A:             Process B:
> > init()
> >                        init()
> > update()
> >                        update()
> > final()
> >                        final()
> >
> > My findings show that the requests are indeed being mixed with each other...
> >
> > Should driver perform any weird locking here? Or maybe that is the
> > case of using ONLY the digest() callback (so no update, no final)
> > because my HW cannot track different kcapi requests?
>
> The hashing is performed on a buffer provided by the caller. E.g. it is the
> buffer pointed to by the ahash request or the shash desc structure. All
> operations of init/update/final operate on that memory.
>
> If you have parallel requests, each caller has a private buffer that it
> provides to the kernel crypto API. This applies also to AF_ALG.
>
> Thus, as long as the individual operations of init/update and final are atomic
> operations, there should be no locking necessary.
>
> Thus, all your driver needs to guarantee is the atomicitcy of the init/update/
> final operation in respect to your hardware state.

Thanks Stephan for hints. Let's assume the each of init, update and
final are atomic... but how about the relation between update and
final? I have two concurrent users in user-space but only one HW:

Process A:             Process B:
init() and set_key()
                       init() and different key
update(some_data)
                       update(different_data)
final()
                       final()

The final() from process A will now produce the result of hashing/CRC
of some_data and different_data (and even maybe mixed with init() for
different key). All because in the meantime process B added its own
data to the HW.

Best regards,
Krzysztof
