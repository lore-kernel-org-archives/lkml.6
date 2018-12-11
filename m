Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52874C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216F42087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="FGRziMQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216F42087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeLKTRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39646 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeLKTRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:19 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so11627777lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XIJBkKtDTdtODSkE6+A4O5w3fglTXZAwQfmBdOXd13U=;
        b=FGRziMQZuMRiSDmvLY8uInW360xLgeVem6Fk+pLfCkeHx9nPJXL2rb4BKTCdFRq59w
         nV3Gt65Szwc5ks8B955gSkoMRfhFXge1a768V9bGZWqvghzQyw7//oLkOEfBhfCpaZqT
         +efUFCNo4XsftnHCFkQhu5y1XzWUt5QvCeuPBbDLnRXzbXw0ShH13CNmXElx57wTxFlL
         0PIDSM1yiW0SR+0OnE9Vt41CGk9LnBsY2nOEV34GyPNxIudGr4i8hQ8FpO+RGGhk7fMY
         d5P0c1jJ2GWjWlk2ffEZPLoyU/q7LW39JW78cRjyqZhgNN5HReYi9qjpvJ8FZL5yJlz1
         TCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XIJBkKtDTdtODSkE6+A4O5w3fglTXZAwQfmBdOXd13U=;
        b=A4EoikFKZWrwiJXikdMbF+gi9Lpk/dl0s3WCeEkFjG5l2OPyXW3/eiBnlJSP/CJbUl
         nZs00Gu9zomwZV0L+ZrbV0VTWwK8eck+q4oOw12WjGMrvE/YezqLM467/H5kaDo5xKZa
         VSntgHAVyO9Hb3UmNkiY6N4afMAjvisWOvEOhNQJIZbj88TRyMn5igWbpKM13f9EI9Qa
         88puX9y6rcMMYd9ywm8sYfkGPuNlmrXD7YwMoPOPHxdR31wxRuHC1f5PxVRyiIuFUnGJ
         0P8hIoTf3YgWwJRCjYM22E8WmlZLZGqWNVkrhtALojmAtNgiF4LWpFm/grbrphrqDrUw
         0hmQ==
X-Gm-Message-State: AA+aEWbtBYhUEg2+6ouACoPjsKdCeGmhTRkjD9wlcUTFYadRNR/Km7zf
        Q/thjt7dkbe74yru1qu79FYhoVo40bE=
X-Google-Smtp-Source: AFSGD/VaQqEmcGg+pu7tqg2kky7TZuBvPyh4u6va9sPk3QJwWFEZQrAUY3PcglXieU+7X0LBjYSs4Q==
X-Received: by 2002:a19:be16:: with SMTP id o22mr9713728lff.22.1544555836221;
        Tue, 11 Dec 2018 11:17:16 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:15 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 13/21] lightnvm: pblk: add comments wrt locking in recovery path
Date:   Tue, 11 Dec 2018 20:16:19 +0100
Message-Id: <20181211191627.15542-14-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
References: <20181211191627.15542-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier González <javier@javigon.com>

pblk's recovery path is single threaded and therefore a number of
assumptions regarding concurrency can be made. To avoid confusion, make
this explicit with a couple of comments in the code.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c     | 1 +
 drivers/lightnvm/pblk-recovery.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 44c5dc046912..f1b411e7c7c9 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1276,6 +1276,7 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 	return 0;
 }
 
+/* Line allocations in the recovery path are always single threaded */
 int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 416d9840544b..4c726506a831 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -13,6 +13,9 @@
  * General Public License for more details.
  *
  * pblk-recovery.c - pblk's recovery path
+ *
+ * The L2P recovery path is single threaded as the L2P table is updated in order
+ * following the line sequence ID.
  */
 
 #include "pblk.h"
-- 
2.17.1

