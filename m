Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A7CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07E620825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07E620825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeKIXvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:51:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:50286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727941AbeKIXvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:51:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7BDE0AF80;
        Fri,  9 Nov 2018 14:10:14 +0000 (UTC)
Date:   Fri, 9 Nov 2018 15:10:12 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 1/3] printk: Add line-buffered printk() API.
Message-ID: <20181109141012.accx62deekzq5gh5@pathway.suse.cz>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181106143502.GA32748@tigerII.localdomain>
 <20181107102154.pobr7yrl5il76be6@pathway.suse.cz>
 <20181108022138.GA2343@jagdpanzerIV>
 <20181108112443.huqkju4uwrenvtnu@pathway.suse.cz>
 <20181108123049.GA30440@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108123049.GA30440@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-11-08 21:30:49, Sergey Senozhatsky wrote:
> On (11/08/18 12:24), Petr Mladek wrote:
> > > - It seems that buffered printk attempts to solve too many problems.
> > >   I'd prefer it to address just one.
> > 
> > This API tries to handle continuous lines more reliably.
> > Do I miss anything, please?
> 
> This part:
> 
> +       /* Flush already completed lines if any. */
> +       for (pos = ptr->len - 1; pos >= 0; pos--) {
> +               if (ptr->buf[pos] != '\n')
> +                       continue;
> +               ptr->buf[pos++] = '\0';
> +               printk("%s\n", ptr->buf);
> +               ptr->len -= pos;
> +               memmove(ptr->buf, ptr->buf + pos, ptr->len);
> +               /* This '\0' will be overwritten by next vsnprintf() above. */
> +               ptr->buf[ptr->len] = '\0';
> +               break;
> +       }
> +       return r;
> 
> If I'm not mistaken, this is for the futute "printk injection" work.

No, it does not make sense to distinguish the context at this level.
The buffer is passed as an argument. It should not get passed to another
task or context.

The above code only tries to push complete lines to the main log buffer
and consoles ASAP. It sounds like a Good Idea(tm).


> Right now printk("foo\nbar\n") will end up to be a single logbuf
> entry, with \n in the middle and at the end. So it will look like
> two lines on the serial console:
> 
> 	[123.123] foo
> 	          bar
> 
> Tetsuo does this \n lookup (on every vprintk_buffered) and split lines
> (via memove) for "printk injection", so the output will be
> 
> 	[123.123] foo
> 	[123.124] bar

No, please note that the for cycle searches for '\n' from the end
of the string.

> Which makes it simpler to "inject" printk origin into every printed
> line.
> 
> Without it we can just do
> 
> 	len = vsprintf();
> 	if (len && text[len - 1] == '\n' || overflow)
> 		flush();

I had the same idea. Tetsuo ignored it. I looked for more arguments
and found that '\n' is used in the middle of several pr_cont()
calls, see

     git grep 'pr_cont.*\\n.*[^\\n]"'

Best Regards,
Petr
