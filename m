Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753353AbeBSPsB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:48:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753322AbeBSPrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:47:37 -0500
From: Farhan Ali <alifm@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com, tomi.valkeinen@ti.com,
        thuth@redhat.com, b.zolnierkie@samsung.com, alifm@linux.vnet.ibm.com
Subject: [PATCH v3 2/3] s390/char : Rename EBCDIC keymap variables
Date: Mon, 19 Feb 2018 10:47:26 -0500
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18021915-0020-0000-0000-00000D7A00BF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008560; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992052; UDB=6.00503963; IPR=6.00771398;
 MB=3.00019637; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-19 15:47:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021915-0021-0000-0000-0000602F9B64
Message-Id: <4e0d31cf01c9fff5fe177338f14b1ca3f6871fb5.1519053920.git.alifm@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802190195
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Virtual Terminal (VT) layer provides a default keymap
which is compiled when VT layer is enabled. But at the same time
we are also compiling the EBCDIC keymap and this causes the linker
to complain.

So let's rename the EBCDIC keymap variables to prevent linker
conflict.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/char/defkeymap.c | 66 ++++++++++++++++++++++---------------------
 drivers/s390/char/keyboard.c  | 32 ++++++++++-----------
 drivers/s390/char/keyboard.h  | 11 ++++++++
 3 files changed, 61 insertions(+), 48 deletions(-)

diff --git a/drivers/s390/char/defkeymap.c b/drivers/s390/char/defkeymap.c
index 98a5c45..193142c 100644
--- a/drivers/s390/char/defkeymap.c
+++ b/drivers/s390/char/defkeymap.c
@@ -9,7 +9,9 @@
 #include <linux/kbd_kern.h>
 #include <linux/kbd_diacr.h>
 
-u_short plain_map[NR_KEYS] = {
+#include "keyboard.h"
+
+u_short ebc_plain_map[NR_KEYS] = {
 	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,
 	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,
 	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,	0xf000,
@@ -85,12 +87,12 @@ static u_short shift_ctrl_map[NR_KEYS] = {
 	0xf20a,	0xf108,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-ushort *key_maps[MAX_NR_KEYMAPS] = {
-	plain_map, shift_map, NULL, NULL,
+ushort *ebc_key_maps[MAX_NR_KEYMAPS] = {
+	ebc_plain_map, shift_map, NULL, NULL,
 	ctrl_map, shift_ctrl_map, NULL,
 };
 
-unsigned int keymap_count = 4;
+unsigned int ebc_keymap_count = 4;
 
 
 /*
@@ -99,7 +101,7 @@ unsigned int keymap_count = 4;
  * the default and allocate dynamically in chunks of 512 bytes.
  */
 
-char func_buf[] = {
+char ebc_func_buf[] = {
 	'\033', '[', '[', 'A', 0, 
 	'\033', '[', '[', 'B', 0, 
 	'\033', '[', '[', 'C', 0, 
@@ -123,37 +125,37 @@ char func_buf[] = {
 };
 
 
-char *funcbufptr = func_buf;
-int funcbufsize = sizeof(func_buf);
-int funcbufleft = 0;          /* space left */
-
-char *func_table[MAX_NR_FUNC] = {
-	func_buf + 0,
-	func_buf + 5,
-	func_buf + 10,
-	func_buf + 15,
-	func_buf + 20,
-	func_buf + 25,
-	func_buf + 31,
-	func_buf + 37,
-	func_buf + 43,
-	func_buf + 49,
-	func_buf + 55,
-	func_buf + 61,
-	func_buf + 67,
-	func_buf + 73,
-	func_buf + 79,
-	func_buf + 85,
-	func_buf + 91,
-	func_buf + 97,
-	func_buf + 103,
-	func_buf + 109,
+char *ebc_funcbufptr = ebc_func_buf;
+int ebc_funcbufsize = sizeof(ebc_func_buf);
+int ebc_funcbufleft = 0;          /* space left */
+
+char *ebc_func_table[MAX_NR_FUNC] = {
+	ebc_func_buf + 0,
+	ebc_func_buf + 5,
+	ebc_func_buf + 10,
+	ebc_func_buf + 15,
+	ebc_func_buf + 20,
+	ebc_func_buf + 25,
+	ebc_func_buf + 31,
+	ebc_func_buf + 37,
+	ebc_func_buf + 43,
+	ebc_func_buf + 49,
+	ebc_func_buf + 55,
+	ebc_func_buf + 61,
+	ebc_func_buf + 67,
+	ebc_func_buf + 73,
+	ebc_func_buf + 79,
+	ebc_func_buf + 85,
+	ebc_func_buf + 91,
+	ebc_func_buf + 97,
+	ebc_func_buf + 103,
+	ebc_func_buf + 109,
 	NULL,
 };
 
-struct kbdiacruc accent_table[MAX_DIACR] = {
+struct kbdiacruc ebc_accent_table[MAX_DIACR] = {
 	{'^', 'c', 0003},	{'^', 'd', 0004},
 	{'^', 'z', 0032},	{'^', 0012, 0000},
 };
 
-unsigned int accent_table_size = 4;
+unsigned int ebc_accent_table_size = 4;
diff --git a/drivers/s390/char/keyboard.c b/drivers/s390/char/keyboard.c
index 5b505fd..db1fbf9 100644
--- a/drivers/s390/char/keyboard.c
+++ b/drivers/s390/char/keyboard.c
@@ -54,24 +54,24 @@ kbd_alloc(void) {
 	kbd = kzalloc(sizeof(struct kbd_data), GFP_KERNEL);
 	if (!kbd)
 		goto out;
-	kbd->key_maps = kzalloc(sizeof(key_maps), GFP_KERNEL);
+	kbd->key_maps = kzalloc(sizeof(ebc_key_maps), GFP_KERNEL);
 	if (!kbd->key_maps)
 		goto out_kbd;
-	for (i = 0; i < ARRAY_SIZE(key_maps); i++) {
-		if (key_maps[i]) {
-			kbd->key_maps[i] = kmemdup(key_maps[i],
+	for (i = 0; i < ARRAY_SIZE(ebc_key_maps); i++) {
+		if (ebc_key_maps[i]) {
+			kbd->key_maps[i] = kmemdup(ebc_key_maps[i],
 						   sizeof(u_short) * NR_KEYS,
 						   GFP_KERNEL);
 			if (!kbd->key_maps[i])
 				goto out_maps;
 		}
 	}
-	kbd->func_table = kzalloc(sizeof(func_table), GFP_KERNEL);
+	kbd->func_table = kzalloc(sizeof(ebc_func_table), GFP_KERNEL);
 	if (!kbd->func_table)
 		goto out_maps;
-	for (i = 0; i < ARRAY_SIZE(func_table); i++) {
-		if (func_table[i]) {
-			kbd->func_table[i] = kstrdup(func_table[i],
+	for (i = 0; i < ARRAY_SIZE(ebc_func_table); i++) {
+		if (ebc_func_table[i]) {
+			kbd->func_table[i] = kstrdup(ebc_func_table[i],
 						     GFP_KERNEL);
 			if (!kbd->func_table[i])
 				goto out_func;
@@ -81,22 +81,22 @@ kbd_alloc(void) {
 		kzalloc(sizeof(fn_handler_fn *) * NR_FN_HANDLER, GFP_KERNEL);
 	if (!kbd->fn_handler)
 		goto out_func;
-	kbd->accent_table = kmemdup(accent_table,
+	kbd->accent_table = kmemdup(ebc_accent_table,
 				    sizeof(struct kbdiacruc) * MAX_DIACR,
 				    GFP_KERNEL);
 	if (!kbd->accent_table)
 		goto out_fn_handler;
-	kbd->accent_table_size = accent_table_size;
+	kbd->accent_table_size = ebc_accent_table_size;
 	return kbd;
 
 out_fn_handler:
 	kfree(kbd->fn_handler);
 out_func:
-	for (i = 0; i < ARRAY_SIZE(func_table); i++)
+	for (i = 0; i < ARRAY_SIZE(ebc_func_table); i++)
 		kfree(kbd->func_table[i]);
 	kfree(kbd->func_table);
 out_maps:
-	for (i = 0; i < ARRAY_SIZE(key_maps); i++)
+	for (i = 0; i < ARRAY_SIZE(ebc_key_maps); i++)
 		kfree(kbd->key_maps[i]);
 	kfree(kbd->key_maps);
 out_kbd:
@@ -112,10 +112,10 @@ kbd_free(struct kbd_data *kbd)
 
 	kfree(kbd->accent_table);
 	kfree(kbd->fn_handler);
-	for (i = 0; i < ARRAY_SIZE(func_table); i++)
+	for (i = 0; i < ARRAY_SIZE(ebc_func_table); i++)
 		kfree(kbd->func_table[i]);
 	kfree(kbd->func_table);
-	for (i = 0; i < ARRAY_SIZE(key_maps); i++)
+	for (i = 0; i < ARRAY_SIZE(ebc_key_maps); i++)
 		kfree(kbd->key_maps[i]);
 	kfree(kbd->key_maps);
 	kfree(kbd);
@@ -131,7 +131,7 @@ kbd_ascebc(struct kbd_data *kbd, unsigned char *ascebc)
 	int i, j, k;
 
 	memset(ascebc, 0x40, 256);
-	for (i = 0; i < ARRAY_SIZE(key_maps); i++) {
+	for (i = 0; i < ARRAY_SIZE(ebc_key_maps); i++) {
 		keymap = kbd->key_maps[i];
 		if (!keymap)
 			continue;
@@ -158,7 +158,7 @@ kbd_ebcasc(struct kbd_data *kbd, unsigned char *ebcasc)
 	int i, j, k;
 
 	memset(ebcasc, ' ', 256);
-	for (i = 0; i < ARRAY_SIZE(key_maps); i++) {
+	for (i = 0; i < ARRAY_SIZE(ebc_key_maps); i++) {
 		keymap = kbd->key_maps[i];
 		if (!keymap)
 			continue;
diff --git a/drivers/s390/char/keyboard.h b/drivers/s390/char/keyboard.h
index a074d97..c467589 100644
--- a/drivers/s390/char/keyboard.h
+++ b/drivers/s390/char/keyboard.h
@@ -14,6 +14,17 @@
 
 struct kbd_data;
 
+extern int ebc_funcbufsize, ebc_funcbufleft;
+extern char *ebc_func_table[MAX_NR_FUNC];
+extern char ebc_func_buf[];
+extern char *ebc_funcbufptr;
+extern unsigned int ebc_keymap_count;
+
+extern struct kbdiacruc ebc_accent_table[];
+extern unsigned int ebc_accent_table_size;
+extern unsigned short *ebc_key_maps[MAX_NR_KEYMAPS];
+extern unsigned short ebc_plain_map[NR_KEYS];
+
 typedef void (fn_handler_fn)(struct kbd_data *);
 
 /*
-- 
2.7.4
