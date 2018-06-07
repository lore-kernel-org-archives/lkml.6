Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /1y1AqYLGVv2ZgAAmS7hNA
	; Thu, 07 Jun 2018 10:43:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0E88F608B8; Thu,  7 Jun 2018 10:43:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 774C4607DC;
	Thu,  7 Jun 2018 10:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 774C4607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932401AbeFGKnC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:43:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46349 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752669AbeFGKnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:43:01 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BEAA8763D251;
        Thu,  7 Jun 2018 18:42:57 +0800 (CST)
Received: from localhost (10.206.48.115) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.382.0; Thu, 7 Jun 2018
 18:42:55 +0800
Date: Thu, 7 Jun 2018 11:42:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <osalvador@techadventures.net>, <linux-kernel@vger.kernel.org>
CC: <akpm@linux-foundation.org>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <pasha.tatashin@oracle.com>, <linux-mm@kvack.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 0/4] Small cleanup for memoryhotplug
Message-ID: <20180607114245.00001068@huawei.com>
In-Reply-To: <20180601125321.30652-1-osalvador@techadventures.net>
References: <20180601125321.30652-1-osalvador@techadventures.net>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.206.48.115]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2018 14:53:17 +0200
<osalvador@techadventures.net> wrote:

> From: Oscar Salvador <osalvador@suse.de>
> 
> 
> Hi,
> 
> I wanted to give it a try and do a small cleanup in the memhotplug's code.
> A lot more could be done, but I wanted to start somewhere.
> I tried to unify/remove duplicated code.
> 
> The following is what this patchset does:
> 
> 1) add_memory_resource() has code to allocate a node in case it was offline.
>    Since try_online_node has some code for that as well, I just made add_memory_resource() to
>    use that so we can remove duplicated code..
>    This is better explained in patch 1/4.
> 
> 2) register_mem_sect_under_node() will be called only from link_mem_sections()
> 
> 3) Get rid of link_mem_sections() in favour of walk_memory_range() with a callback to
>    register_mem_sect_under_node()
> 
> 4) Drop unnecessary checks from register_mem_sect_under_node()
> 
> 
> I have done some tests and I could not see anything broken because of 
> this patchset.
Works fine with the patch set for arm64 I'm intermittently working on.
Or at least I don't need to make any additional changes on top of what I currently
have!

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan
> 
> Oscar Salvador (4):
>   mm/memory_hotplug: Make add_memory_resource use __try_online_node
>   mm/memory_hotplug: Call register_mem_sect_under_node
>   mm/memory_hotplug: Get rid of link_mem_sections
>   mm/memory_hotplug: Drop unnecessary checks from
>     register_mem_sect_under_node
> 
>  drivers/base/memory.c |   2 -
>  drivers/base/node.c   |  52 +++++---------------------
>  include/linux/node.h  |  21 +++++------
>  mm/memory_hotplug.c   | 101 ++++++++++++++++++++++++++------------------------
>  4 files changed, 71 insertions(+), 105 deletions(-)
> 
