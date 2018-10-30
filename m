Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BA2C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F5320827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QKQBOXPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F5320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeJaICG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:02:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38494 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbeJaICF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:02:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so6614559pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HqkIIj+yPtVDWhA7Dl1mMunLg/jddgwc20rm34UXfPk=;
        b=QKQBOXPGrfBIc5BMpy9JSoIu75TeQDveLZ3FwTHPY3hbfwqx7y9+mRFcOP3ww0GnEF
         ATV3k2O/MoEMxQWG1TnqxNhKpD3e+R0+C4qnqTrdSwL8GNfuUB+zqNNsjROfLywXp/YX
         keDUhP/QZGbolG7Rcjwxff85X7VKa7piufgzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HqkIIj+yPtVDWhA7Dl1mMunLg/jddgwc20rm34UXfPk=;
        b=pMu5XE+sorXT6FOFA6wkHFPfqFxE4fmkm64lcXi6bJFIidq1A28DY7SqBJMvhMFxYZ
         KZbgzdr7CbwXz/tcIyVMRkMCkOPjlRG6sOTIm8QcbFEa+li4V+lGoYhAVYP4SCNsCm+Z
         sU3eQsI8ZtG0uUbW+Q4CgXH3xhxJoJbNn88K/7ORgJA0lMqpYIQN23SDzGyP2kYYqtPn
         yqvYtC5pyb94/hWts17GlNNfE2Gbc5A6bXHq85wHXWsKxApnq2jG8UxBQkW4kzdpeCXA
         ipR+F5s7WRKfvJaMUSXhFnHndj1m9K1f8tD4fGfss9koUwdQTmAPRJfSwywfmcGE8N9K
         kNTg==
X-Gm-Message-State: AGRZ1gK21pOuQhJFBkHwvlUg5xDNtTPMuEyIKvVsZVV1M4Y6LVfoWdpr
        yYw4zjbQcJRAyVsQuDrYTB43bzHMbmM=
X-Google-Smtp-Source: AJdET5exaX9NP66IdYrFbmITcfg/g2cQ+L3CyDu1Cj2se23A/hl/hPrjkn43bSWTE+FAn1Knb2YbOQ==
X-Received: by 2002:a62:968a:: with SMTP id s10-v6mr663408pfk.191.1540940798380;
        Tue, 30 Oct 2018 16:06:38 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id z15-v6sm27953490pfn.170.2018.10.30.16.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Oct 2018 16:06:37 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] loop: Report EOPNOTSUPP properly
Date:   Tue, 30 Oct 2018 16:06:23 -0700
Message-Id: <20181030230624.61834-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181030230624.61834-1-evgreen@chromium.org>
References: <20181030230624.61834-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly plumb out EOPNOTSUPP from loop driver operations, which may
get returned when for instance a discard operation is attempted but not
supported by the underlying block device. Before this change, everything
was reported in the log as an I/O error, which is scary and not
helpful in debugging.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/block/loop.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index abad6d15f9563..28990fc94841a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -458,8 +458,13 @@ static void lo_complete_rq(struct request *rq)
 
 	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
 	    req_op(rq) != REQ_OP_READ) {
-		if (cmd->ret < 0)
-			ret = BLK_STS_IOERR;
+		if (cmd->ret < 0) {
+			if (cmd->ret == -EOPNOTSUPP)
+				ret = BLK_STS_NOTSUPP;
+			else
+				ret = BLK_STS_IOERR;
+		}
+
 		goto end_io;
 	}
 
@@ -1788,7 +1793,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
  failed:
 	/* complete non-aio request */
 	if (!cmd->use_aio || ret) {
-		cmd->ret = ret ? -EIO : 0;
+		if (ret == -EOPNOTSUPP)
+			cmd->ret = ret;
+		else
+			cmd->ret = ret ? -EIO : 0;
 		blk_mq_complete_request(rq);
 	}
 }
-- 
2.16.4

