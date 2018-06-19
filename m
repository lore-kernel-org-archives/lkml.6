Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16002C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1A020652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1A020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030246AbeFSRCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:02:50 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34805 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966800AbeFSRCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:02:36 -0400
Received: by mail-pl0-f67.google.com with SMTP id g20-v6so182072plq.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m0/g9RHLZXNS8aWMcbA9cJ/cwoo4enqkKSdVjDpDIHs=;
        b=b0GMVx1pwwtlCszt6mT+dVdBiBuSBS8Valgsj5FAcCIx8p9JXcLF3u9CisTrzZb2To
         nMyRHfxHj3f/suvWvsSWpsFw71RMgJGtL3Qy0DLisjJVJA37lrkdbFIPZpUrnZtKlEGp
         eBOfsPpLQU9mJ86Pv/kuGiep0etcYNj5C7jNyZosWNMRKqyTEoLKjnu5BSnXbvKphb9A
         Q+DA/82X811H/X3bVKTiX0Q/gi7L5R1AxaPuisHAgwda8ZrBhH6CNsQ1uN/k6jQSscAz
         etP0Ak0ugr7/BqpVw2LFXFM2iOqg9i6uSUDjOo4PIrHrOuTmeK+b3DECWDe76k5V4VaF
         f6Ww==
X-Gm-Message-State: APt69E3lI/PTUnBlX0gsr8MT1kK127gHwbu9tAG8Vo8Q8DRCJHwwznRA
        D3mFsKiHma0TRNd8hhIT9F+ELQ==
X-Google-Smtp-Source: ADUXVKJEz2LvOaDeA+KoPGWMrpMcDzv7hiCbe//Oso0vyKcizw+W7vJVX0yZGMBiodqUNrAhi+z6cw==
X-Received: by 2002:a17:902:654c:: with SMTP id d12-v6mr19615561pln.8.1529427756269;
        Tue, 19 Jun 2018 10:02:36 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id z28-v6sm235209pfl.169.2018.06.19.10.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 10:02:35 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     davem@davemloft.net
Cc:     keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] net: nixge: Add __packed attribute to DMA descriptor struct
Date:   Tue, 19 Jun 2018 09:54:53 -0700
Message-Id: <20180619165453.31894-1-mdf@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __packed attribute to DMA descriptor structure  in order to
make sure that the DMA engine's alignemnt requirements are met.

Fixes commit 492caffa8a1a ("net: ethernet: nixge: Add support for
National Instruments XGE netdev")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Hi David,

this addresses an issue where padding occured breaking the alignment
in the array the descriptors are allocated in coherent memory.
This was discovered when we tried to bring up the driver via a PCIe
bridge on x86.

Thanks,

Moritz

---
 drivers/net/ethernet/ni/nixge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 09f674ec0f9e..fea0e994324b 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -122,7 +122,7 @@ struct nixge_hw_dma_bd {
 	u32 sw_id_offset;
 	u32 reserved5;
 	u32 reserved6;
-};
+} __packed;
 
 struct nixge_tx_skb {
 	struct sk_buff *skb;
-- 
2.17.1

