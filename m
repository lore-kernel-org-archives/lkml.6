Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E61CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1780320872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbfAKQYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:24:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbfAKQYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:24:12 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83A2B20872;
        Fri, 11 Jan 2019 16:24:11 +0000 (UTC)
Date:   Fri, 11 Jan 2019 11:24:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysrq: Restore original console_loglevel when sysrq
 disabled
Message-ID: <20190111112409.6babfa2a@gandalf.local.home>
In-Reply-To: <20190111130729.GA31790@tigerII.localdomain>
References: <20190111124515.11017-1-pmladek@suse.com>
        <20190111130729.GA31790@tigerII.localdomain>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 22:07:29 +0900
Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:

> On (01/11/19 13:45), Petr Mladek wrote:
> > The sysrq header line is printed with an increased loglevel
> > to provide users some positive feedback.
> > 
> > The original loglevel is not restored when the sysrq operation
> > is disabled. This bug was introduced in 2.6.12 (pre-git-history)
> > by the commit ("Allow admin to enable only some of the Magic-Sysrq
> > functions").  
> 
> 
> Good find, and the patch looks OK to me. A small comment below.
> FWIW,
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> 
> ---
> 
> A side note (nitpick, etc.); it's Friday night in here, I'm enjoying
> my beer; so maybe I'm wrong about the whole thing.
> 
> 
> > @@ -553,6 +553,7 @@ void __handle_sysrq(int key, bool check_mask)
> >  			op_p->handler(key);
> >  		} else {
> >  			pr_cont("This sysrq operation is disabled.\n");
> > +			console_loglevel = orig_log_level;
> >  		}  
> 
> This looks a bit racy.
> 
> When we do
> 
> 	printk("FOO\n");
> 	console_loglevel = XYZ;
> 
> We don't have any real guarantees that printk("FOO\n") will print
> anything straight ahead. It is possible that console_sem is already
> locked and the owner is preempted, so by the time the console_sem
> owner picks up that FOO\n messages, console_loglevel is back to
> orig_log_level and suppress_message_printing() will just tell us
> to skip the message.
> 
> Do we need pr_cont() there? Maybe we can just have a normal pr_err()
> which would always tell that "key" sysrq is disabled? (we also
> would need to change the error message a bit).
> 

All this is for another patch and another discussion. This current
patch keeps with what is there and fixes a missing reset of
console_loglevel.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
