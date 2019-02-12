Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7EFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E41214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfBLOcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:32:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfBLOcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:32:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02E76214DA;
        Tue, 12 Feb 2019 14:32:05 +0000 (UTC)
Date:   Tue, 12 Feb 2019 09:32:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/9] vsprintf: Factor out %pV handler as va_format()
Message-ID: <20190212093204.1bddf4a8@gandalf.local.home>
In-Reply-To: <20190212130030.s22aamlnmj2lv7zg@pathway.suse.cz>
References: <20190208152310.29531-1-pmladek@suse.com>
        <20190208152310.29531-6-pmladek@suse.com>
        <f308ab312810d538a79c2f54f49edba32c60b561.camel@perches.com>
        <20190212130030.s22aamlnmj2lv7zg@pathway.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 14:00:30 +0100
Petr Mladek <pmladek@suse.com> wrote:

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
>

Not to mention that if it is the only static call, gcc will most likely
just keep it inlined. Could add an inline annotation just to be
paranoid.

-- Steve
