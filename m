Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C603C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4F9214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL0SyX/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4F9214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390960AbeKLIjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:39:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404289AbeKLIXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:14 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EB1B21582;
        Sun, 11 Nov 2018 22:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975597;
        bh=H8G5gK7cH5op4yyATg0chvif9sNRjlNJV6HEsDxRLAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OL0SyX/8SXJ0sZcgYb9kKdfHTWOqLYLv5rErgBv/GSqORYKjVBY8oIfRR0QkRkweB
         832f7IsF4SB4dOT0H5LkDUzJONnqeoG4ntgODvr8ZQWW/NbM1Kopd0UdG0AusN3aHw
         KE8211R3CpNIvjNyzpVmLe2iYtUhxSgF4z+Jyg80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, jason.wessel@windriver.com,
        jslaby@suse.com, He Zhe <zhe.he@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 4.14 181/222] kgdboc: Passing ekgdboc to command line causes panic
Date:   Sun, 11 Nov 2018 14:24:38 -0800
Message-Id: <20181111221703.221729367@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: He Zhe <zhe.he@windriver.com>

commit 1bd54d851f50dea6af30c3e6ff4f3e9aab5558f9 upstream.

kgdboc_option_setup does not check input argument before passing it
to strlen. The argument would be a NULL pointer if "ekgdboc", without
its value, is set in command line and thus cause the following panic.

PANIC: early exception 0xe3 IP 10:ffffffff8fbbb620 error 0 cr2 0x0
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18-rc8+ #1
[    0.000000] RIP: 0010:strlen+0x0/0x20
...
[    0.000000] Call Trace
[    0.000000]  ? kgdboc_option_setup+0x9/0xa0
[    0.000000]  ? kgdboc_early_init+0x6/0x1b
[    0.000000]  ? do_early_param+0x4d/0x82
[    0.000000]  ? parse_args+0x212/0x330
[    0.000000]  ? rdinit_setup+0x26/0x26
[    0.000000]  ? parse_early_options+0x20/0x23
[    0.000000]  ? rdinit_setup+0x26/0x26
[    0.000000]  ? parse_early_param+0x2d/0x39
[    0.000000]  ? setup_arch+0x2f7/0xbf4
[    0.000000]  ? start_kernel+0x5e/0x4c2
[    0.000000]  ? load_ucode_bsp+0x113/0x12f
[    0.000000]  ? secondary_startup_64+0xa5/0xb0

This patch adds a check to prevent the panic.

Cc: stable@vger.kernel.org
Cc: jason.wessel@windriver.com
Cc: gregkh@linuxfoundation.org
Cc: jslaby@suse.com
Signed-off-by: He Zhe <zhe.he@windriver.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/kgdboc.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -133,6 +133,11 @@ static void kgdboc_unregister_kbd(void)
 
 static int kgdboc_option_setup(char *opt)
 {
+	if (!opt) {
+		pr_err("kgdboc: config string not provided\n");
+		return -EINVAL;
+	}
+
 	if (strlen(opt) >= MAX_CONFIG_LEN) {
 		printk(KERN_ERR "kgdboc: config string too long\n");
 		return -ENOSPC;


