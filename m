Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA72C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58425205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MYFxe8uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58425205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeKBI5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:57:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40956 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbeKBI5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:57:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id o14-v6so104725pgv.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 16:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qq/KIzQt0MUPh5ESNm6QSYlRoPZRG38Fh+yGqmdVTFM=;
        b=MYFxe8uyN5L/4tcWw6/sPb5sGozwVAkeBmtlweHZfAvQjYtiGY9KmdDF7Dni/VZItS
         FJHFrt/RAF9ZCdvvs6JWZTLEEw9tvuhGEzpti+uaN+wVtcRFvD1chWdzDOZJ1+lSW+aL
         eH6zifEVJ4cdaRBp/s0LVnHVdcwFtocvVfuZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qq/KIzQt0MUPh5ESNm6QSYlRoPZRG38Fh+yGqmdVTFM=;
        b=Odf2inV3vzv6Z6n1JmLIaB7PSzACjRuW2+Pb9aCcBDOuchV4M+KsXpVlAMf2hXt22m
         GFBaYLZhia3tFKRkWFmfuwGIRhJFfjYACBvhUlxiYKbJ4dc3FMC2J6E/RQkAj3XrDXVJ
         EeZmGzL1WGydNDn4dbKikCPiJ4baNZoQodNTGrS2d0eFNYI9r79AeB0q0zY4nH0pl0dW
         jwuHAp4It4d00eE/iQ5NZSF9n8b2KPxaDbtspJVxMMODuzedKBaRz8fv4K4/gywxa+Rq
         9ipoTgg+s6MKvUIt/+Z+RlghhI2Vkak7W/By38uJ9ru6efbAsr3NQbeKxoFy5aSQGELM
         bGLw==
X-Gm-Message-State: AGRZ1gJR2YUcEcnnLFyuMIUvplzMFZzjGn0GXEwsICpNSOBoLi4DsXmz
        SxI/2VFzsIam6nJxgVxcCejVPg==
X-Google-Smtp-Source: AJdET5fcgRR/kA0YqURU6rdD1LWFD4+W1KHi5EGI+8iimNDLnI2l2US+J9ounYLgszbgxDKvtyW4lA==
X-Received: by 2002:a63:1c64:: with SMTP id c36-v6mr8671136pgm.354.1541116328159;
        Thu, 01 Nov 2018 16:52:08 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v191sm6259354pgb.77.2018.11.01.16.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 16:52:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 3/8] pstore/ram: Report backend assignments with finer granularity
Date:   Thu,  1 Nov 2018 16:51:55 -0700
Message-Id: <20181101235200.28584-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181101235200.28584-1-keescook@chromium.org>
References: <20181101235200.28584-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to more easily perform automated regression testing, this
adds pr_debug() calls to report each prz allocation which can then be
verified against persistent storage. Specifically, seeing the dividing
line between header, data, any ECC bytes. (And the general assignment
output is updated to remove the bogus ECC blocksize which isn't actually
recorded outside the prz instance.)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram.c      | 4 ++--
 fs/pstore/ram_core.c | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index b51901f97dc2..25bede911809 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -856,9 +856,9 @@ static int ramoops_probe(struct platform_device *pdev)
 	ramoops_pmsg_size = pdata->pmsg_size;
 	ramoops_ftrace_size = pdata->ftrace_size;
 
-	pr_info("attached 0x%lx@0x%llx, ecc: %d/%d\n",
+	pr_info("using 0x%lx@0x%llx, ecc: %d\n",
 		cxt->size, (unsigned long long)cxt->phys_addr,
-		cxt->ecc_info.ecc_size, cxt->ecc_info.block_size);
+		cxt->ecc_info.ecc_size);
 
 	return 0;
 
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index f5d0173901aa..d5bf9be82545 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -576,6 +576,12 @@ struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
 	if (ret)
 		goto err;
 
+	pr_debug("attached %s 0x%lx@0x%llx: %lu header, %lu data, %lu ecc (%d/%d)\n",
+		prz->label, prz->size, (unsigned long long)prz->paddr,
+		sizeof(*prz->buffer), prz->buffer_size,
+		prz->size - sizeof(*prz->buffer) - prz->buffer_size,
+		prz->ecc_info.ecc_size, prz->ecc_info.block_size);
+
 	return prz;
 err:
 	persistent_ram_free(prz);
-- 
2.17.1

