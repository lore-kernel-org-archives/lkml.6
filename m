Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567B1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B88B2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfAGUNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:13:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfAGUNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:13:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5940C057E00;
        Mon,  7 Jan 2019 20:13:42 +0000 (UTC)
Received: from x1.home (ovpn-116-25.phx2.redhat.com [10.3.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 216D86012C;
        Mon,  7 Jan 2019 20:13:42 +0000 (UTC)
Date:   Mon, 7 Jan 2019 13:13:41 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Laura Abbott <labbott@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio_pci: Add local source directory as include
Message-ID: <20190107131341.00581863@x1.home>
In-Reply-To: <CAK7LNAQtsW5KoOQmOB4uSv2zHM80azmHnEMj=2BunikhJQEpig@mail.gmail.com>
References: <20190104195714.30045-1-labbott@redhat.com>
        <874lakc09x.fsf@concordia.ellerman.id.au>
        <CAK7LNAQLEYc=czrJvzK8UXeXYm08TuLB62uMN2kFedkcW9b1pw@mail.gmail.com>
        <20190107120716.51d95854.cohuck@redhat.com>
        <CAK7LNAQtsW5KoOQmOB4uSv2zHM80azmHnEMj=2BunikhJQEpig@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 07 Jan 2019 20:13:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019 20:39:19 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> On Mon, Jan 7, 2019 at 8:09 PM Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > On Mon, 7 Jan 2019 19:12:10 +0900
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >  
> > > On Mon, Jan 7, 2019 at 6:18 PM Michael Ellerman <mpe@ellerman.id.au> wrote:  
> > > >
> > > > Laura Abbott <labbott@redhat.com> writes:  
> > > > > Commit 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2]
> > > > > subdriver") introduced a trace.h file in the local directory but
> > > > > missed adding the local include path, resulting in compilation
> > > > > failures with tracepoints:
> > > > >
> > > > > In file included from drivers/vfio/pci/trace.h:102,
> > > > >                  from drivers/vfio/pci/vfio_pci_nvlink2.c:29:
> > > > > ./include/trace/define_trace.h:89:42: fatal error: ./trace.h: No such file or directory
> > > > >  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > > > >
> > > > > Fix this by adjusting the include path.
> > > > >
> > > > > Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
> > > > > Signed-off-by: Laura Abbott <labbott@redhat.com>  
> >
> > (...)
> >  
> > > > Alex I assume you'll merge this fix via the vfio tree?
> > > >
> > > > cheers
> > > >  
> > > > > diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> > > > > index 9662c063a6b1..08d4676a8495 100644
> > > > > --- a/drivers/vfio/pci/Makefile
> > > > > +++ b/drivers/vfio/pci/Makefile
> > > > > @@ -1,3 +1,4 @@
> > > > > +ccflags-y                               += -I$(src)
> > > > >
> > > > >  vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
> > > > >  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
> > > > > --
> > > > > 2.20.1  
> > >
> > >
> > > Hi.
> > >
> > > If I correctly understand the usage of TRACE_INCLUDE_PATH,
> > > the correct fix should be like follows:
> > >
> > >
> > > diff --git a/drivers/vfio/pci/trace.h b/drivers/vfio/pci/trace.h
> > > index 228ccdb..4d13e51 100644
> > > --- a/drivers/vfio/pci/trace.h
> > > +++ b/drivers/vfio/pci/trace.h
> > > @@ -94,7 +94,7 @@ TRACE_EVENT(vfio_pci_npu2_mmap,
> > >  #endif /* _TRACE_VFIO_PCI_H */
> > >
> > >  #undef TRACE_INCLUDE_PATH
> > > -#define TRACE_INCLUDE_PATH .
> > > +#define TRACE_INCLUDE_PATH ../../drivers/vfio/pci
> > >  #undef TRACE_INCLUDE_FILE
> > >  #define TRACE_INCLUDE_FILE trace  
> >
> > Going from the comments in samples/trace_events/trace-events-sample.h,
> > I think both approaches are possible, and I see both used in various
> > places.
> >
> > Personally, I'd prefer Laura's patch, as it doesn't involve hardcoding
> > a path.

Numbering options for clarity:

1)
> ccflags-y += -I$(src)
> would add the header search path for all files in drivers/vfio/pci/
> whereas only the drivers/vfio/pci/vfio_pci_nvlink2.c needs it.
> 

2)
> CFLAGS_vfio_pci_nvlink2.o += -I$(src)
> is a bit better.
> However, it is not obvious why this extra header search path is needed
> until you find vfio_pci_nvlink2.c including trace.h
> 

3)
> #define TRACE_INCLUDE_PATH ../../drivers/vfio/pci
> clarifies the intention because the related code is all placed in trace.h
> 
> 
> 
> From the comment in include/trace/define_trace.h
> TRACE_INCLUDE_PATH is relative to include/trace/define_trace.h

In my scan of the tree, the most common solution seems to be 2) as this
is essentially recommended in the sample file.  3) is well represented,
with much fewer examples of 1), though it might depend how liberally
we grep out or examine the use cases.  Choice 1) also seems to be the
most shotgun approach, adding to the search path for all files.  From a
maintenance perspective I agree that 2) seems more error prone,
especially when the build system only catches the error on in-tree
builds, something I rarely do.  Therefore I'm leaning towards option
3).  The hardcoded path here doesn't seem much of an issue relative to
the negatives of the other approaches (how often do we move these
files?) and it keeps the trace support relatively self-contained.  Are
there further arguments for or against these options?  Otherwise who
wants to formally post the TRACE_INCLUDE_PATH version?  Thanks,

Alex
