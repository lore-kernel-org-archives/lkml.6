Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212E3C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C9B20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="N8TSpA80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C9B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeILDE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:04:28 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:48323 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbeILDE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:04:28 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id fa29623a;
        Tue, 11 Sep 2018 21:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=NaJXhKOGX43G514LubTOOFbgrOw=; b=N8TSpA
        80DjsTU1XUxG4yDLG8N9NaPD40JrNfU7xJG1wR+54NHf7LP7L4osyJaI1w64djWD
        3zgy9XxA/27nf+Iu6KuabvblAMzvGng5ecX120TNmCCY2VPNmcak9l+XOxywDDxi
        R7e/SrBWhHvm7oZgJSE0YYohr+ecRjPX/ZEfGWd+G2Qty4buaevspllnlOEh+La5
        y69SUAJa4paj2cr4EPV6KrSgymMWUU17icGOVvk/nXOopVfs5xs0OOfBt10YtkJH
        DqAc7ofO4nB3TByCOjl7eH6WS5f9zNNJT7AcP5aeYHsfGddlVb7DiWZMOgiMT00M
        eefTGxVyRqy7tZwA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6200f21b (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 11 Sep 2018 21:46:23 +0000 (UTC)
Received: by mail-oi0-f52.google.com with SMTP id x197-v6so50317625oix.5;
        Tue, 11 Sep 2018 15:03:05 -0700 (PDT)
X-Gm-Message-State: APzg51C7HiB0nyOADtypUhtadwNpv01I2c7vk08xq4Rm/yKyGcGLadcf
        427bBQcHPNTb3ltdbQF6QCCW+20r3BynV9ralW4=
X-Google-Smtp-Source: ANB0VdZhc1Fwx27GGmJplrkOCLQQ/3S7ym9XMdqyHPlngC5sVL41Q2lbkeU8niID+bmYkW+Sk2H+2HL7n+pDsp/SHRs=
X-Received: by 2002:aca:fd4f:: with SMTP id b76-v6mr30369903oii.307.1536703385031;
 Tue, 11 Sep 2018 15:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <20180911145624.GA21635@kroah.com> <20180911214737.GA81235@gmail.com>
In-Reply-To: <20180911214737.GA81235@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Sep 2018 16:02:52 -0600
X-Gmail-Original-Message-ID: <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
Message-ID: <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 3:47 PM Eric Biggers <ebiggers@kernel.org> wrote:
> Of course, the real problem is that even after multiple revisions of this
> patchset, there's still no actual conversions of the existing crypto API
> algorithms over to use the new implementations.  "Zinc" is still completely
> separate from the existing crypto API.

No this is not, "the real problem [...] after multiple revisions"
because I've offered to do this and stated pretty clearly my intent to
do so. But, as I've mentioned before, I'd really prefer to land this
series through net-next, and then after we can turn our attention to
integrating this into the existing crypto API. This series is already
big enough and I would really prefer not to further complicate it.

So, what you want is going to happen. There isn't some kind of
fundamental problem here. This is more of a discussion on
scheduling/trees/mergecycles than anything else.
