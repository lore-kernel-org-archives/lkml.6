Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E60C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2527F2082D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2527F2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeLFIk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:40:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:46484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727832AbeLFIkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:40:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EBDCAADE6;
        Thu,  6 Dec 2018 08:40:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Dec 2018 09:40:23 +0100
From:   osalvador@suse.de
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Oscar Salvador <OSalvador@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@gmail.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>, owner-linux-mm@kvack.org
Subject: Re: [RFC PATCH] hwpoison, memory_hotplug: allow hwpoisoned pages to
 be offlined
In-Reply-To: <20181206083206.GC1286@dhcp22.suse.cz>
References: <20181203100309.14784-1-mhocko@kernel.org>
 <20181205122918.GL1286@dhcp22.suse.cz>
 <20181205165716.GS1286@dhcp22.suse.cz>
 <20181206052137.GA28595@hori1.linux.bs1.fc.nec.co.jp>
 <20181206083206.GC1286@dhcp22.suse.cz>
Message-ID: <ec66e12d8140ba117a0e98c37f6557bd@suse.de>
X-Sender: osalvador@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> This commit adds shake_page() for mlocked pages to make sure that the 
>> target
>> page is flushed out from LRU cache. Without this shake_page(), 
>> subsequent
>> delete_from_lru_cache() (from me_pagecache_clean()) fails to isolate 
>> it and
>> the page will finally return back to LRU list.  So this scenario leads 
>> to
>> "hwpoisoned by still linked to LRU list" page.
> 
> OK, I see. So does that mean that the LRU handling is no longer needed
> and there is a guanratee that all kernels with the above commit cannot
> ever get an LRU page?

For the sake of completeness:

I made a quick test reverting 286c469a988 on upstream kernel.
As expected, the poisoned page is in LRU when it hits do_migrate_range,
and so, the migration path is taken and I see the exact failure I saw 
on. 4.4


Oscar Salvador
---
Suse L3



