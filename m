Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B0FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E352083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E352083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbeIGRKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:10:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728087AbeIGRKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:10:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 653D92BCB0;
        Fri,  7 Sep 2018 12:30:09 +0000 (UTC)
Received: from work-vm (ovpn-116-158.ams2.redhat.com [10.36.116.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1FDD637AE;
        Fri,  7 Sep 2018 12:29:58 +0000 (UTC)
Date:   Fri, 7 Sep 2018 13:29:56 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        peterx@redhat.com
Subject: Re: [PATCH v36 0/5] Virtio-balloon: support free page reporting
Message-ID: <20180907122955.GD2544@work-vm>
References: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com>
 <20180723122342-mutt-send-email-mst@kernel.org>
 <20180723143604.GB2457@work-vm>
 <5B911B03.2060602@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B911B03.2060602@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 07 Sep 2018 12:30:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 07 Sep 2018 12:30:09 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dgilbert@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Wei Wang (wei.w.wang@intel.com) wrote:
> On 07/23/2018 10:36 PM, Dr. David Alan Gilbert wrote:
> > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > On Fri, Jul 20, 2018 at 04:33:00PM +0800, Wei Wang wrote:
> > > > This patch series is separated from the previous "Virtio-balloon
> > > > Enhancement" series. The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT,
> > > > implemented by this series enables the virtio-balloon driver to report
> > > > hints of guest free pages to the host. It can be used to accelerate live
> > > > migration of VMs. Here is an introduction of this usage:
> > > > 
> > > > Live migration needs to transfer the VM's memory from the source machine
> > > > to the destination round by round. For the 1st round, all the VM's memory
> > > > is transferred. From the 2nd round, only the pieces of memory that were
> > > > written by the guest (after the 1st round) are transferred. One method
> > > > that is popularly used by the hypervisor to track which part of memory is
> > > > written is to write-protect all the guest memory.
> > > > 
> > > > This feature enables the optimization by skipping the transfer of guest
> > > > free pages during VM live migration. It is not concerned that the memory
> > > > pages are used after they are given to the hypervisor as a hint of the
> > > > free pages, because they will be tracked by the hypervisor and transferred
> > > > in the subsequent round if they are used and written.
> > > > 
> > > > * Tests
> > > > - Test Environment
> > > >      Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
> > > >      Guest: 8G RAM, 4 vCPU
> > > >      Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 second
> > > > 
> > > > - Test Results
> > > >      - Idle Guest Live Migration Time (results are averaged over 10 runs):
> > > >          - Optimization v.s. Legacy = 409ms vs 1757ms --> ~77% reduction
> > > > 	(setting page poisoning zero and enabling ksm don't affect the
> > > >           comparison result)
> > > >      - Guest with Linux Compilation Workload (make bzImage -j4):
> > > >          - Live Migration Time (average)
> > > >            Optimization v.s. Legacy = 1407ms v.s. 2528ms --> ~44% reduction
> > > >          - Linux Compilation Time
> > > >            Optimization v.s. Legacy = 5min4s v.s. 5min12s
> > > >            --> no obvious difference
> > > I'd like to see dgilbert's take on whether this kind of gain
> > > justifies adding a PV interfaces, and what kind of guest workload
> > > is appropriate.
> > > 
> > > Cc'd.
> > Well, 44% is great ... although the measurement is a bit weird.
> > 
> > a) A 2 second downtime is very large; 300-500ms is more normal
> > b) I'm not sure what the 'average' is  - is that just between a bunch of
> > repeated migrations?
> > c) What load was running in the guest during the live migration?
> > 
> > An interesting measurement to add would be to do the same test but
> > with a VM with a lot more RAM but the same load;  you'd hope the gain
> > would be even better.
> > It would be interesting, especially because the users who are interested
> > are people creating VMs allocated with lots of extra memory (for the
> > worst case) but most of the time migrating when it's fairly idle.
> > 
> > Dave
> > 
> 
> Hi Dave,
> 
> The results of the added experiments have been shown in the v37 cover
> letter.
> Could you have a look at https://lkml.org/lkml/2018/8/27/29 . Thanks.

OK, that's much better.
The ~50% reducton with a 8G VM and a real workload is great,
and it does what you expect when you put a lot more RAM in and see the
84% reduction on a guest with 128G RAM - 54s vs ~9s is a big win!

(The migrate_set_speed is a bit high, since that's in bytes/s - but it's
not important).

That looks good,

Thanks!

Dave

> Best,
> Wei
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
