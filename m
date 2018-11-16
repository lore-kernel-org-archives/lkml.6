Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4C0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B852145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B852145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbeKPLe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 06:34:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeKPLe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 06:34:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17A11308428D;
        Fri, 16 Nov 2018 01:24:39 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CBD85ED47;
        Fri, 16 Nov 2018 01:24:36 +0000 (UTC)
Date:   Fri, 16 Nov 2018 09:24:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        pifang@redhat.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aarcange@redhat.com
Subject: Re: Memory hotplug softlock issue
Message-ID: <20181116012433.GU2653@MiWiFi-R3L-srv>
References: <20181114145250.GE2653@MiWiFi-R3L-srv>
 <20181114150029.GY23419@dhcp22.suse.cz>
 <20181115051034.GK2653@MiWiFi-R3L-srv>
 <20181115073052.GA23831@dhcp22.suse.cz>
 <20181115075349.GL2653@MiWiFi-R3L-srv>
 <20181115083055.GD23831@dhcp22.suse.cz>
 <20181115131211.GP2653@MiWiFi-R3L-srv>
 <20181115131927.GT23831@dhcp22.suse.cz>
 <20181115133840.GR2653@MiWiFi-R3L-srv>
 <20181115143204.GV23831@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115143204.GV23831@dhcp22.suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 16 Nov 2018 01:24:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 at 03:32pm, Michal Hocko wrote:
> On Thu 15-11-18 21:38:40, Baoquan He wrote:
> > On 11/15/18 at 02:19pm, Michal Hocko wrote:
> > > On Thu 15-11-18 21:12:11, Baoquan He wrote:
> > > > On 11/15/18 at 09:30am, Michal Hocko wrote:
> > > [...]
> > > > > It would be also good to find out whether this is fs specific. E.g. does
> > > > > it make any difference if you use a different one for your stress
> > > > > testing?
> > > > 
> > > > Created a ramdisk and put stress bin there, then run stress -m 200, now
> > > > seems it's stuck in libc-2.28.so migrating. And it's still xfs. So now xfs
> > > > is a big suspect. At bottom I paste numactl printing, you can see that it's
> > > > the last 4G.
> > > > 
> > > > Seems it's trying to migrate libc-2.28.so, but stress program keeps trying to
> > > > access and activate it.
> > > 
> > > Is this still with faultaround disabled? I have seen exactly same
> > > pattern in the bug I am working on. It was ext4 though.
> > 
> > After a long time struggling, the last 2nd block where libc-2.28.so is
> > located is reclaimed, now it comes to the last memory block, still
> > stress program itself. swap migration entry has been made and trying to
> > unmap, now it's looping there.
> > 
> > [  +0.004445] migrating pfn 190ff2bb0 failed 
> > [  +0.000013] page:ffffea643fcaec00 count:203 mapcount:201 mapping:ffff888dfb268f48 index:0x0
> > [  +0.012809] shmem_aops 
> > [  +0.000011] name:"stress" 
> > [  +0.002550] flags: 0x1dfffffc008004e(referenced|uptodate|dirty|workingset|swapbacked)
> > [  +0.010715] raw: 01dfffffc008004e ffffea643fcaec48 ffffea643fc714c8 ffff888dfb268f48
> > [  +0.007828] raw: 0000000000000000 0000000000000000 000000cb000000c8 ffff888e72e92000
> > [  +0.007810] page->mem_cgroup:ffff888e72e92000
> [...]
> > [  +0.004455] migrating pfn 190ff2bb0 failed 
> > [  +0.000018] page:ffffea643fcaec00 count:203 mapcount:201 mapping:ffff888dfb268f48 index:0x0
> > [  +0.014392] shmem_aops 
> > [  +0.000010] name:"stress" 
> > [  +0.002565] flags: 0x1dfffffc008004e(referenced|uptodate|dirty|workingset|swapbacked)
> > [  +0.010675] raw: 01dfffffc008004e ffffea643fcaec48 ffffea643fc714c8 ffff888dfb268f48
> > [  +0.007819] raw: 0000000000000000 0000000000000000 000000cb000000c8 ffff888e72e92000
> > [  +0.007808] page->mem_cgroup:ffff888e72e92000
> 
> OK, so this is tmpfs backed code of your stree test. This just tells us
> that this is not fs specific. Reference count is 2 more than the map
> count which is the expected state. So the reference count must have been
> elevated at the time when the migration was attempted. Shmem supports
> fault around so this might be still possible (assuming it is enabled).
> If not we really need to dig deeper. I will think of a debugging patch.

Disabled faultaround and reboot, test again, it's looping forever in the
last block again, on node2, stress progam itself again. The weird is
refcount seems to have been crazy, a random number now. There must be
something going wrong.

[  +0.058624] migrating pfn 80fd6fbe failed 
[  +0.000003] page:ffffea203f5bef80 count:336 mapcount:201 mapping:ffff888e1c9357d8 index:0x2
[  +0.014122] shmem_aops 
[  +0.000000] name:"stress" 
[  +0.002467] flags: 0x9fffffc008000e(referenced|uptodate|dirty|swapbacked)
[  +0.009511] raw: 009fffffc008000e ffffc900000e3d80 ffffc900000e3d80 ffff888e1c9357d8
[  +0.007743] raw: 0000000000000002 0000000000000000 000000cb000000c8 ffff888e2233d000
[  +0.007740] page->mem_cgroup:ffff888e2233d000
[  +0.038916] migrating pfn 80fd6fbe failed 
[  +0.000003] page:ffffea203f5bef80 count:349 mapcount:201 mapping:ffff888e1c9357d8 index:0x2
[  +0.012453] shmem_aops 
[  +0.000001] name:"stress" 
[  +0.002641] flags: 0x9fffffc008000e(referenced|uptodate|dirty|swapbacked)
[  +0.009501] raw: 009fffffc008000e ffffc900000e3d80 ffffc900000e3d80 ffff888e1c9357d8
[  +0.007746] raw: 0000000000000002 0000000000000000 000000cb000000c8 ffff888e2233d000
[  +0.007740] page->mem_cgroup:ffff888e2233d000
[  +0.061226] migrating pfn 80fd6fbe failed 
[  +0.000004] page:ffffea203f5bef80 count:276 mapcount:201 mapping:ffff888e1c9357d8 index:0x2
[  +0.014129] shmem_aops 
[  +0.000002] name:"stress" 
[  +0.003246] flags: 0x9fffffc008008e(waiters|referenced|uptodate|dirty|swapbacked)
[  +0.010183] raw: 009fffffc008008e ffffc900000e3d80 ffffc900000e3d80 ffff888e1c9357d8
[  +0.007742] raw: 0000000000000002 0000000000000000 000000cb000000c8 ffff888e2233d000
[  +0.007733] page->mem_cgroup:ffff888e2233d000
[  +0.037305] migrating pfn 80fd6fbe failed 
[  +0.000003] page:ffffea203f5bef80 count:304 mapcount:201 mapping:ffff888e1c9357d8 index:0x2
[  +0.012449] shmem_aops 
[  +0.000002] name:"stress" 
[  +0.002469] flags: 0x9fffffc008000e(referenced|uptodate|dirty|swapbacked)
[  +0.009495] raw: 009fffffc008000e ffffc900000e3d80 ffffc900000e3d80 ffff888e1c9357d8
[  +0.007743] raw: 0000000000000002 0000000000000000 000000cb000000c8 ffff888e2233d000
[  +0.007736] page->mem_cgroup:ffff888e2233d000
