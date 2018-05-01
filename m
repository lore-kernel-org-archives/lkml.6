Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeEADJM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 23:09:12 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44090 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbeEADJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 23:09:10 -0400
X-Google-Smtp-Source: AB8JxZr0O4u+8YK9wA9nyMphW2ySFIxhMSUcYrviHltv8Z5ktoz3IdbPlzBe6AvarE4emDk0+aI4MURU9xu0nVmaCW8=
MIME-Version: 1.0
References: <20180425223340.206907-1-gthelen@google.com> <20180430233500.GI26909@ziepe.ca>
In-Reply-To: <20180430233500.GI26909@ziepe.ca>
From: Greg Thelen <gthelen@google.com>
Date: Tue, 01 May 2018 03:08:57 +0000
Message-ID: <CAHH2K0aJgACn1fQrR=YpifWgOAFTCubcVo+bA+zCFg7++NR1kQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] ib_srpt: depend on INFINIBAND_ADDR_TRANS
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Tarick Bedeir <tarick@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 4:35 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Apr 25, 2018 at 03:33:39PM -0700, Greg Thelen wrote:
> > INFINIBAND_SRPT code depends on INFINIBAND_ADDR_TRANS provided symbols.
> > So declare the kconfig dependency.  This is necessary to allow for
> > enabling INFINIBAND without INFINIBAND_ADDR_TRANS.
> >
> > Signed-off-by: Greg Thelen <gthelen@google.com>
> > Cc: Tarick Bedeir <tarick@google.com>
> >  drivers/infiniband/ulp/srpt/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/ulp/srpt/Kconfig
b/drivers/infiniband/ulp/srpt/Kconfig
> > index 31ee83d528d9..fb8b7182f05e 100644
> > +++ b/drivers/infiniband/ulp/srpt/Kconfig
> > @@ -1,6 +1,6 @@
> >  config INFINIBAND_SRPT
> >       tristate "InfiniBand SCSI RDMA Protocol target support"
> > -     depends on INFINIBAND && TARGET_CORE
> > +     depends on INFINIBAND && INFINIBAND_ADDR_TRANS && TARGET_CORE

> Isn't INFINIBAND && INFINIBAND_ADDR_TRANS a bit redundant? Can't have
> INFINIBAND_ADDR_TRANS without INFINIBAND.

By kconfig INFINIBAND_ADDR_TRANS depends on INFINIBAND.  So yes, it seems
redundant.  I don't know if anyone has designs to break this dependency and
allow for ADDR_TRANS without INFINIBAND.  Assuming not, I'd be willing to
amend my series removing redundant INFINIBAND and a followup series to
remove it from similar depends.  Though I'm not familiar with rdma dev tree
lifecycle.  Is rdma/for-rc a throw away branch (akin to linux-next), or
will it be merged into linus/master?  If throwaway, then we can amend
its patches, otherwise followups will be needed.

Let me know what you'd prefer.  Thanks.

FYI from v4.17-rc3:
drivers/staging/lustre/lnet/Kconfig:  depends on LNET && PCI && INFINIBAND
&& INFINIBAND_ADDR_TRANS
net/9p/Kconfig:       depends on INET && INFINIBAND && INFINIBAND_ADDR_TRANS
net/rds/Kconfig:      depends on RDS && INFINIBAND && INFINIBAND_ADDR_TRANS
net/sunrpc/Kconfig:   depends on SUNRPC && INFINIBAND &&
INFINIBAND_ADDR_TRANS
