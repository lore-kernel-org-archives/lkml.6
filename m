Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056A0C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51452082E
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51452082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbeKEJhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 04:37:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387412AbeKEJhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 04:37:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 920193D15;
        Mon,  5 Nov 2018 00:20:13 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C18756596B;
        Mon,  5 Nov 2018 00:20:12 +0000 (UTC)
Date:   Mon, 5 Nov 2018 08:20:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH] mm, memory_hotplug: teach has_unmovable_pages about of
 LRU migrateable pages
Message-ID: <20181105002009.GF27491@MiWiFi-R3L-srv>
References: <20181101091055.GA15166@MiWiFi-R3L-srv>
 <20181102155528.20358-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102155528.20358-1-mhocko@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 05 Nov 2018 00:20:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 11/02/18 at 04:55pm, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Baoquan He has noticed that 15c30bc09085  ("mm, memory_hotplug: make
> has_unmovable_pages more robust") is causing memory offlining failures
> on a movable node. After a further debugging it turned out that
> has_unmovable_pages fails prematurely because it stumbles over off-LRU
> pages. Nevertheless those pages are not on LRU because they are waiting
> on the pcp LRU caches (an example of __dump_page added by a debugging
> patch)
> [  560.923297] page:ffffea043f39fa80 count:1 mapcount:0 mapping:ffff880e5dce1b59 index:0x7f6eec459
> [  560.931967] flags: 0x5fffffc0080024(uptodate|active|swapbacked)
> [  560.937867] raw: 005fffffc0080024 dead000000000100 dead000000000200 ffff880e5dce1b59
> [  560.945606] raw: 00000007f6eec459 0000000000000000 00000001ffffffff ffff880e43ae8000
> [  560.953323] page dumped because: hotplug
> [  560.957238] page->mem_cgroup:ffff880e43ae8000
> [  560.961620] has_unmovable_pages: pfn:0x10fd030d, found:0x1, count:0x0
> [  560.968127] page:ffffea043f40c340 count:2 mapcount:0 mapping:ffff880e2f2d8628 index:0x0
> [  560.976104] flags: 0x5fffffc0000006(referenced|uptodate)
> [  560.981401] raw: 005fffffc0000006 dead000000000100 dead000000000200 ffff880e2f2d8628
> [  560.989119] raw: 0000000000000000 0000000000000000 00000002ffffffff ffff88010a8f5000
> [  560.996833] page dumped because: hotplug

Sorry, last week I didn't test this patch with memory pressure adding.
Today use "stress -m 200 -t 2h" to add pressure, hot removing failed.
Will send you output log. W/o memory pressure, it sometimes succeed. I
saw one failure last night, it still show un-removable as 0 in
hotpluggable node one time, I worried it might be caused by my compiling
mistake, so compile and try again this morning.

Thanks
Baoquan
