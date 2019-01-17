Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191AFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA4220855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfAQKnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:43:43 -0500
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:50748 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725990AbfAQKnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:43:43 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id D0AFC1C2704
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 10:43:40 +0000 (GMT)
Received: (qmail 12279 invoked from network); 17 Jan 2019 10:43:40 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jan 2019 10:43:40 -0000
Date:   Thu, 17 Jan 2019 10:43:38 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     syzbot <syzbot+80dd4798c16c634daf15@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/page_alloc.c:LINE!
Message-ID: <20190117104338.GH27437@techsingularity.net>
References: <000000000000cdc61b057f9e360e@google.com>
 <e4cb6380-b462-857e-3219-319fdbfa6f81@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <e4cb6380-b462-857e-3219-319fdbfa6f81@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 09:33:09AM +0100, Vlastimil Babka wrote:
> > Code: 4c 39 e3 77 c0 0f b6 8d 74 ff ff ff b8 01 00 00 00 48 d3 e0 e9 11 fd  
> > ff ff 48 c7 c6 a0 63 52 88 4c 89 e7 e8 6a 14 10 00 0f 0b <0f> 0b 48 c7 c6  
> > c0 64 52 88 4c 89 e7 e8 57 14 10 00 0f 0b 48 89 cf
> > RSP: 0000:ffff8880a78e6f58 EFLAGS: 00010007
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88812fffc7e0
> > RDX: 1ffff11025fff8fc RSI: 0000000000000007 RDI: ffff88812fffc7b0
> > RBP: ffff8880a78e7018 R08: ffff8880a78ce000 R09: ffffed1014f1cdf2
> > R10: ffffed1014f1cdf1 R11: 0000000000000003 R12: ffff88812fffc7b0
> > R13: 1ffff11014f1cdf2 R14: ffff88812fffc7b0 R15: ffff8880a78e6ff0
> > FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000438ca0 CR3: 0000000009871000 CR4: 00000000001426f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> > Call Trace:
> >   fast_isolate_freepages mm/compaction.c:1356 [inline]
> 
> Mel's new code... but might be just a victim of e.g. bad struct page
> initialization?
> 

The error looks like compaction found a !PageBuddy on the free lists
while the zone lock was held. That seems bad no matter what. I expect
there will be a respin of the entire series relatively soon but none of
the fixes so far would be for that level of damage.

-- 
Mel Gorman
SUSE Labs
