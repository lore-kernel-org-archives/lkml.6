Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7F8C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E77B21C69
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E77B21C69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030623AbeF1TD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:03:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:40604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968041AbeF1TDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:03:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DDF2BAD65;
        Thu, 28 Jun 2018 19:03:51 +0000 (UTC)
Date:   Thu, 28 Jun 2018 12:30:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ufo19890607@gmail.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhoujian@didichuxing.com
Subject: Re: [PATCH v10 2/2] Refactor part of the oom report in dump_header
Message-ID: <20180628103002.GZ32348@dhcp22.suse.cz>
References: <1529763171-29240-1-git-send-email-ufo19890607@gmail.com>
 <1529763171-29240-2-git-send-email-ufo19890607@gmail.com>
 <20180627191041.509893a3b43f95a27df32266@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627191041.509893a3b43f95a27df32266@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-06-18 19:10:41, Andrew Morton wrote:
> On Sat, 23 Jun 2018 22:12:51 +0800 ufo19890607@gmail.com wrote:
> 
> > From: yuzhoujian <yuzhoujian@didichuxing.com>
> > 
> > The current system wide oom report prints information about the victim
> > and the allocation context and restrictions. It, however, doesn't
> > provide any information about memory cgroup the victim belongs to. This
> > information can be interesting for container users because they can find
> > the victim's container much more easily.
> > 
> > I follow the advices of David Rientjes and Michal Hocko, and refactor
> > part of the oom report. After this patch, users can get the memcg's
> > path from the oom report and check the certain container more quickly.
> > 
> > The oom print info after this patch:
> > oom-kill:constraint=<constraint>,nodemask=<nodemask>,oom_memcg=<memcg>,task_memcg=<memcg>,task=<commm>,pid=<pid>,uid=<uid>
> > 
> > Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> > ---
> > Below is the part of the oom report in the dmesg
> > ...
> > [  134.873392] panic invoked oom-killer: gfp_mask=0x6280ca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), nodemask=(null), order=0, oom_score_adj=0
> >
> > ...
> >
> > [  134.873480] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),task_memcg=/test/test1/test2,task=panic,pid= 8669,  uid=    0
> 
> We're displaying nodemask twice there.  Avoidable?
> 
> Also, the spaces after pid= and uid= don't seem useful.  Why not use
> plain old %d?

I've been discussing this with yuzhoujian off-list so please drop the
current pile
-- 
Michal Hocko
SUSE Labs
