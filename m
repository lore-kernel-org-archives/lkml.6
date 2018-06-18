Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4C5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AE220852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AE220852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754743AbeFRP2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:28:54 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37383 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752849AbeFRP2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:28:52 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lx0lJ-1gJ5pw0rLF-016d3G; Mon, 18 Jun 2018 17:27:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>,
        Dave Carroll <david.carroll@microsemi.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] aacraid: stop using deprated get_seconds()
Date:   Mon, 18 Jun 2018 17:26:47 +0200
Message-Id: <20180618152734.1705907-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:syyDAalw4WAbMQ1EHmInd9Roltij1J07HEFM0xdLx85fWQapAcv
 E1snIRGUtlRI60COhzmvFOZ+iBJvadaf4VEs9FcZCO2/frcgsPGO3KAFcqntgmOLldhi2Gc
 nH45SdLp8Fw/OYXiO70kRUlnNXx8LRis57DdnteNfwBrYHA+00sXwu0m5T3jRCx2qU1fhz7
 zgO03p4ONv9pYnYm2qphw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cZF80Fh1NX8=:zlUkOcCNelIVkjHoWwdaEW
 DQP46HaCYFilqQAzTd5rKT2ASGHb2hW0vLeJdDQ6xVgAiM35bd5+K8fzaCDRUiE0dmuRY+LSQ
 nATyJzeMwKnUyAwelOgNFoWSNfHuJexEI3v13SE9jR2QcIkh2nCcdnWX17F1OT98rsoTU45KA
 wR20Mhzknqh6PDB0VM4VMk1UmI0E0NgITwzyDuNkeaaoGLiE8QG7kGEYjk6b8HylVBIwE2v3l
 jxRd9iHXUxOJa8y6o1v82760BVu7Xexczn0XHmb8bFv719eBMsQ/xIJL0bGZD6hYzKoWyZ1gM
 C6b/PNIvCr2iT4VeyjM9V8hGhHBWxUMeGoBmN514FWzjWiW20yD7j5FUeOUghsSIRTLdd567O
 0vcKpyl28hy4dcpQXxvDLHidqEvBiml9z+gWEuPnCcoLO92CK6RN9Q+5Vkp0vb3vFfNCeXLtX
 FlFJs/QjrIs4dqoOSxrJl84hX4CVQl5uf7/6k1ml1VSe22yjzB+qPr1daDbhDn62AkIxQGpFF
 PGAoGL59XCQlBqpRwN1LzGeKdN1ftTtEOn1ZNVGj7C9izb0nIe3DAtH/takQ2UBIOuTjhVsaQ
 oQ8O5R00BoxIFkccTzjyCKjr+ub76lqVK6pVuIuPvbAUZUVAQ75sTdAavkt7BXTCvUNQ5ZPzM
 IfRRb+STrps0lOXexaAkIYfOerctXuqzOgU/CRfJqz+CG+o30Jtwq9usipl70WIOxjE8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_seconds() can overflow on 32-bit architectures and is deprecated
because of that. The use in the aacraid driver has the same problem due
to a limited firmware interface, it also overflows in the year 2106.

This changes all calls to get_seconds() to the non-deprecated
ktime_get_real_seconds(), which unfortunately doesn't solve that problem
but gets rid of one user of the deprecated interface.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/aacraid/rx.c  | 2 +-
 drivers/scsi/aacraid/sa.c  | 2 +-
 drivers/scsi/aacraid/src.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/aacraid/rx.c b/drivers/scsi/aacraid/rx.c
index 620166694171..576cdf9cc120 100644
--- a/drivers/scsi/aacraid/rx.c
+++ b/drivers/scsi/aacraid/rx.c
@@ -319,7 +319,7 @@ static void aac_rx_start_adapter(struct aac_dev *dev)
 	union aac_init *init;
 
 	init = dev->init;
-	init->r7.host_elapsed_seconds = cpu_to_le32(get_seconds());
+	init->r7.host_elapsed_seconds = cpu_to_le32(ktime_get_real_seconds());
 	// We can only use a 32 bit address here
 	rx_sync_cmd(dev, INIT_STRUCT_BASE_ADDRESS, (u32)(ulong)dev->init_pa,
 	  0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL);
diff --git a/drivers/scsi/aacraid/sa.c b/drivers/scsi/aacraid/sa.c
index 882f40353b96..efa96c1c6aa3 100644
--- a/drivers/scsi/aacraid/sa.c
+++ b/drivers/scsi/aacraid/sa.c
@@ -251,7 +251,7 @@ static void aac_sa_start_adapter(struct aac_dev *dev)
 	 * Fill in the remaining pieces of the init.
 	 */
 	init = dev->init;
-	init->r7.host_elapsed_seconds = cpu_to_le32(get_seconds());
+	init->r7.host_elapsed_seconds = cpu_to_le32(ktime_get_real_seconds());
 	/* We can only use a 32 bit address here */
 	sa_sync_cmd(dev, INIT_STRUCT_BASE_ADDRESS, 
 			(u32)(ulong)dev->init_pa, 0, 0, 0, 0, 0,
diff --git a/drivers/scsi/aacraid/src.c b/drivers/scsi/aacraid/src.c
index 4ebb35a29caa..5a299975a289 100644
--- a/drivers/scsi/aacraid/src.c
+++ b/drivers/scsi/aacraid/src.c
@@ -409,7 +409,7 @@ static void aac_src_start_adapter(struct aac_dev *dev)
 
 	init = dev->init;
 	if (dev->comm_interface == AAC_COMM_MESSAGE_TYPE3) {
-		init->r8.host_elapsed_seconds = cpu_to_le32(get_seconds());
+		init->r8.host_elapsed_seconds = cpu_to_le32(ktime_get_real_seconds());
 		src_sync_cmd(dev, INIT_STRUCT_BASE_ADDRESS,
 			lower_32_bits(dev->init_pa),
 			upper_32_bits(dev->init_pa),
@@ -417,7 +417,7 @@ static void aac_src_start_adapter(struct aac_dev *dev)
 			(AAC_MAX_HRRQ - 1) * sizeof(struct _rrq),
 			0, 0, 0, NULL, NULL, NULL, NULL, NULL);
 	} else {
-		init->r7.host_elapsed_seconds = cpu_to_le32(get_seconds());
+		init->r7.host_elapsed_seconds = cpu_to_le32(ktime_get_real_seconds());
 		// We can only use a 32 bit address here
 		src_sync_cmd(dev, INIT_STRUCT_BASE_ADDRESS,
 			(u32)(ulong)dev->init_pa, 0, 0, 0, 0, 0,
-- 
2.9.0

