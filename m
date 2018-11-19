Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC11C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7A9223CB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7A9223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405573AbeKTDZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:25:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:40912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404694AbeKTDZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:25:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ECCD4AE99;
        Mon, 19 Nov 2018 17:01:06 +0000 (UTC)
Date:   Mon, 19 Nov 2018 18:01:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Baoquan He <bhe@redhat.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, pifang@redhat.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        aarcange@redhat.com, Mel Gorman <mgorman@suse.de>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Memory hotplug softlock issue
Message-ID: <20181119170105.GT22247@dhcp22.suse.cz>
References: <20181116012433.GU2653@MiWiFi-R3L-srv>
 <20181116091409.GD14706@dhcp22.suse.cz>
 <20181119105202.GE18471@MiWiFi-R3L-srv>
 <20181119124033.GJ22247@dhcp22.suse.cz>
 <20181119125121.GK22247@dhcp22.suse.cz>
 <20181119141016.GO22247@dhcp22.suse.cz>
 <eb979e1e-e0fc-b1a3-b6cc-70b503a74a20@suse.cz>
 <20181119164618.GQ22247@dhcp22.suse.cz>
 <c7c20cc5-c2a4-ce61-3d97-56c8acfb13ec@suse.cz>
 <6017b36f-3e29-c2ad-f2d1-2ebd77bbaef1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6017b36f-3e29-c2ad-f2d1-2ebd77bbaef1@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 19-11-18 17:48:35, Vlastimil Babka wrote:
> On 11/19/18 5:46 PM, Vlastimil Babka wrote:
> > On 11/19/18 5:46 PM, Michal Hocko wrote:
> >> On Mon 19-11-18 17:36:21, Vlastimil Babka wrote:
> >>>
> >>> So what protects us from locking a page whose refcount dropped to zero?
> >>> and is being freed? The checks in freeing path won't be happy about a
> >>> stray lock.
> >>
> >> Nothing really prevents that. But does it matter. The worst that might
> >> happen is that we lock a freed or reused page. Who would complain?
> > 
> > free_pages_check() for example
> > 
> > PAGE_FLAGS_CHECK_AT_FREE includes PG_locked

Right you are.

> And besides... what about the last page being offlined and then the
> whole struct page's part of vmemmap destroyed as the node goes away?

Yeah, that is quite unlikely though because the there is quite a large
time window between the two events. I am not entirely sure we are safe
right now TBH. Any access to the struct page after the put_page is
unsafe theoretically.

Then we have to come up with something more clever I am afraid.

-- 
Michal Hocko
SUSE Labs
