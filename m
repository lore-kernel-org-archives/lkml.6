Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeBEWW6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 17:22:58 -0500
Received: from relay2.sgi.com ([192.48.180.65]:56330 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752021AbeBEWWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 17:22:50 -0500
Message-Id: <20180205221503.190219903@stormcage.americas.sgi.com>
References: <20180205221503.032756454@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date: Mon, 05 Feb 2018 16:15:04 -0600
From: <mike.travis@hpe.com>
To: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, Andrew Banman <andrew.banman@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86/platform/UV: Fix GAM Range Table entries less than 1GB
Content-Disposition: inline; filename=fix-gam-range-addr
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest UV platforms include the new ApachePass NVDIMMs into the
UV address space.  This has introduced address ranges in the Global
Address Map Table that are less than the previous lowest range, which
was 2GB.  Fix the address calculation so it accommodates address ranges
from bytes to exabytes.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Andrew Banman <andrew.banman@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- linux-4.4.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux-4.4/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1174,16 +1174,25 @@ static void __init decode_gam_rng_tbl(un
 
 	uv_gre_table = gre;
 	for (; gre->type != UV_GAM_RANGE_TYPE_UNUSED; gre++) {
+		unsigned long size = ((unsigned long)(gre->limit - lgre)
+					<< UV_GAM_RANGE_SHFT);
+		int order = 0;
+		char suffix[] = " KMGTPE";
+
+		while (size > 9999 && order < sizeof(suffix)) {
+			size /= 1024;
+			order++;
+		}
+
 		if (!index) {
 			pr_info("UV: GAM Range Table...\n");
 			pr_info("UV:  # %20s %14s %5s %4s %5s %3s %2s\n", "Range", "", "Size", "Type", "NASID", "SID", "PN");
 		}
-		pr_info("UV: %2d: 0x%014lx-0x%014lx %5luG %3d   %04x  %02x %02x\n",
+		pr_info("UV: %2d: 0x%014lx-0x%014lx %5lu%c %3d   %04x  %02x %02x\n",
 			index++,
 			(unsigned long)lgre << UV_GAM_RANGE_SHFT,
 			(unsigned long)gre->limit << UV_GAM_RANGE_SHFT,
-			((unsigned long)(gre->limit - lgre)) >>
-				(30 - UV_GAM_RANGE_SHFT), /* 64M -> 1G */
+			size, suffix[order],
 			gre->type, gre->nasid, gre->sockid, gre->pnode);
 
 		lgre = gre->limit;

-- 
