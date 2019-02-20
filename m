Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F038C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A06A2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfBTJY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:24:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:38424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbfBTJY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:24:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 030B6AFBB;
        Wed, 20 Feb 2019 09:24:27 +0000 (UTC)
Date:   Wed, 20 Feb 2019 10:24:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 9/9] vsprintf: Avoid confusion between invalid address
 and value
Message-ID: <20190220092425.zgwbvbskpd6zss7r@pathway.suse.cz>
References: <20190208152310.29531-1-pmladek@suse.com>
 <20190208152310.29531-10-pmladek@suse.com>
 <20190219030300.GA640@jagdpanzerIV>
 <CAHp75Vckf_aJqpK75-7xmN-u3aVs8nUrAOWiRzSLP5Gh3uHUEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vckf_aJqpK75-7xmN-u3aVs8nUrAOWiRzSLP5Gh3uHUEQ@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-19 13:06:17, Andy Shevchenko wrote:
> On Tue, Feb 19, 2019 at 5:07 AM Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> 
> > Suppose, in my driver I want to sprintf() IPv4 address. The longest
> > possible address is 3 * 4 (%d%d%d) + 3 bytes (dots) + terminating NULL.
> > E.g. 111.111.111.111
> >
> > forcing sprintf() to write "(invalid address)" to a 16-bytes buffer,
> > but the thing is - strlen("(invalid address)") > 16.

Good catch!

> It would print as many characters as buffer allows. In your case above
> the use of sprintf() is a bit fragile.

Heh, I do not see it used anywhere in the code. Only "%pi6" is used
in a real code and always a safe way.

> But yes, the error messages should not be longer than 8 / 16 bytes
> depending on 32- or 64-bit build we have.

Well, better be on the safe side. I'll move it at the beginning
of the patchset.

Best Regards,
Petr

PS: I am a bit busy with some other things. I'll send v7 later.
I think that it is a material for 5.2. This patchset would deserve
some testing in linux-next and we are already too close to
the 5.1 merge window.
