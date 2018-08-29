Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0695EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEE220659
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hb4rWtSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEE220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeH2Tjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:39:52 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36304 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbeH2Tjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:39:52 -0400
Received: by mail-it0-f67.google.com with SMTP id u13-v6so7806085iti.1;
        Wed, 29 Aug 2018 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBgiGE6VOGyUUM+0z038kipmEO9nK31ZqzDttSMv5yo=;
        b=Hb4rWtSdYtyZ2pauP0RHz9Twg04UpT+DewQCVAYv6XCoERQwg2JgYTJa0xjcOfXz+t
         LPj+fzX+7bR/tJd2vRq5iXPak9NIJ7nw2Ch15HWuuQzVVYstDXP5LtEHYMNaKcGSLtvn
         gzA/XcKPKlecdHH2skF8DOnMvNwQewnVWPO2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBgiGE6VOGyUUM+0z038kipmEO9nK31ZqzDttSMv5yo=;
        b=YxH3mCLYRQbgl5gqlv3PmmBmFhFNMbwgjQykp3DfScht03GiItbUrP7+m4Itj+J7+f
         TQ7CaiPDkI56Y1X79bcidiI/LkUEYq2yRmItayCxTkXTTa+gaKCF8EXa/9/MTm8anlLK
         oih/2auKk/Ty15GP2gNRJTnlcrkAD+1AAKVuvi8NpmMUohv8LO/WQAsGWVpc/rUW2hzt
         oeEk0zUNq7VgIyd+AwzXAb6Iv7ubt+QzkJwlFyWm/rQ4QKZS9J32klYOGytJWHXEBXjM
         pMToj7ZrxinSXXgtGW88ZK1/pUwRo8owyBO1O5FE7qVWkrrd7D1Sh4HeC8VT36ew/Gk2
         QnOQ==
X-Gm-Message-State: APzg51DOD3c9VT1Q6I7dfqEiJtP9Tz5iTnEMu10gkO4pprIo1Znc5/SN
        o1xq0w07yTwdMaywWNeD+jMrPb11z1ZRthRpKWE=
X-Google-Smtp-Source: ANB0VdZAqXMsGt7hzxrQqDTVMBy2/U7Cr4xPqB+RLSb8zexAcQVcqqm9t2+N7eUnXW1e6v3SiWEMzyNgAwMGJ5Yk2FY=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr5747089ite.123.1535557340624;
 Wed, 29 Aug 2018 08:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180828112034.30875-1-npiggin@gmail.com> <20180828112034.30875-3-npiggin@gmail.com>
In-Reply-To: <20180828112034.30875-3-npiggin@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Aug 2018 08:42:09 -0700
Message-ID: <CA+55aFwbZrsdZEh0ds1W3AWUeTamDRheQPKSi9O=--cEOSjr5g@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/cow: optimise pte dirty/accessed bits handling in fork
To:     Nick Piggin <npiggin@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 4:20 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> fork clears dirty/accessed bits from new ptes in the child. This logic
> has existed since mapped page reclaim was done by scanning ptes when
> it may have been quite important. Today with physical based pte
> scanning, there is less reason to clear these bits.

Can you humor me, and make the dirty/accessed bit patches separate?

There is actually a difference wrt the dirty bit: if we unmap an area
with dirty pages, we have to do the special synchronous flush.

So a clean page in the virtual mapping is _literally_ cheaper to have.

> This eliminates a major source of faults powerpc/radix requires to set
> dirty/accessed bits in ptes, speeding up a fork/exit microbenchmark by
> about 5% on POWER9 (16600 -> 17500 fork/execs per second).

I don't think the dirty bit matters.

The accessed bit I think may be worth keeping, so by all means remove the mkold.

                  Linus
