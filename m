Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A1AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28FA2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28FA2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengaru.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJ3GNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:13:43 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:58236 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeJ3GNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:13:42 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id BF9721A402D8; Mon, 29 Oct 2018 14:23:14 -0700 (PDT)
Date:   Mon, 29 Oct 2018 14:23:14 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
Message-ID: <20181029212314.nwruqg6au23ebqlu@shells.gnugeneration.com>
References: <20181029192521.23059-1-dave@stgolabs.net>
 <0afed890-7c5a-93ee-cdb9-e30775bd9cf1@redhat.com>
 <20181029200050.iejuxckzbm742dmw@linux-r8p5>
 <3c5ba85b-5114-c751-0114-ac2cb64c02ea@redhat.com>
 <20181029203818.pot26ewxbncfrnua@linux-r8p5>
 <b40690db-273f-ff67-01bf-de0111deb499@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b40690db-273f-ff67-01bf-de0111deb499@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 04:59:03PM -0400, Waiman Long wrote:
> On 10/29/2018 04:38 PM, Davidlohr Bueso wrote:
> > On Mon, 29 Oct 2018, Waiman Long wrote:
> >
> >> BTW, since you are making stat2 compatible with stat, will that be
> >> easier from the user API perspective if we use a sysctl parameter to
> >> turn on and off IRQs reporting for /proc/stat, for example?
> >
> > For one /proc/stat is also common for debugging envs (ie: performance)
> > and I fear that if a tunnable modifies the behavior of the output, we
> > it might never be usable again (at least not without having users also
> > now consider the systctl parameter). Making it dynamic I think is not
> > worth it.
> >
> > Thanks,
> > Davidlohr
> 
> This is just a matter if it is easier for users to modify their code to
> use /proc/stat2 or turning on a sysctl parameter. Again, this will
> certainly depend on the circumstances.
> 

I wonder if it makes sense to introduce a more general mechanism for
toggling subfields in proc files.  Extended attributes could probably be
abused to key the subfields, write a 1 or 0 to well-known names for
toggling them on a per-fd basis via fsetxattr.

For this particular case the program would just have to add code like:

int	zero = 0;
fsetxattr(proc_stat_fd, "intr", &zero, sizeof(zero), XATTR_REPLACE);

Just putting it out there.  I've certainly wanted an ability to noop
fields before where I was polling proc frequently and skipping the bulk
of what was there but syscpu was still rather high.

I'm definitely not in favor of just adding another stat file that is the
same format as the existing one with the intrs zeroed out.  It's a dirty
hack; fine for your local needs but too gross for upstream IMHO.

Regards,
Vito Caputo
