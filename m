Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F2FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042322082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042322082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbeK3BYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:24:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:43560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731046AbeK3BYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:24:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65D2EAFDE;
        Thu, 29 Nov 2018 14:19:22 +0000 (UTC)
Date:   Thu, 29 Nov 2018 15:19:21 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: don't unconditionally shortcut print_time()
Message-ID: <20181129141921.djeumz723fr7pasn@pathway.suse.cz>
References: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-11-24 19:50:13, Tetsuo Handa wrote:
> Since /sys/module/printk/parameters/time can change from N to Y between
> "msg_print_text() called print_prefix() with buf == NULL" and
> "msg_print_text() again calls print_prefix() with buf != NULL", it is not
> safe for print_time() to unconditionally return 0 if printk_time == false.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  kernel/printk/printk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 5c2079d..df7ced0 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1230,7 +1230,7 @@ static size_t print_time(u64 ts, char *buf)
>  {
>  	unsigned long rem_nsec;
>  
> -	if (!printk_time)
> +	if (!printk_time && buf)

This fixes a real problem. It might even avoid a crash.

See syslog_print_all() and kmsg_dump_get_buffer(). They
start with calling msg_print_text() many times to calculate
how many messages fit into the given buffer. Then they
blindly copy the messages into the buffer.

Now, the buffer might overflow if the size is calculated
with printk_time disabled and the messages are copied with
printk_time enabled.


Well, the time stamps are 22% of the printed characters on
my test systems:

$> dmesg | wc -l
524
$> dmesg | wc -c
33013
>$ bc -l
524 * 14 / 33013
.22221549086723411989

It seems worth supporting the disabled printk_time() properly.
I am not sure who is disabling the timestamps. But people might
worry if we waste 22% of the given buffer.

IMHO, passing it as parameter to msg_print_text(), print_prefix(),
and print_time() looks acceptable.

Best Regards,
Petr
