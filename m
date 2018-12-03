Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C98C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B8720851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B8720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeLCPGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:06:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:37110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbeLCPGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:06:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3119CAD47;
        Mon,  3 Dec 2018 15:06:04 +0000 (UTC)
Date:   Mon, 3 Dec 2018 16:06:03 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181203150603.cdqii263e4kmmibo@pathway.suse.cz>
References: <1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
 <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-12-01 23:44:37, Tetsuo Handa wrote:
> On 2018/12/01 0:40, Petr Mladek wrote:
> >> Some examples for console output:
> >>
> >>   [    0.293000] [T1] smpboot: CPU0: Intel(R) Core(TM) i5-4440S CPU @ 2.80GHz (family: 0x6, model: 0x3c, stepping: 0x3)
> >>   [    0.299733] [T1] Performance Events: Haswell events, core PMU driver.
> >>   [    2.813808] [T35] clocksource: Switched to clocksource tsc
> >>   [    2.893984] [C0] random: fast init done
> >                   ^
> > 
> > Please, remove the space between the timestamp and the from field.
> 
> This space was emitted by print_time(). Do we want to modify print_time()
> not to emit this space if the from field is printed?

Exactly. This is what I thought about.
 
> If we modify print_time(), I think that the leading spaces inserted by "%5lu"
> makes little sense, for "%5lu" is too small for systems with uptime >= 1.16 days
> and parsers after all cannot assume fixed length for the timestamp field. Then,
> we could change from "%5lu.%06lu" to "%lu.%06lu" so that parsers (like /bin/awk)
> can get prefix part using white spaces as a delimiter.

My primary concern was a human readability. The different header columns
are separated by brackets and the message itself is separated by the space.

awk could easily use \[ as the separator.

But you made a good point about the column width. The text might be
hard to read when every line of text starts on a different column. And
the might be bigger differences for the task id. It might be useful to
add some reasonable default width also for the for the "from_id" column.

> If we want to reduce space, do we want to do like
> 
>   [0.293000@T1] smpboot: CPU0: Intel(R) Core(TM) i5-4440S CPU @ 2.80GHz (family: 0x6, model: 0x3c, stepping: 0x3)
>   [0.299733@T1] Performance Events: Haswell events, core PMU driver.
>   [2.813808@T35] clocksource: Switched to clocksource tsc
>   [2.893984@C0] random: fast init done

Hmm, this is pretty hard to parse by my eyes. Also it changes the format
of the timestamp column.

I think that the following might give the best human user experience:

[    0.293000][     T1] smpboot: CPU0: Intel(R) Core(TM) i5-4440S CPU @ 2.80GHz (family: 0x6, model: 0x3c, stepping: 0x3)
[    0.299733][     T1] Performance Events: Haswell events, core PMU driver.
[    2.813808][    T35] clocksource: Switched to clocksource tsc
[    2.893984][     C0] random: fast init done


> >> @@ -1037,6 +1054,9 @@ void log_buf_vmcoreinfo_setup(void)
> >>  	VMCOREINFO_OFFSET(printk_log, len);
> >>  	VMCOREINFO_OFFSET(printk_log, text_len);
> >>  	VMCOREINFO_OFFSET(printk_log, dict_len);
> >> +#ifdef CONFIG_PRINTK_FROM
> >> +	VMCOREINFO_OFFSET(printk_log, from_id);
> >> +#endif
> > 
> > The crash tool would need to be updated if anyone wanted to read
> > the log from the extended structure. Well, it might be done later
> > if people start using it more widely.
> 
> Since syzbot can utilize output from only normal consoles, I can
> keep extended records unmodified for now.

Please, add VMCOREINFO_OFFSET(printk_log, from_id) so that crashdump
can be updated when necessary.

> > 
> > I think about adding one more filed "u8 version". It would help
> > to solve the external compatibility in the long term.
> 
> /dev/kmsg format allows adding more fields, but that format did not define
> how to tell what fields are there. If fields are conditionally added by
> kernel config options, I don't think that "u8 version" field helps.
> Unless we add fields unconditionally, we will need to use $name=$value
> (where $name and $value must not contain ',' and ';') representation.

/dev/kmsg uses key=value notation. It does not need any version. The
version filed was intended for crashdump. It would make the life
easier for its maintainers.

Well, I do not resist on it. Let's put the version field aside for now.

Best Regards,
Petr
