Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D61EC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35B220C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35B220C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeGLIBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:01:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:57488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726093AbeGLIBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:01:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C51BAE6E;
        Thu, 12 Jul 2018 07:53:16 +0000 (UTC)
Date:   Thu, 12 Jul 2018 09:53:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] console: Replace #if 1 with a bool to ignore
 WARN_CONSOLE_UNLOCKED()
Message-ID: <20180712075315.vvcebweho635d3le@pathway.suse.cz>
References: <20180711151755.613eba3c@gandalf.local.home>
 <20180712015848.GA663@jagdpanzerIV>
 <20180711230912.2575fae1@vmware.local.home>
 <20180712042552.GB663@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712042552.GB663@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-07-12 13:25:52, Sergey Senozhatsky wrote:
> On (07/11/18 23:09), Steven Rostedt wrote:
> > > On (07/11/18 15:17), Steven Rostedt wrote:
> > > > +bool ignore_console_lock_warning __read_mostly;
> > > > +EXPORT_SYMBOL(ignore_console_lock_warning);  
> > > 
> > > OK. So, to recap,
> > > We made is_console_locked() EXPORT_SYMBOL recently [it's still in linux-next],
> > > so people could use WARN_CONSOLE_UNLOCKED in more places; this made other
> > > people unhappy, so now we add another EXPORT_SYMBOL to the picture, which will
> > > disable those newly added WARN_CONSOLE_UNLOCKED and make other people happy
> > > again.
> > 
> > Note, it only made people that added a module parameter that disables
> > grabbing the console lock in the first place for debugging purposes
> > only. The added WARN_CONSOLE_UNLOCKED() are good. Nobody complaining
> > that they exist. They are complaining that it breaks one of their
> > debugging work flows, and need to disable it when they are doing so.
> 
> True, but at the same time nobody complained that we didn't have those
> extra WARN_CONSOLE_UNLOCKED()-s. Just saying. Over all I agree that there
> is probably some value in those extra WARN-s.

I agree that there is some value in the extra WARN's. Also it seems
that it is useful to disable them for debugging purposes. I do not
see a better solution. Therefore I am fine with this one.


> > I could add a comment explaining why it exists. Something like:
> > 
> > /*
> >  * Set this is you need to quiet WARN_CONSOLE_UNLOCKED() for debugging
> >  * purposes.
> >  */
> 
> s/is you/if you/

Yes, this extra comment would be appreciated.

If you send v2, please, break also the WARN definition to 80-chars's
per line ;-)


> Suggested-by: One-of-those-commiters@YouKnowWhoYouAre.org ;)

AFAIK, the change was actually suggested by Steven. The inspiration
is described by the line:

Link:
http://lkml.kernel.org/r/717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de


Finally, IMHO, it would make sense to push this change together with
the fbcon/vt side.

Best Regards,
Petr
