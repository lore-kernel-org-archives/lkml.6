Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA16C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DBB21874
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAZpVJjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfBZWTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:19:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33633 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfBZWTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:19:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so15761049wrw.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 14:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=4VGA/rvdp59YF+HynJarf8sg4qhTofD4EEranAJJWU8=;
        b=iAZpVJjkRHYEdmVvWImhHSfhVKBgSuK2eKdrBjyaJNgBZP7t6QlO+8uXfUlCRlZbrq
         AdgQN/W5+PfrsCfePeqU1jT6fTpmHUQ3fJQo15BslJuwKyQj2Xx64QDtdL/rmjIgjUFh
         X2ChezV3hCK7qCjYrZrcF8/esOBBHwpc8Pmnw+EXDaYEmdGOmhsIwmjHqhauHYQ0sOBF
         +q4ZrfXH2a0Qy8QVs8pTi4LAUdAsOX/TxbTwdEczMnsflsXeEyePwiSIGLdujgdaiu3X
         +H9pVK4eLsg2d/4RPnyNG7od3Ke03oDF5Ehkm8hKA4OIucRPnS+emEWdhzP2UapcQenl
         si3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=4VGA/rvdp59YF+HynJarf8sg4qhTofD4EEranAJJWU8=;
        b=TMFVnK50T3Zx1VsNP2BQvf26xd+WKSyYGeImujiFDSuR8OPlEzoua+Qwxoab0mCs9n
         U/Zg5LKAco3h6M3E8Irx5ExorrErCCDT99ZmjJz4Tq4VGSddELXHB2RK5cBs3ZrOb3kX
         Oryl+q/Ui/VwSeRUA+di6Mjea2s1scNXqcmjGs3YCgRmUT+WYfTt9Fg8LJ10lUFsLOYF
         ZHuFCP9cMiQiktL+firWgU7JVrsikzFsRU5wS5VyPoN1774aeHPiLfIRAlcXY7LwRMtg
         u0LpjsUXPwBN+f/wXl/79OyIVKc9UIoY2YRVOBG/ddr66lohlk+dU8VEvFoJ+Ih4U7DM
         pqaQ==
X-Gm-Message-State: APjAAAU0VyLcyLx7utviVCCE2Tm2lMFeYdfdalcLN4G2rdHtvUQD4dtR
        8yMDbDja3Y2mc1yT41Kln5w=
X-Google-Smtp-Source: APXvYqzCyhIIeV38YpEOfVt6bbkxLdp6a8PGd0Adm+wtSO+NX9U8+PGiLE9tiOVaLBVX7p1EJwSEjg==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr504wrp.44.1551219560443;
        Tue, 26 Feb 2019 14:19:20 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o18sm39158166wrg.40.2019.02.26.14.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 14:19:19 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: allow memory allocations larger than 4GB
Date:   Wed, 27 Feb 2019 00:19:18 +0200
Message-Id: <20190226221918.20991-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch increase the size field in the uapi structure of the Memory
IOCTL from 32-bit to 64-bit. This is to allow the user to allocate and/or
map memory in chunks that are larger then 4GB.

Goya's device memory (DRAM) can be up to 16GB, and for certain
topologies, the user may want an allocation that is larger than 4GB.

This change doesn't break current user-space because there was a "pad"
field in the uapi structure right after the size field. Changing the size
field to be 64-bit and removing the pad field maintains compatibility with
current user-space.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs.h |  2 +-
 drivers/misc/habanalabs/memory.c     | 10 ++++------
 include/uapi/misc/habanalabs.h       |  6 ++----
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 901542d685e8..fdf517448599 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1320,7 +1320,7 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx);
 int hl_vm_init(struct hl_device *hdev);
 void hl_vm_fini(struct hl_device *hdev);
 
-int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u32 size,
+int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
 			struct hl_userptr *userptr);
 int hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userptr);
 void hl_userptr_delete_list(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 9e3491dc3b55..4b57d7ce50dd 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1210,7 +1210,7 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
  * - Pins the physical pages
  * - Create a SG list from those pages
  */
-int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u32 size,
+int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
 			struct hl_userptr *userptr)
 {
 	u64 start, end;
@@ -1218,14 +1218,12 @@ int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u32 size,
 	int rc;
 
 	if (!size) {
-		dev_err(hdev->dev, "size to pin is invalid - %d\n",
-			size);
+		dev_err(hdev->dev, "size to pin is invalid - %llu\n", size);
 		return -EINVAL;
 	}
 
 	if (!access_ok((void __user *) (uintptr_t) addr, size)) {
-		dev_err(hdev->dev, "user pointer is invalid - 0x%llx\n",
-			addr);
+		dev_err(hdev->dev, "user pointer is invalid - 0x%llx\n", addr);
 		return -EFAULT;
 	}
 
@@ -1236,7 +1234,7 @@ int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u32 size,
 	if (((addr + size) < addr) ||
 			PAGE_ALIGN(addr + size) < (addr + size)) {
 		dev_err(hdev->dev,
-			"user pointer 0x%llx + %u causes integer overflow\n",
+			"user pointer 0x%llx + %llu causes integer overflow\n",
 			addr, size);
 		return -EINVAL;
 	}
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 4afc1891ece8..23d6ad3459cb 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -237,8 +237,7 @@ struct hl_mem_in {
 		/* HL_MEM_OP_ALLOC- allocate device memory */
 		struct {
 			/* Size to alloc */
-			__u32 mem_size;
-			__u32 pad;
+			__u64 mem_size;
 		} alloc;
 
 		/* HL_MEM_OP_FREE - free device memory */
@@ -278,8 +277,7 @@ struct hl_mem_in {
 			 */
 			__u64 hint_addr;
 			/* Size of allocated host memory */
-			__u32 mem_size;
-			__u32 pad;
+			__u64 mem_size;
 		} map_host;
 
 		/* HL_MEM_OP_UNMAP - unmap host memory */
-- 
2.17.1

