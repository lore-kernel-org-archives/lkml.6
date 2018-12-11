Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FDFC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73172146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543613;
	bh=8ZVk39zR6CnThZhzBQRTlVHLqfWoYgzzT8KcmAaY2tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sRUpKirIo24N/pMgo0ZULQtDX6AhbfKCXdudR70y0RfkKMcgLEPwog7DyriMoD+Zo
	 f0SZAYCZo1ulQQLnC9I/qkkbmHoA9svVnGzq/Z1X4g2aH1P2LqvMriylxegm8gvccp
	 ZiTo/SWgL/c4yo5ZJ6VlA7V2OiznmE8gnmIpzGuQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73172146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbeLKPxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:53:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729911AbeLKPxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:53:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EB4D2146E;
        Tue, 11 Dec 2018 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543604;
        bh=8ZVk39zR6CnThZhzBQRTlVHLqfWoYgzzT8KcmAaY2tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ta7PTy72u18SNKnhnNtq2JNKPsk6gH5s5IzN70AebEjI/KgJYDMjYCFLrrDTzXs/H
         QiWRMt3l9T887voDSubDmDnmy49AQ4IAxCP/tdo5YujGdh6soXVpr4QTjsuasRhyZA
         0Zp+TigcKpSu9Pok4y/qCuppOeOZ0vkB2ua95+wo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Macpaul Lin <macpaul@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 4.14 61/67] kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()
Date:   Tue, 11 Dec 2018 16:42:01 +0100
Message-Id: <20181211151633.514591974@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/kgdboc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -232,7 +232,7 @@ static void kgdboc_put_char(u8 chr)
 
 static int param_set_kgdboc_var(const char *kmessage, struct kernel_param *kp)
 {
-	int len = strlen(kmessage);
+	size_t len = strlen(kmessage);
 
 	if (len >= MAX_CONFIG_LEN) {
 		printk(KERN_ERR "kgdboc: config string too long\n");
@@ -254,7 +254,7 @@ static int param_set_kgdboc_var(const ch
 
 	strcpy(config, kmessage);
 	/* Chop out \n char as a result of echo */
-	if (config[len - 1] == '\n')
+	if (len && config[len - 1] == '\n')
 		config[len - 1] = '\0';
 
 	if (configured == 1)


