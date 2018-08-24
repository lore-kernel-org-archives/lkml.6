Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7172CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295CA2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YKTQQ7p6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295CA2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeHXTus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:50:48 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54711 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHXTus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:50:48 -0400
Received: by mail-it0-f68.google.com with SMTP id l186-v6so2819629itb.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8EI6Cmnn55rUrZk3eqlRIC883FRYLzC0/FwbAfAYvzM=;
        b=YKTQQ7p6v7WyBKA+MYZ7oidxJWR3bZ7c+T5ibTTrm8J3v175QBoJFPhKE7cVp+r27+
         eMJG7S/01luwXz1YDL8CencEaxh9bY1ke7lzOvq2xPs6MYpt5F7dEiwmhYT3CepYuz5M
         aCHgqPSbI+FZzM5afue6N1Y1xB3QrA6vJ2+kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8EI6Cmnn55rUrZk3eqlRIC883FRYLzC0/FwbAfAYvzM=;
        b=MpPBuMhxPx1MM73keoJvh/7CxZ98HG4Me/aB9yhE5axfFR/VVGEsLtIuXF0CCK8xD3
         rEQvetZ6Kq19Pgc0EN97HatneQXA38d6yxxm9w4mK+KmUrBvSDO+/E+Rini7ZrhQHodJ
         Enjf9S9df4eSz0bwv9KWYJrapId/yAWzrmIfgS+xZb+iRGsSdE5iw199t46Hlt9U3Vrt
         Ar4QohQQyaZcjFy8xHRjp1kPjKkNLJAUZQYhBCrKw458NI9T2+IJxA6Wvn2GouYqngFf
         SHES+jkOWbDu6jZdiZghV3FdYKI2WReWZiaRf+zErJcMMG9NcMimaxAUNMxDDN4cigNQ
         AAfw==
X-Gm-Message-State: APzg51AC0negtxhm13V1STvLlpwXwY2Aqs3ku1fnjE2kfr0bk7PUZCQA
        P2nHAhL3qE0v/enPxFdGP6dXRwJ5pPiJHIJStOM=
X-Google-Smtp-Source: ANB0VdZluH2OtuzgBVrqJAWMJVrSZaSVo+01111iLNx1s98NdXbsogFoxUFNznX6vhUCrcBRyFfhMpHNMKd6j/FAoFk=
X-Received: by 2002:a24:3046:: with SMTP id q67-v6mr2042613itq.9.1535127329127;
 Fri, 24 Aug 2018 09:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com> <1535125966-7666-4-git-send-email-will.deacon@arm.com>
In-Reply-To: <1535125966-7666-4-git-send-email-will.deacon@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Aug 2018 09:15:17 -0700
Message-ID: <CA+55aFyAWyGTCzG8YtNwDdmS9TDVYoMCUYvxo0cj3V79w7hQ4A@mail.gmail.com>
Subject: Re: [RFC PATCH 03/11] arm64: pgtable: Implement p[mu]d_valid() and
 check in set_p[mu]d()
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 8:52 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Now that our walk-cache invalidation routines imply a DSB before the
> invalidation, we no longer need one when we are clearing an entry during
> unmap.

Do you really still need it when *setting* it?

I'm wondering if you could just remove the thing unconditionally.

Why would you need a barrier for another CPU for a mapping that is
just being created? It's ok if they see the old lack of mapping until
they are told about it, and that eventual "being told about it" must
involve a data transfer already.

And I'm assuming arm doesn't cache negative page table entries, so
there's no issue with any stale tlb.

And any other kernel thread looking at the page tables will have to
honor the page table locking, so you don't need it for some direct
page table lookup either.

Hmm? It seems like you shouldn't need to order the "set page directory
entry" with anything.

But maybe there's some magic arm64 rule I'm not aware of. Maybe even
the local TLB hardware walker isn't coherent with local stores?

                Linus
