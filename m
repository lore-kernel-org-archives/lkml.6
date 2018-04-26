Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756635AbeDZQk4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:40:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754462AbeDZQky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:40:54 -0400
Date: Thu, 26 Apr 2018 12:40:53 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-mm@kvack.org,
        jack@suse.cz, stefanha@redhat.com,
        dan j williams <dan.j.williams@intel.com>, riel@surriel.com,
        haozhong zhang <haozhong.zhang@intel.com>, nilal@redhat.com,
        kwolf@redhat.com, pbonzini@redhat.com,
        ross zwisler <ross.zwisler@intel.com>, david@redhat.com,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, hch@infradead.org,
        marcel@redhat.com, mst@redhat.com, niteshnarayanlal@hotmail.com,
        imammedo@redhat.com, lcapitulino@redhat.com
Message-ID: <58645254.23011245.1524760853269.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180426131517.GB30991@stefanha-x1.localdomain>
References: <20180425112415.12327-1-pagupta@redhat.com> <20180425112415.12327-3-pagupta@redhat.com> <20180426131517.GB30991@stefanha-x1.localdomain>
Subject: Re: [RFC v2 2/2] pmem: device flush over VIRTIO
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.119, 10.4.195.10]
Thread-Topic: pmem: device flush over VIRTIO
Thread-Index: LQYKnvVqMrEPJ59FVtpvxGsK/zFRrw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Wed, Apr 25, 2018 at 04:54:14PM +0530, Pankaj Gupta wrote:
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
> >  	struct nd_region_data *ndrd = dev_get_drvdata(&nd_region->dev);
> >  	int i, idx;
> >  
> > +       /* call PV device flush */
> > +	if (test_bit(ND_REGION_VIRTIO, &nd_region->flags)) {
> > +		virtio_pmem_flush(&nd_region->dev);
> > +		return;
> > +	}
> 
> How does libnvdimm know when flush has completed?
> 
> Callers expect the flush to be finished when nvdimm_flush() returns but
> the virtio driver has only queued the request, it hasn't waited for
> completion!

I tried to implement what nvdimm does right now. It just writes to
flush hint address to make sure data persists.

I just did not want to block guest write requests till host side 
fsync completes.

Operations(write/fsync) on same file would be blocking at guest side and wait time could 
be worse for operations on different guest files because all these operations would happen 
ultimately on same file at host.

I think with current way, we can achieve an asynchronous queuing mechanism on cost of not 
100% sure when fsync would complete but it is assured it will happen. Also, its entire block
flush.

I am open for suggestions here, this is my current thought and implementation. 

Thanks,
Pankaj
