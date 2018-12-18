Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31070C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38B121873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151228;
	bh=HFs5I83Qckr8sT1bbamUWInQBw8FnIMu7cRDmFxuZqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t1WYs6YcTA0QsW1OPGDc+4Ab3pmBz7zKMKwcgBovcq2rnTw6vT2TqI5IIWCrTQuzG
	 YHXs3r1sjb6s4W3W/K298SKxI4TOGMK5tyxeIqOt7nkUXdu5c3NsZxYp/4+g0YEHu4
	 UJ9foSgqv5FlUkYj3w9bHdJdxB7ldVJkwub8pwNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeLRQk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbeLRQkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E791B21873;
        Tue, 18 Dec 2018 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151223;
        bh=HFs5I83Qckr8sT1bbamUWInQBw8FnIMu7cRDmFxuZqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWXV3nwPjoFkho7HnVtFCVWcVkl7TZohfz+Q59+eEUauLu3OfrDfuGfjhgRaIEDsm
         et+D+lLrJgvaXGqbXzWRib3C0TrdzhXevLiRE94WftQzKCjZMcAgFkYcpSpuJlwExL
         LDGLuHDRbyerroiqVUfEfpEzFNvrmVLc40vqbcr8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 07/44] drm/msm: fix address space warning
Date:   Tue, 18 Dec 2018 17:39:19 +0100
Message-Id: <20181218163928.146556875@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

In the linux-4.19 stable kernel, we get a warning about a type
mismatch between phys_addr_t and dma_addr_t:

drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c: In function '_dpu_dbg_dump_dpu_dbg_bus':
drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c:2003:16: error: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type [-Werror=incompatible-pointer-types]
     list_size, &phys, GFP_KERNEL);
                ^~~~~
In file included from include/linux/dma-buf.h:31,
                 from drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c:20:
include/linux/dma-mapping.h:561:15: note: expected 'dma_addr_t *' {aka 'long long unsigned int *'} but argument is of type 'phys_addr_t *' {aka 'unsigned int *'}
   dma_addr_t *dma_handle, gfp_t flag)
   ~~~~~~~~~~~~^~~~~~~~~~
drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c: In function '_dpu_dbg_dump_vbif_dbg_bus':
drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c:2154:16: error: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type [-Werror=incompatible-pointer-types]
     list_size, &phys, GFP_KERNEL);
                ^~~~~
In file included from include/linux/dma-buf.h:31,
                 from drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c:20:
include/linux/dma-mapping.h:561:15: note: expected 'dma_addr_t *' {aka 'long long unsigned int *'} but argument is of type 'phys_addr_t *' {aka 'unsigned int *'}

This code was removed in linux-4.20 with upstream commit effec874792f
("drm/msm/dpu: Remove dpu_dbg"). Rather than backporting the large
patch, this just fixes the warning by using the correct type.

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c
index ae2aee7ed9e1..e741d26185df 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c
@@ -1962,7 +1962,7 @@ static void _dpu_dbg_dump_dpu_dbg_bus(struct dpu_dbg_dpu_debug_bus *bus)
 	u32 *dump_addr = NULL;
 	u32 status = 0;
 	struct dpu_debug_bus_entry *head;
-	phys_addr_t phys = 0;
+	dma_addr_t dma = 0;
 	int list_size;
 	int i;
 	u32 offset;
@@ -2000,7 +2000,7 @@ static void _dpu_dbg_dump_dpu_dbg_bus(struct dpu_dbg_dpu_debug_bus *bus)
 	if (in_mem) {
 		if (!(*dump_mem))
 			*dump_mem = dma_alloc_coherent(dpu_dbg_base.dev,
-				list_size, &phys, GFP_KERNEL);
+				list_size, &dma, GFP_KERNEL);
 
 		if (*dump_mem) {
 			dump_addr = *dump_mem;
@@ -2101,7 +2101,7 @@ static void _dpu_dbg_dump_vbif_dbg_bus(struct dpu_dbg_vbif_debug_bus *bus)
 	u32 value, d0, d1;
 	unsigned long reg, reg1, reg2;
 	struct vbif_debug_bus_entry *head;
-	phys_addr_t phys = 0;
+	dma_addr_t dma = 0;
 	int i, list_size = 0;
 	void __iomem *mem_base = NULL;
 	struct vbif_debug_bus_entry *dbg_bus;
@@ -2151,7 +2151,7 @@ static void _dpu_dbg_dump_vbif_dbg_bus(struct dpu_dbg_vbif_debug_bus *bus)
 	if (in_mem) {
 		if (!(*dump_mem))
 			*dump_mem = dma_alloc_coherent(dpu_dbg_base.dev,
-				list_size, &phys, GFP_KERNEL);
+				list_size, &dma, GFP_KERNEL);
 
 		if (*dump_mem) {
 			dump_addr = *dump_mem;
-- 
2.19.1



