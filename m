Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbeCTPig (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:38:36 -0400
Received: from linode.aoot.com ([69.164.194.13]:56860 "EHLO linode.aoot.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeCTPie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:38:34 -0400
From: "Steve Wise" <swise@opengridcomputing.com>
To: "'Jason Gunthorpe'" <jgg@ziepe.ca>,
        "'Sinan Kaya'" <okaya@codeaurora.org>
Cc: <linux-rdma@vger.kernel.org>, <timur@codeaurora.org>,
        <sulrich@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "'Steve Wise'" <swise@chelsio.com>,
        "'Doug Ledford'" <dledford@redhat.com>, <linux-kernel@vger.kernel.org>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org> <1521514068-8856-5-git-send-email-okaya@codeaurora.org> <20180320145159.GG19744@ziepe.ca> 
In-Reply-To: 
Subject: RE: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers on weakly-ordered archs
Date: Tue, 20 Mar 2018 10:38:33 -0500
Message-ID: <3d9b01d3c061$8173d890$845b89b0$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJnohsAzCjMC8iCAg840eHfO7WHuQE8ydHJAazdTfQB/pHyGaKKPMXg
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Mon, Mar 19, 2018 at 10:47:46PM -0400, Sinan Kaya wrote:
> > > Code includes wmb() followed by writel(). writel() already has a
barrier
> on
> > > some architectures like arm64.
> > >
> > > This ends up CPU observing two barriers back to back before executing
> > the
> > > register write.
> > >
> > > Since code already has an explicit barrier call, changing writel() to
> > > writel_relaxed().
> > >
> > > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > >  drivers/infiniband/hw/cxgb4/t4.h | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/cxgb4/t4.h
> > b/drivers/infiniband/hw/cxgb4/t4.h
> > > index 8369c7c..6e5658a 100644
> > > +++ b/drivers/infiniband/hw/cxgb4/t4.h
> > > @@ -457,7 +457,7 @@ static inline void pio_copy(u64 __iomem *dst,
> u64
> > *src)
> > >  	int count = 8;
> > >
> > >  	while (count) {
> > > -		writeq(*src, dst);
> > > +		writeq_relaxed(*src, dst);
> > >  		src++;
> > >  		dst++;
> > >  		count--;
> >
> > This is another case where writes can be re-ordered.. IIRC dst is WC
> > BAR memory, so the NIC should tolerate re-ordering, but Steve will
> > have to ack this.
> >
> 
> Yes, this is WC BAR memory.  The goal is that pio_copy() will enable
write-
> combining this into a single 64B pci-e transaction.
> 


I'd like to see the PPC issue resolved...but

Acked-by: Steve Wise <swise@opengridcomputing.com>
