Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F5BC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E450420892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VrkBPHu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E450420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeLFS2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:28:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45249 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeLFS2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:28:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so1259787ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPmChsXpD6jULg3nKRnIGAzBW4eqh3P5qEA9OErdy/w=;
        b=VrkBPHu9adAxtV5gCcAuQyzI7ffMV61nijB1mfFx1rg2joEv240qeMhoymb63ZHF2q
         vdq6yeQRY5Ymhp43gkVRDDrslbEvENVj4enUHuzqL7GefVHrQWUovSRH2c6ZBCqK1lTb
         R+uKgIhU204t+pnD+w2Dpn7ohMWOQtE4Rnyf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPmChsXpD6jULg3nKRnIGAzBW4eqh3P5qEA9OErdy/w=;
        b=pxzbHrfzD0O9myL5T8htJoI45I9JbwMAOiHe2WJ4fZiNMzUoz1or1X+qLEIJtTUH7r
         5dUlNRiFTglhcKBVfpWn1YTGN7qa1L8vA4M15hqP0Yd8s0Nauab8Bgrol52nowHZvDt+
         GbM3w9BLeImVwaKBR5WGp7r0XXVdAdViAp/KT4i+E20v0fs0RfcdU5lKyKY5VzmZ0j04
         SuoWcp2kWgsA5a31jfNNFPHAu1EzVDz9Vfe29pqUph9q0f2InQZEEPxx8OwrnKFrtMap
         QbjZLBMiFyben5jon1LGvL4ppfr2ndvv+yT7eSBLWcL3ns+DTH56CJg6p6DU5fLdhaJo
         Bysw==
X-Gm-Message-State: AA+aEWaTSnH4WY3d2+ivSQlQl985YN/flQaCxynD8ZgOlfRswx5nLRPm
        nbH1yCgLC6FTWgV0FcuCzgjoycKwwKg=
X-Google-Smtp-Source: AFSGD/U9ptxlG9CGGmnGa0ZAHo39e5EyZm0HkAa8aIDQihwCJk9npnH5n9UfBDRF580gEIjbzvKH8Q==
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr7749573lji.93.1544120921505;
        Thu, 06 Dec 2018 10:28:41 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id x21sm199880lfe.6.2018.12.06.10.28.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 10:28:40 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id n18so1100815lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:28:40 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr17091565lfj.138.1544120919765;
 Thu, 06 Dec 2018 10:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20181206153720.10702-1-hch@lst.de>
In-Reply-To: <20181206153720.10702-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Dec 2018 10:28:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com>
Message-ID: <CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, brouer@redhat.com,
        tariqt@mellanox.com, ilias.apalodimas@linaro.org, toke@toke.dk,
        robin.murphy@arm.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 7:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This patch adds a check if we are using dma_direct_ops in each fast path
> DMA operation, and just uses a direct call instead.  For the XDP workload
> this increases the number of packets per second from 7,438,283 to
> 9,610,088, so it provides a very significant speedup.

May I suggest re-doing the logic a bit?

You do things like this:

+       if (ops->unmap_page) {
+               if (dma_is_direct(ops))
+                       dma_direct_unmap_page(dev, addr, size, dir, attrs);
+               else
+                       ops->unmap_page(dev, addr, size, dir, attrs);
+       }

which is counterproductive because it checks for the fast case *after*
you've done a load (and a check) that is entirely pointless for the
fast case.

Put another way, you made the fast case unnecessarily slow.

If this fast case matters (and the whole point of the series is that
it *does* matter), then you should make sure that

 (a) the dma_is_direct() function/macro uses "likely()" for the test

and

 (b) the code is organized like this instead:

+       if (dma_is_direct(ops))
+               dma_direct_unmap_page(dev, addr, size, dir, attrs);
+       else if (ops->unmap_page)
+               ops->unmap_page(dev, addr, size, dir, attrs);

because now you avoid that unnecessary conditional for the common
case, and you hopefully never even access the pointer (because you
know what's behind it: the direct ops cases that you're
short-circuiting).

In fact, as a further micro-optimization it might be a good idea to
just specify that the dma_is_direct() ops is a special pointer
(perhaps even just say that "NULL means it's direct"), because that
then makes the fast-case test much simpler (avoids a whole nasty
constant load, and testing for NULL in particular is often much
better).

But that further micro-optimization absolutely *requires* that the ops
pointer test comes first. So making that ordering change is not only
"better code generation for the fast case to avoid extra cache
accesses", it also allows future optimizations.

                     Linus
