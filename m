Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62D4C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80262206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iw6FIM/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80262206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeIGMhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:37:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45087 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeIGMhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:37:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id i26-v6so6615379pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jeWHjhWZzqcn992r+CjxadoTg1glUklXZIt+KkbfGzY=;
        b=Iw6FIM/UTbLuebPjiA4jQVIGzj1ZOSMVexZ11oWFVNDZ/ufvkYBdyX+BbPZ/5aYKuB
         r7XPHSCEgPMikmy/gv+Bo0F7HsfeRIQE/WRc+OOPgtR5GjEeC+1fc0e67z4kIxqGHvFI
         9s44tc/wjbhJiYdjVD0GmiWIk9iV8rl4OPZWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jeWHjhWZzqcn992r+CjxadoTg1glUklXZIt+KkbfGzY=;
        b=qRA9/44oUflzGjDqIM5WSRZMR/Je07E9yMra7flDKA7G+TRv99p8QIwA7v4f+xK8bW
         8m7rZYYF7BUQZUibXIX4iKsQ/aPvgPbcmTbOR3wJOz2f3iF9f1arYzFjvg/+4EKS30//
         0dg8R4AloVRmr4jWILhj7sdDfaUHG1L3mpJnoShIIcXz5aAw8JtRbVcjoXLm32W1VKU9
         VJBVanpDA4931p8PT6vaM16lx8K3bY8UeESwRGAnBxALkojPmS/B3+V6doOhDX1GV8RT
         4k15tadB75ar0h1FvfYSzc8k+y/wqtgTb4w7ShI5WnQvjzZSc95/RFIRzJnoIAyF8o05
         5cdg==
X-Gm-Message-State: APzg51AO3X+EUJPI2UVBadbOukE9DJTYvuLVeoln0erMQYuUwAMDlGq/
        CFdjK/35gJW0J1SatBnbthBz5Q==
X-Google-Smtp-Source: ANB0VdZrG69yj9ElBSyC2eZg1/EFcPXyz/rqBMU49wEU/gT4vQCwnzRYWUbh+3xhlWJ+NispINZ47A==
X-Received: by 2002:a62:56d9:: with SMTP id h86-v6mr7152853pfj.229.1536307082476;
        Fri, 07 Sep 2018 00:58:02 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id l185-v6sm18675979pga.5.2018.09.07.00.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 00:58:01 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v14 05/16] kexec_file: kexec_walk_memblock() only walks a dedicated region at kdump
Date:   Fri,  7 Sep 2018 16:56:42 +0900
Message-Id: <20180907075653.4696-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907075653.4696-1-takahiro.akashi@linaro.org>
References: <20180907075653.4696-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdump case, there exists only one dedicated memblock region as usable
memory (crashk_res). With this patch, kexec_walk_memblock() runs a given
callback function on this region.

Cosmetic change: 0 to MEMBLOCK_NONE at for_each_free_mem_range*()

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 370d7eab49fe..2f615a7968dd 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -511,8 +511,11 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 	phys_addr_t mstart, mend;
 	struct resource res = { };
 
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		return func(&crashk_res, kbuf);
+
 	if (kbuf->top_down) {
-		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
+		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, MEMBLOCK_NONE,
 						&mstart, &mend, NULL) {
 			/*
 			 * In memblock, end points to the first byte after the
@@ -526,8 +529,8 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 				break;
 		}
 	} else {
-		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
-					NULL) {
+		for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
+					&mstart, &mend, NULL) {
 			/*
 			 * In memblock, end points to the first byte after the
 			 * range while in kexec, end points to the last byte
-- 
2.18.0

