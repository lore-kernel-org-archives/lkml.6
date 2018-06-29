Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3551AC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E443027552
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YAUq8kbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E443027552
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936584AbeF2Ssz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:48:55 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33239 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933723AbeF2Ssw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:48:52 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so4873406plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9JSsLFN7pKBad8rj/9rpVXN9GZ6bOBjPe/JLuyiijzg=;
        b=YAUq8kbhttQry2lNA2SPwPbF+/Q6RNairzvOQfEQFe5hwBkKNbc7IuzdpHpnNCiVuL
         gxxIDKHkszGiJGKkGnwSv2Dd4+qeWWnjri6psCiDjTrKsxrVgMJU+m3y6qcgOrmItXdE
         YZN1TSE9Yve1g+ebhvEVPbNHrQiwyS+Pxx9fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9JSsLFN7pKBad8rj/9rpVXN9GZ6bOBjPe/JLuyiijzg=;
        b=km7WkvaE1mQiCTBQgx2eai30JSYZOWAuB3UUG3IkUZQMFyXMXxi7SJfhYodZRrQC4G
         3YabmWh+301zINQzDEJEfp6i60rTel/p4zaapSK2UPO1ATB1smtEhHx3ZQ66ChbjzaGQ
         pRNHI/gZLfbLx4z1GwkOfv1wCSUxreesYbOni8atPaJ5kawI+/JWepJpyd2GOBMH3lXP
         33t630gENlXk4Wtb+L90lAltmU7/WdA87f/cCRH8OgGQKQkG2JjfvkV5AL2120qp9auV
         tFrglTCvdPTNDAvjqOnMGSwd/9Q0NvjZNDYTaBXM7GXCUyoPVBtvTW4GRXxPBDPLGyMt
         9yXA==
X-Gm-Message-State: APt69E1dlnMot6+OMI89APQoe+oj7JIUqWATfix0bcaJzmwFmAWbkgwp
        rGk5fLu0od2qZAH9172E7TpuHQ==
X-Google-Smtp-Source: AAOMgpfSxgbVJyPtu0jYuT1SPv89S7R+6AwvugccGUjmPoruy1yDhU+aHHHQoJfml7rZoyJ4S6Qbnw==
X-Received: by 2002:a17:902:2702:: with SMTP id c2-v6mr14845806plb.297.1530298132151;
        Fri, 29 Jun 2018 11:48:52 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h13-v6sm14646427pgp.13.2018.06.29.11.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:48:51 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:48:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Daney <david.daney@cavium.com>
Cc:     Jan Glauber <jglauber@cavium.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC, thunderx: Remove VLA usage
Message-ID: <20180629184850.GA37464@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
switches to using a kmalloc-allocated buffer instead of stack space.
This should be fine since the existing routine is allocating memory
too.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: David Daney <david.daney@cavium.com>
Cc: Jan Glauber <jglauber@cavium.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/edac/thunderx_edac.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 4803c6468bab..c009d94f40c5 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -408,26 +408,29 @@ static ssize_t thunderx_lmc_inject_ecc_write(struct file *file,
 					     size_t count, loff_t *ppos)
 {
 	struct thunderx_lmc *lmc = file->private_data;
-
 	unsigned int cline_size = cache_line_size();
-
-	u8 tmp[cline_size];
+	u8 *tmp;
 	void __iomem *addr;
 	unsigned int offs, timeout = 100000;
 
 	atomic_set(&lmc->ecc_int, 0);
 
 	lmc->mem = alloc_pages_node(lmc->node, GFP_KERNEL, 0);
-
 	if (!lmc->mem)
 		return -ENOMEM;
 
+	tmp = kmalloc(cline_size, GFP_KERNEL);
+	if (!tmp) {
+		__free_pages(lmc->mem, 0);
+		return -ENOMEM;
+	}
+
 	addr = page_address(lmc->mem);
 
 	while (!atomic_read(&lmc->ecc_int) && timeout--) {
 		stop_machine(inject_ecc_fn, lmc, NULL);
 
-		for (offs = 0; offs < PAGE_SIZE; offs += sizeof(tmp)) {
+		for (offs = 0; offs < PAGE_SIZE; offs += cline_size) {
 			/*
 			 * Do a load from the previously rigged location
 			 * This should generate an error interrupt.
@@ -437,6 +440,7 @@ static ssize_t thunderx_lmc_inject_ecc_write(struct file *file,
 		}
 	}
 
+	kfree(tmp);
 	__free_pages(lmc->mem, 0);
 
 	return count;
-- 
2.17.1


-- 
Kees Cook
Pixel Security
