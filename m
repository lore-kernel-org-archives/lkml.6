Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EC0ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8128420853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dunFdfIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8128420853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeINXDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:03:05 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:46891 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbeINXDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:03:05 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 1f32816e;
        Fri, 14 Sep 2018 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=04fgp+gPZBsNUpJrtAbEPPMJ1nw=; b=dunFdf
        INIQhbm/18K7YMPRidybeYxS1ksrU2owOI9omCpBF61FKUw4ENObF4qHy3t8lJo0
        zTT0JEitQGQBmEqoEh9cnR84cG4zyHvKp11jZipYopvSMktXBEYw/n5H5EjOyv+r
        oCH2he1+KYuodFNbGjU1e5r4wAvAsn2z+fJKFyeJ0FcCOueUKutWNdUKXbQGDV1/
        ZBuDJ3PFXJJ5plN9F7ea17AtHdeZ6pDU+1lh8/q5sqT1mGZRfNFd3ZhChJj0RZuu
        rCscIugBdk51NIV3NrkHum/N9RR6zHL2Iosun1RPs0Wz/+roQJic5hcwhjBCO0pc
        Wv8n4Vp6wUiiPS1g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ec96dc3d (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 14 Sep 2018 17:30:27 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id n5-v6so5377746otl.5;
        Fri, 14 Sep 2018 10:47:31 -0700 (PDT)
X-Gm-Message-State: APzg51CBrJYKx0lPJjEtmc4ClRYA5FZxl8TfuxwmxOYHj+RmEn+1c3Uf
        7yTFkOXrI4ra5KCn/E+S3Fy90JVkui+PhQCIfZk=
X-Google-Smtp-Source: ANB0VdYE98DyiXKrwPoEogC/yxPdRscGEbjvWzUedLUSHQI/fudEo+bFLYTRyoWJJuNgC9hx3wP3hvzFkCek8bgCCKE=
X-Received: by 2002:a9d:2dc8:: with SMTP id g66-v6mr4958654otb.311.1536947250977;
 Fri, 14 Sep 2018 10:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180914161954.7325-1-Jason@zx2c4.com> <CAKv+Gu_LYsNs88uF4+G1xfOtWvNPOjiiYZKqZf7qSBkvn6iEoA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_LYsNs88uF4+G1xfOtWvNPOjiiYZKqZf7qSBkvn6iEoA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 14 Sep 2018 19:47:18 +0200
X-Gmail-Original-Message-ID: <CAHmME9phjkOuODQEUXp=ZZLGDg3ypUPRr6YYPsMDgfvAdNcznA@mail.gmail.com>
Message-ID: <CAHmME9phjkOuODQEUXp=ZZLGDg3ypUPRr6YYPsMDgfvAdNcznA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/20] WireGuard: Secure Network Tunnel
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 7:40 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> >   - Move away from makefile ifdef maze and instead prefer kconfig values,
> >     which also makes the design a bit more modular too, which could help
> >     in the future.
>
> Could you elaborate on this? From the patches, it is not clear to me
> how this has improved.

Feature detection was prior done as a confusing set of ifeq and
ifdefs. Instead, I've now put the logic for this into the kconfig,
which makes the makefiles and header files a bit simpler. This also
makes it easier to later on modularize Zinc itself if deemed
necessary.
