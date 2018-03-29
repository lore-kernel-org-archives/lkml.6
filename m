Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeC2Lcp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:32:45 -0400
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:52107 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752975AbeC2Lco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:32:44 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,,:::::,RULES_HIT:41:355:379:541:800:960:965:966:973:988:989:1260:1345:1359:1437:1534:1541:1711:1730:1747:1777:1792:1978:1981:2194:2196:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3352:3865:3866:3867:3868:3870:3871:3872:3874:4321:4385:4390:4395:4605:5007:6261:10004:10848:11026:11473:11658:11914:12555:12895:13069:13149:13161:13229:13230:13311:13357:14096:14181:14384:14394:14721:21080:21433:21451:21627:30012:30054,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: knee35_17a473fa33b56
X-Filterd-Recvd-Size: 1831
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH v5 01/16] initrd: Add weakly-linked generic free_initrd_mem.
Date: Thu, 29 Mar 2018 07:31:52 -0400
Message-Id: <20180329113207.30674-1-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328203659.18692-1-shea@shealevy.com>
References: <20180328203659.18692-1-shea@shealevy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is effectively identical across 14 architectures, and
the generic implementation is small enough to be negligible in the
architectures that do override it. Many of the remaining divergent
implementations can be included in the common code path in future,
further reducing code duplication and sharing improvements between
architectures.

v5: Add more complete commit messages.
v4: Use weak symbols instead of Kconfig.
v3: Make the generic path opt-out instead of opt-in.
v2: Mark generic free_initrd_mem __init.

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 init/initramfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/init/initramfs.c b/init/initramfs.c
index 7e99a0038942..c8fe150f958a 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -526,6 +526,11 @@ extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+void __init __weak free_initrd_mem(unsigned long start, unsigned long end)
+{
+       free_reserved_area((void *)start, (void *)end, -1, "initrd");
+}
+
 static void __init free_initrd(void)
 {
 #ifdef CONFIG_KEXEC_CORE
-- 
2.16.2
