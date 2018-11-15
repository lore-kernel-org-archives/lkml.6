Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4EAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF352146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF352146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388349AbeKPAkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:40:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:44518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387548AbeKPAkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:40:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE207B015;
        Thu, 15 Nov 2018 14:32:05 +0000 (UTC)
Date:   Thu, 15 Nov 2018 15:32:04 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        pifang@redhat.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aarcange@redhat.com
Subject: Re: Memory hotplug softlock issue
Message-ID: <20181115143204.GV23831@dhcp22.suse.cz>
References: <20181114090134.GG23419@dhcp22.suse.cz>
 <20181114145250.GE2653@MiWiFi-R3L-srv>
 <20181114150029.GY23419@dhcp22.suse.cz>
 <20181115051034.GK2653@MiWiFi-R3L-srv>
 <20181115073052.GA23831@dhcp22.suse.cz>
 <20181115075349.GL2653@MiWiFi-R3L-srv>
 <20181115083055.GD23831@dhcp22.suse.cz>
 <20181115131211.GP2653@MiWiFi-R3L-srv>
 <20181115131927.GT23831@dhcp22.suse.cz>
 <20181115133840.GR2653@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115133840.GR2653@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-11-18 21:38:40, Baoquan He wrote:
> On 11/15/18 at 02:19pm, Michal Hocko wrote:
> > On Thu 15-11-18 21:12:11, Baoquan He wrote:
> > > On 11/15/18 at 09:30am, Michal Hocko wrote:
> > [...]
> > > > It would be also good to find out whether this is fs specific. E.g. does
> > > > it make any difference if you use a different one for your stress
> > > > testing?
> > > 
> > > Created a ramdisk and put stress bin there, then run stress -m 200, now
> > > seems it's stuck in libc-2.28.so migrating. And it's still xfs. So now xfs
> > > is a big suspect. At bottom I paste numactl printing, you can see that it's
> > > the last 4G.
> > > 
> > > Seems it's trying to migrate libc-2.28.so, but stress program keeps trying to
> > > access and activate it.
> > 
> > Is this still with faultaround disabled? I have seen exactly same
> > pattern in the bug I am working on. It was ext4 though.
> 
> After a long time struggling, the last 2nd block where libc-2.28.so is
> located is reclaimed, now it comes to the last memory block, still
> stress program itself. swap migration entry has been made and trying to
> unmap, now it's looping there.
> 
> [  +0.004445] migrating pfn 190ff2bb0 failed 
> [  +0.000013] page:ffffea643fcaec00 count:203 mapcount:201 mapping:ffff888dfb268f48 index:0x0
> [  +0.012809] shmem_aops 
> [  +0.000011] name:"stress" 
> [  +0.002550] flags: 0x1dfffffc008004e(referenced|uptodate|dirty|workingset|swapbacked)
> [  +0.010715] raw: 01dfffffc008004e ffffea643fcaec48 ffffea643fc714c8 ffff888dfb268f48
> [  +0.007828] raw: 0000000000000000 0000000000000000 000000cb000000c8 ffff888e72e92000
> [  +0.007810] page->mem_cgroup:ffff888e72e92000
[...]
> [  +0.004455] migrating pfn 190ff2bb0 failed 
> [  +0.000018] page:ffffea643fcaec00 count:203 mapcount:201 mapping:ffff888dfb268f48 index:0x0
> [  +0.014392] shmem_aops 
> [  +0.000010] name:"stress" 
> [  +0.002565] flags: 0x1dfffffc008004e(referenced|uptodate|dirty|workingset|swapbacked)
> [  +0.010675] raw: 01dfffffc008004e ffffea643fcaec48 ffffea643fc714c8 ffff888dfb268f48
> [  +0.007819] raw: 0000000000000000 0000000000000000 000000cb000000c8 ffff888e72e92000
> [  +0.007808] page->mem_cgroup:ffff888e72e92000

OK, so this is tmpfs backed code of your stree test. This just tells us
that this is not fs specific. Reference count is 2 more than the map
count which is the expected state. So the reference count must have been
elevated at the time when the migration was attempted. Shmem supports
fault around so this might be still possible (assuming it is enabled).
If not we really need to dig deeper. I will think of a debugging patch.
-- 
Michal Hocko
SUSE Labs
