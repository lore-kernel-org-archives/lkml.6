Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058F8C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DCA2082C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbfBCO1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:27:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55514 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730073AbfBCOUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:42 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdV-0006LQ-0Z; Sun, 03 Feb 2019 14:20:41 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0006sO-0q; Sun, 03 Feb 2019 14:49:42 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        "He Zhe" <zhe.he@windriver.com>, "Petr Mladek" <pmladek@suse.com>,
        rostedt@goodmis.org
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.262117185@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 065/305] printk: Fix panic caused by passing
 log_buf_len to command line
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

From: He Zhe <zhe.he@windriver.com>

commit 277fcdb2cfee38ccdbe07e705dbd4896ba0c9930 upstream.

log_buf_len_setup does not check input argument before passing it to
simple_strtoull. The argument would be a NULL pointer if "log_buf_len",
without its value, is set in command line and thus causes the following
panic.

PANIC: early exception 0xe3 IP 10:ffffffffaaeacd0d error 0 cr2 0x0
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc4-yocto-standard+ #1
[    0.000000] RIP: 0010:_parse_integer_fixup_radix+0xd/0x70
...
[    0.000000] Call Trace:
[    0.000000]  simple_strtoull+0x29/0x70
[    0.000000]  memparse+0x26/0x90
[    0.000000]  log_buf_len_setup+0x17/0x22
[    0.000000]  do_early_param+0x57/0x8e
[    0.000000]  parse_args+0x208/0x320
[    0.000000]  ? rdinit_setup+0x30/0x30
[    0.000000]  parse_early_options+0x29/0x2d
[    0.000000]  ? rdinit_setup+0x30/0x30
[    0.000000]  parse_early_param+0x36/0x4d
[    0.000000]  setup_arch+0x336/0x99e
[    0.000000]  start_kernel+0x6f/0x4ee
[    0.000000]  x86_64_start_reservations+0x24/0x26
[    0.000000]  x86_64_start_kernel+0x6f/0x72
[    0.000000]  secondary_startup_64+0xa4/0xb0

This patch adds a check to prevent the panic.

Link: http://lkml.kernel.org/r/1538239553-81805-1-git-send-email-zhe.he@windriver.com
Cc: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: He Zhe <zhe.he@windriver.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/printk/printk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -837,7 +837,12 @@ static unsigned long __initdata new_log_
 /* save requested log_buf_len since it's too early to process it */
 static int __init log_buf_len_setup(char *str)
 {
-	unsigned size = memparse(str, &str);
+	unsigned int size;
+
+	if (!str)
+		return -EINVAL;
+
+	size = memparse(str, &str);
 
 	if (size)
 		size = roundup_pow_of_two(size);

