Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874CAC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A72E20666
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2cbHO+YN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A72E20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeH3G0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:26:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbeH3G0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:26:42 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D40722054F;
        Thu, 30 Aug 2018 02:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535596012;
        bh=oJHadjBXSG1yLxCcf1sLQxT3FxQrZsBJi6liTeaeSKk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2cbHO+YNiuqjCmjX0Gkxk26veXwxOlWZl4eMuR62We1YgG2+5g2+2uop7InQs4EOd
         Cs7UCsPa3u5pqD7HWMVjk1KkiEDHjGbfqFlS2MZvaBjwf04X9DDM75IjaoVZpZyIhX
         oMh9rio4k+HyGBqllpwTzh7l3kkTFfZWhMsI8qUE=
Date:   Thu, 30 Aug 2018 11:26:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [RFC PATCH 1/6] x86/alternative: assert text_mutex is taken
Message-Id: <20180830112649.4b774f401d99a8b98e12008c@kernel.org>
In-Reply-To: <20180829210006.GA7166@linux.intel.com>
References: <20180829081147.184610-1-namit@vmware.com>
        <20180829081147.184610-2-namit@vmware.com>
        <20180829175936.fb27b3bf13da819a9a971f07@kernel.org>
        <1F547CEE-B5D9-42A0-8093-2C5555BACE26@vmware.com>
        <2694AE6F-2212-46C6-A570-6BAF265364FB@vmware.com>
        <20180829201309.GA7142@linux.intel.com>
        <58345C1F-8FF3-4F49-AF2F-B4789DF50CC7@vmware.com>
        <20180829210006.GA7166@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 14:00:06 -0700
Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> On Wed, Aug 29, 2018 at 08:44:47PM +0000, Nadav Amit wrote:
> > at 1:13 PM, Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> > 
> > > On Wed, Aug 29, 2018 at 07:36:22PM +0000, Nadav Amit wrote:
> > >> at 10:11 AM, Nadav Amit <namit@vmware.com> wrote:
> > >> 
> > >>> at 1:59 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >>> 
> > >>>> On Wed, 29 Aug 2018 01:11:42 -0700
> > >>>> Nadav Amit <namit@vmware.com> wrote:
> > >>>> 
> > >>>>> Use lockdep to ensure that text_mutex is taken when text_poke() is
> > >>>>> called.
> > >>>>> 
> > >>>>> Actually it is not always taken, specifically when it is called by kgdb,
> > >>>>> so take the lock in these cases.
> > >>>> 
> > >>>> Can we really take a mutex in kgdb context?
> > >>>> 
> > >>>> kgdb_arch_remove_breakpoint
> > >>>> <- dbg_deactivate_sw_breakpoints
> > >>>>  <- kgdb_reenter_check
> > >>>>     <- kgdb_handle_exception
> > >>>>        <- __kgdb_notify
> > >>>>          <- kgdb_ll_trap
> > >>>>            <- do_int3
> > >>>>          <- kgdb_notify
> > >>>>            <- die notifier
> > >>>> 
> > >>>> kgdb_arch_set_breakpoint
> > >>>> <- dbg_activate_sw_breakpoints
> > >>>>  <- kgdb_reenter_check
> > >>>>     <- kgdb_handle_exception
> > >>>>         ...
> > >>>> 
> > >>>> Both seems called in exception context, so we can not take a mutex lock.
> > >>>> I think kgdb needs a special path.
> > >>> 
> > >>> You are correct, but I don’t want a special path. Presumably text_mutex is
> > >>> guaranteed not to be taken according to the code.
> > >>> 
> > >>> So I guess the only concern is lockdep. Do you see any problem if I change
> > >>> mutex_lock() into mutex_trylock()? It should always succeed, and I can add a
> > >>> warning and a failure path if it fails for some reason.
> > >> 
> > >> Err.. This will not work. I think I will drop this patch, since I cannot
> > >> find a proper yet simple assertion. Creating special path just for the
> > >> assertion seems wrong.
> > > 
> > > It's probably worth expanding the comment for text_poke() to call out
> > > the kgdb case and reference kgdb_arch_{set,remove}_breakpoint(), whose
> > > code and comments make it explicitly clear why its safe for them to
> > > call text_poke() without acquiring the lock.  Might prevent someone
> > > from going down this path again in the future.
> > 
> > I thought that the whole point of the patch was to avoid comments, and
> > instead enforce the right behavior. I don’t understand well enough kgdb
> > code, so I cannot attest it does the right thing. What happens if
> > kgdb_do_roundup==0?
> 
> As is, the comment is wrong because there are obviously cases where
> text_poke() is called without text_mutex being held.  I can't attest
> to the kgdb code either.  My thought was to document the exception so
> that if someone does want to try and enforce the right behavior they
> can dive right into the problem instead of having to learn of the kgdb
> gotcha the hard way.  Maybe a FIXME is the right approach?

No, kgdb ensures that the text_mutex has not been held right before
calling text_poke. So they also take care the text_mutex. I guess
kgdb_arch_{set,remove}_breakpoint() is supposed to be run under
a special circumstance, like stopping all other threads/cores.
In that case, we can just check the text_mutex is not locked.
 
Anyway, kgdb is a very rare courner case. I think if CONFIG_KGDB is
enabled, lockdep and any assertion should be disabled, since kgdb
can tweak anything in the kernel with unexpected ways...

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
