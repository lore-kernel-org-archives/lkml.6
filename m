Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E688C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7592073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdGE7hpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7592073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbeH3SDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:03:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728942AbeH3SDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:03:15 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D4EC20836;
        Thu, 30 Aug 2018 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535637658;
        bh=UMBXX+QKbwUh+grHbQZF+3Z2G5PHqHEIpQl5gfke3xM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KdGE7hpkwl5F/6GjoIHbFXPifEAdFfH8wCHP6po1eiXnbUYrMmwqs3sUFOJiDD4M+
         nJcvj9UL1KemZj872QMBfnt6Vtvx+o6YlxpvQa+q++PbRUJFoNbw3K6e2n/uxSc21N
         1rkeRsddv0EAzcGIQazmwtJWpE8c+qTPn9Z47n4k=
Received: by mail-wr1-f51.google.com with SMTP id v90-v6so8194902wrc.0;
        Thu, 30 Aug 2018 07:00:58 -0700 (PDT)
X-Gm-Message-State: APzg51CC6qYVhUOTo1Wlm9tMY1DWMGEUeMw9GaJQhDjh5PSH3345agny
        aENrAmw/t6AdX67+OrQSAdaAploObrSXtU92Lts=
X-Google-Smtp-Source: ANB0VdYr4rIBC5qhu3goeEX+tcjWic/GMqHyMhsijR/o/aKR8fi5BewSuQrTuxYzwZTOFQb6wjc+eaoOhjeZkj7fCJQ=
X-Received: by 2002:adf:cc91:: with SMTP id p17-v6mr7730728wrj.226.1535637656992;
 Thu, 30 Aug 2018 07:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPfVXnazraHq-NCCM+h26FFi1U6Z3OSYOX17XH3bj-UDLQ@mail.gmail.com>
 <20180830133930.r7s5hmnriif46hlr@gondor.apana.org.au>
In-Reply-To: <20180830133930.r7s5hmnriif46hlr@gondor.apana.org.au>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 30 Aug 2018 16:00:45 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc4aFZYXCy8Kt_ky7-KEcQXtu0pH_PYpdvFQFrqtM2M4w@mail.gmail.com>
Message-ID: <CAJKOXPc4aFZYXCy8Kt_ky7-KEcQXtu0pH_PYpdvFQFrqtM2M4w@mail.gmail.com>
Subject: Re: Locking for HW crypto accelerators
To:     herbert@gondor.apana.org.au
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, smueller@chronox.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 at 15:39, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Aug 30, 2018 at 02:22:22PM +0200, Krzysztof Kozlowski wrote:
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
>
> After each operation all state must be stored in the ahash_request
> object.  The next operation should then load the state from the
> request object into the hardware.

Thanks, that's the solution I was missing.

Best regards,
Krzysztof
