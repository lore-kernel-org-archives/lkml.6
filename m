Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED0AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850A6205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ElBEfMzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850A6205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeK2FCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:02:55 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33844 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeK2FCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:02:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so20072713lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 10:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESkwdHBBDasYizEIp40J7493QYQPcDQi32FjrB5LM38=;
        b=ElBEfMzsPx+DweVR8IVClFnR3MS28XOgn5rhuriDmS4mK9Lmr4ytbx9nIEu026kwAo
         iqUtNEVKmggXCmEV2uxk655ZI1Re3dhqjrcZF4uxRtP0ggO3/CUo3Aug+F0auWcb3sEW
         hc5bgqxvFNOAfIU9IKuVgmAFJHREPOkY+cbjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESkwdHBBDasYizEIp40J7493QYQPcDQi32FjrB5LM38=;
        b=JRSlbtSTAN76yv4HOTLmcMw1GK4+quDnw5G1zIiJlWfFB+S6JjvfvCRNExSWpxTf6/
         ymAGPlDYd3pQDaHZXB/pu0bWbYyT6sqj7kfW/5gg7iu/tJQSFge6EBcU8032kRoDCDtF
         MpW0YwKBfz5WrQ5TrI9ky0RPHA1Je/WoVIv+W1pT75ZDniJ5V0Sin7eglWQvOscKnRI7
         LnM8RfMFnYQj+zrcqGcvX80+DSgOAXBMuJ+H8NEy7ghiLl8jQiYqGkLI4fQhGxmcHbBQ
         EB+DpqDsOi8hOOMmX9c25fZ/gduX/hhrAMoAQbcZ+r+KuGmVVXOZmBZzlWaODotEGLIO
         LHxA==
X-Gm-Message-State: AGRZ1gLCtnPNcWeyqxQJJUHJfXHbDVRCfffcYcYr3NX0/62Eb8+YEyIH
        cfHEiVf5Ab/lm2m4OOlF08eonjS77J8=
X-Google-Smtp-Source: AJdET5fRXMSzDinZIh0ChDETWbFkp7WupGBM+DYC4QlW+SSkUQSCqK0k2ZhJNc8qsCOXE3APYSZ1lg==
X-Received: by 2002:a19:24c6:: with SMTP id k189mr23108470lfk.77.1543428024933;
        Wed, 28 Nov 2018 10:00:24 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id y9sm1300191lfe.75.2018.11.28.10.00.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 10:00:23 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id l15-v6so24263269lja.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 10:00:23 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr25570388lji.133.1543428022781;
 Wed, 28 Nov 2018 10:00:22 -0800 (PST)
MIME-Version: 1.0
References: <20181122140320.24080-1-hch@lst.de> <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk> <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
 <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com> <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
 <20181123065511.GA17856@lst.de> <20181128074117.GA21126@lst.de>
 <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com> <20181128174545.GJ30658@n2100.armlinux.org.uk>
In-Reply-To: <20181128174545.GJ30658@n2100.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Nov 2018 10:00:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
Message-ID: <CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
To:     linux@armlinux.org.uk
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        robin.murphy@arm.com, "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 9:45 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> > I don't think this is a huge deal, but ERR_PTR() has been hugely
> > successful elsewhere. And I'm not hugely convinced about all these
> > "any address can be valid" arguments. How the hell do you generate a
> > random dma address in the last page that isn't even page-aligned?
>
> kmalloc() a 64-byte buffer, dma_map_single() that buffer.

No.

You already cannot do that kmalloc(), exactly because of ERR_PTR().

Not all memory is accessible even to the kernel. If you have memory
that shows up in the last page of phys_addr_t, you just mark it
reserved at boot-time.

Which is what we ALREADY do for these exact reasons. If the DMA
mappings means that you'd need to add one more page to that list of
reserved pages, then so be it.

The whole argument of "every possible piece of memory is DMA'able" is
just wrong.

                Linus
