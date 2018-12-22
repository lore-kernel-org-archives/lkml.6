Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC555C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843332054F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404577AbeLVRsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:48:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390020AbeLVRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:14 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB6B921A4F;
        Sat, 22 Dec 2018 12:24:05 +0000 (UTC)
Date:   Sat, 22 Dec 2018 07:24:04 -0500
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
Message-ID: <20181222072404.27a7e9a3@vmware.local.home>
In-Reply-To: <20181222093346.GB7610@danjae.aot.lge.com>
References: <20181221231924.4583e90b@vmware.local.home>
        <20181222093346.GB7610@danjae.aot.lge.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2018 18:33:46 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> > +static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
> > +{
> > +	size_t len = strlen(prefix);
> > +	return strncmp(str, prefix, len) == 0 ? len : 0;  
> 
> As it already knows the length (and it needs to use it for return
> value), isn't it (slightly) better using memcmp() instead?

No, because we don't know the length of str.


	[ str = "h\0[bad memory]" ]


	str_has_prefix(str, "TEST THIS BIG STRING AT FRONT")


If we use memcmp(), then we are testing way after str has ended, and
that can cause a memory fault.

-- Steve
