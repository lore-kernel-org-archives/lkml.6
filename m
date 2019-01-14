Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4979C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB8D20651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ehqd+iAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfANTRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:17:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41038 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfANTRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:17:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so51064pgq.8;
        Mon, 14 Jan 2019 11:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EGaVf28KQQ0R2S6vfsVu0HCs6MySjISxtykerEMR7gM=;
        b=Ehqd+iAXtywWB9bRgoduUjNSWjZbyJ6stv3eIE8ZZjVKRbI3P8huUvb6ZXlBaW58G1
         UIBHxopU2ZQVaH+YS0qWzplui4WYErRKt1NJQ/V8J+KFKWsT1g8QhoR9Ig6bNaM1Gm6z
         N9/tRfIOLR5itCsDYgPBcFlGhrXPjSrbyIqmu+wgLj6A6ODrxo6LhA/QNmxlMthd0IfG
         obzDMSCy3ATVLXg8UbLtwWoOfpRzxMm2+jDxFKMnGVq6NcAQxrTAAwqOP5AbIfpJI8VZ
         qfaWBNgJYXsQkBFjWtNf2/QZ46lyhRZJxDtjfPOahGichR5vVlKzt9C06zdbwcfKtFgY
         Y96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EGaVf28KQQ0R2S6vfsVu0HCs6MySjISxtykerEMR7gM=;
        b=a0xcNt+uZvtlOa32qhO6MRFc/BlM64ZNqJ+8lZXTibCkFW58wweLxZvoe6Lq7ZfYTl
         5yGf5BiDMd0x5h41M/7fMt0dv9Q1E7sB+8iHyoW3GhoDz6QEVsptbAwV/YOOsUJnOEj1
         66cq/WGfUXNzZGDic/6FZ25jO4IfBin0lwuhlIkJX7VtfIO6R50agD9cUAZ//2hyKoii
         gKAQuQiG0eQm6pG+g9K+DVY8YK2FNNp4bC7g7Bvfkld5FPcsZGqSFXhhx1iq0TTu4U6r
         cn/feKwHE3Yeryiu2totf7h7JstPZ8IGxkINzIyaBl5Yq9/iSOuY8uCrJ8b6Fi/uFef7
         YAOw==
X-Gm-Message-State: AJcUukcm46DveB9TqNRDCT1Uj3A2ed8xxDXTu892vy9wc4HQq4RYD2p/
        clfMoDWJJUmrXtAtIewc/AA=
X-Google-Smtp-Source: ALg8bN6xDqOam8yEIm+xQAvAbd/JbLk69yBKrw2YeFrxvkiby/N9eDK2+cLxGW8UjD9uUNMeu29avw==
X-Received: by 2002:a63:ce08:: with SMTP id y8mr1527pgf.388.1547493462731;
        Mon, 14 Jan 2019 11:17:42 -0800 (PST)
Received: from localhost.localdomain ([216.13.234.27])
        by smtp.gmail.com with ESMTPSA id b2sm2672771pgg.87.2019.01.14.11.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 11:17:42 -0800 (PST)
From:   Alamy Liu <alamy.liu@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Alamy Liu <alamy.liu@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: cqhci: replace NUM_SLOTS with cq_host->num_slots
Date:   Mon, 14 Jan 2019 11:17:21 -0800
Message-Id: <20190114191724.29960-1-alamy.liu@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent to use fixed value (NUM_SLOTS) after it had been determined
and saved in a variable (cq_host->num_slots).

Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
---
 drivers/mmc/host/cqhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 159270e947..26d63594b7 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -699,7 +699,7 @@ static void cqhci_error_irq(struct mmc_host *mmc, u32 status, int cmd_error,
 		 * The only way to guarantee forward progress is to mark at
 		 * least one task in error, so if none is indicated, pick one.
 		 */
-		for (tag = 0; tag < NUM_SLOTS; tag++) {
+		for (tag = 0; tag < cq_host->num_slots; tag++) {
 			slot = &cq_host->slot[tag];
 			if (!slot->mrq)
 				continue;
-- 
2.17.1

