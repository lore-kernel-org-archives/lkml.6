Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578DAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3133C21A4B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391164AbeLVRTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:19:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390141AbeLVRTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:19:14 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28D8A21A48;
        Sat, 22 Dec 2018 17:19:13 +0000 (UTC)
Date:   Sat, 22 Dec 2018 12:19:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>, kernel-team@lge.com
Subject: Re: [PATCH v4] string.h: Add str_has_prefix() helper function
Message-ID: <20181222121911.68603488@vmware.local.home>
In-Reply-To: <20181222164605.GA10792@danjae.aot.lge.com>
References: <20181221231924.4583e90b@vmware.local.home>
        <20181222093346.GB7610@danjae.aot.lge.com>
        <20181222072404.27a7e9a3@vmware.local.home>
        <20181222142411.GA10058@danjae.aot.lge.com>
        <20181222101244.7da017c9@vmware.local.home>
        <20181222111630.24a4444a@vmware.local.home>
        <20181222164605.GA10792@danjae.aot.lge.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2018 01:46:05 +0900
Namhyung Kim <namhyung@kernel.org> wrote:


> > What I meant by that is if a string is allocated at a end of a page,
> > and the next page is marked as not present. A read into that page will
> > cause a page fault, and since memcmp() does not stop at the '\0' it
> > will read into that not-present memory and trigger a fault, and that
> > read wont be in the exception table, and it will then BUG.  
> 
> Why it doesn't stop at the '\0' if one has it and the other doesn't?
> It's not because it's '\0', it's because they are different.  The '\0'
> should be in the prev page (otherwise it's already a BUG) so it should
> be detected and stopped before going to next page IMHO.
> 

Because memcmp() isn't required to test byte by byte. In fact, most
implementations don't which is why memcmp is faster than strcncmp.

It can be checking in 8 byte chunks or more (although perhaps not
likely). Perhaps there's an arch command that lets you compare 32 bytes
at a time, if the size passed to memcmp is 32 or more, the
implementation is allowed to read both src and dst of 32 bytes at a
time. If there was a '\0' followed by not present memory, you will
still get that fault.

-- Steve
