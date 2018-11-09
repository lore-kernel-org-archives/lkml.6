Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A53DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D71220855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D71220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeKITgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:36:02 -0500
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:53249 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727532AbeKITgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:36:02 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 5CBDB1C2F5C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Nov 2018 09:56:11 +0000 (GMT)
Received: (qmail 11997 invoked from network); 9 Nov 2018 09:56:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.69])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Nov 2018 09:56:11 -0000
Date:   Fri, 9 Nov 2018 09:56:09 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Kyungtae Kim <kt0755@gmail.com>, akpm@linux-foundation.org,
        pavel.tatashin@microsoft.com, vbabka@suse.cz, osalvador@suse.de,
        rppt@linux.vnet.ibm.com, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, alexander.h.duyck@linux.intel.com,
        lifeasageek@gmail.com, threeearcat@gmail.com,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: UBSAN: Undefined behaviour in mm/page_alloc.c
Message-ID: <20181109095609.GC23260@techsingularity.net>
References: <CAEAjamseRRHu+TaTkd1TwpLNm8mtDGP=2K0WKLF0wH-3iLcW_w@mail.gmail.com>
 <20181109084353.GA5321@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181109084353.GA5321@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 09:43:53AM +0100, Michal Hocko wrote:
> On Thu 08-11-18 23:09:23, Kyungtae Kim wrote:
> > We report a bug in v4.19-rc2 (4.20-rc1 as well, I guess):
> > 
> > kernel config: https://kt0755.github.io/etc/config_v2-4.19
> > repro: https://kt0755.github.io/etc/repro.c4074.c
> > 
> > In the middle of page request, this arose because order is too large to handle
> >  (mm/page_alloc.c:3119). It actually comes from that order is
> > controllable by user input
> > via raw_cmd_ioctl without its sanity check, thereby causing memory problem.
> > To stop it, we can use like MAX_ORDER for bounds check before using it.
> 
> Yes, we do only check the max order in the slow path. We have already
> discussed something similar with Konstantin [1][2]. Basically kvmalloc
> for a large size might get to the page allocator with an out of bound
> order and warn during direct reclaim.
> 
> I am wondering whether really want to check for the order in the fast
> path instead. I have hard time to imagine this could cause a measurable
> impact.
> 
> The full patch is below
> 
> [1] http://lkml.kernel.org/r/154109387197.925352.10499549042420271600.stgit@buzz
> [2] http://lkml.kernel.org/r/154106356066.887821.4649178319705436373.stgit@buzz
> 

I'm ok with such changes under the policy "there is no point being fast if
we're broken". It's unfortunate and I know the original microoptimisation
was mine but if the fast-path check ends up being a problem then I/we go
back to finding ways of making the page allocator faster from a fundamental
algorithmic point of view and not a microoptimisation approach. There is
potential fruit there, just none that is low-hanging.

-- 
Mel Gorman
SUSE Labs
