Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933029AbeCMNpA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:45:00 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.101]:41669 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932572AbeCMNo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:44:57 -0400
Date: Tue, 13 Mar 2018 08:44:49 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v3] EDAC, sb_edac: Remove VLA usage
Message-ID: <20180313134449.GA24398@embeddedgus>
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
X-Exim-ID: 1evkEa-004Hap-0m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:54502
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove VLA and replace it
with a fixed-length array instead.

Fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Reviewed-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v3:
 - Update macro MAX_INTERLEAVE in order to avoid too long lines.
   This change is based on Mauro's feedback.
 - Update changelog with Mauro's Reviewed-by.

Changes in v2:
 - Use macro max_t to compute the max of all three array sizes.
   This change is based on Borislav's feedback.

 drivers/edac/sb_edac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 8721002..aff4778 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -110,6 +110,11 @@ static const u32 knl_interleave_list[] = {
 	0xdc, 0xe4, 0xec, 0xf4, 0xfc, /* 15-19 */
 	0x104, 0x10c, 0x114, 0x11c,   /* 20-23 */
 };
+#define MAX_INTERLEAVE							\
+	(max_t(unsigned int, ARRAY_SIZE(sbridge_interleave_list),	\
+	       max_t(unsigned int, ARRAY_SIZE(ibridge_interleave_list),	\
+		     ARRAY_SIZE(knl_interleave_list))))
+
 
 struct interleave_pkg {
 	unsigned char start;
@@ -1899,7 +1904,7 @@ static int get_memory_error_data(struct mem_ctl_info *mci,
 	int			n_rir, n_sads, n_tads, sad_way, sck_xch;
 	int			sad_interl, idx, base_ch;
 	int			interleave_mode, shiftup = 0;
-	unsigned		sad_interleave[pvt->info.max_interleave];
+	unsigned int		sad_interleave[MAX_INTERLEAVE];
 	u32			reg, dram_rule;
 	u8			ch_way, sck_way, pkg, sad_ha = 0;
 	u32			tad_offset;
-- 
2.7.4
