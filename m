Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbeCNSVf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:21:35 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.129]:37004 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750779AbeCNSVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:21:34 -0400
Date: Wed, 14 Mar 2018 13:21:32 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v4] EDAC, sb_edac: Remove VLA usage
Message-ID: <20180314182131.GA25259@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1ewB1p-001sw1-AR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:44066
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove VLA and replace it
with a fixed-length array instead.

Fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Also, remove max_interleave as it is no longer useful.

Reviewed-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v4:
 - Remove max_interleave.

Changes in v3:
 - Update macro MAX_INTERLEAVE in order to avoid too long lines.
   This change is based on Mauro's feedback.
 - Update changelog with Mauro's Reviewed-by.

Changes in v2:
 - Use macro max_t to compute the max of all three array sizes.
   This change is based on Borislav's feedback.

 drivers/edac/sb_edac.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 8721002..4a89c80 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -110,6 +110,10 @@ static const u32 knl_interleave_list[] = {
 	0xdc, 0xe4, 0xec, 0xf4, 0xfc, /* 15-19 */
 	0x104, 0x10c, 0x114, 0x11c,   /* 20-23 */
 };
+#define MAX_INTERLEAVE							\
+	(max_t(unsigned int, ARRAY_SIZE(sbridge_interleave_list),	\
+	       max_t(unsigned int, ARRAY_SIZE(ibridge_interleave_list),	\
+		     ARRAY_SIZE(knl_interleave_list))))
 
 struct interleave_pkg {
 	unsigned char start;
@@ -321,7 +325,6 @@ struct sbridge_info {
 	const u32	*interleave_list;
 	const struct interleave_pkg *interleave_pkg;
 	u8		max_sad;
-	u8		max_interleave;
 	u8		(*get_node_id)(struct sbridge_pvt *pvt);
 	enum mem_type	(*get_memory_type)(struct sbridge_pvt *pvt);
 	enum dev_type	(*get_width)(struct sbridge_pvt *pvt, u32 mtr);
@@ -1899,7 +1902,7 @@ static int get_memory_error_data(struct mem_ctl_info *mci,
 	int			n_rir, n_sads, n_tads, sad_way, sck_xch;
 	int			sad_interl, idx, base_ch;
 	int			interleave_mode, shiftup = 0;
-	unsigned		sad_interleave[pvt->info.max_interleave];
+	unsigned int		sad_interleave[MAX_INTERLEAVE];
 	u32			reg, dram_rule;
 	u8			ch_way, sck_way, pkg, sad_ha = 0;
 	u32			tad_offset;
@@ -3169,7 +3172,6 @@ static int sbridge_register_mci(struct sbridge_dev *sbridge_dev, enum type type)
 		pvt->info.dram_attr = dram_attr;
 		pvt->info.max_sad = ARRAY_SIZE(ibridge_dram_rule);
 		pvt->info.interleave_list = ibridge_interleave_list;
-		pvt->info.max_interleave = ARRAY_SIZE(ibridge_interleave_list);
 		pvt->info.interleave_pkg = ibridge_interleave_pkg;
 		pvt->info.get_width = ibridge_get_width;
 
@@ -3194,7 +3196,6 @@ static int sbridge_register_mci(struct sbridge_dev *sbridge_dev, enum type type)
 		pvt->info.dram_attr = dram_attr;
 		pvt->info.max_sad = ARRAY_SIZE(sbridge_dram_rule);
 		pvt->info.interleave_list = sbridge_interleave_list;
-		pvt->info.max_interleave = ARRAY_SIZE(sbridge_interleave_list);
 		pvt->info.interleave_pkg = sbridge_interleave_pkg;
 		pvt->info.get_width = sbridge_get_width;
 
@@ -3219,7 +3220,6 @@ static int sbridge_register_mci(struct sbridge_dev *sbridge_dev, enum type type)
 		pvt->info.dram_attr = dram_attr;
 		pvt->info.max_sad = ARRAY_SIZE(ibridge_dram_rule);
 		pvt->info.interleave_list = ibridge_interleave_list;
-		pvt->info.max_interleave = ARRAY_SIZE(ibridge_interleave_list);
 		pvt->info.interleave_pkg = ibridge_interleave_pkg;
 		pvt->info.get_width = ibridge_get_width;
 
@@ -3244,7 +3244,6 @@ static int sbridge_register_mci(struct sbridge_dev *sbridge_dev, enum type type)
 		pvt->info.dram_attr = dram_attr;
 		pvt->info.max_sad = ARRAY_SIZE(ibridge_dram_rule);
 		pvt->info.interleave_list = ibridge_interleave_list;
-		pvt->info.max_interleave = ARRAY_SIZE(ibridge_interleave_list);
 		pvt->info.interleave_pkg = ibridge_interleave_pkg;
 		pvt->info.get_width = broadwell_get_width;
 
@@ -3269,7 +3268,6 @@ static int sbridge_register_mci(struct sbridge_dev *sbridge_dev, enum type type)
 		pvt->info.dram_attr = dram_attr_knl;
 		pvt->info.max_sad = ARRAY_SIZE(knl_dram_rule);
 		pvt->info.interleave_list = knl_interleave_list;
-		pvt->info.max_interleave = ARRAY_SIZE(knl_interleave_list);
 		pvt->info.interleave_pkg = ibridge_interleave_pkg;
 		pvt->info.get_width = knl_get_width;
 
-- 
2.7.4
