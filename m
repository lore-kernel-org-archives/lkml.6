Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D71C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949AD2080F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfBHJer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:34:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:43794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbfBHJer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:34:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F23ADAD72;
        Fri,  8 Feb 2019 09:34:45 +0000 (UTC)
Date:   Fri, 8 Feb 2019 10:34:45 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alice Ferrazzi <alicef@alicef.me>, jeyu@kernel.org,
        jikos@kernel.org, mbenes@suse.cz, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: Re: [PATCH v2] livepatch: core: Return EOPNOTSUPP instead of ENOSYS
Message-ID: <20190208093445.zvxkgaummsait5z6@pathway.suse.cz>
References: <20190204183324.30775-1-alicef@alicef.me>
 <20190205155933.r6ey474lq4m5nlmp@treble>
 <20190206102832.apa7sekkwljo4ejg@pathway.suse.cz>
 <20190208062005.GA21436@JAVRIS.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208062005.GA21436@JAVRIS.in.ibm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-02-08 11:50:05, Kamalesh Babulal wrote:
> On Wed, Feb 06, 2019 at 11:28:32AM +0100, Petr Mladek wrote:
> > On Tue 2019-02-05 09:59:33, Josh Poimboeuf wrote:
> > > On Tue, Feb 05, 2019 at 03:33:28AM +0900, Alice Ferrazzi wrote:
> > > > From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > > > 
> > > > As a result of an unsupported operation is better to use EOPNOTSUPP
> > > > as error code.
> > > > ENOSYS is only used for 'invalid syscall nr' and nothing else.
> > > > 
> > > > Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > > 
> > > Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > 
> > I have applied the patch into for-5.1/atomic-replace branch.
> 
> Sorry to jump into the discussion so late. Thinking a little more about
> the check itself, previously with immediate flag an architecture can do
> livepatching with limitations and without the reliable stack trace
> implemented yet.
> 
> After removal of the immediate flag by
> commit d0807da78e11 ("livepatch: Remove immediate feature"), every
> architecture enabling livepatching is required to have implemented
> reliable stack trace.  Is it a better idea to make
> HAVE_RELIABLE_STACKTRACE a config dependency, which will disable
> livepatching support for architectures without reliable stack trace
> function during kernel build?
> 
> The idea is to remove klp_have_reliable_stack() by moving
> CONFIG_HAVE_RELIABLE_STACKTRACE as a config dependency to Kconfig
> file

Looks like a nice cleanup.

> and adding the other CONFIG_STACKTRACE as a config dependency is not
> required, as it's selected via CONFIG_DYNAMIC_FTRACE_WITH_REGS
> dependency chain. With the patch on architecture without
> HAVE_RELIABLE_STACKTRACE, the user should see:

Hmm, I see the following in kernel/trace/Kconfig:

config TRACING
[...]
	select STACKTRACE if STACKTRACE_SUPPORT

It seems that the depency is not guaranted. Or do I miss anything?

Anyway, it is pretty indirect. I would prefer to add dependency
on STACKTRACE explicitly into config LIVEPATCH.

Best Regards,
Petr
