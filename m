Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeD3HWd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:22:33 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39239 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbeD3HWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:22:32 -0400
X-Google-Smtp-Source: AB8JxZqZkdRbp3i3xj22xGXWRLouIb19yym+uJy3Qhhap3s2Mmx1OFedbYbhcMRzHloNZjerNAbSnA==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com
Subject: [PATCH 1/3] nds32: Fix the virtual address may map too much range by tlbop issue.
Date: Mon, 30 Apr 2018 15:20:39 +0800
Message-Id: <a42871ba8088e343cdfd405426ea25e5727116af.1525072600.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use tlbop to map virtual address in the first beginning, however it
may map too much if DRAM size is not that big. We have to invalidate the
mapping when the page table is created.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
index ba910e9e4ecb..2f5b2ccebe47 100644
--- a/arch/nds32/kernel/setup.c
+++ b/arch/nds32/kernel/setup.c
@@ -293,6 +293,9 @@ void __init setup_arch(char **cmdline_p)
 	/* paging_init() sets up the MMU and marks all pages as reserved */
 	paging_init();
 
+	/* invalidate all TLB entries because the new mapping is created */
+	__nds32__tlbop_flua();
+
 	/* use generic way to parse */
 	parse_early_param();
 
-- 
1.9.5
