Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F04BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B250222419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B250222419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbeKNUDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:03:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:40818 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727558AbeKNUDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:03:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 112F1AF17;
        Wed, 14 Nov 2018 10:00:59 +0000 (UTC)
Date:   Wed, 14 Nov 2018 11:00:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aarcange@redhat.com, david@redhat.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Memory hotplug softlock issue
Message-ID: <20181114100058.GK23419@dhcp22.suse.cz>
References: <20181114070909.GB2653@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114070909.GB2653@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Vladimir]

On Wed 14-11-18 15:09:09, Baoquan He wrote:
> Hi,
> 
> Tested memory hotplug on a bare metal system, hot removing always
> trigger a lock. Usually need hot plug/unplug several times, then the hot
> removing will hang there at the last block. Surely with memory pressure
> added by executing "stress -m 200".
> 
> Will attach the log partly. Any idea or suggestion, appreciated. 
> 
[...]
> [  +0.007169]       Not tainted 4.20.0-rc2+ #4
> [  +0.004630] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  +0.008001] kworker/181:1   D    0  1187      2 0x80000000
> [  +0.005711] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
> [  +0.006467] Call Trace:
> [  +0.002591]  ? __schedule+0x24e/0x880
> [  +0.004995]  schedule+0x28/0x80
> [  +0.003380]  rwsem_down_read_failed+0x103/0x190
> [  +0.006528]  call_rwsem_down_read_failed+0x14/0x30
> [  +0.004937]  __percpu_down_read+0x4f/0x80
> [  +0.004204]  get_online_mems+0x2d/0x30
> [  +0.003871]  memcg_create_kmem_cache+0x1b/0x120
> [  +0.004740]  memcg_kmem_cache_create_func+0x1b/0x60
> [  +0.004986]  process_one_work+0x1a1/0x3a0
> [  +0.004255]  worker_thread+0x30/0x380
> [  +0.003764]  ? drain_workqueue+0x120/0x120
> [  +0.004238]  kthread+0x112/0x130
> [  +0.003320]  ? kthread_park+0x80/0x80
> [  +0.003796]  ret_from_fork+0x35/0x40

For a quick context. We do hold the exclusive mem hotplug lock
throughout the whole offlining and that can take quite some time.
So I am wondering whether we absolutely have to take the shared lock
in this path (introduced by 03afc0e25f7f ("slab: get_online_mems for
kmem_cache_{create,destroy,shrink}")). Is there any way to relax this
requirement? E.g. nodes stay around even when they are completely
offline. Does that help?
-- 
Michal Hocko
SUSE Labs
