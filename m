Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4B4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2442720BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2442720BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbeGLDQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 23:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeGLDQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 23:16:41 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C4620BF2;
        Thu, 12 Jul 2018 03:09:14 +0000 (UTC)
Date:   Wed, 11 Jul 2018 23:09:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] console: Replace #if 1 with a bool to ignore
 WARN_CONSOLE_UNLOCKED()
Message-ID: <20180711230912.2575fae1@vmware.local.home>
In-Reply-To: <20180712015848.GA663@jagdpanzerIV>
References: <20180711151755.613eba3c@gandalf.local.home>
        <20180712015848.GA663@jagdpanzerIV>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 10:58:48 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> On (07/11/18 15:17), Steven Rostedt wrote:
> > +bool ignore_console_lock_warning __read_mostly;
> > +EXPORT_SYMBOL(ignore_console_lock_warning);  
> 
> OK. So, to recap,
> We made is_console_locked() EXPORT_SYMBOL recently [it's still in linux-next],
> so people could use WARN_CONSOLE_UNLOCKED in more places; this made other
> people unhappy, so now we add another EXPORT_SYMBOL to the picture, which will
> disable those newly added WARN_CONSOLE_UNLOCKED and make other people happy
> again.

Note, it only made people that added a module parameter that disables
grabbing the console lock in the first place for debugging purposes
only. The added WARN_CONSOLE_UNLOCKED() are good. Nobody complaining
that they exist. They are complaining that it breaks one of their
debugging work flows, and need to disable it when they are doing so.

> 
> This makes me wonder - do we want to add more WARN_CONSOLE_UNLOCKED in the
> first place? :)

I would say yes.

> 
> Other than that, the patch looks OK to me I guess. I'm not super happy with
> more printk EXPORT_SYMBOL-s, frankly speaking, I'm not entirely in love with
> the "add a bool flag to suppress warn print outs which we added in the
> previous patch" direction, but if you guys want/need it...

I could add a comment explaining why it exists. Something like:

/*
 * Set this is you need to quiet WARN_CONSOLE_UNLOCKED() for debugging
 * purposes.
 */

> Probably I'm just dramatizing it, as usual ;)
> The removal of "#if 1" is definitely nice.

Yeah, that had to go regardless.

> 
> Let's hear from Petr.

Sure.

-- Steve
