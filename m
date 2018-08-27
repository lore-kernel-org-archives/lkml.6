Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E29C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6F4208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fwBkrMN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6F4208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeH0Vx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:53:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeH0Vx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ICxQOCwPYVaulUctenArGL34326lGVYLeH0tsWd3ir4=; b=fwBkrMN4g6d8QHvR1qQptABTW
        LqmgXtjkS1czqTZ669VDH5osMRTC5qRpW4m8uzKPvwN5AKKS4TjWhCmxE51SxBrukp+EqkkNdvAxf
        b3qYRT3aroNQhgDhBsIGhByXRTKoEmU0ZY6vyHWQkYQGj//KAwd7IGBCgMJ1aL6Qj7fL7v/WmFguX
        OofYBC+FKSBJM7ztvyWGE0RcSmFfJWvmhkEXqJ0cEAjj8Cxpb3XtiGU2EVT6agp0CecL1TzFeZJik
        v7i81sfM2BkJpQ0XybdAJD8etaPyZQzxUwgRyZV0P9M/sbWSNsK/ApHK3vO4+cliLMK1GMY6xe6SH
        vgYzhIT8A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuLtZ-0003sY-5T; Mon, 27 Aug 2018 18:05:45 +0000
Date:   Mon, 27 Aug 2018 11:05:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/3] x86: Convert vdso to use vm_fault_t
Message-ID: <20180827180544.GA24544@bombadil.infradead.org>
References: <20180703123910.2180-1-willy@infradead.org>
 <20180703123910.2180-2-willy@infradead.org>
 <alpine.DEB.2.21.1807161116590.2644@nanos.tec.linutronix.de>
 <CAFqt6zbgoTgw1HNp+anOYY8CiU1BPoNeeddsnGGXWY_hVOd5iQ@mail.gmail.com>
 <alpine.DEB.2.21.1808031503370.1745@nanos.tec.linutronix.de>
 <CAFqt6zbJq9kca8dHDVAs-MOWNZgo2C=id3Cp4M0C76MQDXevJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zbJq9kca8dHDVAs-MOWNZgo2C=id3Cp4M0C76MQDXevJg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 09:01:48PM +0530, Souptick Joarder wrote:
> On Fri, Aug 3, 2018 at 6:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Fri, 3 Aug 2018, Souptick Joarder wrote:
> > > On Mon, Jul 16, 2018 at 2:47 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > On Tue, 3 Jul 2018, Matthew Wilcox wrote:
> > > >
> > > >> Return vm_fault_t codes directly from the appropriate mm routines instead
> > > >> of converting from errnos ourselves.  Fixes a minor bug where we'd return
> > > >> SIGBUS instead of the correct OOM code if we ran out of memory allocating
> > > >> page tables.
> > > >>
> > > >> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> > > >
> > > > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > > >
> > >
> > > Thomas, are these 3 patches part of this series will be queued
> > > for 4.19 ?
> >
> > I don't know. I expected that these go through the mm tree, but if nobody
> > feels responsible, I could pick up the whole lot. But I'd like to see acks
> > from the mm folks for [1/3] and [3/3]
> >
> >   https://lkml.kernel.org/r/20180703123910.2180-1-willy@infradead.org
> >
> > Thanks,
> >
> >         tglx
> >
> 
> Any comment from mm reviewers for patch [1/3] and [3/3] ??
> 
> https://lkml.kernel.org/r/20180703123910.2180-1-willy@infradead.org

I think at this point, it would probably be best to ask Andrew to pick
up all three of these patches.

In addition to these three, I see the following places that need to be changed:

Documentation/gpu/drm-mm.rst:300:               int (*fault)(struct vm_fault *vmf);

drivers/gpu/drm/virtio/virtgpu_ttm.c:117:static int virtio_gpu_ttm_fault(struct vm_fault *vmf)
 - #if 0 code.  convert anyway.

drivers/gpu/drm/vkms/vkms_drv.h:68:int vkms_gem_fault(struct vm_fault *vmf);
drivers/gpu/drm/vkms/vkms_gem.c:46:int vkms_gem_fault(struct vm_fault *vmf)

fs/ext4/ext4.h:2472:extern int ext4_page_mkwrite(struct vm_fault *vmf);
fs/ext4/ext4.h:2473:extern int ext4_filemap_fault(struct vm_fault *vmf);
fs/ext4/inode.c:6154:int ext4_page_mkwrite(struct vm_fault *vmf)
fs/ext4/inode.c:6251:int ext4_filemap_fault(struct vm_fault *vmf)

fs/iomap.c:1059:int iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
include/linux/iomap.h:144:int iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops);
 - I saw you just resent this patch.

mm/filemap.c:2751:int filemap_page_mkwrite(struct vm_fault *vmf)
 - This is the NOMMU case, so I suspect your testing didn't catch it.

