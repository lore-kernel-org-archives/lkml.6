Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE09C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95C124072
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95C124072
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeGDODL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:03:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:33996 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751761AbeGDODJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:03:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B89DAE9A;
        Wed,  4 Jul 2018 14:03:07 +0000 (UTC)
Date:   Wed, 4 Jul 2018 16:03:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, mgorman@techsingularity.net,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        dchinner@redhat.com, akpm@linux-foundation.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: ext4: use BUG_ON if writepage call comes from
 direct reclaim
Message-ID: <20180704140306.GB22669@dhcp22.suse.cz>
References: <1530591079-33813-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180703103948.GB27426@thunk.org>
 <6c305241-d502-b8ea-a187-54c33e4ca692@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c305241-d502-b8ea-a187-54c33e4ca692@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-07-18 10:05:04, Yang Shi wrote:
> 
> 
> On 7/3/18 3:39 AM, Theodore Y. Ts'o wrote:
> > On Tue, Jul 03, 2018 at 12:11:18PM +0800, Yang Shi wrote:
> > > direct reclaim doesn't write out filesystem page, only kswapd could do
> > > it. So, if the call comes from direct reclaim, it is definitely a bug.
> > > 
> > > And, Mel Gormane also mentioned "Ultimately, this will be a BUG_ON." In
> > > commit 94054fa3fca1fd78db02cb3d68d5627120f0a1d4 ("xfs: warn if direct
> > > reclaim tries to writeback pages").
> > > 
> > > Although it is for xfs, ext4 has the similar behavior, so elevate
> > > WARN_ON to BUG_ON.
> > > 
> > > And, correct the comment accordingly.
> > > 
> > > Cc: Mel Gorman <mgorman@techsingularity.net>
> > > Cc: "Theodore Ts'o" <tytso@mit.edu>
> > > Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> > > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > What's the upside of crashing the kernel if the file sytsem can handle it?
> 
> I'm not sure if it is a good choice to let filesystem handle such vital VM
> regression. IMHO, writing out filesystem page from direct reclaim context is
> a vital VM bug. It means something is definitely wrong in VM. It should
> never happen.

Could you be more specific about the vital part please? Issuing
writeback from the direct reclaim surely can be sub-optimal. But since
we have quite a large stacks it shouldn't overflow immediately even for
more complex storage setups. So what is the _vital_ bug here?
-- 
Michal Hocko
SUSE Labs
