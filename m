Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759CDC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C9F2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C9F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbeLNKKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:10:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeLNKKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:10:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3ACFCC0495BF;
        Fri, 14 Dec 2018 10:10:07 +0000 (UTC)
Received: from work-vm (ovpn-117-198.ams2.redhat.com [10.36.117.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B61395D6B3;
        Fri, 14 Dec 2018 10:09:59 +0000 (UTC)
Date:   Fri, 14 Dec 2018 10:09:57 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>, sweil@redhat.com,
        Steven Whitehouse <swhiteho@redhat.com>
Subject: Re: [PATCH 15/52] fuse: map virtio_fs DAX window BAR
Message-ID: <20181214100956.GC2454@work-vm>
References: <20181210171318.16998-1-vgoyal@redhat.com>
 <20181210171318.16998-16-vgoyal@redhat.com>
 <CAA9_cmdLvFqG_Us5ZoBopj2ssWzxVbyNqf4XcgmY+=D_gARWDA@mail.gmail.com>
 <20181213200936.GU2313@work-vm>
 <CAPcyv4hwPBGLkAN8MKhtti8e-=hksg+oD3CDAUY6B9uh54zBLw@mail.gmail.com>
 <20181213204052.GE4384@redhat.com>
 <20181213211819.GF4384@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213211819.GF4384@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 14 Dec 2018 10:10:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vivek Goyal (vgoyal@redhat.com) wrote:
> On Thu, Dec 13, 2018 at 03:40:52PM -0500, Vivek Goyal wrote:
> > On Thu, Dec 13, 2018 at 12:15:51PM -0800, Dan Williams wrote:
> > > On Thu, Dec 13, 2018 at 12:09 PM Dr. David Alan Gilbert
> > > <dgilbert@redhat.com> wrote:
> > > >
> > > > * Dan Williams (dan.j.williams@intel.com) wrote:
> > > > > On Mon, Dec 10, 2018 at 9:22 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > >
> > > > > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > >
> > > > > > Experimental QEMU code introduces an MMIO BAR for mapping portions of
> > > > > > files in the virtio-fs device.  Map this BAR so that FUSE DAX can access
> > > > > > file contents from the host page cache.
> > > > >
> > > > > FUSE DAX sounds terrifying, can you explain a bit more about what this is?
> > > >
> > > > We've got a guest running in QEMU, it sees an emulated PCI device;
> > > > that runs a FUSE protocol over virtio on that PCI device, but also has
> > > > a trick where via commands sent over the virtio queue associated with that device,
> > > > (fragments of) host files get mmap'd into the qemu virtual memory that corresponds
> > > > to the kvm slot exposed to the guest for that bar.
> > > >
> > > > The guest sees those chunks in that BAR, and thus you can read/write
> > > > to the host file by directly writing into that BAR.
> > > 
> > > Ok so it's all software emulated and there won't be hardware DMA
> > > initiated by the guest to that address?
> > 
> > That's my understanding.
> > 
> > > I.e. if the host file gets
> > > truncated / hole-punched the guest would just cause a refault and the
> > > filesystem could fill in the block,
> > 
> > Right
> > 
> > > or the guest is expected to die if
> > > the fault to the truncated file range results in SIGBUS.
> > 
> > Are you referring to the case where a file page is mapped in qemu and
> > another guest/process trucates that page and when qemu tries to access it it
> > will get SIGBUS. Have not tried it, will give it a try. Not sure what
> > happens when QEMU receives SIGBUS.
> > 
> > Having said that, this is not different from the case of one process
> > mapping a file and another process truncating the file and first process
> > getting SIGBUS, right?
> 
> Ok, tried this and guest process hangs.
> 
> Stefan, dgilbert, this reminds me that we have faced this issue during
> our testing and we decided that this will need some fixing in KVM. I
> even put this in as part of changelog of patch with subject "fuse: Take
> inode lock for dax inode truncation"
> 
> "Another problem is, if we setup a mapping in fuse_iomap_begin(), and
>  file gets truncated and dax read/write happens, KVM currently hangs.
>  It tries to fault in a page which does not exist on host (file got
>  truncated). It probably requries fixing in KVM."
> 
> Not sure what should happen though when qemu receives SIGBUS in this
> case.

Yes, and I noted it in the TODO in my qemu patch posting.

We need to figure out what we want the guest to see in this case and
figure out how to make QEMU/kvm fix it up so that the guest doesn't
see anything odd.

Dave

> Thanks
> Vivek
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
