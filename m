Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEEDC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927A12084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9+wECpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927A12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbeLJXtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:49:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45127 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeLJXtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:49:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id b14so12245204wru.12;
        Mon, 10 Dec 2018 15:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Qj69Iy9VS8/1f+Z2Gw5CwPWeDUPOnHJKR52mJUlAb4=;
        b=D9+wECpcTYOZAE6QVnsGIQCP+egUAbv8rTN0YmCk8fl9N9vVVcjDuIvJVTZGsWygbL
         KRwshnKBxJd+y6+jkShY+GaRuN2n3BzhQIM2DOIup4aqwQFgytjVyitFxfdMxs+l7dFq
         aDkzX2W0Tn9aj9RGLZEwFZuLRubeQoDkWBngDk+qbzS6FWzgLWsGKFW25Tfi0cpt5Spj
         +Cepb/ACud689O4uLTyOC+Z26QYop41WkhYvuZuFoXu/xywwMQwFyeGAuTDBiz6eFlId
         AFORtozTvSthfjEvnQSRYZm90Wwb7dwLtAW5NqFoRyZ/qHkMtsUNp25toF4o9vocUTx9
         zU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Qj69Iy9VS8/1f+Z2Gw5CwPWeDUPOnHJKR52mJUlAb4=;
        b=Z8WXInV/NJmN+IL/RjljbVIH9hmDyQcbtjAxYU9t4HxmZVBzwXcEJrgdzmOmPOPXgD
         AnOoAWrgf03mdssIwkYImRk9Qk8QfHErjRJF+XG5MMbHlS6EMEbARdT5ZUcborBwKcVJ
         8vKarOO7wNZSCJRYbZ/gI48iy4llr3Iqze4/cBB3UPXAbQ0YLqdFYQijRRql6PfrQ62Z
         vzsHiYtxxKLcsRCrlyuMg0juQPym96+HJQHi2/mSmMW6ABSqt/5QLKWqJR9WvnzUXyzd
         tqVcoORiKg3iQH/607ZFEvITOcbQ/QxZIO5eSWXM+ymebPdg0fi/G/V5xfFSu7muML4Q
         m+Og==
X-Gm-Message-State: AA+aEWZxBfw7pbJO9AoyddUk10EU/nYB8qw8UIiyzt277RbZHBOjnIXf
        aqBvW9j0jZ9S5S3w9pnYiOo=
X-Google-Smtp-Source: AFSGD/XYnFyodJMfRShEoO4Xol3eOQv/xdP5FAh8Y91KFNGjV08V+NpskmM/BGwg0s9lJML6F7Qxcw==
X-Received: by 2002:adf:9083:: with SMTP id i3mr11280833wri.124.1544485782903;
        Mon, 10 Dec 2018 15:49:42 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id k128sm303884wmd.37.2018.12.10.15.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 15:49:42 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] crypto: ux500 - Use proper enum in cryp_set_dma_transfer
Date:   Mon, 10 Dec 2018 16:49:29 -0700
Message-Id: <20181210234929.5729-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another:

drivers/crypto/ux500/cryp/cryp_core.c:559:5: warning: implicit
conversion from enumeration type 'enum dma_data_direction' to different
enumeration type 'enum dma_transfer_direction' [-Wenum-conversion]
                                direction, DMA_CTRL_ACK);
                                ^~~~~~~~~
drivers/crypto/ux500/cryp/cryp_core.c:583:5: warning: implicit
conversion from enumeration type 'enum dma_data_direction' to different
enumeration type 'enum dma_transfer_direction' [-Wenum-conversion]
                                direction,
                                ^~~~~~~~~
2 warnings generated.

dmaengine_prep_slave_sg expects an enum from dma_transfer_direction.
Because we know the value of the dma_data_direction enum from the
switch statement, we can just use the proper value from
dma_transfer_direction so there is no more conversion.

DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1
DMA_FROM_DEVICE = DMA_DEV_TO_MEM = 2

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/crypto/ux500/cryp/cryp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
index d2663a4e1f5e..a92a66b1ff46 100644
--- a/drivers/crypto/ux500/cryp/cryp_core.c
+++ b/drivers/crypto/ux500/cryp/cryp_core.c
@@ -556,7 +556,7 @@ static int cryp_set_dma_transfer(struct cryp_ctx *ctx,
 		desc = dmaengine_prep_slave_sg(channel,
 				ctx->device->dma.sg_src,
 				ctx->device->dma.sg_src_len,
-				direction, DMA_CTRL_ACK);
+				DMA_MEM_TO_DEV, DMA_CTRL_ACK);
 		break;
 
 	case DMA_FROM_DEVICE:
@@ -580,7 +580,7 @@ static int cryp_set_dma_transfer(struct cryp_ctx *ctx,
 		desc = dmaengine_prep_slave_sg(channel,
 				ctx->device->dma.sg_dst,
 				ctx->device->dma.sg_dst_len,
-				direction,
+				DMA_DEV_TO_MEM,
 				DMA_CTRL_ACK |
 				DMA_PREP_INTERRUPT);
 
-- 
2.20.0

