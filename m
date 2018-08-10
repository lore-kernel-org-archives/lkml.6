Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5A3C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07D2223A6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07D2223A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeHJDcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 23:32:46 -0400
Received: from fieldses.org ([173.255.197.46]:49516 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbeHJDcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 23:32:46 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 0945F1E3D; Thu,  9 Aug 2018 21:05:19 -0400 (EDT)
Date:   Thu, 9 Aug 2018 21:05:19 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Wilck <mwilck@suse.de>
Subject: Re: [PATCH 0/4] locks: avoid thundering-herd wake-ups
Message-ID: <20180810010519.GD3915@fieldses.org>
References: <153369219467.12605.13472423449508444601.stgit@noble>
 <20180808195445.GD23873@fieldses.org>
 <20180808200912.GE23873@fieldses.org>
 <20180808212832.GF23873@fieldses.org>
 <04ffa27c29d2bff8bd9cb9b6d4ea6b6fd3969b6c.camel@kernel.org>
 <20180809130001.GG23873@fieldses.org>
 <877ekzrt60.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ekzrt60.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 09:56:07AM +1000, NeilBrown wrote:
> On Thu, Aug 09 2018, J. Bruce Fields wrote:
> > If we only cared about the former, and only in simple cases, we could
> > walk the entire list and skip waking up only the locks that conflict
> > with the first one we wake.  We wouldn't need the tree.
> 
> Yes, we could do that. It would probably make the code simpler.
> It would mean doing the conflicts() tests when performing wake-up rather
> than prior to going to sleep.  In general it would mean doing the tests
> more often, as the tree effectively records the results of the previous
> time conflicts() was run.
> You might get a quadratic effect though ... wouldn't you want to
> skip anything that conflicts with anything that has been woken?

I was thinking it'd be simplest just to check for conflict with the
first thing that you decide to wake.  That might be all that's necessary
for typical cases.

If you wanted to keep a running list of the locks you've chosen to wake
so far and check each one against that list, I guess you could.

> If the tree-management code turns out to be too complex, it would
> certainly be an option.  I think the tree approach should result in less
> total CPU usage..

Have we ever looked into the CPU usage of deadlock detection?  Might
experiment with turning that off.  But I may be biased by my white-hot
hatred of it.

--b.
