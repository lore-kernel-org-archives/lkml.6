Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA961C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7902154F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mp/d4UTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7902154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390484AbeIUTbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:31:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39964 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390084AbeIUT3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:36 -0400
Received: by mail-io1-f66.google.com with SMTP id l14-v6so12206447iob.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=amN7ddXkResdHNrYb0iY3daOfe5OJqdHWfYz3x09ACo=;
        b=Mp/d4UTgcJSm6suijva9O0ARRHCzFsHG0E61wEWgrJA8roIsxCLYllX4I/4eC7QUUD
         nDwU7Ox46ctqyxgx+PlrGqmYNevt1YBC8AcwUn7hqrLIsCM6F+8+YgpNqEfeaDgOZVs0
         aBU4kk935QXfLVEg3OQ2nYdgu0PVXN6YmfcOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=amN7ddXkResdHNrYb0iY3daOfe5OJqdHWfYz3x09ACo=;
        b=dle+Mi1VPF/YEg0HL+VpfB4ZORQJ7JCjRF9OJahYpaKMAcwD7uSDVOjRZ2cBLVG4EE
         7qnIVv+NUZ3RanxfbHnitzj/LBfufYDj5r+iQ/bkMXIOg/yRZWY1vcK1z8KnSYGfS4Yp
         /+EewbIFXobX7E1TQtlLC0MMObq0/EyFPcGJ8b7XHNTUv/lp4K/f7K6OwKtVX1mJqLNN
         mZ0fZT2UuRDx64zJtzwcaJgRsDVx6cV3MJzCgjwfHkv6uWGKAQ69SCEBSpf5FGJ3N+qz
         9qEhcshFRINhzfp4Q6hg3TSVvo+YCgojywp6me8pLp5HATl+Q508AptnJI8I06cn8T6f
         ZguQ==
X-Gm-Message-State: APzg51CuMd5Lfod8hCB7TcTkOsIrJL8u4kbpUYEDCINKnah6BJdJUDvX
        KP89NXVncYHaH2uqUBtkcjqGpFYrOvA=
X-Google-Smtp-Source: ANB0VdYIGzmW8LYMJbMjqstxiMy/pJxWm1XMotKwYz1ayFtSMpvoFGrBuMvPPfFKYcCt3rOwZeGYTg==
X-Received: by 2002:a02:97c5:: with SMTP id v5-v6mr8154135jaj.72.1537537240722;
        Fri, 21 Sep 2018 06:40:40 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:40 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/26] nvmem: use list_for_each_entry_safe in nvmem_device_remove_all_cells()
Date:   Fri, 21 Sep 2018 06:40:05 -0700
Message-Id: <20180921134026.4596-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the provided helper for iterating over list entries without having
to use the list_entry() macro.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 72313a1d215f..0e963d83a099 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -308,14 +308,11 @@ static void nvmem_cell_drop(struct nvmem_cell *cell)
 
 static void nvmem_device_remove_all_cells(const struct nvmem_device *nvmem)
 {
-	struct nvmem_cell *cell;
-	struct list_head *p, *n;
+	struct nvmem_cell *cell, *p;
 
-	list_for_each_safe(p, n, &nvmem_cells) {
-		cell = list_entry(p, struct nvmem_cell, node);
+	list_for_each_entry_safe(cell, p, &nvmem_cells, node)
 		if (cell->nvmem == nvmem)
 			nvmem_cell_drop(cell);
-	}
 }
 
 static void nvmem_cell_add(struct nvmem_cell *cell)
-- 
2.19.0

