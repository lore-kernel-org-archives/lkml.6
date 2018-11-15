Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996EFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642522089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642522089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbeKOSAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:00:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbeKOSAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:00:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B31A58E41;
        Thu, 15 Nov 2018 07:54:01 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6D835D9CA;
        Thu, 15 Nov 2018 07:53:58 +0000 (UTC)
Date:   Thu, 15 Nov 2018 15:53:56 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        aarcange@redhat.com
Subject: Re: Memory hotplug softlock issue
Message-ID: <20181115075349.GL2653@MiWiFi-R3L-srv>
References: <20181114070909.GB2653@MiWiFi-R3L-srv>
 <5a6c6d6b-ebcd-8bfa-d6e0-4312bfe86586@redhat.com>
 <20181114090134.GG23419@dhcp22.suse.cz>
 <20181114145250.GE2653@MiWiFi-R3L-srv>
 <20181114150029.GY23419@dhcp22.suse.cz>
 <20181115051034.GK2653@MiWiFi-R3L-srv>
 <20181115073052.GA23831@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115073052.GA23831@dhcp22.suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 15 Nov 2018 07:54:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 at 08:30am, Michal Hocko wrote:
> On Thu 15-11-18 13:10:34, Baoquan He wrote:
> > On 11/14/18 at 04:00pm, Michal Hocko wrote:
> > > On Wed 14-11-18 22:52:50, Baoquan He wrote:
> > > > On 11/14/18 at 10:01am, Michal Hocko wrote:
> > > > > I have seen an issue when the migration cannot make a forward progress
> > > > > because of a glibc page with a reference count bumping up and down. Most
> > > > > probable explanation is the faultaround code. I am working on this and
> > > > > will post a patch soon. In any case the migration should converge and if
> > > > > it doesn't do then there is a bug lurking somewhere.
> > > > > 
> > > > > Failing on ENOMEM is a questionable thing. I haven't seen that happening
> > > > > wildly but if it is a case then I wouldn't be opposed.
> > > > 
> > > > Applied your debugging patches, it helps a lot to printing message.
> > > > 
> > > > Below is the dmesg log about the migrating failure. It can't pass
> > > > migrate_pages() and loop forever.
> > > > 
> > > > [  +0.083841] migrating pfn 10fff7d0 failed 
> > > > [  +0.000005] page:ffffea043ffdf400 count:208 mapcount:201 mapping:ffff888dff4bdda8 index:0x2
> > > > [  +0.012689] xfs_address_space_operations [xfs] 
> > > > [  +0.000030] name:"stress" 
> > > > [  +0.004556] flags: 0x5fffffc0000004(uptodate)
> > > > [  +0.007339] raw: 005fffffc0000004 ffffc900000e3d80 ffffc900000e3d80 ffff888dff4bdda8
> > > > [  +0.009488] raw: 0000000000000002 0000000000000000 000000cb000000c8 ffff888e7353d000
> > > > [  +0.007726] page->mem_cgroup:ffff888e7353d000
> > > > [  +0.084538] migrating pfn 10fff7d0 failed 
> > > > [  +0.000006] page:ffffea043ffdf400 count:210 mapcount:201 mapping:ffff888dff4bdda8 index:0x2
> > > > [  +0.012798] xfs_address_space_operations [xfs] 
> > > > [  +0.000034] name:"stress" 
> > > > [  +0.004524] flags: 0x5fffffc0000004(uptodate)
> > > > [  +0.007068] raw: 005fffffc0000004 ffffc900000e3d80 ffffc900000e3d80 ffff888dff4bdda8
> > > > [  +0.009359] raw: 0000000000000002 0000000000000000 000000cb000000c8 ffff888e7353d000
> > > > [  +0.007728] page->mem_cgroup:ffff888e7353d000
> > > 
> > > I wouldn't be surprised if this was a similar/same issue I've been
> > > chasing recently. Could you try to disable faultaround to see if that
> > > helps. It seems that it helped in my particular case but I am still
> > > waiting for the final good-to-go to post the patch as I do not own the
> > > workload which triggered that issue.
> > 
> > Tried, still stuck in last block sometime. Usually after several times
> > of hotplug/unplug. If stop stress program, the last block will be
> > offlined immediately.
> 
> Is the pattern still the same? I mean failing over few pages with
> reference count jumping up and down between attempts?

->count jumping up and down, mapcount stays the same value.

> 
> > [root@ ~]# cat /sys/kernel/debug/fault_around_bytes 
> > 4096
> 
> Can you make it 0?

I executed 'echo 0 > fault_around_bytes', value less than one page size
will round up to one page.

/*
 * fault_around_bytes must be rounded down to the nearest page order as it's
 * what do_fault_around() expects to see.
 */
static int fault_around_bytes_set(void *data, u64 val)
{
        if (val / PAGE_SIZE > PTRS_PER_PTE)
                return -EINVAL;
        if (val > PAGE_SIZE)
                fault_around_bytes = rounddown_pow_of_two(val);
        else
                fault_around_bytes = PAGE_SIZE; /* rounddown_pow_of_two(0) is undefined */
        return 0;
}

