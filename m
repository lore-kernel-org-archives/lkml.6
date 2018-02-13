Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965828AbeBMUl1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:41:27 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43118 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965676AbeBMUl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:41:26 -0500
X-Google-Smtp-Source: AH8x226HSKndK704RL2MpeJZgOs7Yfb1UJH9nSopBLCTWasPTi/bSv5HCxqZWuYb4kzp8wddYFur5Q==
From: Markus Mayer <mmayer@broadcom.com>
To: Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc: Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] memory: brcmstb: dpfe: properly mask vendor error bits
Date: Tue, 13 Feb 2018 12:40:38 -0800
Message-Id: <1518554440-21805-2-git-send-email-mmayer@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518554440-21805-1-git-send-email-mmayer@broadcom.com>
References: <1518554440-21805-1-git-send-email-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were printing the entire 32 bit register rather than just the lower
8 bits. Anything above bit 7 is reserved and may be any random value.

Fixes: 2f330caff577 ("memory: brcmstb: Add driver for DPFE")
Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 0a7bdbed3a6f..088153760e52 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -603,7 +603,8 @@ static ssize_t show_vendor(struct device *dev, struct device_attribute *devattr,
 		       readl_relaxed(info + DRAM_VENDOR_MR6) & DRAM_VENDOR_MASK,
 		       readl_relaxed(info + DRAM_VENDOR_MR7) & DRAM_VENDOR_MASK,
 		       readl_relaxed(info + DRAM_VENDOR_MR8) & DRAM_VENDOR_MASK,
-		       readl_relaxed(info + DRAM_VENDOR_ERROR));
+		       readl_relaxed(info + DRAM_VENDOR_ERROR) &
+				     DRAM_VENDOR_MASK);
 }
 
 static int brcmstb_dpfe_resume(struct platform_device *pdev)
-- 
2.7.4
