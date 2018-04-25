Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754799AbeDYOsB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:48:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3635 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753508AbeDYOr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:47:58 -0400
Date: Wed, 25 Apr 2018 10:47:56 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>, Linux MM <linux-mm@kvack.org>,
        Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        Nitesh Narayan Lal <nilal@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ross Zwisler <ross.zwisler@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, niteshnarayanlal@hotmail.com,
        Igor Mammedov <imammedo@redhat.com>, lcapitulino@redhat.com
Message-ID: <458087373.22645020.1524667676533.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4gpZzKfE7jY1peYOVd6sVhNz7jce1s_xNH_2Lt8AjRK-Q@mail.gmail.com>
References: <20180425112415.12327-1-pagupta@redhat.com> <20180425112415.12327-3-pagupta@redhat.com> <CAPcyv4gpZzKfE7jY1peYOVd6sVhNz7jce1s_xNH_2Lt8AjRK-Q@mail.gmail.com>
Subject: Re: [RFC v2 2/2] pmem: device flush over VIRTIO
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.111, 10.4.195.23]
Thread-Topic: pmem: device flush over VIRTIO
Thread-Index: RGAJX2p9n07JgwlroFp9vISyZdXRBQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Wed, Apr 25, 2018 at 4:24 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
> > This patch adds functionality to perform
> > flush from guest to hosy over VIRTIO
> > when 'ND_REGION_VIRTIO'flag is set on
> > nd_negion. Flag is set by 'virtio-pmem'
> > driver.
> >
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  drivers/nvdimm/region_devs.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> > index a612be6..6c6454e 100644
> > --- a/drivers/nvdimm/region_devs.c
> > +++ b/drivers/nvdimm/region_devs.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/nd.h>
> >  #include "nd-core.h"
> >  #include "nd.h"
> > +#include <linux/virtio_pmem.h>
> >
> >  /*
> >   * For readq() and writeq() on 32-bit builds, the hi-lo, lo-hi order is
> > @@ -1074,6 +1075,12 @@ void nvdimm_flush(struct nd_region *nd_region)
> >         struct nd_region_data *ndrd = dev_get_drvdata(&nd_region->dev);
> >         int i, idx;
> >
> > +       /* call PV device flush */
> > +       if (test_bit(ND_REGION_VIRTIO, &nd_region->flags)) {
> > +               virtio_pmem_flush(&nd_region->dev);
> > +               return;
> > +       }
> > +
> 
> I'd rather introduce a ->flush() operation hanging off of 'struct
> nd_region' so that this multiplexing can be a static setting.

Sure! will make the change.

Thanks,
Pankaj
