Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2712BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81DB20869
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbfBLR6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:58:32 -0500
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:34420 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728380AbfBLR6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:58:30 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 97047180A9C64;
        Tue, 12 Feb 2019 17:58:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: limit75_2ca540df80443
X-Filterd-Recvd-Size: 2066
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Feb 2019 17:58:26 +0000 (UTC)
Message-ID: <c65a43b1711dfba3749d7e3022589c7c652e83c4.camel@perches.com>
Subject: Re: [PATCH v6 5/9] vsprintf: Factor out %pV handler as va_format()
From:   Joe Perches <joe@perches.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Feb 2019 09:58:25 -0800
In-Reply-To: <20190212130030.s22aamlnmj2lv7zg@pathway.suse.cz>
References: <20190208152310.29531-1-pmladek@suse.com>
         <20190208152310.29531-6-pmladek@suse.com>
         <f308ab312810d538a79c2f54f49edba32c60b561.camel@perches.com>
         <20190212130030.s22aamlnmj2lv7zg@pathway.suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-12 at 14:00 +0100, Petr Mladek wrote:
> On Fri 2019-02-08 09:11:17, Joe Perches wrote:
> > On Fri, 2019-02-08 at 16:23 +0100, Petr Mladek wrote:
> > > Move the code from the long pointer() function. We are going to improve
> > > error handling that will make it more complicated.
> > > 
> > > This patch does not change the existing behavior.
> > 
> > But doesn't this increase stack use?
> > %pV is recursive and increasing the stack is undesired
> > for this use.
> 
> %pV handler is stack sensitive because the entire vsnprintf()
> machinery is called recursively. This one extra call does
> not make it much worse.

That's an argument?.

Refactoring is good, but you need to add
__always_inline here.


