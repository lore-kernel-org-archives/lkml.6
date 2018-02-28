Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeB1KwN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:52:13 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39831 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752427AbeB1Kvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:51:45 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37332014"
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>
CC: <indou.takao@jp.fujitsu.com>, <lcapitulino@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v9 4/5] x86/KASLR: Skip memory mirror handling if movable_node specified
Date: Wed, 28 Feb 2018 18:51:04 +0800
Message-ID: <20180228105105.11487-5-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
References: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: 4D149486A796.A7D8D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel code, if 'movable_node' specified, it will skip the mirror
feature. So also skip mirror feature in KASLR.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/boot/compressed/kaslr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 9fb86248d5c5..d19085dbd6f5 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -698,6 +698,7 @@ static bool
 process_efi_entries(unsigned long minimum, unsigned long image_size)
 {
 	struct efi_info *e = &boot_params->efi_info;
+	char *args = (char *)get_cmd_line_ptr();
 	bool efi_mirror_found = false;
 	struct mem_vector region;
 	efi_memory_desc_t *md;
@@ -731,6 +732,12 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 		}
 	}
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+	/* Skip memory mirror if 'movabale_node' specified */
+	if (strstr(args, "movable_node"))
+		efi_mirror_found = false;
+#endif
+
 	for (i = 0; i < nr_desc; i++) {
 		md = efi_early_memdesc_ptr(pmap, e->efi_memdesc_size, i);
 
-- 
2.14.3
