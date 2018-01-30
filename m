Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeA3Ouj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:50:39 -0500
Received: from terminus.zytor.com ([65.50.211.136]:36547 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbeA3Ouh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:50:37 -0500
Date: Tue, 30 Jan 2018 06:49:19 -0800
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-9471eee9186a46893726e22ebb54cade3f9bc043@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        misono.tomohiro@jp.fujitsu.com, douly.fnst@cn.fujitsu.com,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        douly.fnst@cn.fujitsu.com, misono.tomohiro@jp.fujitsu.com,
        hpa@zytor.com
In-Reply-To: <f5892721-7528-3647-08fb-f8d10e65ad87@cn.fujitsu.com>
References: <f5892721-7528-3647-08fb-f8d10e65ad87@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/spectre: Check CONFIG_RETPOLINE in command line
 parser
Git-Commit-ID: 9471eee9186a46893726e22ebb54cade3f9bc043
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

Commit-ID:  9471eee9186a46893726e22ebb54cade3f9bc043
Gitweb:     https://git.kernel.org/tip/9471eee9186a46893726e22ebb54cade3f9bc043
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Tue, 30 Jan 2018 14:13:50 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 15:30:35 +0100

x86/spectre: Check CONFIG_RETPOLINE in command line parser

The spectre_v2 option 'auto' does not check whether CONFIG_RETPOLINE is
enabled. As a consequence it fails to emit the appropriate warning and sets
feature flags which have no effect at all.

Add the missing IS_ENABLED() check.

Fixes: da285121560e ("x86/spectre: Add boot time option to select Spectre v2 mitigation")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: Tomohiro" <misono.tomohiro@jp.fujitsu.com>
Cc: dave.hansen@intel.com
Cc: bp@alien8.de
Cc: arjan@linux.intel.com
Cc: dwmw@amazon.co.uk
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/f5892721-7528-3647-08fb-f8d10e65ad87@cn.fujitsu.com

---
 arch/x86/kernel/cpu/bugs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3bfb2b2..400c34e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -213,10 +213,10 @@ static void __init spectre_v2_select_mitigation(void)
 		return;
 
 	case SPECTRE_V2_CMD_FORCE:
-		/* FALLTRHU */
 	case SPECTRE_V2_CMD_AUTO:
-		goto retpoline_auto;
-
+		if (IS_ENABLED(CONFIG_RETPOLINE))
+			goto retpoline_auto;
+		break;
 	case SPECTRE_V2_CMD_RETPOLINE_AMD:
 		if (IS_ENABLED(CONFIG_RETPOLINE))
 			goto retpoline_amd;
