Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A86C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCB421848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbfAKPc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:32:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:32836 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730193AbfAKPc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:32:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54B3CAFAD;
        Fri, 11 Jan 2019 15:32:57 +0000 (UTC)
Date:   Fri, 11 Jan 2019 16:32:56 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysrq: Restore original console_loglevel when sysrq
 disabled
Message-ID: <20190111153256.emsne4s37g2dgt4g@pathway.suse.cz>
References: <20190111124515.11017-1-pmladek@suse.com>
 <20190111130729.GA31790@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111130729.GA31790@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-01-11 22:07:29, Sergey Senozhatsky wrote:
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

Thanks.

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

The same problem is with the sysrq header line. It uses the trick
with console_loglevel by intention. We want to show it but
it is not really an error message, see the commit
fb144adc517d9ebe8fd ("sysrq: add commentary on why we use
the console loglevel over using KERN_EMERG").

Best Regards,
Petr

PS: I am going to resend this patch as part of a patchset.
I was working on one more fix. It looked independent
and questionable. I wanted to send it as RFC separately
but there is a clash in the end...
