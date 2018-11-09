Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90F5C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECDB20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cG0/ZKO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECDB20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeKIMGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:06:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45877 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbeKIMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:06:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id g10so314716otl.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 18:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=av8B9fXa40TdXDmMB/gn2NuaAc0FYClBRS+FIaCZczs=;
        b=cG0/ZKO1zqx3LiELe0VOfmiyr/oSB7nFepywC4tJ8SHKskNGarysJjYhUCw5rZ4Viu
         TIdIwJ5LU5R6oCkTFPk+NKqx5ygQS42RI0R4L4++oqAXJxTHu5wmECIU0Wi10Xl9bHP/
         5DNrMbIlvKfYKbzTti659irrplLSp3jri5At16bORVPZrSILMHzECtRBtzzf4UU/8SZa
         iel5irQTf6c7zqHDI5rPbqN0FRGur2XVU7VyGdckQT+eM6d5U1hb9jkG2V+8WxFSsa2P
         8Fay/bPvZ5LYYR2pgiNIT3TqP+Z54u75n55dtdhbDvEtsUlj0RSJPXh9tjb9LyKjARxE
         IdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=av8B9fXa40TdXDmMB/gn2NuaAc0FYClBRS+FIaCZczs=;
        b=qWLgK6zu11vdQvlsRCJo5m5o891rR4f9cVvZhl98B9Tz3jkzmkQ3+TzubM+EIrSg0t
         PgEUGT2f2OK5FQV1qjTZSIxkwz2nACqdpT/AJc13CKFEOqRiPkaK48puN+exBX2Bmqox
         CBLA8/RALx9QqSXNS3A1myVdOF05xskuLOVca4csybzLrtBer4YgvZn+g+ruCPVxnvQl
         /6v98dLv+CSn6tdc+6S8qjN5LVMdmX/F1u6USaTfzfJSw91jjhNGxxIU7kMKLPF7foOt
         TDWYDYmwZr7IbyIAwAVe63n6Zd6k1FOWXi0HY6sKWqtDVkDvtzIPQCVJSm9wvBNxMvPZ
         SGSw==
X-Gm-Message-State: AGRZ1gJg4Ub3dvrR9i4lCsLri4MjDgJW9uiexaDLe6Fv4pyZf9oh9SIZ
        uBL+w9kRlaLypOaDm17UHnaL7kXw
X-Google-Smtp-Source: AJdET5fMB2X8Hc94TTvcwS8SSbMHEqj8IAtnaP8+8gqdsB2w+o5ok2D1Dooco5VWUG+uWVhu93tkpQ==
X-Received: by 2002:a9d:4a5c:: with SMTP id d28mr4207340otj.25.1541730485653;
        Thu, 08 Nov 2018 18:28:05 -0800 (PST)
Received: from simulacrum.agostinelli.home.saggio.net (cpe-66-68-97-1.austin.res.rr.com. [66.68.97.1])
        by smtp.gmail.com with ESMTPSA id v40sm2334565oti.53.2018.11.08.18.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 18:28:04 -0800 (PST)
From:   "Darryl T. Agostinelli" <dagostinelli@gmail.com>
To:     linux-mm@kvack.org
Cc:     cl@linux.com, bvanassche@acm.org, akpm@linux-foundation.org,
        penberg@kernel.org, vbabka@suse.cz, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        "Darryl T. Agostinelli" <dagostinelli@gmail.com>
Subject: [PATCH] Suppress the sparse warning ./include/linux/slab.h:332:43: warning: dubious: x & !y
Date:   Thu,  8 Nov 2018 20:28:01 -0600
Message-Id: <20181109022801.29979-1-dagostinelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Darryl T. Agostinelli <dagostinelli@gmail.com>
---
 include/linux/slab.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 918f374e7156..883b7f56bf35 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -317,6 +317,7 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
 	int is_dma = 0;
 	int type_dma = 0;
 	int is_reclaimable;
+	int y;
 
 #ifdef CONFIG_ZONE_DMA
 	is_dma = !!(flags & __GFP_DMA);
@@ -329,7 +330,10 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
 	 * If an allocation is both __GFP_DMA and __GFP_RECLAIMABLE, return
 	 * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
 	 */
-	return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
+
+	y = (is_reclaimable & (is_dma == 0 ? 1 : 0));
+
+	return type_dma + y * KMALLOC_RECLAIM;
 }
 
 /*
-- 
2.17.1

