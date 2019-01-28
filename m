Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3951BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B742177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfA1VUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:20:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfA1VUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:20:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 86F6E124D0D;
        Mon, 28 Jan 2019 21:20:07 +0000 (UTC)
Received: from ivy-bridge (ovpn-204-44.brq.redhat.com [10.40.204.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DA0585887;
        Mon, 28 Jan 2019 21:19:56 +0000 (UTC)
Date:   Mon, 28 Jan 2019 22:19:51 +0100
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Richard Guy Briggs <rbriggs@redhat.com>
Subject: Re: [PATCH] audit: always enable syscall auditing when supported
 and audit is enabled
Message-ID: <20190128221951.57a5e03b@ivy-bridge>
In-Reply-To: <CAHC9VhSCFiEfzcwwkDdMsyh0xa2zh-WDTbv55tsDXYU4Td0zDQ@mail.gmail.com>
References: <20151208164237.15736.42955.stgit@localhost>
        <5490ae28-251b-bfda-38a6-5be201a4a8d8@nokia.com>
        <CAHC9VhQsVFY1LAakAUUCBZw6nmSy0-eoFrhQgVQrkqgAsWVGhQ@mail.gmail.com>
        <4fb6def1-a1d9-8af0-394c-f92224884d18@nokia.com>
        <CAHC9VhT1T4wTonW_L8CH2j1aMqSaBcUf-zH==233+ZZvSKhkwg@mail.gmail.com>
        <8bf5d613-9b27-381d-283b-c8892483f424@nokia.com>
        <CAHC9VhR25UdWPSRurefEX3YjM80DEh5BXETvK4na3Ym+k2=9xQ@mail.gmail.com>
        <20190128210328.64b7719c@ivy-bridge>
        <CAHC9VhSCFiEfzcwwkDdMsyh0xa2zh-WDTbv55tsDXYU4Td0zDQ@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 28 Jan 2019 21:20:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 15:08:56 -0500
Paul Moore <paul@paul-moore.com> wrote:

> On Mon, Jan 28, 2019 at 3:03 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > On Mon, 28 Jan 2019 11:26:51 -0500
> > Paul Moore <paul@paul-moore.com> wrote:
> >  
> > > On Mon, Jan 28, 2019 at 10:38 AM Sverdlin, Alexander (Nokia -
> > > DE/Ulm) <alexander.sverdlin@nokia.com> wrote:  
> > > > Hello Paul,
> > > >
> > > > On 28/01/2019 15:52, Paul Moore wrote:  
> > > > >>>>> time also enables syscall auditing; this patch simplifies
> > > > >>>>> the Kconfig menus by removing the option to disable
> > > > >>>>> syscall auditing when audit is selected and the target
> > > > >>>>> arch supports it.
> > > > >>>>>
> > > > >>>>> Signed-off-by: Paul Moore <pmoore@redhat.com>  
> > > > >>>> this patch is responsible for massive performance
> > > > >>>> degradation for those who used only
> > > > >>>> CONFIG_SECURITY_APPARMOR.
> > > > >>>>
> > > > >>>> And the numbers are, take the following test for instance:
> > > > >>>>
> > > > >>>> dd if=/dev/zero of=/dev/null count=2M
> > > > >>>>
> > > > >>>> ARM64:      500MB/s -> 350MB/s
> > > > >>>> ARM:        400MB/s -> 300MB/s  
> > > > >>> Hi there.
> > > > >>>
> > > > >>> Out of curiosity, what kernel/distribution are you running,
> > > > >>> or is this a custom kernel compile?  Can you also share the
> > > > >>> output of 'auditctl  
> > > > >> This test was carried out with Linux 4.9. Custom built.  
> > > > > I suspected that was the case, thanks.
> > > > >  
> > > > >>> -l' from your system?  The general approach taken by
> > > > >>> everyone to turn-off the per-syscall audit overhead is to
> > > > >>> add the "-a never,task" rule to their audit configuration:
> > > > >>>
> > > > >>>  # auditctl -a never,task
> > > > >>>
> > > > >>> If you are using Fedora/CentOS/RHEL, or a similarly
> > > > >>> configured system,  
> > > > >> This is an embedded distribution. We are not using auditctl
> > > > >> or any other audit-related user-space packages.
> > > > >>  
> > > > >>> you can find this configuration in
> > > > >>> the /etc/audit/audit.rules file (be warned, that file is
> > > > >>> automatically generated based on /etc/audit/rules.d).  
> > > > >> I suppose in this case rule list must be empty. Is there a
> > > > >> way to check this without extra user-space packages?  
> > > > > Yes, unless you are loading rules through some other method I
> > > > > would expect that your audit rule list is empty.
> > > > >
> > > > > I'm not aware of any other tools besides auditctl to load
> > > > > audit rules into the kernel, although I haven't ever had a
> > > > > need for another tool so I haven't looked very hard.  If you
> > > > > didn't want to bring auditctl into your distribution, I
> > > > > expect it would be a rather trivial task to create a small
> > > > > tool to load a single "-a never,task" into the kernel.  
> > > >
> > > > I've done a quick test on my x86_64 PC and got the following
> > > > results:  
> > >
> > > ...
> > >  
> > > > Which brings me to an idea, that the subject patch should have
> > > > been accompanied by a default "never,task" rule inside the
> > > > kernel, otherwise you require an extra user-space package
> > > > (audit) just to bring Linux 4.5+ to 4.4 performance levels.  
> > >
> > > [NOTE: I dropped pmoore@redhat.com from the To/CC line, I left
> > > Red Hat for greener pastures several months ago.]
> > >
> > > Well, it generally hasn't been an issue as 1) most people that
> > > enable audit also enable syscall auditing and 2) most people that
> > > enable audit have some sort of audit userspace tools to work with
> > > the audit logs (and configure audit if necessary).  I don't want
> > > to diminish your report, but this change was made several years
> > > ago and we really haven't heard of many issues surrounding the
> > > change.  If we can ever get all of the different arches to
> > > support syscall auditing, I'd love to get rid of the syscall
> > > auditing Kconfig knob entirely.
> > >
> > > If you wanted to put together a patch that added a single "-a
> > > never,task" rule on boot I could get behind that, just make it
> > > default to off.  
> >
> > That will make processes unauditable for everyone. That's how it
> > gets a speedup is not entering into the audit machinery.  
> 
> That is pretty much what is being asked for in this thread.  It's
> really no different from what Fedora/CentOS/RHEL (and who knows how
> many others) ship with their default audit config.  It's important to
> note that you could always delete this rule at runtime; all that is
> being proposed is to have the kernel populate the the audit ruleset
> with the "-a never,task" rule *IF* the proposed kernel Kconfig option
> is enabled (and it would default to being off, you would have to turn
> it on during build).

Yes, but you can't add the auditable flag back to the task struct
because syscalls never enter audit machinery where it can be added back.
Meaning that even if you wanted to audit, there will be processes you
never can audit. Whereas deciding via auditd, they become unauditable
only after auditd loads the rule. Prior to that they are and all
processes are auditable if you decide to audit. So, this is
fundamentally different than what fedora does.

-Steve

> > I suppose its possible that people may want MAC hardwired events
> > but no syscall events. I don't know if there are other kconfig
> > audit options. but maybe getting it down to audit enabled and
> > syscall auditing as the only choices is probably the most
> > performant.
> >
> > -Steve  
> 

