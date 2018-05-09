Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965820AbeEIWVj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 18:21:39 -0400
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:30449 "EHLO
        g2t2354.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965625AbeEIWVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 18:21:37 -0400
From: Toshi Kani <toshi.kani@hpe.com>
To: bp@alien8.de
Cc: mchehab@kernel.org, linux-edac@vger.kernel.org, elliott@hpe.com,
        linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH] ghes_edac: add DDR4 and NVDIMM memory types
Date: Wed,  9 May 2018 16:20:30 -0600
Message-Id: <20180509222030.9299-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ghes_edac driver obtains memory type from SMBIOS type 17,
but it does not recognize DDR4 and NVDIMM types.

Add support of DDR4 and NVDIMM types.  NVDIMM type is set when
memory type is DDR3/4 and non-volatile.

Reported-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/edac/ghes_edac.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 68b6ee18bea6..d0399273018d 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -123,11 +123,21 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 			dimm->mtype = MEM_FB_DDR2;
 			break;
 		case 0x18:
-			if (entry->type_detail & 1 << 13)
+			if (entry->type_detail & 1 << 12)
+				dimm->mtype = MEM_NVDIMM;
+			else if (entry->type_detail & 1 << 13)
 				dimm->mtype = MEM_RDDR3;
 			else
 				dimm->mtype = MEM_DDR3;
 			break;
+		case 0x1a:
+			if (entry->type_detail & 1 << 12)
+				dimm->mtype = MEM_NVDIMM;
+			else if (entry->type_detail & 1 << 13)
+				dimm->mtype = MEM_RDDR4;
+			else
+				dimm->mtype = MEM_DDR4;
+			break;
 		default:
 			if (entry->type_detail & 1 << 6)
 				dimm->mtype = MEM_RMBS;
