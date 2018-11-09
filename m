Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DA7C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E8E20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E8E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeKIUFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:05:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:55672 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727537AbeKIUFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:05:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CBB08AE11;
        Fri,  9 Nov 2018 10:25:36 +0000 (UTC)
Date:   Fri, 9 Nov 2018 11:25:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Kyungtae Kim <kt0755@gmail.com>, akpm@linux-foundation.org,
        pavel.tatashin@microsoft.com, vbabka@suse.cz, osalvador@suse.de,
        rppt@linux.vnet.ibm.com, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, alexander.h.duyck@linux.intel.com,
        mgorman@techsingularity.net, lifeasageek@gmail.com,
        threeearcat@gmail.com, syzkaller@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: UBSAN: Undefined behaviour in mm/page_alloc.c
Message-ID: <20181109102536.GE5321@dhcp22.suse.cz>
References: <CAEAjamseRRHu+TaTkd1TwpLNm8mtDGP=2K0WKLF0wH-3iLcW_w@mail.gmail.com>
 <20181109084353.GA5321@dhcp22.suse.cz>
 <b51aae15-eb5d-47f0-1222-bfc1ef21e06c@I-love.SAKURA.ne.jp>
 <20181109095604.GC5321@dhcp22.suse.cz>
 <a74e6a5d-d4c1-9006-60af-de52afafebb2@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a74e6a5d-d4c1-9006-60af-de52afafebb2@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-11-18 19:07:49, Tetsuo Handa wrote:
> On 2018/11/09 18:56, Michal Hocko wrote:
> > Does this following look better?
> 
> Yes.
> 
> >> Also, why not to add BUG_ON(gfp_mask & __GFP_NOFAIL); here?
> > 
> > Because we do not want to blow up the kernel just because of a stupid
> > usage of the allocator. Can you think of an example where it would
> > actually make any sense?
> > 
> > I would argue that such a theoretical abuse would blow up on an
> > unchecked NULL ptr access. Isn't that enough?
> 
> We after all can't avoid blowing up the kernel even if we don't add BUG_ON().
> Stopping with BUG_ON() is saner than NULL pointer dereference messages.

I disagree (strongly to be more explicit). You never know the context
the allocator is called from. We do not want to oops with a random state
(locks heled etc). If the access blows up in the user then be it, the
bug will be clear and to be fixed but BUG_ON on an invalid core kernel
function is just a bad idea. I believe Linus was quite explicit about it
and I fully agree with him.

Besides that this is really off-topic to the issue at hands. Don't you
think?
-- 
Michal Hocko
SUSE Labs
