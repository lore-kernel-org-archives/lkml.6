Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D7C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBDF20836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DBDF20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935948AbeFRS4l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:56:41 -0400
Received: from www.osadl.org ([62.245.132.105]:48894 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935752AbeFRS4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:56:40 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w5IIrtX6023371;
        Mon, 18 Jun 2018 20:53:56 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] staging: board: drop refcount in success case
Date:   Mon, 18 Jun 2018 20:53:19 +0200
Message-Id: <1529347999-9316-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The call to of_find_compatible_node() returns irqc_node with refcount
incremented thus it must be explicitly decremented here after it was
checked for non-NULL.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 72ee8626eeb1 ("staging: board: Add support for translating hwirq to virq numbers")
---

Problem located with an experimental coccinelle script

Patch was compile-tested with: x86_64_defconfig + STAGING=y, STAGING_BOARD=y

Patch is against 4.18-rc1 (localversion-next is next-20180618)

 drivers/staging/board/board.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
index cb6feb3..8ee48e5 100644
--- a/drivers/staging/board/board.c
+++ b/drivers/staging/board/board.c
@@ -64,12 +64,13 @@ int __init board_staging_gic_setup_xlate(const char *gic_match,
 	irqc_node = of_find_compatible_node(NULL, NULL, gic_match);
 
 	WARN_ON(!irqc_node);
 	if (!irqc_node)
 		return -ENOENT;
 
+	of_node_put(irqc_node);
 	irqc_base = base;
 	return 0;
 }
 
 static void __init gic_fixup_resource(struct resource *res)
 {
-- 
2.1.4

