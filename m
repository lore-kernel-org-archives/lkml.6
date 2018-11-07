Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980F5C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBC220827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBC220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeKGSx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:53:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:46690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbeKGSx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:53:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B99CACC6;
        Wed,  7 Nov 2018 09:23:55 +0000 (UTC)
Date:   Wed, 7 Nov 2018 10:23:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Arun KS <arunks@codeaurora.org>, akpm@linux-foundation.org,
        keescook@chromium.org, khlebnikov@yandex-team.ru,
        minchan@kernel.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        getarunks@gmail.com
Subject: Re: [PATCH v2 1/4] mm: Fix multiple evaluvations of totalram_pages
 and managed_pages
Message-ID: <20181107092354.GZ27423@dhcp22.suse.cz>
References: <1541521310-28739-1-git-send-email-arunks@codeaurora.org>
 <1541521310-28739-2-git-send-email-arunks@codeaurora.org>
 <20181107082037.GX27423@dhcp22.suse.cz>
 <c2862bb0-ced1-add1-c816-21c0d4e76bbe@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2862bb0-ced1-add1-c816-21c0d4e76bbe@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-11-18 09:44:00, Vlastimil Babka wrote:
> On 11/7/18 9:20 AM, Michal Hocko wrote:
> > On Tue 06-11-18 21:51:47, Arun KS wrote:
> 
> Hi,
> 
> there's typo in subject: evaluvations -> evaluations.
> 
> However, "fix" is also misleading (more below), so I'd suggest something
> like:
> 
> mm: reference totalram_pages and managed_pages once per function
> 
> >> This patch is in preparation to a later patch which converts totalram_pages
> >> and zone->managed_pages to atomic variables. This patch does not introduce
> >> any functional changes.
> > 
> > I forgot to comment on this one. The patch makes a lot of sense. But I
> > would be little bit more conservative and won't claim "no functional
> > changes". As things stand now multiple reads in the same function are
> > racy (without holding the lock). I do not see any example of an
> > obviously harmful case but claiming the above is too strong of a
> > statement. I would simply go with something like "Please note that
> > re-reading the value might lead to a different value and as such it
> > could lead to unexpected behavior. There are no known bugs as a result
> > of the current code but it is better to prevent from them in principle."
> 
> However, the new code doesn't use READ_ONCE(), so the compiler is free
> to read the value multiple times, and before the patch it was free to
> read it just once, as the variables are not volatile. So strictly
> speaking this is indeed not a functional change (if compiler decides
> differently based on the patch, it's an implementation detail).

Yes, compiler is allowed to optimize this either way without READ_ONCE
but it is allowed to do two reads so claiming no functional change is a
bit problematic. Not that this would be a reason to discuss this in
length...
-- 
Michal Hocko
SUSE Labs
