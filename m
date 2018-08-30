Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E547C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CC12073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1vF7c//5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CC12073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeH3QY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:24:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbeH3QY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:24:29 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 550B720835;
        Thu, 30 Aug 2018 12:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535631755;
        bh=kx93GrFcBPvCaooof/mjkFoZx15gJ+/IuqHVIGP48tQ=;
        h=From:Date:Subject:To:From;
        b=1vF7c//5fxioUm/QpmMwvANq+xD2nAttU+zvdOFfQWfEqAl8ubNAKKl2BkyzmM+dK
         3Pl+rn8jy4xBh5tJphoKgMJvxYyfozIArV7s+CcVi+us8Et3Ae7XjpaBn+J4/+Go45
         zom0eVQl9esa0AaSVY+V5xyk41j+RCf6YkpULchc=
Received: by mail-wr1-f51.google.com with SMTP id j26-v6so7884597wre.2;
        Thu, 30 Aug 2018 05:22:35 -0700 (PDT)
X-Gm-Message-State: APzg51Az4OsJSuM13M+EK49oEF0yiH+BjpkVB+YM/pjOpqXFk8+7HogO
        WPqEA4Hrk8NKvrC2nZ8rw8alYhjwVOECkART31g=
X-Google-Smtp-Source: ANB0Vda+XXiIR9zbkgr75xvdRf6UIFTx48NRvHJk+MPiW4uODygtpfAx9HBOMoBQEUSerLKEnOzC+f2wlhd0r6lPdAc=
X-Received: by 2002:adf:cc91:: with SMTP id p17-v6mr7456508wrj.226.1535631753843;
 Thu, 30 Aug 2018 05:22:33 -0700 (PDT)
MIME-Version: 1.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 30 Aug 2018 14:22:22 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfVXnazraHq-NCCM+h26FFi1U6Z3OSYOX17XH3bj-UDLQ@mail.gmail.com>
Message-ID: <CAJKOXPfVXnazraHq-NCCM+h26FFi1U6Z3OSYOX17XH3bj-UDLQ@mail.gmail.com>
Subject: Locking for HW crypto accelerators
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        smueller@chronox.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to figure out necessary locking on the driver side of
crypto HW accelerator for symmetric hash (actually: CRC). I
implemented quite simple driver for shash_alg.

I looked at the docs, I looked at the crypto kcapi core code... and
there is nothing about necessary locking. kcapi does not perform it.

My HW is quite similar to drivers/crypto/stm32/stm32_crc32.c so it has
only one HW set of registers for dealing with CRC. Or in other words,
only one queue of one element. :) I implemented all shash_alg
callbacks - init(), update(), final()... and also finup() (manually
calling update+final) and digest() (init+update+final).

Now imagine multiple user-space users of this crypto alg where all of
them call kcapi_md_digest() (so essentially init() -> update() ->
final()). It seems that kcapi does not perform any locking here so at
some point updates from different processes might be mixed with
finals:

Process A:             Process B:
init()
                       init()
update()
                       update()
final()
                       final()

My findings show that the requests are indeed being mixed with each other...

Should driver perform any weird locking here? Or maybe that is the
case of using ONLY the digest() callback (so no update, no final)
because my HW cannot track different kcapi requests?

Best regards,
Krzysztof
