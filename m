Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358E9C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2687218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfBCNy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:54:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54424 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728758AbfBCNyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:54:20 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIDz-0003tt-Ic; Sun, 03 Feb 2019 13:54:19 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9r-0007Ot-L8; Sun, 03 Feb 2019 14:50:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Macpaul Lin" <macpaul@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Daniel Thompson" <daniel.thompson@linaro.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.486893761@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 270/305] kgdboc: fix KASAN global-out-of-bounds bug
 in param_set_kgdboc_var()
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Macpaul Lin <macpaul@gmail.com>

commit dada6a43b0402eba438a17ac86fdc64ac56a4607 upstream.

This patch is trying to fix KE issue due to
"BUG: KASAN: global-out-of-bounds in param_set_kgdboc_var+0x194/0x198"
reported by Syzkaller scan."

[26364:syz-executor0][name:report8t]BUG: KASAN: global-out-of-bounds in param_set_kgdboc_var+0x194/0x198
[26364:syz-executor0][name:report&]Read of size 1 at addr ffffff900e44f95f by task syz-executor0/26364
[26364:syz-executor0][name:report&]
[26364:syz-executor0]CPU: 7 PID: 26364 Comm: syz-executor0 Tainted: G W 0
[26364:syz-executor0]Call trace:
[26364:syz-executor0][<ffffff9008095cf8>] dump_bacIctrace+Ox0/0x470
[26364:syz-executor0][<ffffff9008096de0>] show_stack+0x20/0x30
[26364:syz-executor0][<ffffff90089cc9c8>] dump_stack+Oxd8/0x128
[26364:syz-executor0][<ffffff90084edb38>] print_address_description +0x80/0x4a8
[26364:syz-executor0][<ffffff90084ee270>] kasan_report+Ox178/0x390
[26364:syz-executor0][<ffffff90084ee4a0>] _asan_report_loadi_noabort+Ox18/0x20
[26364:syz-executor0][<ffffff9008b092ac>] param_set_kgdboc_var+Ox194/0x198
[26364:syz-executor0][<ffffff900813af64>] param_attr_store+Ox14c/0x270
[26364:syz-executor0][<ffffff90081394c8>] module_attr_store+0x60/0x90
[26364:syz-executor0][<ffffff90086690c0>] sysfs_kl_write+Ox100/0x158
[26364:syz-executor0][<ffffff9008666d84>] kernfs_fop_write+0x27c/0x3a8
[26364:syz-executor0][<ffffff9008508264>] do_loop_readv_writev+0x114/0x1b0
[26364:syz-executor0][<ffffff9008509ac8>] do_readv_writev+0x4f8/0x5e0
[26364:syz-executor0][<ffffff9008509ce4>] vfs_writev+0x7c/Oxb8
[26364:syz-executor0][<ffffff900850ba64>] SyS_writev+Oxcc/0x208
[26364:syz-executor0][<ffffff90080883f0>] elO_svc_naked +0x24/0x28
[26364:syz-executor0][name:report&]
[26364:syz-executor0][name:report&]The buggy address belongs to the variable:
[26364:syz-executor0][name:report&] kgdb_tty_line+Ox3f/0x40
[26364:syz-executor0][name:report&]
[26364:syz-executor0][name:report&]Memory state around the buggy address:
[26364:syz-executor0] ffffff900e44f800: 00 00 00 00 00 04 fa fa fa fa fa fa 00 fa fa fa
[26364:syz-executor0] ffffff900e44f880: fa fa fa fa 00 fa fa fa fa fa fa fa 00 fa fa fa
[26364:syz-executor0]> ffffff900e44f900: fa fa fa fa 04 fa fa fa fa fa fa fa 00 00 00 00
[26364:syz-executor0][name:report&]                                       ^
[26364:syz-executor0] ffffff900e44f980: 00 fa fa fa fa fa fa fa 04 fa fa fa fa fa fa fa
[26364:syz-executor0] ffffff900e44fa00: 04 fa fa fa fa fa fa fa 00 fa fa fa fa fa fa fa
[26364:syz-executor0][name:report&]
[26364:syz-executor0][name:panic&]Disabling lock debugging due to kernel taint
[26364:syz-executor0]------------[cut here]------------

After checking the source code, we've found there might be an out-of-bounds
access to "config[len - 1]" array when the variable "len" is zero.

Signed-off-by: Macpaul Lin <macpaul@gmail.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/serial/kgdboc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -252,7 +252,7 @@ static void kgdboc_put_char(u8 chr)
 
 static int param_set_kgdboc_var(const char *kmessage, struct kernel_param *kp)
 {
-	int len = strlen(kmessage);
+	size_t len = strlen(kmessage);
 
 	if (len >= MAX_CONFIG_LEN) {
 		printk(KERN_ERR "kgdboc: config string too long\n");
@@ -274,7 +274,7 @@ static int param_set_kgdboc_var(const ch
 
 	strcpy(config, kmessage);
 	/* Chop out \n char as a result of echo */
-	if (config[len - 1] == '\n')
+	if (len && config[len - 1] == '\n')
 		config[len - 1] = '\0';
 
 	if (configured == 1)

