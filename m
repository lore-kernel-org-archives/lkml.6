Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7B7ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2295921473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhnYp7Ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2295921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeJRKvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:51:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34623 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeJRKvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:51:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id l6-v6so31443710wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 19:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6sy3ZcN/CTmbCkH9L6A1uqhfR+PZHAwRfReEcTJgX9k=;
        b=hhnYp7EfU57wtKKwkUFOg3jsJidi7rtc8NMXReWNwQa5CBCsqn2T/9U9h3d84F1r2Y
         XwDpxLNwfQVF7iJWZxl6e4BqBrQERVNnuvpczttXapl+Qd507TLwt1+MQ10/Fks0KBgx
         bJfAXfkUaDLtCTykdpdvApAc3ZcPxuLDuUC4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6sy3ZcN/CTmbCkH9L6A1uqhfR+PZHAwRfReEcTJgX9k=;
        b=RbTaa/YUHDZV0SH9X4hyMoyxaeEurlyTzHUWoIs86esaMWTJoxL4MBMtKGWHk93AA5
         tvNf2M3KBQUQxmMyP4k4qH/flycqLBGfMssXAb7sr/YGvpG/uDeOhvlbwtxyjaUCVixk
         IFlBKyauD9MD+N/4OAZ+UUQoriVoQo7915TYHd8rKHklkoWy8BStonWMKWU8Tb2B222h
         aSa5E+d8blKJibhNzE5w0IzNtY/eqOfE1rYqQ/vpWO7nh91A0pW2FNIRpRui37YY809A
         4AxPDSeDsBZ0g6fOmrjLH/7fvslOcFu+9dKhprhrmNBi1G4WVbAsT41Ddn9GE/1Ufi04
         B+QA==
X-Gm-Message-State: ABuFfoh9B76tIdssYjKnn+verLtVNS2I0ocW35pKVrpDqDkZ1upjY0pE
        //7PQGU9FWUtPNLkHWB4pb2sLDMh1RdLxoFhvO6bjg==
X-Google-Smtp-Source: ACcGV61K9Op8i+pt+Xns/fVynLZ5qkLgjky9e78pb40FoSvTREg4IBycOAcR9B4I+5bNtaNr62r5y8/103XBEc3Ny1M=
X-Received: by 2002:adf:a194:: with SMTP id u20-v6mr18606292wru.50.1539831181952;
 Wed, 17 Oct 2018 19:53:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b485:0:0:0:0:0 with HTTP; Wed, 17 Oct 2018 19:53:00
 -0700 (PDT)
In-Reply-To: <7534ca1d-f874-7809-6125-d9fc72f70e39@redhat.com>
References: <1539214413-26173-1-git-send-email-john.stultz@linaro.org> <7534ca1d-f874-7809-6125-d9fc72f70e39@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 17 Oct 2018 19:53:00 -0700
Message-ID: <CALAqxLUd-L+dj=GD5F=PkP5o-FokMCeYHWRJZs24R9-Grbf=PA@mail.gmail.com>
Subject: Re: [PATCH] staging: ion: Rework ion_map_dma_buf() to minimize re-mapping
To:     Laura Abbott <labbott@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Matt Szczesiak <matt.szczesiak@arm.com>,
        Anders Pedersen <Anders.Pedersen@arm.com>,
        John Reitan <John.Reitan@arm.com>,
        Liam Mark <lmark@codeaurora.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:51 AM, Laura Abbott <labbott@redhat.com> wrote:
>
> I suspect most of the cost of the dma_map/dma_unmap is from the
> cache flushing and not the actual mapping operations. If this
> is the case, another option might be to figure out how to
> incorporate dma_attrs so drivers can use DMA_ATTR_SKIP_CPU_SYNC
> to decide when they actually want to sync.

So just to confirm on this point, I basically tested the following
change (whitespace corrupt, sorry):

diff --git a/drivers/staging/android/ion/ion.c
b/drivers/staging/android/ion/ion.c
index 24cb666..e76b0e2 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -273,8 +273,8 @@ static struct sg_table *ion_map_dma_buf(struct
dma_buf_attachment *attachment,

        table = a->table;

-       if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
-                       direction))
+       if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
+                             direction,  DMA_ATTR_SKIP_CPU_SYNC))
                return ERR_PTR(-ENOMEM);

        return table;
@@ -284,7 +284,7 @@ static void ion_unmap_dma_buf(struct
dma_buf_attachment *attachment,
                              struct sg_table *table,
                              enum dma_data_direction direction)
 {
-       dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
+       dma_unmap_sg_attrs(attachment->dev, table->sgl, table->nents,
direction, DMA_ATTR_SKIP_CPU_SYNC);
 }

 static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)


And indeed, that performed similarly to the pre 4.12 ION code (and it
also had some of the same image caching error garbage we've seen w/
4.9 era kernels, which my earlier patch didn't have).

So yes, it seems having some way to conditionally skip cpu sync would
be good.  Though I'm not sure what sort of interface to using this you
might have in mind?

thanks
-john
