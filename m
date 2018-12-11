Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFFCC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24DD2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543331;
	bh=I56TJmKCf9pokNmWAK6G8URE7cBHXgRUy+OCcuREvLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BZPIbwzU3LcoAf0t5HD1AQxKlYnIFN9U69bfEvJgHBSxrdZ7bG8H+3DoQ/Yc2pdLO
	 HnPpZzVkN3er2E6YhJM7bv5x6gA1n5qZ17W4a35Ako69bP7lpUseobcnioggTJzIfc
	 W7/tFmCAF2Pl6o3yOrIDQoFX1Y19JaQvZnPZC4lo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24DD2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbeLKPsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:48:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbeLKPsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:48:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E9CA20870;
        Tue, 11 Dec 2018 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543326;
        bh=I56TJmKCf9pokNmWAK6G8URE7cBHXgRUy+OCcuREvLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tqih7l913ytniwgUsCIocv+GZO7y13lCnHXNSPdqgrW04Wrp1c5laRVQIypKGCg8r
         18SuWxA3taMsjka5DRMeOF/kWQq+c8lyzRS7xFc3OEtcKapIFq4CheYMd6FMJ5XC2S
         N1l8RYmQJzrtpVgRrIsAvB7xfqUI6BmT4nA9wzCU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Macpaul Lin <macpaul@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 4.4 86/91] kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()
Date:   Tue, 11 Dec 2018 16:41:45 +0100
Message-Id: <20181211151613.844598759@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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


