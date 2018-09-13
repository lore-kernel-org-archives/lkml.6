Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BD4C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908B6206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908B6206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbeIMU3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:29:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbeIMU3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:29:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9623C8764D;
        Thu, 13 Sep 2018 15:19:39 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-40.phx2.redhat.com [10.3.112.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19953600C8;
        Thu, 13 Sep 2018 15:19:36 +0000 (UTC)
Date:   Thu, 13 Sep 2018 11:14:55 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time
 adjustments
Message-ID: <20180913151455.yxvtcorxakh7vqrq@madcap2.tricolour.ca>
References: <20180824120001.20771-1-omosnace@redhat.com>
 <20180827075020.GL27091@localhost>
 <CAFqZXNvADB-E_fjEaQpUymSVvfP-vXQXtk3K+nJ9DqrScHL8bQ@mail.gmail.com>
 <4819575.TSNxuEWROA@x2>
 <CAFqZXNtzSU0KjFwYzqJCQybEvJz1GhQZHxRfJ2hj=6o_RGGLLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNtzSU0KjFwYzqJCQybEvJz1GhQZHxRfJ2hj=6o_RGGLLA@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 13 Sep 2018 15:19:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-13 15:59, Ondrej Mosnacek wrote:
> On Mon, Aug 27, 2018 at 6:38 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > On Monday, August 27, 2018 5:13:17 AM EDT Ondrej Mosnacek wrote:
> > > On Mon, Aug 27, 2018 at 9:50 AM Miroslav Lichvar <mlichvar@redhat.com>
> > wrote:
> > > > On Fri, Aug 24, 2018 at 02:00:00PM +0200, Ondrej Mosnacek wrote:
> > > > > This patch adds two auxiliary record types that will be used to
> > > > > annotate
> > > > > the adjtimex SYSCALL records with the NTP/timekeeping values that have
> > > > > been changed.
> > > >
> > > > It seems the "adjust" function intentionally logs also calls/modes
> > > > that don't actually change anything. Can you please explain it a bit
> > > > in the message?
> > > >
> > > > NTP/PTP daemons typically don't read the adjtimex values in a normal
> > > > operation and overwrite them on each update, even if they don't
> > > > change. If the audit function checked that oldval != newval, the
> > > > number of messages would be reduced and it might be easier to follow.
> > >
> > > We actually want to log any attempt to change a value, as even an
> > > intention to set/change something could be a hint that the process is
> > > trying to do something bad (see discussion at [1]).
> >
> > One of the problems is that these applications can flood the logs very
> > quickly. An attempt to change is not needed unless it fails for permissions
> > reasons. So, limiting to actual changes is probably a good thing.
> 
> Well, Richard seemed to "violently" agree with the opposite, so now I
> don't know which way to go... Paul, you are the official tie-breaker
> here, which do you prefer?

The circumstances have changed with new information being added.  I
recall violently agreeing several iterations ago with your previous
assessment, which has also changed with this new information.  I'd agree
with Steve that a flood of information about something that did not
change value could hide important information.

(BTW: The expression "to violoently agree with" is generally used in a
situation where two parties appear to have been arguing two different
sides of an issue and then realize they have much more in common than
initially apparent.)

> > -Steve
> >
> > > There are valid
> > > arguments both for and against this choice, but we have to pick one in
> > > the end... Anyway, I should explain the reasoning in the commit
> > > message better, right now it just states the fact without explanation
> > > (in the second patch), thank you for pointing my attention to it.
> > >
> > > [1] https://www.redhat.com/archives/linux-audit/2018-July/msg00061.html
> > >
> > > --
> > > Ondrej Mosnacek <omosnace at redhat dot com>
> 
> Ondrej Mosnacek <omosnace at redhat dot com>

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
