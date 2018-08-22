Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247C6C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD4B208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BM29FNWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD4B208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeHWBDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 21:03:52 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55837 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeHWBDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 21:03:52 -0400
Received: by mail-it0-f67.google.com with SMTP id d10-v6so4804737itj.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 14:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SU1pbdkvsKjFPY5p6qZ0sw4ZWpcCqqH/eqjf6E3PztE=;
        b=BM29FNWVstXrkTJQQL+UqBMgIm4qb/XiY3teoGagKA5Ism1+9tO/d7Td5jTgLaQ0+7
         5jnmAA4GcbNQHeoHmoqnk2IfjEXyOPlGXRvHtBsfKemxyhDTwFiGJsltB2PZ9/yut4Od
         cQo3EUW4K/Ru553jXwmZ0pxjQE83eJC6V6J+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SU1pbdkvsKjFPY5p6qZ0sw4ZWpcCqqH/eqjf6E3PztE=;
        b=Wyg0qKgNMYnRawWShUG+c8Vwq3QsE/sL579SAr+IOnLzkaeDz+76o2mhe+pfbbzfYD
         HWVhenimk3Gav71/WU+949t0ufAsRP3XtaWlao6fPNYDsdjFvEPGr5jMoW0m2WHan6rN
         x/9dmRAzv/9gWMVyqPJKYMoq9LXlNQHTSk09enyFjJfPqFc18/Yy9qaKXnlsaYzdDhJP
         z81kdXRTe7rs3UVE8QO1UzsrSxpOgBxHzzEhpnKBPz3sgY30aOTcaRiJYRAgnVRnxxlU
         DGlZWF/4wZxOu3X7eVW7xIRrrsd+c8Je1uLMoSR0yMXSmDPu2EyVPF1WRxc7Q//DCjyy
         rveQ==
X-Gm-Message-State: APzg51DOup2Xw5slAtI6AUjeE6DPn+TReaDlc1Qu41BuCmLmwWaB3pYB
        zEiLSZ4HFIf93+/Ma6Pm+P3cJuJ+hjnNTFCaqCs=
X-Google-Smtp-Source: ANB0VdajXIId1M2r0naud88gZkgZXNYVGpWSlJGrH+6mUuD1cCsUxy7jBnMBz3BHOAuQarc1dQH5hqa+mIG3pbHY7ac=
X-Received: by 2002:a24:3046:: with SMTP id q67-v6mr5048532itq.9.1534973836713;
 Wed, 22 Aug 2018 14:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180822153012.173508681@infradead.org> <20180822154046.717610121@infradead.org>
In-Reply-To: <20180822154046.717610121@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 14:37:05 -0700
Message-ID: <CA+55aFw6bBFnV__JZnzh0ZCSTma5J2ijH8BnMtfK55dnjVp=dw@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/mm/tlb: Revert the recent lazy TLB patches
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 8:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Revert [..] in order to simplify the TLB invalidate fixes for x86. We'll try again later.

Rik, I assume I should take your earlier "yeah, I can try later" as an
ack for this?

I'll wait a bit more in the hopes of getting reviews/acks, but I'm
basically chomping at the bit to just apply this series and have this
issue behind us.

             Linus
