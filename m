Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38FBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D2020645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D2020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeIFTEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:04:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:52654 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729881AbeIFTEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:04:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F3ABAEC9;
        Thu,  6 Sep 2018 14:28:26 +0000 (UTC)
Date:   Thu, 6 Sep 2018 16:28:25 +0200
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
Message-ID: <20180906142825.u2fiqt62jmapr5ud@pathway.suse.cz>
References: <20180904180154.845-1-hdegoede@redhat.com>
 <20180905023522.GA1444@jagdpanzerIV>
 <93901f2b-91ad-a910-7031-0040b827a3af@redhat.com>
 <20180905053609.GA19936@jagdpanzerIV>
 <20180905083326.GC19936@jagdpanzerIV>
 <20180905110207.rxy3upplgkjbk5oi@pathway.suse.cz>
 <20180906072940.GA382@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906072940.GA382@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-09-06 16:29:40, Sergey Senozhatsky wrote:
> On (09/05/18 13:02), Petr Mladek wrote:
> > Note that the first registered console prints all messages
> > even without this flag.
> 
> Hmm, OK, interesting point.
> 
> I assumed that the first console usually has CON_PRINTBUFFER bit set.
> Or even a CON_PRINTBUFFER | CON_ANYTIME combo. E.g. 8250. It sort of
> makes sense to have CON_PRINTBUFFER for the first console. Any later
> consoles [e.g. fbcon, netcon] don't necessarily have CON_PRINTBUFFER.
> 
> And the first console has CON_PRINTBUFFER bit set. Well, just because
> it sounds reasonable. Those were the main assumptions behind my code
> snippet. Was any of those assumptions wrong?

This assumption makes sense. In fact, I was wrong. I thought that
console_seq/console_idx were not updated until the first console
was registered. But it is not the case.

It means that the hack with exclusive_console might be usable.
But I would prefer to do it a cleaner way.


> > I played with another solution, see the patch below. It defines
> > which messages have a valid NOCONS flag according to the msg_seq
> > number. IMHO, it is a bit more straightforward but it is still
> > a hack. I am not super happy about it.
> 
> I just skimmed through it, and probably missed some parts. But I sort
> of expected to see some console_valid_nocons_seq manipulations in
> register_console(), when we register a new CON_PRINTBUFFER console
> on already running system.

I do not see any reason for this. If quiet/debug/loglevel kernel
parameters are proceed before register_console() call then
console_valid_nocons_seq is already set to the right sequence
number. Otherwise console_loglevel should be still the default
value and there is no reason to re-calculate nocons flag.

But it is rather complicated, still hacky, ...


> > Hmm, I seriously think about reverting the commit 375899cddcbb
> > ("printk: make sure to print log on console.") and solving it
> > another way.
> 
> I can agree, definitely. That's one of the options.

I prefer the revert for now.

Best Regards,
Petr
