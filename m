Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBC4C46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAE322442
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAE322442
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeHKDwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 23:52:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36086 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeHKDwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 23:52:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id h12-v6so5130916pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 18:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lBmHgo8Xwbu0nxdHRBU9RXbVn5fbBW+QCc9OuSS5Fh0=;
        b=uoXBMAv0LF4+745whv9A697lKukMIqQ9o+RTPjksm9jQ6sVGUFht8b/UOHBsSJlfaq
         WkIL26wIiLTnjuTKz+Ga5ZVrgQlPJcEM0jfqjy5ON81+4l7JebupA48PUnarjrpQ6MHY
         20kTPnZaCZDeysFgqihgBK+np5wunP30GGCP/RWQ+N/Bp6YrG2hpeyhi1loAI+80vKU6
         sqZ1luPQgfchLW1nlF9CbcwDKTwNN/XLvZnqBG098XVSzDMrDTgW4+h1+SSM9kN+U8V4
         ECbwzrtPGuteN3f+CY7uOPvGBpfbEpgXm2jiSZBJdEY4yIvfTHM156m2p83FavVHzRZL
         TWsw==
X-Gm-Message-State: AOUpUlEEePYmCR522Ym6dkpoyOTNURR2Z44S0UyKEu6earE1c8cxIz0u
        Wyevu09Aj8JqtuhYZ1EUJwshUQ==
X-Google-Smtp-Source: AA+uWPzWQNhelq3ioByo7CxpjvIc2LVgXnQ/WkDphppG+fOW9VwPpyW4xJXWiL9oQhCjNR0Q0CKGAw==
X-Received: by 2002:a62:6f87:: with SMTP id k129-v6mr9326074pfc.26.1533950398319;
        Fri, 10 Aug 2018 18:19:58 -0700 (PDT)
Received: from localhost (c-107-3-165-230.hsd1.ca.comcast.net. [107.3.165.230])
        by smtp.gmail.com with ESMTPSA id e73-v6sm24048725pfb.153.2018.08.10.18.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 18:19:57 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     davem@davemloft.net
Cc:     keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williams@ni.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/2] net: nixge: Do not zero application specific fields in desc
Date:   Fri, 10 Aug 2018 18:19:40 -0700
Message-Id: <20180811011941.6187-2-mdf@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180811011941.6187-1-mdf@kernel.org>
References: <20180811011941.6187-1-mdf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not zero application specific fields in DMA descriptors.
The hardware does ignore them, so should software.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/net/ethernet/ni/nixge.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 9ae4fcef725e..ac31b0d30415 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -739,22 +739,12 @@ static void nixge_dma_err_handler(unsigned long data)
 		cur_p->phys = 0;
 		cur_p->cntrl = 0;
 		cur_p->status = 0;
-		cur_p->app0 = 0;
-		cur_p->app1 = 0;
-		cur_p->app2 = 0;
-		cur_p->app3 = 0;
-		cur_p->app4 = 0;
 		cur_p->sw_id_offset = 0;
 	}
 
 	for (i = 0; i < RX_BD_NUM; i++) {
 		cur_p = &lp->rx_bd_v[i];
 		cur_p->status = 0;
-		cur_p->app0 = 0;
-		cur_p->app1 = 0;
-		cur_p->app2 = 0;
-		cur_p->app3 = 0;
-		cur_p->app4 = 0;
 	}
 
 	lp->tx_bd_ci = 0;
-- 
2.18.0

