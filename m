Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE2EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379682089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379682089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbeGIXaG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:30:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33832 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932847AbeGIXaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:30:05 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C7753E2E;
        Mon,  9 Jul 2018 23:30:03 +0000 (UTC)
Date:   Mon, 9 Jul 2018 16:30:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NeilBrown <neilb@suse.com>, Wei Wang <wvw@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Andrei Vagin <avagin@openvz.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] kernel.h: Add for_each_if()
Message-Id: <20180709163001.8fb8148223a57bc46a13fbda@linux-foundation.org>
In-Reply-To: <20180709162509.29343-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
        <20180709162509.29343-1-daniel.vetter@ffwll.ch>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Jul 2018 18:25:09 +0200 Daniel Vetter <daniel.vetter@ffwll.ch> wrote:

> To avoid compilers complainig about ambigious else blocks when putting
> an if condition into a for_each macro one needs to invert the
> condition and add a dummy else. We have a nice little convenience
> macro for that in drm headers, let's move it out. Subsequent patches
> will roll it out to other places.
> 
> The issue the compilers complain about are nested if with an else
> block and no {} to disambiguate which if the else belongs to. The C
> standard is clear, but in practice people forget:
> 
> if (foo)
> 	if (bar)
> 		/* something */
> 	else
> 		/* something else

um, yeah, don't do that.  Kernel coding style is very much to do

	if (foo) {
		if (bar)
			/* something */
		else
			/* something else
	}

And if not doing that generates a warning then, well, do that.

> The same can happen in a for_each macro when it also contains an if
> condition at the end, except the compiler message is now really
> confusing since there's only 1 if:
> 
> for_each_something()
> 	if (bar)
> 		/* something */
> 	else
> 		/* something else
> 
> The for_each_if() macro, by inverting the condition and adding an
> else, avoids the compiler warning.

Ditto.

> Motivated by a discussion with Andy and Yisheng, who want to add
> another for_each_macro which would benefit from for_each_if() instead
> of hand-rolling it.

Ditto.

> v2: Explain a bit better what this is good for, after the discussion
> with Peter Z.

Presumably the above was discussed in whatever-thread-that-was.

