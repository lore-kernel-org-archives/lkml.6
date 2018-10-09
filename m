Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E3AC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760B62075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="NelPmmwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760B62075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeJISbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:31:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42674 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeJISbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:31:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id c8-v6so666344plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CX3jLagFDXrT/aQbCv9ci7CccXPocFUNIPbKbYeTMZ0=;
        b=NelPmmwjZg244FqP7YcUkwWhRdvSRmrR+uGl7VKSmdXl3V7FYy1pmZ9E1s91X2kA6N
         Oh5i/V+SOdyURWfnWdqHGXCspgL6ee6qg23ixyoQ0baFldspFQk6bSmbd8fFgPEOBhbO
         CqhLcGXFo7G5GuKU90z4pa0SOLrataFed2HhqSdtAwl4ZBgFCOOGvbivGKJkNvQrpuQh
         YOu2Qdz8c1VSyh8sbvhwKg59WMPUuddfqvYSudvEnd68oQ/f2v/5pLiS9HrZtZiCBg50
         KQRWDtpUButglle8j2C3b1Yev1uf1XjfMQnxkuHs7BgjMO9k2A/p++CvRor46jyTOB2B
         6jwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CX3jLagFDXrT/aQbCv9ci7CccXPocFUNIPbKbYeTMZ0=;
        b=iP9d4g3RvI5KldQNYIJtm+UFFRSagGbeKuwEdADkDBh3k2NxwSjbq5Se2rAZje4EN4
         fNaa9jVbDxAX5jIbS95iLxT3waZrh21S/XY2yMmtaMzyY3TQPb7Pzz8+J+4gdm3YjUne
         aYPp5zLTpeuMgZPa6wtiVM39JYSYonzNbhE4IOv8Y0x4M5/wsyWi10Yfbyj63GDhUxP/
         6jWgx9330MvLmHfLtBrocf87L4gnb7L2eKIUSW2nFkTHvlFmWU705DEcBfOe113v0Sq5
         Ra0q8Yn+dvXFpvgY1hF5VFS1/05/71XHbB+zCc89jpA5hWrjR7585ghP1wI8zTwu5QmB
         dgFg==
X-Gm-Message-State: ABuFfojvKoS2KK21w0B3cdgls1DdErF4Urc2l6PMSeZs/dW8cqVuOsF8
        cLNu+IXjtB1mK/bOLpMBR++paA==
X-Google-Smtp-Source: ACcGV60yslXTgqNxhuxwHXMquU5RkV3NEf7x8fQPW6pDJYQ3mzFyK7F2byNp5C/Z4Ljncml3we040w==
X-Received: by 2002:a17:902:6848:: with SMTP id f8-v6mr28535533pln.27.1539083715720;
        Tue, 09 Oct 2018 04:15:15 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:15:14 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 36/45] lightnvm: pblk: add SPDX license tag
Date:   Tue,  9 Oct 2018 13:12:06 +0200
Message-Id: <20181009111215.7653-37-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier González <javier@javigon.com>

Add GLP-2.0 SPDX license tag to all pblk files

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-cache.c    | 1 +
 drivers/lightnvm/pblk-core.c     | 1 +
 drivers/lightnvm/pblk-gc.c       | 1 +
 drivers/lightnvm/pblk-init.c     | 1 +
 drivers/lightnvm/pblk-map.c      | 1 +
 drivers/lightnvm/pblk-rb.c       | 1 +
 drivers/lightnvm/pblk-read.c     | 1 +
 drivers/lightnvm/pblk-recovery.c | 1 +
 drivers/lightnvm/pblk-rl.c       | 1 +
 drivers/lightnvm/pblk-sysfs.c    | 1 +
 drivers/lightnvm/pblk-write.c    | 1 +
 drivers/lightnvm/pblk.h          | 1 +
 12 files changed, 12 insertions(+)

diff --git a/drivers/lightnvm/pblk-cache.c b/drivers/lightnvm/pblk-cache.c
index f565a56b898a..c9fa26f95659 100644
--- a/drivers/lightnvm/pblk-cache.c
+++ b/drivers/lightnvm/pblk-cache.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a3ce4a36dd33..4045a9b1ee74 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index e05d06bd5b83..2fa118c8eb71 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 7ef8249108f0..f84c428a76f1 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 IT University of Copenhagen (rrpc.c)
  * Copyright (C) 2016 CNEX Labs
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index ff677ca6e4e1..6dcbd44e3acb 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index a7648e12f54f..c26eab2ba8bd 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index f5fe01d3a07f..9fba614adeeb 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index fccf65bc70b3..5740b7509bd8 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index a32790f7b7fc..db55a1c89997 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index e56eeeeb914e..cba83ac43e62 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index a276f25d3931..277abc8633f7 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 4c015c457197..e710f6db2a35 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2015 IT University of Copenhagen (rrpc.h)
  * Copyright (C) 2016 CNEX Labs
-- 
2.17.1

