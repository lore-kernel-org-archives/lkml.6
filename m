Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934478AbeBWTnY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:43:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57392 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754822AbeBWTmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 14:42:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD03960848
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tbaicar@codeaurora.org
From: Tyler Baicar <tbaicar@codeaurora.org>
To: ard.biesheuvel@linaro.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhugo@codeaurora.org,
        sgoel@codeaurora.org, takahiro.akashi@linaro.org, timur@codeaurora.org
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH 1/2] efi/esrt: fix unsupported version initialization failure
Date: Fri, 23 Feb 2018 12:42:32 -0700
Message-Id: <1519414953-5478-2-git-send-email-tbaicar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519414953-5478-1-git-send-email-tbaicar@codeaurora.org>
References: <1519414953-5478-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ESRT initialization fails due to an unsupported version, the
early_memremap allocation is never unmapped. This will cause an
early ioremap leak. So, make sure to unmap the memory allocation
before returning from efi_esrt_init().

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/firmware/efi/esrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index c47e0c6..504f3c3 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -285,7 +285,7 @@ void __init efi_esrt_init(void)
 	} else {
 		pr_err("Unsupported ESRT version %lld.\n",
 		       tmpesrt.fw_resource_version);
-		return;
+		goto err_memunmap;
 	}
 
 	if (tmpesrt.fw_resource_count > 0 && max - size < entry_size) {
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
