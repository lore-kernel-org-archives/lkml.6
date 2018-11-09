Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3542C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939C120827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939C120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeKIUJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:09:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:56084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727537AbeKIUJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:09:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C86ACAE11;
        Fri,  9 Nov 2018 10:29:00 +0000 (UTC)
Date:   Fri, 9 Nov 2018 11:28:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Kyungtae Kim <kt0755@gmail.com>,
        akpm@linux-foundation.org, pavel.tatashin@microsoft.com,
        osalvador@suse.de, rppt@linux.vnet.ibm.com, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, alexander.h.duyck@linux.intel.com,
        mgorman@techsingularity.net, lifeasageek@gmail.com,
        threeearcat@gmail.com, syzkaller@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: UBSAN: Undefined behaviour in mm/page_alloc.c
Message-ID: <20181109102855.GF5321@dhcp22.suse.cz>
References: <CAEAjamseRRHu+TaTkd1TwpLNm8mtDGP=2K0WKLF0wH-3iLcW_w@mail.gmail.com>
 <20181109084353.GA5321@dhcp22.suse.cz>
 <b51aae15-eb5d-47f0-1222-bfc1ef21e06c@I-love.SAKURA.ne.jp>
 <20181109095604.GC5321@dhcp22.suse.cz>
 <d8757554-45f4-1240-dc8a-0f918ae0e5f3@suse.cz>
 <9e17d033-b2ab-3edb-ae0b-90d4f713e55b@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e17d033-b2ab-3edb-ae0b-90d4f713e55b@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-11-18 19:24:48, Tetsuo Handa wrote:
> On 2018/11/09 19:10, Vlastimil Babka wrote:>>>> +	 * reclaim >= MAX_ORDER areas which will never succeed. Callers may
> >>>> +	 * be using allocators in order of preference for an area that is
> >>>> +	 * too large.
> >>>> +	 */
> >>>> +	if (order >= MAX_ORDER) {
> >>>
> >>> Also, why not to add BUG_ON(gfp_mask & __GFP_NOFAIL); here?
> >>
> >> Because we do not want to blow up the kernel just because of a stupid
> >> usage of the allocator. Can you think of an example where it would
> >> actually make any sense?
> >>
> >> I would argue that such a theoretical abuse would blow up on an
> >> unchecked NULL ptr access. Isn't that enough?
> > 
> > Agreed.
> > 
> 
> If someone has written a module with __GFP_NOFAIL for an architecture
> where PAGE_SIZE == 2048KB, and someone else tried to use that module on
> another architecture where PAGE_SIZE == 4KB. You are saying that
> triggering NULL pointer dereference is a fault of that user's ignorance
> about MM. You are saying that everyone knows internal of MM. Sad...

What kind of argument is this? Seriously! We do consider GFP_NOFAIL
problematic even for !order-0 requests and warn appropriately. Talking
about anything getting close to MAX_ORDER is just a crazy talk. In any
case this is largely tangential to the issue reported here.
-- 
Michal Hocko
SUSE Labs
