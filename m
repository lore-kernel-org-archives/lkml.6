Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9CAC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB2C25BD8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB2C25BD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934673AbeFYO45 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:56:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:33118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934543AbeFYO4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:56:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 48D96ABBF;
        Mon, 25 Jun 2018 14:56:54 +0000 (UTC)
Date:   Mon, 25 Jun 2018 16:56:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Make CONSOLE_LOGLEVEL_QUIET configurable
Message-ID: <20180625145653.knkugqikkxpvz67z@pathway.suse.cz>
References: <20180619115726.3098-1-hdegoede@redhat.com>
 <20180620110335.sjzmtra2z3chvon2@pathway.suse.cz>
 <f60d844d-9d3b-3154-4eec-982432c8e502@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f60d844d-9d3b-3154-4eec-982432c8e502@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-06-20 15:37:47, Hans de Goede wrote:
> Hi,
> 
> On 20-06-18 13:03, Petr Mladek wrote:
> > On Tue 2018-06-19 13:57:26, Hans de Goede wrote:
> > > The goal of passing the "quiet" option to the kernel is for the kernel
> > > to be quiet unless something really is wrong.
> > > 
> > > Sofar passing quiet has been (mostly) equivalent to passing
> > > loglevel=4 on the kernel commandline. Which means to show any messages
> > > with a level of KERN_ERR or higher severity on the console.
> > > 
> > > In practice this often does not result in a quiet boot though, since
> > > there are many false-positive or otherwise harmless error messages printed,
> > > defeating the purpose of the quiet option. Esp. the ACPICA code is really
> > > bad wrt this, but there are plenty of others too.
> > 
> > I see your pain. But this sounds like a workaround for a broken code.
> > This change might just encourage people to create even more mess.
> 
> I've been submitting patches upstream to fix false-positive KERN_ERR
> messages for more then a year now and getting a KERN_ERR free kernel
> (on more then 1 specific model hw) is just undoable. Every release some
> new nonsense error comes up, like e.g.:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1568276
> 
> Besides this random KERN_ERR cases (of which there are plenty
> by themselves) I've also had long discussions with the ACPICA upstream
> maintainers, but they refuse to change this instead insisting that:
> 
> a) Vendors should fix there DSDTs to be perfect; and
> b) end-users should then update their BIOS to fix this
> 
> Neither of which is a realistic expectation in anyway.

Thanks for the many examples. It would help me to argue if anyone
later complains about this change ;-)


> > > This commit makes CONSOLE_LOGLEVEL_QUIET configurable.
> > > 
> > > This for example will allow distros which want quiet to really mean quiet
> > > to set CONSOLE_LOGLEVEL_QUIET so that only messages with a higher severity
> > > then KERN_ERR (CRIT, ALERT, EMERG) get printed, avoiding an endless game
> > > of whack-a-mole silencing harmless error messages.
> > 
> > I find it a bit confusing that "quiet" would mean something different
> > on different systems.
> 
> The kernel is so configurable already that I don't think this really is much
> of an issue, quiet will still mean quiet on all systems, some might just
> be a tad more quiet (or actually be quiet) compared to others.

Just for record. Some people actually do a lot to prevent adding new
configure options. The many possibilities cause troubles to users
and even experienced developers.

A common argument against adding new options is: "How users could be
able to choose reasonable value when even experts (maintainers,
developers) are not able to agree on it".


> I went with making this configurable because I expect that to
> be a controversial change.

Exactly, I thought about changing the default. But it might just
bring a lot of bike-shedding.

I do not see any other good option. More people like this patch.
So I pushed it into printk.git, branch for-4.19.

Best Regards,
Petr
