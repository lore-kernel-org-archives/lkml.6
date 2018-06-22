Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FE1C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E1523F69
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E1523F69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeFVJJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:09:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:55002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbeFVJJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:09:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 88059AC17;
        Fri, 22 Jun 2018 09:09:36 +0000 (UTC)
Date:   Fri, 22 Jun 2018 11:09:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     jing xia <jing.xia.mail@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
Message-ID: <20180622090935.GT10465@dhcp22.suse.cz>
References: <alpine.LRH.2.02.1806141424510.30404@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615073201.GB24039@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806150724260.15022@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615115547.GH24039@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806150832100.26650@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615130925.GI24039@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806181003560.4201@file01.intranet.prod.int.rdu2.redhat.com>
 <20180619104312.GD13685@dhcp22.suse.cz>
 <alpine.LRH.2.02.1806191228110.25656@file01.intranet.prod.int.rdu2.redhat.com>
 <20180622090151.GS10465@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622090151.GS10465@dhcp22.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-06-18 11:01:51, Michal Hocko wrote:
> On Thu 21-06-18 21:17:24, Mikulas Patocka wrote:
[...]
> > What about this patch? If __GFP_NORETRY and __GFP_FS is not set (i.e. the 
> > request comes from a block device driver or a filesystem), we should not 
> > sleep.
> 
> Why? How are you going to audit all the callers that the behavior makes
> sense and moreover how are you going to ensure that future usage will
> still make sense. The more subtle side effects gfp flags have the harder
> they are to maintain.

So just as an excercise. Try to explain the above semantic to users. We
currently have the following.

 * __GFP_NORETRY: The VM implementation will try only very lightweight
 *   memory direct reclaim to get some memory under memory pressure (thus
 *   it can sleep). It will avoid disruptive actions like OOM killer. The
 *   caller must handle the failure which is quite likely to happen under
 *   heavy memory pressure. The flag is suitable when failure can easily be
 *   handled at small cost, such as reduced throughput

 * __GFP_FS can call down to the low-level FS. Clearing the flag avoids the
 *   allocator recursing into the filesystem which might already be holding
 *   locks.

So how are you going to explain gfp & (__GFP_NORETRY | ~__GFP_FS)? What
is the actual semantic without explaining the whole reclaim or force
users to look into the code to understand that? What about GFP_NOIO |
__GFP_NORETRY? What does it mean to that "should not sleep". Do all
shrinkers have to follow that as well?
-- 
Michal Hocko
SUSE Labs
