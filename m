Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1439C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41B42599F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41B42599F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbeFYNhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:37:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:50583 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752124AbeFYNhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:37:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1AFB0AB34;
        Mon, 25 Jun 2018 13:37:06 +0000 (UTC)
Date:   Mon, 25 Jun 2018 15:37:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Namit Gupta <gupta.namit@samsung.com>
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        a.sahrawat@samsung.com, himanshu.m@samsung.com
Subject: Re: [PATCH] printk: remove unnecessary kmalloc() from syslog during
 clear
Message-ID: <20180625133705.7zsg2rkw4xtyg6ie@pathway.suse.cz>
References: <CGME20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2@epcas5p3.samsung.com>
 <20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-06-20 19:26:19, Namit Gupta wrote:
> When the request is only for clearing logs, there is no need for
> allocation/deallocation. Only the indexes need to be reset and returned.
> Rest of the patch is mostly made up of changes because of indention.
> 
> Signed-off-by: Namit Gupta <gupta.namit@samsung.com>
> Signed-off-by: Himanshu Maithani <himanshu.m@samsung.com>

> ---
>  kernel/printk/printk.c | 111 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 60 insertions(+), 51 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 512f7c2..53952ce 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1348,71 +1348,80 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
>  {
>  	char *text;
>  	int len = 0;
> +	u64 next_seq;
> +	u64 seq;
> +	u32 idx;
> +
> +	if (!buf) {
> +		if (clear) {
> +			logbuf_lock_irq();
> +			clear_seq = log_next_seq;
> +			clear_idx = log_next_idx;
> +			logbuf_unlock_irq();

I pushed a bit different version into printk.git, branch for-4.19,
see below. It removes the code duplication. Also it keeps the original
indentation. IMHO, it helped to better distinguish the code for printing
and clearing.

It is rather a cosmetic change, so I do not want you to resend
Reviewed-by tags. But feel free to disagree and ask me to use
the original variant.


This is in printk.git now:

From 41cb6dcedd9257d51fd310bf9b2958d11d93aa2b Mon Sep 17 00:00:00 2001
From: Namit Gupta <gupta.namit@samsung.com>
Date: Mon, 25 Jun 2018 14:58:05 +0200
Subject: [PATCH] printk: remove unnecessary kmalloc() from syslog during

When the request is only for clearing logs, there is no need for
allocation/deallocation. Only the indexes need to be reset and returned.
Rest of the patch is mostly made up of changes because of indention.

Link: http://lkml.kernel.org/r/20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com
Cc: linux-kernel@vger.kernel.org
Cc: pankaj.m@samsung.com
Cc: a.sahrawat@samsung.com
Signed-off-by: Namit Gupta <gupta.namit@samsung.com>
Signed-off-by: Himanshu Maithani <himanshu.m@samsung.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
[pmladek@suse.com: Removed code duplication.]
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 247808333ba4..0fa2ca6fd8f9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1350,12 +1350,14 @@ static int syslog_print(char __user *buf, int size)
 
 static int syslog_print_all(char __user *buf, int size, bool clear)
 {
-	char *text;
+	char *text = NULL;
 	int len = 0;
 
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
-	if (!text)
-		return -ENOMEM;
+	if (buf) {
+		text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
+		if (!text)
+			return -ENOMEM;
+	}
 
 	logbuf_lock_irq();
 	if (buf) {
@@ -1426,7 +1428,8 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	}
 	logbuf_unlock_irq();
 
-	kfree(text);
+	if (text)
+		kfree(text);
 	return len;
 }
 
-- 
2.13.7
