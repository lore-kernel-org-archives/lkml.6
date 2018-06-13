Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C2FFDC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7C0208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7C0208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935501AbeFMMcw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:32:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:38140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935346AbeFMMcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:32:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BC927AF3E;
        Wed, 13 Jun 2018 12:32:49 +0000 (UTC)
Date:   Wed, 13 Jun 2018 14:32:47 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: Quilt vs gmail (Was: [PATCH 0/3] sched/swait: Convert to full
 exclusive mode)
Message-ID: <20180613143247.1b749c83@endymion>
In-Reply-To: <20180612171420.GU12217@hirez.programming.kicks-ass.net>
References: <20180612083449.100099222@infradead.org>
        <CA+55aFzLNFO1za9-Lb=jxO_F9NS0jZyti+we=ycr5NTpgzdEbw@mail.gmail.com>
        <20180612171420.GU12217@hirez.programming.kicks-ass.net>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Linus, Andreas,

On Tue, 12 Jun 2018 19:14:20 +0200, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 09:47:34AM -0700, Linus Torvalds wrote:
> 
> > I do note how quilt emails are really hard to read, because that:
> > 
> >     Content-Disposition: inline
> > 
> > makes gmail think it's flowed.
> > 
> > Which works horribly badly for patches, surprise surprise.
> > 
> > So I really wish quilt wouldn't do that. It does smell like a gmail
> > bug, but at the same time, why would you use "Content-Disposition:
> > inline" when you don't have an actual multi-part email? So I do blame
> > quilt too for sending nonsensical headers.
> > 
> > (Yes, yes, I see the "It is permissible to use Content-Disposition on
> > the main body" in the RFC. But the RFC also makes it clear that it
> > actually matters for how things are presented, so saying "ok, I'll do
> > flowed" seems equally insane and equally technically RFC-compliant)  
> 
> Quilt people, anything that can be done about that?

The purpose of the Content-Disposition header is to let quilt store the
original patch file name, so that the recipient can save the email as a
patch file having the exact same name as the sender was using, to make
communication between developers easier. This is the reason why the
header is being added despite the email not being multi-part. As Linus
found out already, RFC 2183 allows that. The RFC also explicitly allows
the use of a filename parameter for inline parts (see section 2.3.)

Using "attachment" instead of "inline" would presumably force the user
to save the patch to a file before being able to read it, or, at least,
to take additional actions in the MUA to convince it to display the
contents inline regardless of what the Content-Disposition header
says. This is clearly not desirable.

We could try specifying the filename directly, without the "inline"
keyword, however that would no longer comply with the RFC
("disposition-parm" is optional, but "disposition-type" is mandatory)
and I am afraid that some MUA implementations would either default to
disposition-type "attachment" in this case, or ignore the header
altogether.

I'm not sure I understand what "flowed" means in this context. If you
mean that gmail breaks the formatting of the patch, I would say that
gmail is infringing the RFC, which clearly stipulates at the beginning
that the Content-Disposition header field is only about telling the MUA
which parts should be displayed immediately and which parts should not,
and not about presentation issues.

Considering that "inline" is the default for a non-multi-part message,
any MUA which changes its behavior in the presence of
"Content-Disposition: inline" is bugged in my opinion.
-- 
Jean Delvare
SUSE L3 Support
