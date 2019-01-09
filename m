Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2603DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EDD21783
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hrILsYZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfAIUbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:31:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfAIUbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 15:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ORIZ4H6VG7g1rczGd4vwGdWugTdPg1Dzt5ly6d5cdrM=; b=hrILsYZhzVPsPqNilrou03HZ18
        4R+AJP2wcBWZJyYNCVmV2GM+A/t+bf3O0rovYZu3fjmqs0SKg7knAZfMFKC3/NcIBn4ift9DQP6uq
        AdrPxU0YyJYh4sHmHhfe+MlZwBDdmDxDZ5DF3tr6OqwJbt7guZouJMBB0QLSOXUA9ldJO4w7QVB9p
        CKRv9asmIk0xV9h/ixFVz96OkZxltTpesRFXsErNMptBfw9MjtL/20tRMwgKqkUDowaLNRtqXy+lW
        trMnldcI+hQWcnTCcEIFc2+r0Rff2E4Ap/9R1Agu3yLtlLNLCscxWBENCuVwuw+6vXWeqeS0fQ2uU
        pR1n4a1Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghKVT-0007F5-O7; Wed, 09 Jan 2019 20:31:19 +0000
Date:   Wed, 9 Jan 2019 12:31:19 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [RFC] Use plan9 C extensions
Message-ID: <20190109203119.GR6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


While replacing idr_alloc_cyclic(), I've come across a situation in
which being able to depend on -fplan9-extensions is going to lead to
nicer code in the users.

For cyclic allocations, we need to keep a 'next' value somewhere.
The IDR had a moderately large root, so they didn't mind the cost to
all users of embedding the next value in the root.  For the XArray,
I care about increasing it from the current 16 bytes on 64-bit or
12 bytes on 32-bit.  If most users used it, I wouldn't care, but
only about 10% of the IDR users use the cyclic functionality.

What I currently have is this (random example):

-       struct idr      s2s_cp_stateids;
-       spinlock_t      s2s_cp_lock;
+       struct xarray   s2s_cp_stateids;
+       u32             s2s_cp_stateid_next;

...

+       if (xa_alloc_cyclic(&nn->s2s_cp_stateids,
+                               &copy->cp_stateid.si_opaque.so_id, copy,
+                               xa_u32_limit, &nn->s2s_cp_stateid_next,
+                               GFP_KERNEL))
                return 0;

What I'd really like to do is have a special data structure for the
cyclic users that embeds that "next" field, but I can pass to all the
regular xa_foo() functions.  Something like this:

struct cyclic_xarray {
	struct xarray;
	u32 next;
};

Then this user would do:

	struct cyclic_xarray s2s_cp_stateids;

	if (xa_alloc_cyclic(&nn->s2s_cp_stateids,
				&copy->cp_stateid.si_opaque.so_id, copy,
				xa_u32_limit, GFP_KERNEL))

(ie one fewer argument, as well as one fewer thing to track in their struct).

That's what -fplan9-extensions would allow us to do.  Without it,
we'd need to name that struct xarray and need extra syntactic sugar;
eg later when it calls xa_erase(), it'd look like this:

	xa_erase(&nn->s2s_cp_stateids, copy->cp_stateid.si_opaque.so_id);

instead of:

	xa_erase(&nn->s2s_cp_stateids.xa, copy->cp_stateid.si_opaque.so_id);

-fplan9-extensions is supported in gcc since 4.6 which is now our minimum
version.  This might annoy the people who want to get the kernel compiling
with LLVM though (and any other compilers?  is icc still a thing?).  Added
those people to the cc.
