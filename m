Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26177C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8D020659
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8D020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJNAHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 20:07:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbeJNAHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 20:07:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C70B981DE1;
        Sat, 13 Oct 2018 16:29:14 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 394E4607C4;
        Sat, 13 Oct 2018 16:29:14 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id A623D180053A;
        Sat, 13 Oct 2018 16:29:13 +0000 (UTC)
Date:   Sat, 13 Oct 2018 12:29:12 -0400 (EDT)
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
Message-ID: <2107404743.20781403.1539448152851.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4gEVxoNFUmFctSR6nRku_Pcz2GfXB+-iHBARmc+Wa+dfQ@mail.gmail.com>
References: <20181013050021.11962-1-pagupta@redhat.com> <CAPcyv4gEVxoNFUmFctSR6nRku_Pcz2GfXB+-iHBARmc+Wa+dfQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] kvm "fake DAX" device
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.15, 10.4.195.9]
Thread-Topic: kvm "fake DAX" device
Thread-Index: +S5hvCT+X5OpmacPj4Q8TC96GIS4Ug==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sat, 13 Oct 2018 16:29:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> >  This patch series has implementation for "fake DAX".
> >  "fake DAX" is fake persistent memory(nvdimm) in guest
> >  which allows to bypass the guest page cache. This also
> >  implements a VIRTIO based asynchronous flush mechanism.
> 
> Can we stop calling this 'fake DAX', because it isn't 'DAX' and it's
> starting to confuse people. This enabling is effectively a
> host-page-cache-passthrough mechanism not DAX. Let's call the whole
> approach virtio-pmem, and leave DAX out of the name to hopefully
> prevent people from wondering why some DAX features are disabled with
> this driver. For example MAP_SYNC is not compatible with this
> approach.

Sure. I got your point. I will use "virtio-pmem" in future.  

> 
> Additional enabling is need to disable MAP_SYNC in the presence of a
> virtio-pmem device. See the rough proposal here:
> 
>     https://lkml.org/lkml/2018/4/25/756

Yes, I will handle disabling of MAP_SYNC for this use-case.


Thanks,
Pankaj

