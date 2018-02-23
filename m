Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934393AbeBWTmn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:42:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57432 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754691AbeBWTml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 14:42:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9451D6084A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tbaicar@codeaurora.org
From: Tyler Baicar <tbaicar@codeaurora.org>
To: ard.biesheuvel@linaro.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhugo@codeaurora.org,
        sgoel@codeaurora.org, takahiro.akashi@linaro.org, timur@codeaurora.org
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH 2/2] efi/esrt: mark ESRT memory region as nomap
Date: Fri, 23 Feb 2018 12:42:33 -0700
Message-Id: <1519414953-5478-3-git-send-email-tbaicar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519414953-5478-1-git-send-email-tbaicar@codeaurora.org>
References: <1519414953-5478-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ESRT memory region is being exposed as System RAM in /proc/iomem
which is wrong because it cannot be overwritten. This memory is needed
for kexec kernels in order to properly initialize ESRT, so if it is
overwritten it will cause ESRT failures in the kexec kernel. Mark this
region as nomap so that it is not overwritten.

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/firmware/efi/esrt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index 504f3c3..f5f79c7 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -335,6 +335,14 @@ void __init efi_esrt_init(void)
 	pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, &end);
 	efi_mem_reserve(esrt_data, esrt_data_size);
 
+	/*
+	 * Mark the ESRT memory region as nomap to avoid it being exposed as
+	 * System RAM in /proc/iomem. Otherwise this block can be overwritten
+	 * which will then cause failures in kexec'd kernels since the ESRT
+	 * information is no longer there.
+	 */
+	memblock_mark_nomap(esrt_data, esrt_data_size);
+
 	pr_debug("esrt-init: loaded.\n");
 err_memunmap:
 	early_memunmap(va, size);
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
