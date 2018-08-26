Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512ADC43334
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D31E20A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 02:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CEFttIcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D31E20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeHZGWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 02:22:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42434 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeHZGW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 02:22:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7Q2ci0W018166;
        Sun, 26 Aug 2018 02:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=rzPKFXQX+fuQlPeaU75vzZtEQSZNaJqX0TtSlt5GhyI=;
 b=CEFttIcYP9+ICeIcCo0vLer1Abuvap8p18ylyS9P2hnliYm57+mOpp1XaJDifci/tQMN
 3oD3rdTrcRRyu2JAu4VUoIAbUAEvmYx1kBQqpPKtCINiJyjW7TBP/t/0+gwO19oNPRt3
 Y8k8ugzZVNk4KW3jEdlBIYfXLhRd+TsuUxmfxjZSXxxTg2D1GMEvg4Ju47t/if0M+Dhx
 0k2MbBtAqELk+Va+hR/zQkz8jkMJWe8CnrpGnjxT8RnM4cVwedxzqwdQ0wO5XZDUeG5l
 iHs47NP36tUzSmDFHQ9c7pY56cqFVLNtWE4nNvO2DF+7iNhUb4NoRGEmeenT1PFY0Wzr 4A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2m2xht9mam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Aug 2018 02:40:13 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7Q2eCaN012162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Aug 2018 02:40:12 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7Q2eBhM028423;
        Sun, 26 Aug 2018 02:40:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 25 Aug 2018 19:40:11 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     herbert@gondor.apana.org.au
Cc:     Jeff.Lien@wdc.com, ard.biesheuvel@linaro.org,
        david.darrington@wdc.com, hch@infradead.org, jeff.furlong@wdc.com,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, tim.c.chen@linux.intel.com
Subject: [PATCH 4/4] block: Integrity profile init function to trigger module loads
Date:   Sat, 25 Aug 2018 22:40:06 -0400
Message-Id: <20180826024006.13800-4-martin.petersen@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180826024006.13800-1-martin.petersen@oracle.com>
References: <20180825061205.ygrjjazkooqghrqy@gondor.apana.org.au>
 <20180826024006.13800-1-martin.petersen@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8996 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808260028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The T10 CRC library function is built into the kernel and therefore
registered early. The hardware-accelerated CRC helpers are typically
loaded as modules and only become available later in the boot
sequence. A separate patch modifies the T10 CRC library to subscribe
to notifications from crypto and permits switching from the
table-based algorithm to a hardware accelerated ditto once the
relevant module is loaded.

However, since the dependency for "crc10dif" is already satisfied,
nothing is going to cause the hardware-accelerated kernel modules to
get loaded. Introduce an init_fn in the integrity profile that can be
called to trigger a load of modules providing the T10 CRC calculation
capability. This function will ony get called when a new integrity
profile is registered during device discovery.

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-integrity.c  |  5 +++++
 block/t10-pi.c         | 10 ++++++++++
 include/linux/blkdev.h |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 6121611e1316..5cacae9a2dc2 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -27,6 +27,7 @@
 #include <linux/scatterlist.h>
 #include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 
 #include "blk.h"
 
@@ -391,6 +392,7 @@ static blk_status_t blk_integrity_nop_fn(struct blk_integrity_iter *iter)
 
 static const struct blk_integrity_profile nop_profile = {
 	.name = "nop",
+	.init_fn = NULL,
 	.generate_fn = blk_integrity_nop_fn,
 	.verify_fn = blk_integrity_nop_fn,
 };
@@ -418,6 +420,9 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
 	bi->tuple_size = template->tuple_size;
 	bi->tag_size = template->tag_size;
 
+	if (bi->profile->init_fn)
+		bi->profile->init_fn();
+
 	disk->queue->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
 }
 EXPORT_SYMBOL(blk_integrity_register);
diff --git a/block/t10-pi.c b/block/t10-pi.c
index a98db384048f..b83278f9163a 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -24,6 +24,7 @@
 #include <linux/t10-pi.h>
 #include <linux/blkdev.h>
 #include <linux/crc-t10dif.h>
+#include <linux/module.h>
 #include <net/checksum.h>
 
 typedef __be16 (csum_fn) (void *, unsigned int);
@@ -157,8 +158,14 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
 	return t10_pi_verify(iter, t10_pi_ip_fn, 3);
 }
 
+static void t10_pi_crc_init(void)
+{
+	request_module_nowait(CRC_T10DIF_STRING);
+}
+
 const struct blk_integrity_profile t10_pi_type1_crc = {
 	.name			= "T10-DIF-TYPE1-CRC",
+	.init_fn		= t10_pi_crc_init,
 	.generate_fn		= t10_pi_type1_generate_crc,
 	.verify_fn		= t10_pi_type1_verify_crc,
 };
@@ -166,6 +173,7 @@ EXPORT_SYMBOL(t10_pi_type1_crc);
 
 const struct blk_integrity_profile t10_pi_type1_ip = {
 	.name			= "T10-DIF-TYPE1-IP",
+	.init_fn		= NULL,
 	.generate_fn		= t10_pi_type1_generate_ip,
 	.verify_fn		= t10_pi_type1_verify_ip,
 };
@@ -173,6 +181,7 @@ EXPORT_SYMBOL(t10_pi_type1_ip);
 
 const struct blk_integrity_profile t10_pi_type3_crc = {
 	.name			= "T10-DIF-TYPE3-CRC",
+	.init_fn		= t10_pi_crc_init,
 	.generate_fn		= t10_pi_type3_generate_crc,
 	.verify_fn		= t10_pi_type3_verify_crc,
 };
@@ -180,6 +189,7 @@ EXPORT_SYMBOL(t10_pi_type3_crc);
 
 const struct blk_integrity_profile t10_pi_type3_ip = {
 	.name			= "T10-DIF-TYPE3-IP",
+	.init_fn		= NULL,
 	.generate_fn		= t10_pi_type3_generate_ip,
 	.verify_fn		= t10_pi_type3_verify_ip,
 };
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 79226ca8f80f..a43c02e4f43d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1806,10 +1806,12 @@ struct blk_integrity_iter {
 };
 
 typedef blk_status_t (integrity_processing_fn) (struct blk_integrity_iter *);
+typedef void (integrity_init_fn) (void);
 
 struct blk_integrity_profile {
 	integrity_processing_fn		*generate_fn;
 	integrity_processing_fn		*verify_fn;
+	integrity_init_fn		*init_fn;
 	const char			*name;
 };
 
-- 
2.17.1

