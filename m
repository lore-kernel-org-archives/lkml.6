Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60312C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5CC21928
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNaMLDvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfBGU5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:57:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37328 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfBGU5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:57:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so535002plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TaQt44LZ/RgJMg+KOP1uNPzwqb7oQUqEYZ+0YwXObdU=;
        b=XNaMLDvmhdqik4WyKLnmEJSrikd5Gtl6T2EvsYYgyG4q19++MZFwL51DaHWcx9cV7Z
         oKhGkSLhpC7/ixJlHU2zYA5iI4Q1kNWVFX+3m71KqoTgzxaxCJO+owO4Z8X/IP370xQ+
         ERCIXPDYG1vUeeGxUcPw76xHlhMiMibDPbl/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TaQt44LZ/RgJMg+KOP1uNPzwqb7oQUqEYZ+0YwXObdU=;
        b=EPcwxdGkIHTmi/05gW4pgblo7+RzI6iUyR6cV/tD1IoJQsQ7MYSmm8MvaVURAdjJiD
         7ByTvpBgeEWGfRW8LnJVYEJXS4lE/4sZ8KO8GIniY6hX/w3524rHv0ATpGBJgP0KH7C1
         /4FkSnRO99dR00UAwyeX4+BaIzofDl8HbyTHKTCJN+l4tk1poJ4U7YJlXtcQgI/+1x6l
         oGEfSXc72zsYRVfnZIAokM5Nrw6/5I8IXRNz5VXyGS4OacBCVprK/R10gpj0p6pU9l5D
         9sgzAdFYzjMXGEc90UlHwVh4n3xhE/p8k7YE1Eh8+BIGQ7+oq39tdn5AgjcSG2Izx2vA
         PqrA==
X-Gm-Message-State: AHQUAuagSk5NXA14Aj33IMcFvx1gK1TpF5JWQAPM9wQCjXPqgz44zRfT
        NtMn7wesAFlato0dHwjey7Dtuw==
X-Google-Smtp-Source: AHgI3IYAlpAbhePcDHpFAHMl3iLxEMniMWtPps5GlshTP8NP2devcVV52NZy9wCcGwSzGN7QHuA3AA==
X-Received: by 2002:a17:902:8c8a:: with SMTP id t10mr16404837plo.39.1549573069816;
        Thu, 07 Feb 2019 12:57:49 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id y9sm27199pfi.74.2019.02.07.12.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Feb 2019 12:57:49 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] loop: Report EOPNOTSUPP properly
Date:   Thu,  7 Feb 2019 12:57:28 -0800
Message-Id: <20190207205730.199332-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207205730.199332-1-evgreen@chromium.org>
References: <20190207205730.199332-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---

Changes in v2:
- Unnested error if statement (Bart)

Ming, I opted to keep your Reviewed-by since the change since v1 was trivial.
Hope that's okay.

---
 drivers/block/loop.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cf5538942834..b6c2d8f3202b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -458,7 +458,9 @@ static void lo_complete_rq(struct request *rq)
 
 	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
 	    req_op(rq) != REQ_OP_READ) {
-		if (cmd->ret < 0)
+		if (cmd->ret == -EOPNOTSUPP)
+			ret = BLK_STS_NOTSUPP;
+		else if (cmd->ret < 0)
 			ret = BLK_STS_IOERR;
 		goto end_io;
 	}
@@ -1878,7 +1880,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
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
2.20.1

