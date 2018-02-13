Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933507AbeBMP2a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:28:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49471 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933425AbeBMP22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:28:28 -0500
Date: Tue, 13 Feb 2018 07:25:00 -0800
From: "tip-bot for mike.travis@hpe.com" <tipbot@zytor.com>
Message-ID: <tip-c25d99d20ba69824a1e2cc118e04b877cd427afc@git.kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, andrew.banman@hpe.com,
        russ.anderson@hpe.com, mike.travis@hpe.com, hpa@zytor.com,
        tglx@linutronix.de, dimitri.sivanich@hpe.com, mingo@kernel.org
Reply-To: torvalds@linux-foundation.org, andrew.banman@hpe.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        hpa@zytor.com, dimitri.sivanich@hpe.com, mingo@kernel.org,
        russ.anderson@hpe.com, mike.travis@hpe.com
In-Reply-To: <20180205221503.190219903@stormcage.americas.sgi.com>
References: <20180205221503.190219903@stormcage.americas.sgi.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/platform/UV: Fix GAM Range Table entries less
 than 1GB
Git-Commit-ID: c25d99d20ba69824a1e2cc118e04b877cd427afc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c25d99d20ba69824a1e2cc118e04b877cd427afc
Gitweb:     https://git.kernel.org/tip/c25d99d20ba69824a1e2cc118e04b877cd427afc
Author:     mike.travis@hpe.com <mike.travis@hpe.com>
AuthorDate: Mon, 5 Feb 2018 16:15:04 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 14:15:45 +0100

x86/platform/UV: Fix GAM Range Table entries less than 1GB

The latest UV platforms include the new ApachePass NVDIMMs into the
UV address space.  This has introduced address ranges in the Global
Address Map Table that are less than the previous lowest range, which
was 2GB.  Fix the address calculation so it accommodates address ranges
from bytes to exabytes.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Andrew Banman <andrew.banman@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180205221503.190219903@stormcage.americas.sgi.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 46b675a..f11910b 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1176,16 +1176,25 @@ static void __init decode_gam_rng_tbl(unsigned long ptr)
 
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
