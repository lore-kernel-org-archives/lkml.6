Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D1DECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB932081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/3ZkM0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB932081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbeKAIJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:09:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730658AbeKAIJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB8A20838;
        Wed, 31 Oct 2018 23:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027378;
        bh=uj7pqy00sEesVJHROTkKHccFKi6NjlaVwUz+BnUtPmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/3ZkM0Z5J4h0b3hl3kCi3dSFoB6oCNIN1EljK9ZC8YdPKa7sxayWRq72ilCoSSWG
         073gN5VX2xxePMqOZRRUSDTZK7I1qOuDXfOak1wqbBTEhoYCrOojHkmL+tjnRJlrOw
         blhOtDhAGp2wqHLAua48UeohLrBpm+0bcqNghEO8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 115/126] firmware: coreboot: Unmap ioregion after device population
Date:   Wed, 31 Oct 2018 19:07:43 -0400
Message-Id: <20181031230754.29029-115-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit 20edec388277b62ddfddb8b2b376a937a2cd6d1b ]

Both callers of coreboot_table_init() ioremap the pointer that comes in
but they don't unmap the memory on failure. Both of them also fail probe
immediately with the return value of coreboot_table_init(), leaking a
mapping when it fails. The mapping isn't necessary at all after devices
are populated either, so we can just drop the mapping here when we exit
the function. Let's do that to simplify the code a bit and plug the leak.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Fixes: 570d30c2823f ("firmware: coreboot: Expose the coreboot table as a bus")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/google/coreboot_table.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 19db5709ae28..898bb9abc41f 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -110,7 +110,8 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
 
 	if (strncmp(header.signature, "LBIO", sizeof(header.signature))) {
 		pr_warn("coreboot_table: coreboot table missing or corrupt!\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	ptr_entry = (void *)ptr_header + header.header_bytes;
@@ -137,7 +138,8 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
 
 		ptr_entry += entry.size;
 	}
-
+out:
+	iounmap(ptr);
 	return ret;
 }
 EXPORT_SYMBOL(coreboot_table_init);
@@ -146,7 +148,6 @@ int coreboot_table_exit(void)
 {
 	if (ptr_header) {
 		bus_unregister(&coreboot_bus_type);
-		iounmap(ptr_header);
 		ptr_header = NULL;
 	}
 
-- 
2.17.1

