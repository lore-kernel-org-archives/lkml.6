Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57727C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCBC2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfANO7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:59:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:34584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbfANO7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:59:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0E07ACBD;
        Mon, 14 Jan 2019 14:59:45 +0000 (UTC)
Date:   Mon, 14 Jan 2019 15:59:44 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/3] sysrq: Warn about insufficient console_loglevel
Message-ID: <20190114145944.5fhu6zfcjie5nmx6@pathway.suse.cz>
References: <20190111162038.19771-1-pmladek@suse.com>
 <20190111162038.19771-4-pmladek@suse.com>
 <20190114080522.GA433@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114080522.GA433@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-01-14 17:05:22, Sergey Senozhatsky wrote:
> On (01/11/19 17:20), Petr Mladek wrote:
> > +static void warn_console(bool console_suppressed,
> > +			 int orig_log_level,
> > +			 struct sysrq_key_op *op_p)
> > +{
> > +	static int warned;
> > +
> > +	if (warned)
> > +		return;
> > +
> > +	/* Do not warn when people are already setting loglevel via sysrq */
> > +	if (op_p->enable_mask & SYSRQ_ENABLE_LOG) {
> > +		warned = 1;
> > +		return;
> > +	}
> > +
> > +	if (console_suppressed) {
> > +		pr_info("Messages filtered by console_loglevel (%d)%s\n",
> > +			orig_log_level,
> > +			sysrq_on_mask(SYSRQ_ENABLE_LOG) ? ", try SysRq+7" : "");
> > +		warned = 1;
> > +	}
> > +}
> 
> I understand the intent.
> 
> Some comments:
> 
> - Not all of sysrq handlers printk() data. There are some quiet
>   handlers. E.g. sysrq_handle_unraw(). Having "Messages filtered by
>   console_loglevel" can be confusing.
> 
> - Not all sysrq handlers use INFO level.
>   E.g. sync_inodes_sb()->WARN_ON()->pr_warn(). So once again there can
>   be a "false positive" "Messages filtered" error, while in fact
>   no messages would be filtered out.
> 
> What do you think?

Yes, it has false positives. On the other hand, I do not think
that a better message is worth even more complicated code.

Either we find a better text, for example, use warning style:

    pr_warn("warning: messages are filtered by console loglevel (%d)%s\n"

or hint style:

    pr_info("hint: make sure to see all messages by increasing the
    console logvel, ...

or ???

Otherwise, I would just throw away this idea.

Best Regards,
Petr
