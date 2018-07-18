Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5851AECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1290E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1290E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbeGRHld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:41:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbeGRHld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:41:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D982F81DE8;
        Wed, 18 Jul 2018 07:05:10 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F3915C1A1;
        Wed, 18 Jul 2018 07:05:10 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id E0FF44BB78;
        Wed, 18 Jul 2018 07:05:09 +0000 (UTC)
Date:   Wed, 18 Jul 2018 03:05:09 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, jack@suse.cz,
        dan j williams <dan.j.williams@intel.com>, riel@surriel.com,
        haozhong zhang <haozhong.zhang@intel.com>, nilal@redhat.com,
        kwolf@redhat.com, pbonzini@redhat.com,
        ross zwisler <ross.zwisler@intel.com>, david@redhat.com,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        hch@infradead.org, mst@redhat.com, niteshnarayanlal@hotmail.com,
        lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com
Message-ID: <2137768776.51859350.1531897509492.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180717131156.GA13498@stefanha-x1.localdomain>
References: <20180713075232.9575-1-pagupta@redhat.com> <20180713075232.9575-3-pagupta@redhat.com> <20180717131156.GA13498@stefanha-x1.localdomain>
Subject: Re: [RFC v3 2/2] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.193.70, 10.4.195.11]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: IHu9fR6hsmnbOScmgE4tqtLPkAEXeg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 18 Jul 2018 07:05:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stefan,

> > + /* The request submission function */
> > +static int virtio_pmem_flush(struct device *dev)
> > +{
> > +	int err;
> > +	unsigned long flags;
> > +	struct scatterlist *sgs[2], sg, ret;
> > +	struct virtio_device *vdev = dev_to_virtio(dev->parent->parent);
> > +	struct virtio_pmem *vpmem = vdev->priv;
> > +	struct virtio_pmem_request *req = kmalloc(sizeof(*req), GFP_KERNEL);
> > +
> > +	req->done = false;
> > +	init_waitqueue_head(&req->acked);
> > +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > +
> > +	sg_init_one(&sg, req, sizeof(req));
> 
> What are you trying to do here?
> 
> sizeof(req) == sizeof(struct virtio_pmem_request *) == sizeof(void *)
> 
> Did you mean sizeof(*req)?

yes, I meant: sizeof(struct virtio_pmem_request)

Thanks for catching this.

> 
> But why map struct virtio_pmem_request to the device?  struct
> virtio_pmem_request is the driver-internal request state and is not part
> of the hardware interface.

o.k. I will separate out request from 'virtio_pmem_request' struct
and use that. 

> 
> > +	sgs[0] = &sg;
> > +	sg_init_one(&ret, &req->ret, sizeof(req->ret));
> > +	sgs[1] = &ret;
> > +	err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req, GFP_ATOMIC);
> > +	if (err) {
> > +		dev_err(&vdev->dev, "failed to send command to virtio pmem device\n");
> 
> This can happen if the virtqueue is full.  Printing a message and
> failing the flush isn't appropriate.  This thread needs to wait until
> virtqueue space becomes available.

o.k. I will implement this.

> 
> > +		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > +		return -ENOSPC;
> 
> req is leaked.

will free req.

> 
> > +	virtio_device_ready(vdev);
> 
> This call isn't needed.  Driver use it when they wish to submit buffers
> on virtqueues before ->probe() returns.

o.k. I will remove it.

> 
> > diff --git a/include/linux/virtio_pmem.h b/include/linux/virtio_pmem.h
> > new file mode 100644
> > index 0000000..0f83d9c
> > --- /dev/null
> > +++ b/include/linux/virtio_pmem.h
> 
> include/ is for declarations (e.g. kernel APIs) needed by other
> compilation units.  The contents of this header are internal to the
> virtio_pmem driver implementation and can therefore be in virtio_pmem.c.
> include/linux/virtio_pmem.h isn't necessary since nothing besides
> virtio_pmem.c will need to include it.

Agree. Will move declarations from virtio_pmem.h to virtio_pmem.c

Thanks,
Pankaj
