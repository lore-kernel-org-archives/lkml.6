Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11209C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF91C20815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XxkDFU+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfBDTVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:21:44 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33469 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDTVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:21:43 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so936865eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 11:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yjlgHfUuLREhUyUC0oL83S2doeTgEdz5km2W8jN9X3Y=;
        b=XxkDFU+iUxzT3gR8bd2KVfuPG48QCSiFCkRIh6DQevqQLhgTC2FEZyvZA+bVrEkvse
         0PB6J2mvSMfMJOvmHHQPu2kT1l0zRAUGHn7xivL8WC7Q+Amewadvtm6pxtnYMS9wVHtf
         BoHPymkcZ+owgadisxYLvjXrecctGpIIJmR1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yjlgHfUuLREhUyUC0oL83S2doeTgEdz5km2W8jN9X3Y=;
        b=Ih+F+T3ojhBrG8Z3AA6bCxYQTPxqIaJszVvDNhlRAVQI3Y+zq/CmYqo/7zZXQKGHGO
         YsMePjesMf/4qJ5a8VSRWzMtC0a+yD+eMxe4eM/2e1DXS8t/bsqXgCFtFnDsxEFRKnL9
         fO0RXjk9eZJYKiqpIYLUu5zQCm/iYCbeYI+6dlO8ULaccLOk/IHwr+f/j+W36i8ta9Ck
         8LiYhrmPRzAdmM0lcuVC6AgNmbgTC/STRgL4omy7a//3gDuI4PRzThn5hEBzEEJUcfog
         b8zmqo8AG6TtxnQFiE4/8J452J8+FyB0qaquCqc9+WlUONfILCH42FEDWB7CPq7U0DJ5
         oStg==
X-Gm-Message-State: AHQUAuY/IASURnLNhlLO8gHHQeaOKfnXlYRKxfMWMHnBa3L6Vs6IvzQ/
        OX1ynYrfhj8Ftg+iNhNlq3maJjbKnLuDa4gg
X-Google-Smtp-Source: AHgI3IadN/MWFNYSVdw/Fcwpo3gpXWQv2Fw1mE6TJQUnJrKhVHK42TDvIy4dfK1Gm1sDh/TbP+N9CA==
X-Received: by 2002:a17:906:480d:: with SMTP id w13mr733985ejq.40.1549308101840;
        Mon, 04 Feb 2019 11:21:41 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h47sm4627953eda.8.2019.02.04.11.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 11:21:41 -0800 (PST)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH] mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush timeout issue
Date:   Mon,  4 Feb 2019 11:21:29 -0800
Message-Id: <20190204192129.93533-1-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

RING_CONTROL reg was not written due to wrong address, hence all
the subsequent ring flush was timing out.

Fixes: a371c10ea4b3 ("mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush sequence")

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index d713271ebf7c..a64116586b4c 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1396,9 +1396,9 @@ static void flexrm_shutdown(struct mbox_chan *chan)
 
 	/* Clear ring flush state */
 	timeout = 1000; /* timeout of 1s */
-	writel_relaxed(0x0, ring + RING_CONTROL);
+	writel_relaxed(0x0, ring->regs + RING_CONTROL);
 	do {
-		if (!(readl_relaxed(ring + RING_FLUSH_DONE) &
+		if (!(readl_relaxed(ring->regs + RING_FLUSH_DONE) &
 		      FLUSH_DONE_MASK))
 			break;
 		mdelay(1);
-- 
2.17.1

