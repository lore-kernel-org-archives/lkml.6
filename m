Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F25C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3DA218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUbsJTfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfB0GKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:10:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41378 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbfB0GKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:10:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id y5so7461504plk.8;
        Tue, 26 Feb 2019 22:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzl+S8oDICuWbk4VgoY+6al847sdlThKo04zm8asx6s=;
        b=oUbsJTfFHAMXt+/7KULEyJFnjHEKQ/xyCu5hJ6Wm06q0DU+nPiEYxR48Jk2DOiHlmj
         +UOQK/Oq10rePLa277sTn8v5hK3ydoKnZvH4d8Wy9aproGsqcRxeOXs/d8czJd98cI2P
         7h21SwMiKxKneZG8/y2qqMlZcDU7PzYriyvC215FCiHX337jl3y6CxErnnegIgpsYio2
         ZfHZgCQXuXpmqrxakvVxsOESQioQnRJ1DrxXubye5G4CgqAHCovU61ek/XEC0uQ59iTA
         8mdLQ9h6nMv84poR9UdE6vBShDme1LDUrOvNV2yT05bLyyz7WlyFdKyJJL+O4SAJht5K
         v32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzl+S8oDICuWbk4VgoY+6al847sdlThKo04zm8asx6s=;
        b=bS+SE7byi/hrg/H+pvp1/0ln64SBK320ZiSWDWp2lP19j4oehlxlaq35ewaeUrKZLd
         sU2Zm6DPEvMfOgY+y75sKkv+hhnY6sWGrLmU6WPpVeJpYV0NG4Vz3xNJsJPc4s6lIDBM
         J/uV7lfQltBJhnbVB0rg1vtKhad931oubAuBTP6PtKK0ebknakZs7pmAlyNFAHU5cZjL
         NSw10FKH2cw8cW7a7DXHwo9N0T+qkbI0FMpC5TnAPmSywNbPWsEW0osLtb1J0x2JVi0m
         Yzfi21BD3WhUPg28p7R+3ULB9fMiT3tcNTaQUsmxePWbU9un5FoF+PUHhH390CzJFCjn
         i9Pg==
X-Gm-Message-State: AHQUAuYAtMInrZ9O55xQHxrbpFllw9d+9SugK7YlzTRANISRppsbcWuc
        EKt+MrurgXjyXZuhIBzR8vU=
X-Google-Smtp-Source: AHgI3IZm4OruDYIURy18LqyiKGXZ1SnneIPrvAqkbs979hUoqTvUPguGdiB9gHGijwZuP2ZiET/5Dg==
X-Received: by 2002:a17:902:be16:: with SMTP id r22mr471143pls.128.1551247807893;
        Tue, 26 Feb 2019 22:10:07 -0800 (PST)
Received: from bobby.hsd1.or.comcast.net ([2601:1c0:5501:37e2::87c4])
        by smtp.googlemail.com with ESMTPSA id d5sm20733473pfo.83.2019.02.26.22.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 22:10:07 -0800 (PST)
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Halasa <khalasa@piap.pl>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] net: ethernet: ixp4xx_eth: remove memset(,0) with zalloc
Date:   Tue, 26 Feb 2019 22:09:55 -0800
Message-Id: <0f9d3e4eec82da38366721a20030e55ceb311aec.1551246708.git.bobbyeshleman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1551246708.git.bobbyeshleman@gmail.com>
References: <cover.1551246708.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a call to memset(,0) by replacing the
prior call to dma_pool_alloc with a call to dma_pool_zalloc.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index aee55c03def0..8471e1857d53 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -1107,11 +1107,10 @@ static int init_queues(struct port *port)
 		if (!dma_pool)
 			return -ENOMEM;
 	}
-
-	if (!(port->desc_tab = dma_pool_alloc(dma_pool, GFP_KERNEL,
-					      &port->desc_tab_phys)))
+	port->desc_tab = dma_pool_zalloc(dma_pool, GFP_KERNEL,
+					 &port->desc_tab_phys);
+	if (!port->desc_tab)
 		return -ENOMEM;
-	memset(port->desc_tab, 0, POOL_ALLOC_SIZE);
 	memset(port->rx_buff_tab, 0, sizeof(port->rx_buff_tab)); /* tables */
 	memset(port->tx_buff_tab, 0, sizeof(port->tx_buff_tab));
 
-- 
2.20.1

