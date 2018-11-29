Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C22C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C2C2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C2C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbeK2RGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:06:39 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:42022 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbeK2RGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:06:38 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id B4A45276C99C78946551;
        Thu, 29 Nov 2018 14:02:23 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAT628Et020267;
        Thu, 29 Nov 2018 14:02:08 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018112914023711-13644379 ;
          Thu, 29 Nov 2018 14:02:37 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     robdclark@gmail.com, airlied@linux.ie
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH] drm/msm: Fix error return checking
Date:   Thu, 29 Nov 2018 14:01:50 +0800
Message-Id: <20181129060150.51287-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-29 14:02:37,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-29 14:01:56
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wAT628Et020267
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error checks on ret for a negative error return always fails because
the return value of iommu=5Fmap=5Fsg() is unsigned and can never be negativ=
e.

Detected with Coccinelle:
drivers/gpu/drm/msm/msm=5Fiommu.c:69:9-12: WARNING: Unsigned expression
compared with zero: ret < 0

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Rob Clark <robdclark@gmail.com>
CC: David Airlie <airlied@linux.ie>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: linux-arm-msm@vger.kernel.org
CC: dri-devel@lists.freedesktop.org
CC: freedreno@lists.freedesktop.org
CC: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/msm/msm=5Fiommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm=5Fiommu.c b/drivers/gpu/drm/msm/msm=5F=
iommu.c
index b23d33622f37..2a90aa4caec0 100644
--- a/drivers/gpu/drm/msm/msm=5Fiommu.c
+++ b/drivers/gpu/drm/msm/msm=5Fiommu.c
@@ -66,7 +66,7 @@ static int msm=5Fiommu=5Fmap(struct msm=5Fmmu *mmu, uint6=
4=5Ft iova,
 //	pm=5Fruntime=5Fget=5Fsync(mmu->dev);
 	ret =3D iommu=5Fmap=5Fsg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
 //	pm=5Fruntime=5Fput=5Fsync(mmu->dev);
-	WARN=5FON(ret < 0);
+	WARN=5FON(!ret);
=20
 	return (ret =3D=3D len) ? 0 : -EINVAL;
 }
--=20
2.19.1

