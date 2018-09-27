Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B94C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8D621531
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8D621531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeI0TYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:24:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbeI0TYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:24:53 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6628530024D8;
        Thu, 27 Sep 2018 13:06:42 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5584CB7E8F;
        Thu, 27 Sep 2018 13:06:42 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 32C124BB74;
        Thu, 27 Sep 2018 13:06:41 +0000 (UTC)
Date:   Thu, 27 Sep 2018 09:06:40 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>, Jan Kara <jack@suse.cz>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Kevin Wolf <kwolf@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ross Zwisler <ross.zwisler@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        niteshnarayanlal@hotmail.com, lcapitulino@redhat.com,
        Igor Mammedov <imammedo@redhat.com>,
        Eric Blake <eblake@redhat.com>
Message-ID: <435471901.16563045.1538053600799.JavaMail.zimbra@redhat.com>
In-Reply-To: <1204243972.15515798.1537782119951.JavaMail.zimbra@redhat.com>
References: <20180831133019.27579-1-pagupta@redhat.com> <20180831133019.27579-4-pagupta@redhat.com> <CAPcyv4gy-ONZz=PnXN92xYnyRX0rhu7Oq-_jPWJekbYQjNKRiw@mail.gmail.com> <1204243972.15515798.1537782119951.JavaMail.zimbra@redhat.com>
Subject: Re: [PATCH 3/3] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.173, 10.4.195.17]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: O2xK7RuQHwBLvgXctDUcgKgtPS87E2LFBAoH
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 27 Sep 2018 13:06:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Dan,

> > > + /* The request submission function */
> > > +static int virtio_pmem_flush(struct nd_region *nd_region)
> > > +{
> > > +       int err;

[...]

> > > +       init_waitqueue_head(&req->host_acked);
> > > +       init_waitqueue_head(&req->wq_buf);
> > > +
> > > +       spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > > +       sg_init_one(&sg, req->name, strlen(req->name));
> > > +       sgs[0] = &sg;
> > > +       sg_init_one(&ret, &req->ret, sizeof(req->ret));
> > > +       sgs[1] = &ret;

[...]
> > > +       spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > > +       /* When host has read buffer, this completes via host_ack */
> > > +       wait_event(req->host_acked, req->done);
> > 
> > Hmm, this seems awkward if this is called from pmem_make_request. If
> > we need to wait for completion that should be managed by the guest
> > block layer. I.e. make_request should just queue request and then
> > trigger bio_endio() when the response comes back.
> 
> We are plugging VIRTIO based flush callback for virtio_pmem driver. If pmem
> driver (pmem_make_request) has to queue request we have to plug "blk_mq_ops"
> callbacks for corresponding  VIRTIO vqs. AFAICU there is no existing
> multiqueue
> code merged for pmem driver yet, though i could see patches by Dave upstream.
> 

I thought about this and with current infrastructure "make_request" releases spinlock 
and makes current thread/task. All Other threads are free to call 'make_request'/flush 
and similarly wait by releasing the lock. This actually works like a queue of threads 
waiting for notifications from host.

Current pmem code do not have multiqueue support and I am not sure if core pmem code 
needs it. Adding multiqueue support just for virtio-pmem and not for pmem in same driver
will be confusing or require alot of tweaking.

Could you please give your suggestions on this. 
 
Thanks,
Pankaj
