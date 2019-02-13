Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DCAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7749C222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbfBMJ2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:28:16 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47748 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfBMJ2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:28:16 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 9F52B13F89C;
        Wed, 13 Feb 2019 10:27:48 +0100 (CET)
Subject: Re: [RESEND PATCH v2] of: fix kmemleak crash caused by imbalance in
 early memory reservation
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
References: <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr>
 <CGME20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8@epcas3p1.samsung.com>
 <20190123055414.GA4747@rapoport-lnx>
 <78f4ea8a-996d-038e-9e33-5ff02fa2c43f@samsung.com>
 <20190123123143.GE4747@rapoport-lnx>
 <4b8f82c4-7f8f-b814-c1ec-9902e43963f6@free.fr>
 <617e0d57-342d-4162-bd21-ece18e481d87@free.fr>
 <CAL_JsqKbCg-rGmLoA3mPv54=LMuQBfevfzL8f2QPVyjN-sNk8w@mail.gmail.com>
 <20190213085028.6199594b@canb.auug.org.au>
 <CAL_JsqK-cC6oVZ9MkP+ExOGjCRhA0XxGSgqGKL3W9bFF3rKAgA@mail.gmail.com>
 <20190213065734.GA14425@rapoport-lnx>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <5c9184f3-71c1-7875-52f7-616d299a9549@free.fr>
Date:   Wed, 13 Feb 2019 10:27:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213065734.GA14425@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2019 07:57, Mike Rapoport wrote:

> Below is the version vs. current mmotm.
> 
> From 9ea6dceb46067d4f1cbbdbec1189c8496aa0a4bc Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Mon, 4 Feb 2019 15:37:21 +0100
> Subject: [PATCH] of: fix kmemleak crash caused by imbalance in early memory reservation

Out of curiosity, why don't you send as a proper v3?

> Marc Gonzalez reported the following kmemleak crash:
> 
> [...]
> 
> The crash happens when a no-map area is allocated in
> early_init_dt_alloc_reserved_memory_arch(). The allocated region is
> registered with kmemleak, but it is then removed from memblock using
> memblock_remove() that is not kmemleak-aware.
> 
> Replacing __memblock_alloc_base() with memblock_find_in_range()

Nit: in this new version, you're replacing memblock_phys_alloc_range()
with memblock_find_in_range() so I don't know if the comment still
applies.

> makes sure that the allocated memory is not added to kmemleak and then
> memblock_remove()'ing this memory is safe.
> 
> As a bonus, since memblock_find_in_range() ensures the allocation in the
> specified range, the bounds check can be removed.
> 
> Cc: stable@vger.kernel.org # 3.15+
> Fixes: 3f0c820664483 ("drivers: of: add initialization code for dynamic reserved memory")
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Prateek Patel <prpatel@nvidia.com>
> Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
