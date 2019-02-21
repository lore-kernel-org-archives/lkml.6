Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C503FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBC72084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfBUQoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:44:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfBUQoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:44:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50F793082E91;
        Thu, 21 Feb 2019 16:44:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id F10B56090C;
        Thu, 21 Feb 2019 16:44:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 21 Feb 2019 17:44:06 +0100 (CET)
Date:   Thu, 21 Feb 2019 17:44:04 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 4/7] cgroup: cgroup v2 freezer
Message-ID: <20190221164403.GB26064@redhat.com>
References: <20190219220252.4906-1-guro@fb.com>
 <20190219220252.4906-5-guro@fb.com>
 <20190220144202.GB9477@redhat.com>
 <20190220221423.GA17163@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220221423.GA17163@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 21 Feb 2019 16:44:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20, Roman Gushchin wrote:
>
> On Wed, Feb 20, 2019 at 03:42:02PM +0100, Oleg Nesterov wrote:
> > On 02/19, Roman Gushchin wrote:
> > >
> > > @@ -2363,7 +2419,8 @@ bool get_signal(struct ksignal *ksig)
> > >  	 * we should notify the parent, prepare_signal(SIGCONT) encodes
> > >  	 * the CLD_ si_code into SIGNAL_CLD_MASK bits.
> > >  	 */
> > > -	if (unlikely(signal->flags & SIGNAL_CLD_MASK)) {
> > > +	if (unlikely(signal->flags & SIGNAL_CLD_MASK) &
> > > +	    !(current->jobctl & JOBCTL_TRAP_FREEZE)) {
> >
> > Hmm, why?
>
> If a process is going from the stopped to the frozen state, it looks like
> it's better to delay parent's notification up to the moment when it will
> actually run.

Perhaps I missed something but I do not understand why it is really better,
at least why it deserves this (small but still) complication...

OK, if nothing else, suppose that SIGCONT races with cgroup_do_freeze(true).
With or without this change CLD_CONTINUED can be reported or not depending
on /dev/random, do we really care?

Oleg.

