Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759846AbeD1Kso (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 06:48:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759651AbeD1Ksm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 06:48:42 -0400
Date: Sat, 28 Apr 2018 06:48:41 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: jack@suse.cz, kvm@vger.kernel.org, david@redhat.com,
        linux-nvdimm@ml01.01.org, ross zwisler <ross.zwisler@intel.com>,
        qemu-devel@nongnu.org, lcapitulino@redhat.com, linux-mm@kvack.org,
        niteshnarayanlal@hotmail.com, mst@redhat.com, hch@infradead.org,
        Stefan Hajnoczi <stefanha@gmail.com>, marcel@redhat.com,
        nilal@redhat.com, haozhong zhang <haozhong.zhang@intel.com>,
        riel@surriel.com, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>, kwolf@redhat.com,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        linux-kernel@vger.kernel.org, imammedo@redhat.com
Message-ID: <1266554822.23475618.1524912521209.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180427133146.GB11150@stefanha-x1.localdomain>
References: <20180425112415.12327-1-pagupta@redhat.com> <20180425112415.12327-2-pagupta@redhat.com> <20180426131236.GA30991@stefanha-x1.localdomain> <197910974.22984070.1524757499459.JavaMail.zimbra@redhat.com> <20180427133146.GB11150@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v2 1/2] virtio: add pmem driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.38, 10.4.195.28]
Thread-Topic: virtio: add pmem driver
Thread-Index: yfnsc35dwFGDNzCGklJwWeo1J1CSKA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > +        int err;
> > > > +
> > > > +        sg_init_one(&sg, buf, sizeof(buf));
> > > > +
> > > > +        err = virtqueue_add_outbuf(vpmem->req_vq, &sg, 1, buf, GFP_KERNEL);
> > > > +
> > > > +        if (err) {
> > > > +                dev_err(&vdev->dev, "failed to send command to virtio pmem
> > > > device\n");
> > > > +                return;
> > > > +        }
> > > > +
> > > > +        virtqueue_kick(vpmem->req_vq);
> > > 
> > > Is any locking necessary?  Two CPUs must not invoke virtio_pmem_flush()
> > > at the same time.  Not sure if anything guarantees this, maybe you're
> > > relying on libnvdimm but I haven't checked.
> > 
> > I thought about it to some extent, and wanted to go ahead with simple
> > version first:
> > 
> > - I think file 'inode -> locking' sill is there for request on single file.
> > - For multiple files, our aim is to just flush the backend block image.
> > - Even there is collision for virt queue read/write entry it should just
> > trigger a Qemu fsync.
> >   We just want most recent flush to assure guest writes are synced
> >   properly.
> > 
> > Important point here: We are doing entire block fsync for guest virtual
> > disk.
> 
> I don't understand your answer.  Is locking necessary or not?

It will be required with other changes.

> 
> From the virtqueue_add_outbuf() documentation:
> 
>  * Caller must ensure we don't call this with other virtqueue operations
>  * at the same time (except where noted).

Yes, I also saw it. But thought if can avoid it with current functionality. :)


Thanks,
Pankaj
