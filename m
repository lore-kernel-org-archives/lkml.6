Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17478C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B808D25B90
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B808D25B90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934579AbeFYOhI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934318AbeFYOhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:37:07 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06F5125B8E;
        Mon, 25 Jun 2018 14:37:05 +0000 (UTC)
Date:   Mon, 25 Jun 2018 10:37:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Namit Gupta <gupta.namit@samsung.com>,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        pankaj.m@samsung.com, a.sahrawat@samsung.com,
        himanshu.m@samsung.com
Subject: Re: [PATCH] printk: remove unnecessary kmalloc() from syslog during
 clear
Message-ID: <20180625103704.49811ec1@gandalf.local.home>
In-Reply-To: <20180625133705.7zsg2rkw4xtyg6ie@pathway.suse.cz>
References: <CGME20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2@epcas5p3.samsung.com>
        <20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com>
        <20180625133705.7zsg2rkw4xtyg6ie@pathway.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 15:37:05 +0200
Petr Mladek <pmladek@suse.com> wrote:

> On Wed 2018-06-20 19:26:19, Namit Gupta wrote:
> > When the request is only for clearing logs, there is no need for
> > allocation/deallocation. Only the indexes need to be reset and returned.
> > Rest of the patch is mostly made up of changes because of indention.
> > 
> > Signed-off-by: Namit Gupta <gupta.namit@samsung.com>
> > Signed-off-by: Himanshu Maithani <himanshu.m@samsung.com>  
> 
> > ---
> >  kernel/printk/printk.c | 111 ++++++++++++++++++++++++++-----------------------
> >  1 file changed, 60 insertions(+), 51 deletions(-)
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 512f7c2..53952ce 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -1348,71 +1348,80 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
> >  {
> >  	char *text;
> >  	int len = 0;
> > +	u64 next_seq;
> > +	u64 seq;
> > +	u32 idx;
> > +
> > +	if (!buf) {
> > +		if (clear) {
> > +			logbuf_lock_irq();
> > +			clear_seq = log_next_seq;
> > +			clear_idx = log_next_idx;
> > +			logbuf_unlock_irq();  
> 
> I pushed a bit different version into printk.git, branch for-4.19,
> see below. It removes the code duplication. Also it keeps the original
> indentation. IMHO, it helped to better distinguish the code for printing
> and clearing.
> 
> It is rather a cosmetic change, so I do not want you to resend
> Reviewed-by tags. But feel free to disagree and ask me to use
> the original variant.
> 

I actually prefer the original version. It's not really duplicating
much text, and it's cleaner, because it lets you know exactly what is
happening when buf == NULL.

	if (buf)
		text = kmalloc();

	logbuf_lock_irq();

	if (buf) {
		[...]
	}

Is IMHO rather ugly.

And the original patch has one more advantage. If buf and clear are
both NULL/zero, we don't take any locks.

-- Steve


