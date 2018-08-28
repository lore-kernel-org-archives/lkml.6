Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AA0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E115420898
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E115420898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeH1QbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:31:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbeH1QbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:31:22 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6966286670;
        Tue, 28 Aug 2018 12:39:54 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43CF9862C0;
        Tue, 28 Aug 2018 12:39:54 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id D7A254BB74;
        Tue, 28 Aug 2018 12:39:53 +0000 (UTC)
Date:   Tue, 28 Aug 2018 08:39:53 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, kwolf@redhat.com,
        haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        riel@surriel.com, niteshnarayanlal@hotmail.com, mst@redhat.com,
        ross zwisler <ross.zwisler@intel.com>, lcapitulino@redhat.com,
        hch@infradead.org, stefanha@redhat.com, imammedo@redhat.com,
        pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>,
        nilal@redhat.com
Message-ID: <16583366.7193885.1535459993521.JavaMail.zimbra@redhat.com>
In-Reply-To: <1328e543-0276-8f33-1744-8baa053023c4@redhat.com>
References: <20180713075232.9575-1-pagupta@redhat.com> <1328e543-0276-8f33-1744-8baa053023c4@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 0/2] kvm "fake DAX" device flushing
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.113, 10.4.195.30]
Thread-Topic: kvm "fake DAX" device flushing
Thread-Index: UtTP1YtN/57qbZTwbS5MJbaMnAE9XQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 28 Aug 2018 12:39:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi David,

> > for review. This patchset has two parts:
> > 
> > - Guest virtio-pmem driver
> >   Guest driver reads persistent memory range from paravirt device
> >   and registers with 'nvdimm_bus'. 'nvdimm/pmem' driver uses this
> >   information to allocate persistent memory range. Also, we have
> >   implemented guest side of VIRTIO flushing interface.
> > 
> > - Qemu virtio-pmem device
> >   It exposes a persistent memory range to KVM guest which at host
> >   side is file backed memory and works as persistent memory device.
> >   In addition to this it provides virtio device handling of flushing
> >   interface. KVM guest performs Qemu side asynchronous sync using
> >   this interface.
> > 
> > Changes from RFC v2:
> > - Add flush function in the nd_region in place of switching
> >   on a flag - Dan & Stefan
> > - Add flush completion function with proper locking and wait
> >   for host side flush completion - Stefan & Dan
> > - Keep userspace API in uapi header file - Stefan, MST
> > - Use LE fields & New device id - MST
> > - Indentation & spacing suggestions - MST & Eric
> > - Remove extra header files & add licensing - Stefan
> > 
> > Changes from RFC v1:
> > - Reuse existing 'pmem' code for registering persistent
> >   memory and other operations instead of creating an entirely
> >   new block driver.
> > - Use VIRTIO driver to register memory information with
> >   nvdimm_bus and create region_type accordingly.
> > - Call VIRTIO flush from existing pmem driver.
> > 
> > Details of project idea for 'fake DAX' flushing interface is
> > shared [2] & [3].
> > 
> > Pankaj Gupta (2):
> >    Add virtio-pmem guest driver
> >    pmem: device flush over VIRTIO
> > 
> > [1] https://marc.info/?l=linux-mm&m=150782346802290&w=2
> > [2] https://www.spinics.net/lists/kvm/msg149761.html
> > [3] https://www.spinics.net/lists/kvm/msg153095.html
> > 
> >  drivers/nvdimm/nd.h              |    1
> >  drivers/nvdimm/pmem.c            |    4
> >  drivers/nvdimm/region_devs.c     |   24 +++-
> >  drivers/virtio/Kconfig           |    9 +
> >  drivers/virtio/Makefile          |    1
> >  drivers/virtio/virtio_pmem.c     |  190
> >  +++++++++++++++++++++++++++++++++++++++
> >  include/linux/libnvdimm.h        |    5 -
> >  include/linux/virtio_pmem.h      |   44 +++++++++
> >  include/uapi/linux/virtio_ids.h  |    1
> >  include/uapi/linux/virtio_pmem.h |   40 ++++++++
> >  10 files changed, 310 insertions(+), 9 deletions(-)
> > 
> 
> Hi Pankaj,
> 
> do you have a branch for the QEMU part somewhere available? I want to
> see how this works with MemoryDevice changes.

o.k I will update the guest virtio-pmem and Qemu current changes
and share with you. BTW previous version is here:

https://marc.info/?l=kvm&m=153146839627143&w=2

Thanks,
Pankaj
 
> 
> --
> 
> Thanks,
> 
> David / dhildenb
> 
> 
