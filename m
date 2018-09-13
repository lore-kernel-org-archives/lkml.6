Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2048BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C412520881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C412520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIMRfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:35:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:54658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726919AbeIMRfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:35:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64F45B03A;
        Thu, 13 Sep 2018 12:26:27 +0000 (UTC)
Date:   Thu, 13 Sep 2018 14:26:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
References: <20180620090413.GA444@jagdpanzerIV>
 <20180620091541.GB444@jagdpanzerIV>
 <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
 <20180620110759.GD444@jagdpanzerIV>
 <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
 <20180620130628.GA1000@tigerII.localdomain>
 <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
 <20180912065307.GA606@jagdpanzerIV>
 <20180912120548.4280f04a@vmware.local.home>
 <20180913071204.GA604@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913071204.GA604@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-09-13 16:12:54, Sergey Senozhatsky wrote:
> On (09/12/18 12:05), Steven Rostedt wrote:
> > > : Introduce a few helper functions for it:
> > > : 
> > > :  init_line_buffer(&buf);
> > > :  print_line(&buf, fmt, args);
> > > :  vprint_line(&buf, fmt, vararg);
> > > :  finish_line(&buf);
> > > : 
> > 
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -324,3 +324,49 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, int cnt)
>  	s->readpos += cnt;
>  	return cnt;
>  }
> +
> +int vpr_line(struct pr_line *pl, const char *fmt, va_list args)
> +{
> +	struct seq_buf *s = &pl->sb;
> +	int ret, len;
> +
> +	if (fmt[0] == '\n') {
> +		pr_line_flush(pl);
> +		return 0;
> +	}

You would need to check if fmt[1] == '\0'. But then you would need
to be careful about a possible buffer overflow. I would personally
avoid this optimization.


> +	ret = seq_buf_vprintf(s, fmt, args);
> +
> +	len = seq_buf_used(s);
> +	if (len && s->buffer[len - 1] == '\n')
> +		pr_line_flush(pl);

This would cause that pr_line_flush() won't be strictly needed.
Also it would encourage people to use this feature a more
complicated way (for more lines). Do we really want this?


In general, I like this approach more than any attemps to handle
continuous lines transpatently. The other attemps were much more
complicated or were not reliable.

Best Regards,
Petr
