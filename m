Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F35AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323F320870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbfAKHpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:45:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727578AbfAKHpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:45:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2703719D383;
        Fri, 11 Jan 2019 07:45:07 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ABC4600C2;
        Fri, 11 Jan 2019 07:45:06 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 554C93F7CB;
        Fri, 11 Jan 2019 07:45:05 +0000 (UTC)
Date:   Fri, 11 Jan 2019 02:45:04 -0500 (EST)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, jack@suse.cz, stefanha@redhat.com,
        dan j williams <dan.j.williams@intel.com>, riel@surriel.com,
        nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com,
        zwisler@kernel.org, vishal l verma <vishal.l.verma@intel.com>,
        dave jiang <dave.jiang@intel.com>, david@redhat.com,
        jmoyer@redhat.com,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        hch@infradead.org, mst@redhat.com, jasowang@redhat.com,
        lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com,
        willy@infradead.org, tytso@mit.edu,
        adilger kernel <adilger.kernel@dilger.ca>,
        darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net
Message-ID: <1326478078.61913951.1547192704870.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190110012617.GA4205@dastard>
References: <20190109144736.17452-1-pagupta@redhat.com> <20190110012617.GA4205@dastard>
Subject: Re: [PATCH v3 0/5] kvm "virtio pmem" device
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.161.12, 10.4.195.30]
Thread-Topic: kvm "virtio pmem" device
Thread-Index: BxCbuq7mbfT/7EGJGXq2rFPowBArAw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 11 Jan 2019 07:45:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Wed, Jan 09, 2019 at 08:17:31PM +0530, Pankaj Gupta wrote:
> >  This patch series has implementation for "virtio pmem".
> >  "virtio pmem" is fake persistent memory(nvdimm) in guest
> >  which allows to bypass the guest page cache. This also
> >  implements a VIRTIO based asynchronous flush mechanism.
> 
> Hmmmm. Sharing the host page cache direct into the guest VM. Sounds
> like a good idea, but.....
> 
> This means the guest VM can now run timing attacks to observe host
> side page cache residency, and depending on the implementation I'm
> guessing that the guest will be able to control host side page
> cache eviction, too (e.g. via discard or hole punch operations).

Not sure how? this is similar to mmapping virtual memory by any userspace 
process. Any host userspace process can do such attack on host page cache
using mincore & mmap shared file. 

But i don't think guest can do this alone. For virtio-pmem usecase guest 
won't be using page cache so timing attack from only guest side is not 
possible unless host userspace can run checks on page cache eviction state
using mincore etc. 

As rightly described by Rik, guest will only access its own page cache pages 
and if guest page cache is managed directly by host, this saves alot of 
effort for guest in transferring guest state of page cache.  

> 
> Which means this functionality looks to me like a new vector for
> information leakage into and out of the guest VM via guest
> controlled host page cache manipulation.
> 
> https://arxiv.org/pdf/1901.01161
> 
> I might be wrong, but if I'm not we're going to have to be very
> careful about how guest VMs can access and manipulate host side
> resources like the page cache.....

If I am following correctly the discussions in MM thread. 
Important steps to mitigate this:

* Avoid running mincore in privilege mode: to safeguard page evict state of any 
  page cache page.
* tweaking RWF_NOWAIT 

I think if we secure ways to find current state(cached/evicted) of a page in host, 
we should be able to mitigate the impact for any page cache page access attack 
including virtio-pmem.

Thanks,
Pankaj


