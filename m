Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25A1C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70D420839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70D420839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeIKNpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:45:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:55748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726519AbeIKNpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:45:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C69BAF5C;
        Tue, 11 Sep 2018 08:47:24 +0000 (UTC)
Date:   Tue, 11 Sep 2018 10:47:22 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 4.19 regression fix] printk: For early boot messages
 check loglevel when flushing the buffer
Message-ID: <20180911084722.22fqbewiebzsdofm@pathway.suse.cz>
References: <20180905023522.GA1444@jagdpanzerIV>
 <93901f2b-91ad-a910-7031-0040b827a3af@redhat.com>
 <20180905053609.GA19936@jagdpanzerIV>
 <20180905083326.GC19936@jagdpanzerIV>
 <20180905110207.rxy3upplgkjbk5oi@pathway.suse.cz>
 <20180906072940.GA382@jagdpanzerIV>
 <20180906142825.u2fiqt62jmapr5ud@pathway.suse.cz>
 <20180907042132.GC2394@jagdpanzerIV>
 <20180910145747.emvfzv4mzlk5dfqk@pathway.suse.cz>
 <20180911023039.GA4065@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911023039.GA4065@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-09-11 11:30:39, Sergey Senozhatsky wrote:
> On (09/10/18 16:57), Petr Mladek wrote:
> > 
> > Good catch.
> > 
> > > ---
> > > 
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index c036f128cdc3..ede29a7ba6db 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -2545,6 +2545,7 @@ void console_flush_on_panic(void)
> > >  	 * ensure may_schedule is cleared.
> > >  	 */
> > >  	console_trylock();
> > > +	exclusive_console = NULL;
> > 
> > This is not be enough. It would cause replying old messages
> > on all consoles.
> 
> Oh, that was intentional. I consider repeated messages to be less
> problematic than the missing ones.

It makes some sense. But it might be problematic with slow consoles.
I prefer to avoid it if there is a better solution.


> > Most problems should probably be solved when we store console_seq
> > before setting exclusive_console. Then we could clear
> > exclusive_console when reaching the stored sequence number.
> > 
> > Can this be that simple? ;-)
> 
> This can work, yes.

I'll try to cook up a patch later this week.


> I also thought about doing it the way Linus, Jan Kara and Hannes
> Reinecke proposed:
> 
> - store the console_seq nr of the first oops_in_progress message
>   (oops_console_seq) and flush only messages that are in
>   [oops_console_seq - 200, log_next_seq] range, as opposed to complete
>   logbuf flush.
> 
> Hannes asked for this several times. And it was in Jan's printk patches
> long time ago (if I'm not mistaken - sorry if I am -- Jan said that Linus
> wanted that "just N messages prior to oops" thing).
> 
> Jan's patch:
>  https://lore.kernel.org/lkml/1457964820-4642-3-git-send-email-sergey.senozhatsky@gmail.com/T/#u

The patch might be useful but it also might be controversial. It would
deserve discussion with a wide audience in a dedicated thread.


> > This reverts commit 375899cddcbb26881b03cb3fbdcfd600e4e67f4a.
> > 
> > Reported-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

I have just pushed the patch into printk.git, for-4.19-rc4 branch.

Note that I merged also a revert of the build fix
commit ffaa619af1b06 ("printk: Fix warning about unused
suppress_message_printing"). I am sorry that I missed
it in the original patch. It is an obvious oneliner.
It should not invalidate the acks.

Best Regards,
Petr
