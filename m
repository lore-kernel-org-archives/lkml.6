Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3030FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E372B2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E372B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeJHVLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:11:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:51672 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726056AbeJHVLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:11:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB827B000;
        Mon,  8 Oct 2018 13:59:16 +0000 (UTC)
Date:   Mon, 8 Oct 2018 15:59:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     zhe.he@windriver.com
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk: Give error on attempt to set log buffer
 length to over 4G
Message-ID: <20181008135916.gg4kkmoki5bgtco5@pathway.suse.cz>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
 <1538239553-81805-4-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538239553-81805-4-git-send-email-zhe.he@windriver.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2018-09-30 00:45:53, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> Give explicit error for users who want to use larger log buffer.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> Cc: pmladek@suse.com
> Cc: sergey.senozhatsky@gmail.com
> Cc: rostedt@goodmis.org
> ---
>  kernel/printk/printk.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index b84aac0..5ccfd5d 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1039,18 +1039,23 @@ void log_buf_vmcoreinfo_setup(void)
>  static unsigned long __initdata new_log_buf_len;
>  
>  /* we practice scaling the ring buffer by powers of 2 */
> -static void __init log_buf_len_update(unsigned size)
> +static void __init log_buf_len_update(u64 size)
>  {
> +	if (size > UINT_MAX) {
> +		size = UINT_MAX;
> +		pr_err("log_buf over 4G is not supported.\n");

I tried this patch with log_buf_len=5G. The kernel did not crash
but dmesg shown some mess. There are several 32-bit variables
to store the size, for example:

static u32 log_buf_len = __LOG_BUF_LEN;
u32 log_buf_len_get(void)
static u32 log_first_idx;
static u32 log_next_idx;

I guess that the code somewhere does not detect an overflows
correctly.

I am not motivated enought to add support for such huge message
buffer. Therefore I suggest to limit it to 32G for now.

This patch worked for me:


From d63b781b596ccb3d205801b2ba944797fa7ab0ce Mon Sep 17 00:00:00 2001
From: He Zhe <zhe.he@windriver.com>
Date: Sun, 30 Sep 2018 00:45:53 +0800
Subject: [PATCH] printk: Give error on attempt to set log buffer length to
 over 2G

The current printk() is ready to handle log buffer size up to 2G.
Give an explicit error for users who want to use larger log buffer.

Also fix printk formatting to show the 2G as a positive number.

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 15f3e70be448..f595107ddf42 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1040,18 +1040,23 @@ void log_buf_vmcoreinfo_setup(void)
 static unsigned long __initdata new_log_buf_len;
 
 /* we practice scaling the ring buffer by powers of 2 */
-static void __init log_buf_len_update(unsigned size)
+static void __init log_buf_len_update(u64 size)
 {
+	if (size > UINT_MAX) {
+		size = UINT_MAX;
+		pr_err("log_buf over 2G is not supported.\n");
+	}
+
 	if (size)
 		size = roundup_pow_of_two(size);
 	if (size > log_buf_len)
-		new_log_buf_len = size;
+		new_log_buf_len = (unsigned long)size;
 }
 
 /* save requested log_buf_len since it's too early to process it */
 static int __init log_buf_len_setup(char *str)
 {
-	unsigned int size;
+	u64 size;
 
 	if (!str)
 		return -EINVAL;
@@ -1121,7 +1126,7 @@ void __init setup_log_buf(int early)
 	}
 
 	if (unlikely(!new_log_buf)) {
-		pr_err("log_buf_len: %ld bytes not available\n",
+		pr_err("log_buf_len: %lu bytes not available\n",
 			new_log_buf_len);
 		return;
 	}
@@ -1134,8 +1139,8 @@ void __init setup_log_buf(int early)
 	memcpy(log_buf, __log_buf, __LOG_BUF_LEN);
 	logbuf_unlock_irqrestore(flags);
 
-	pr_info("log_buf_len: %d bytes\n", log_buf_len);
-	pr_info("early log buf free: %d(%d%%)\n",
+	pr_info("log_buf_len: %u bytes\n", log_buf_len);
+	pr_info("early log buf free: %u(%u%%)\n",
 		free, (free * 100) / __LOG_BUF_LEN);
 }
 
-- 
2.13.7

