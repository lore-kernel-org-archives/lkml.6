Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeB1Kvq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:51:46 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39831 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752542AbeB1Kvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:51:44 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37332013"
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>
CC: <indou.takao@jp.fujitsu.com>, <lcapitulino@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v9 3/5] x86/KASLR: Give a warning if movable_node specified without kaslr_boot_mem=
Date: Wed, 28 Feb 2018 18:51:03 +0800
Message-ID: <20180228105105.11487-4-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
References: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: 51C0A486A78A.A8FBC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since only 'movable_node' specified without 'kaslr_boot_mem=' may
break memory hotplug, so reconmmend users using 'kaslr_boot_mem='
when 'movable_node' specified.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/boot/compressed/kaslr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index eb47502fbe54..9fb86248d5c5 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -288,6 +288,16 @@ static int handle_mem_filter(void)
 	    !strstr(args, "kaslr_boot_mem="))
 		return 0;
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+	/*
+	 * Check if 'kaslr_boot_mem=' specified when 'movable_node' found.
+	 * If not, just give a warrning. Otherwise memory hotplug could be
+	 * affected if kernel is put on movable memory regions.
+	 */
+	if (strstr(args, "movable_node") && !strstr(args, "kaslr_boot_mem="))
+		warn("'kaslr_boot_mem=' should be specified when using 'movable_node'.\n");
+#endif
+
 	tmp_cmdline = malloc(len + 1);
 	if (!tmp_cmdline)
 		error("Failed to allocate space for tmp_cmdline");
-- 
2.14.3
