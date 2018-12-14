Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9AFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7298208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbeLNWNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:13:54 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:38237 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730956AbeLNWNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:13:54 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N2lzA-1hYnJJ3KJQ-0134uH; Fri, 14 Dec 2018 23:13:49 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Clark <robdclark@gmail.com>,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] [stable-4.19] drm/msm:  fix address space warning
Date:   Fri, 14 Dec 2018 23:10:12 +0100
Message-Id: <20181214221023.3878670-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214221023.3878670-1-arnd@arndb.de>
References: <20181214221023.3878670-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RALjA4tkloILgjm6jR+7T/S9goEocRFmUxYdSSKmhq8BVzr3cEe
 hXH994KH1JsI6FXYdhmRFjzNMOaN1XtRkYxMYxMjHTmqsbeLKNFlxFXRibvAtZgo+IDsTgk
 Q6F5VoxotmMJ+4lLatWxJ6/VyuZI/xxrO7OgCRnHkm17cuuYd6rk3OeafmWcoBG0M8zzIIL
 QMy6rhCltkgWKitzPnrFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K9rLjnmW5vk=:jVB6ky/IMCgCbvqNg5+HnQ
 mxpLVgI6lrqRNSExZI2nhNZXTAeJdFPvsWnDbLdT1Nbdzkjb8Qv3wftXDwG4zv2MSYs76Ci6O
 h8BCuUzmlRv5q9dsTL4IN4fXMAwTyruiIFBca4YFX/Wl0b7yBxuQ0quuMv43FZxgfvAHtH1fH
 Y6w9w42BWUc992cE3d72RiBuQQSZR6l1ABbFG79NlDD2jH5QuevaouIDAN7b7vycPdvINcXJ/
 XlUCp6U4vMCiaIN7DJiW3yw7pwzcc+LpzTIw1IlxGg0xOOMZhKlfw9bRTTkWSuhkC9fy33YsV
 dUjPrZdoRFxVB9HG4vOazAuj/K9+QidwSEK6ZKOAt/F08ZZdH3in6u0IGiuyjoAcCfl93fw1J
 I3lwC6v5EM/5R9B5PA+xspDHAm/CNr7zAHBoQak5mhSSVd/vmaAPfF/RV35TqV8mNekaqrTjq
 j15sfm7LkoTK5wV/Y0JWl4WKqkLrdSYglxCozuyUjaOdaAcqrVWDySJkG/jeXApdAAYhZaZQl
 CYDpDomBUB9X1WebGZDDb2srYAa+Hcom6amDZD0Mv5R0RayMzns0o/rYpvLTxmM/H8qEo9lCN
 RD7NIL7ynQmesZ909Wrpa9GceE3gtzGrnJprle0pKOUsU8tWCO0BsRpO4ZNf1RQKcDibCkayD
 qBaaCcbElSDOHDB7QQcpjIDmioPc6vugVkrtGPWihsYYDOl5qAePTP17nxRX3fbf5Y3CbEP6Y
 ZAUWqa3FAMDWeba8jW5OewxgFNvgG5fYe+bqjA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.20.0

