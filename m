Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbeEAEiY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 00:38:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50365 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeEAEiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 00:38:22 -0400
X-Google-Smtp-Source: AB8JxZr929ja2jKYFabzucM2TuLM/t44w6k/dhkqRVUGCCkEbV9w+W9d1erhOdO5os0hXxDsWjJr9w==
Date: Tue, 1 May 2018 07:38:16 +0300
From: jackm <jackm@dev.mellanox.co.il>
To: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        =?ISO-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Don Hiatt <don.hiatt@intel.com>,
        Dasaratharaman Chandramouli
        <dasaratharaman.chandramouli@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Sean Hefty <sean.hefty@intel.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core: Make ib_mad_client_id atomic
Message-ID: <20180501073816.00001ec6@dev.mellanox.co.il>
In-Reply-To: <1525108249.11756.93.camel@redhat.com>
References: <20180418142450.15581-1-Haakon.Bugge@oracle.com>
        <1524196555.11756.30.camel@redhat.com>
        <20180420153451.GF30433@ziepe.ca>
        <50E3FE4A-2C6E-4493-92E1-383C349FAE3A@oracle.com>
        <20180423221618.0000795d@dev.mellanox.co.il>
        <20180430144930.GB26895@ziepe.ca>
        <1525108249.11756.93.camel@redhat.com>
Organization: Mellanox
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w414ckvu011868

On Mon, 30 Apr 2018 13:10:49 -0400
Doug Ledford <dledford@redhat.com> wrote:

Looks good!

-Jack

> On Mon, 2018-04-30 at 08:49 -0600, Jason Gunthorpe wrote:
> > On Mon, Apr 23, 2018 at 10:16:18PM +0300, jackm wrote:
> >   
> > > > > TIDs need to be globally unique on the entire machine.    
> > > Jason, that is not exactly correct.  
> > 
> > The expecation for /dev/umad users is that they all receive locally
> > unique TID prefixes. The kernel may be OK to keep things
> > port-specific but it is slightly breaking the API we are presenting
> > to userspace to allow them to alias..
> > 
> > Jason  
> 
> Would people be happier with this commit message then:
> 
> IB/core: Make ib_mad_client_id atomic
>   
> Currently, the kernel protects access to the agent ID allocator on a
> per port basis using a spinlock, so it is impossible for two
> apps/threads on the same port to get the same TID, but it is entirely
> possible for two threads on different ports to end up with the same
> TID.  
> 
> As this can be confusing (regardless of it being legal according to
> the IB Spec 1.3, C13-18.1.1, in section 13.4.6.4 - TransactionID
> usage), and as the rdma-core user space API for /dev/umad devices
> implies unique TIDs even across ports, make the TID an atomic type so
> that no two allocations, regardless of port number, will be the same.
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> Reviewed-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
> Signed-off-by: Doug Ledford <dledford@redhat.com>
> 
> 
