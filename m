Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1D3ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5503D21476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5503D21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeJRDI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:08:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbeJRDI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:08:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A90E53082E60;
        Wed, 17 Oct 2018 19:11:52 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B82FF1949B;
        Wed, 17 Oct 2018 19:11:51 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 973E64BB74;
        Wed, 17 Oct 2018 19:11:49 +0000 (UTC)
Date:   Wed, 17 Oct 2018 15:11:49 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Kevin Wolf <kwolf@redhat.com>, Jan Kara <jack@suse.cz>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        KVM list <kvm@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Qemu Developers <qemu-devel@nongnu.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, zwisler@kernel.org,
        lcapitulino@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
        Nitesh Narayan Lal <nilal@redhat.com>
Message-ID: <431127218.21694133.1539803509205.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4hroaVWA-HgjWCnr7QTd_y7U8sCvS+Up733ttnD6_cKzQ@mail.gmail.com>
References: <20181013050021.11962-1-pagupta@redhat.com> <20181013050021.11962-3-pagupta@redhat.com> <CAPcyv4hroaVWA-HgjWCnr7QTd_y7U8sCvS+Up733ttnD6_cKzQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.136, 10.4.195.4]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: YyGiz7N3rzLKI9gm98sFjSpgz86qJg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 17 Oct 2018 19:11:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Fri, Oct 12, 2018 at 10:01 PM Pankaj Gupta <pagupta@redhat.com> wrote:
> >
> > This patch adds virtio-pmem driver for KVM guest.
> >
> > Guest reads the persistent memory range information from
> > Qemu over VIRTIO and registers it on nvdimm_bus. It also
> > creates a nd_region object with the persistent memory
> > range information so that existing 'nvdimm/pmem' driver
> > can reserve this into system memory map. This way
> > 'virtio-pmem' driver uses existing functionality of pmem
> > driver to register persistent memory compatible for DAX
> > capable filesystems.
> >
> > This also provides function to perform guest flush over
> > VIRTIO from 'pmem' driver when userspace performs flush
> > on DAX memory range.
> 
> Before we can move forward with this driver we need additional
> filesystem enabling to detect when the backing device is fronting DAX
> pmem or a paravirtualized page cache through virtio-pmem. Any
> interface that requires fsync() and a round trip to the hypervisor to
> flush host page cache is not DAX.

I saw your proposal[1] for new mmap flag MAP_DIRECT. IIUIC mapping should fail for 
MAP_DIRECT if it requires explicit flush or buffer indirection. So, if we disable 
MAP_SYNC flag for virtio-pmem this should fail MAP_DIRECT as well? Otherwise 
without MAP_DIRECT, virtio-pmem should be defaulted to VIRTIO flush mechanism.     

[1] https://marc.info/?l=linux-fsdevel&m=153953206330814&w=2

Thanks,
Pankaj
