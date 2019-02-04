Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D9DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5E320815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfBDL1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:27:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfBDL1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:27:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56D052D2BD3;
        Mon,  4 Feb 2019 11:27:42 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9726E809EA;
        Mon,  4 Feb 2019 11:27:36 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x14BRark000838;
        Mon, 4 Feb 2019 06:27:36 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x14BRYfJ000829;
        Mon, 4 Feb 2019 06:27:34 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 4 Feb 2019 06:27:34 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Huaisheng Ye <yehs2007@zoho.com>
cc:     snitzer@redhat.com, agk@redhat.com, dan.j.williams@intel.com,
        hch@lst.de, jack@suse.cz, corbet@lwn.net, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-doc@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [PATCH v3 0/5] Optimize writecache when using pmem as cache
In-Reply-To: <20190131022955.9920-1-yehs2007@zoho.com>
Message-ID: <alpine.LRH.2.02.1902040606380.28217@file01.intranet.prod.int.rdu2.redhat.com>
References: <20190131022955.9920-1-yehs2007@zoho.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 04 Feb 2019 11:27:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Jan 2019, Huaisheng Ye wrote:

> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> This patch set could be used for dm-writecache when use persistent
> memory as cache data device.
> 
> Patch 1 and 2 go towards removing unused parameter and codes which
> actually doesn't really work.

I agree that there is some unused variables and code, but I would let it 
be as it is. The processors can write data to persistent memory either by 
using non-temporal stores (the movnti instruction) or by normal stores 
followed by the clwb instruction.

Currently, the movnti instruction is faster - however, it may be possible 
that with some newer processors, the clwb instruction could be faster - 
and in that case, we need the code that you have removed.

I would like to keep both flush strategies around (movnti and clwb), so 
that we can test how do they perform on various processors. 
Unfortunatelly, some upstream developers hate code with #ifdefs :-(

Note that compiler optimizations already remove the unused parameter and 
the impossible code behind "if (WC_MODE_PMEM(wc)) if (!WC_MODE_PMEM(wc))".

> Patch 3 and 4 are targeted at solving problem fn ctr failed to work
> due to invalid magic or version, which is caused by the super block
> of pmem has messy data stored.

LVM zeros the beginning of new logical volumes, so there should be no 
problem with it. If the user wants to use the writecache target without 
LVM, he should zero the superblock with dd if=/dev/zero of=/dev/pmem0 
bs=4k count=1

Note that other device mapper targets also follow this policy - for 
example see drivers/md/dm-snap-persistent.c:
        if (le32_to_cpu(dh->magic) == 0) {
                *new_snapshot = 1;
                return 0;
        }

        if (le32_to_cpu(dh->magic) != SNAP_MAGIC) {
                DMWARN("Invalid or corrupt snapshot");
                r = -ENXIO;
                goto bad;
        }

So, I think there is no need for these patches - dm-writecache just does 
what others targets do.

> Patch 5 is used for getting the status of seq_count.

It may be accepted if other LVM team members find some use for this value.

Mikulas

> Changes Since v2: 
>         - seq_count is important for flush operations, output it within status
>           for debugging and analyzing code behavior.
> 	[1]: https://lkml.org/lkml/2019/1/3/43
>         [2]: https://lkml.org/lkml/2019/1/9/6
> 
> Huaisheng Ye (5):
>   dm-writecache: remove unused size to writecache_flush_region
>   dm-writecache: get rid of memory_data flush to writecache_flush_entry
>   dm-writecache: expand pmem_reinit for struct dm_writecache
>   Documentation/device-mapper: add optional parameter reinit
>   dm-writecache: output seq_count within status
> 
>  Documentation/device-mapper/writecache.txt |  4 ++++
>  drivers/md/dm-writecache.c                 | 23 +++++++++++++----------
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 
> -- 
> 1.8.3.1
> 
> 
