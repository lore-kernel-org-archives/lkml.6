Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B92AC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F062086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfASRgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:36:14 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41269 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbfASRgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 12:36:14 -0500
Received: by mail-qt1-f195.google.com with SMTP id l12so18732628qtf.8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 09:36:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ypvr+OQYTHNW4uY/rsGS/sj1gVmbytj2ZKJs+P5iF1A=;
        b=G3RIaxSyLP7kAXfSf8cnLEcfuTaueSe/VlmOdKCAkocrfxgWMg2HmDWQdkbnlMEzFy
         uk6L5pSVm2v5Ik1f5pCyoJ0Xs5nryBWgbeDFdCvG1jRFd1qIb/6rCjE6vSxmrHmEkhXF
         /iYJoe2wZlGp9RmA5b7mdi+zId0BARspdedRinn7A3Ke2KYJDI68RF27ockP8uHBxFOu
         au3bdLWpBTjHzrq9v/zyHtlFwortxGVxcMF7RllLnXTD61qmjl4Q8/J4klvOiyKA51M6
         U5Q16ytZty/j8crLrHQwTBZdn3V7/OXg3GP1ykbqTcPX9XodT7e3luneGzt68gSbWKOr
         epQA==
X-Gm-Message-State: AJcUuke+Lmao9FWUGXjNrqdDbBzGX3TY5oxzuASz2EHRIxpxHqW9CbjY
        5e+3KQgUXX6Vgz3Rv7xLupG5i+qcAGM=
X-Google-Smtp-Source: ALg8bN7XqssjwFdyiBEKx7QTA/6s4K+zBW74AvjGO7ecXmSTWr75yoXlTP6/x02d8me3Gr9P9By0cw==
X-Received: by 2002:a0c:a9da:: with SMTP id c26mr19630056qvb.140.1547919373462;
        Sat, 19 Jan 2019 09:36:13 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id v32sm77821479qta.37.2019.01.19.09.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Jan 2019 09:36:12 -0800 (PST)
Date:   Sat, 19 Jan 2019 10:36:11 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu: amd: call free_iova_fast with pfn in map_sg
Message-ID: <20190119173611.reqzqxwgf2z22gby@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20190117192902.15158-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190117192902.15158-1-jsnitsel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jan 17 19, Jerry Snitselaar wrote:
>In the error path of map_sg, free_iova_fast is being called with
>address instead of the pfn. This results in a bad value getting into
>the rcache, and can result in hitting a BUG_ON when
>iova_magazine_free_pfns is called.
>
>Cc: Joerg Roedel <joro@8bytes.org>
>Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>---
> drivers/iommu/amd_iommu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 87ba23a75b38..418df8ff3e50 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -2623,7 +2623,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
> 	}
>
> out_free_iova:
>-	free_iova_fast(&dma_dom->iovad, address, npages);
>+	free_iova_fast(&dma_dom->iovad, address >> PAGE_SHIFT, npages);
>
> out_err:
> 	return 0;
>-- 
>2.20.1.98.gecbdaf0899
>


I forgot to add the Fixes line.

Fixes: 80187fd39dcb ("iommu/amd: Optimize map_sg and unmap_sg")
