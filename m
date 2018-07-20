Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F2BECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1762064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pk1QvNSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1762064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbeGTU0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:26:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388096AbeGTU0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/7u4+OD27GlP3cqEM5lcFMPz0NX/FTMb22m+nZBXNy0=; b=Pk1QvNSq0u7SSY4LajqvbC/kt
        i6cqtan5jV3VzmQgH07pi3UtrASlovj5bO1ACmnUn5waE0LhUfBkFtB0iu9B10ra1n3Uk8tio6UzI
        wxMezxo8Urort8JTaEMAx/XSVyB16mOKNVbW4ioqHOkdLBj9WxHK5w03+hFTXU3Gkjxz2VPAKv10w
        qz07FI3TsDGJb94uejSgfOoVVst+NAjS2R+5pyOeLMfXWeUY1HVeOPgVy/x88NWcI7AE5+gAc7kdt
        rXHa8cWVvrwm1PiUsTMzxAiyzWiDnc0BnFDaabmJIcLtc396ZmQ7K+vDXmsYVOk+QX/nir34cy5hp
        a7Rdwr5ig==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgbCx-0000WG-9s; Fri, 20 Jul 2018 19:36:55 +0000
Date:   Fri, 20 Jul 2018 12:36:55 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Bob Peterson <rpeterso@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH] fs: iomap: Change return type to vm_fault_t
Message-ID: <20180720193655.GA2736@bombadil.infradead.org>
References: <20180702154354.GA3919@jordon-HP-15-Notebook-PC>
 <CAHc6FU6CVaT3W15n4jSiy6F4cZEFa9HdrZ8NRrU2GppTXr7p8A@mail.gmail.com>
 <20180703213943.GU32415@magnolia>
 <CAHc6FU4sZj4DFbQddXk2Uo5Nh4EOFM6rdAnwD3kmnN2RjvL9OQ@mail.gmail.com>
 <CAFqt6zY4BLw4HeaQmwgv2B+hQLnULuyvJDkcRd5-CbYTZuPw+w@mail.gmail.com>
 <20180720060944.GA4823@magnolia>
 <CAFqt6zZTqLP2TPE-ANn7HTkakU=zs3hLJ1DC3a2Y=ZR+ASYfuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zZTqLP2TPE-ANn7HTkakU=zs3hLJ1DC3a2Y=ZR+ASYfuQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 12:25:26PM +0530, Souptick Joarder wrote:
> At this point we are almost done with vm_fault_t migration in all drivers/fs
> except 3 patches and all the changes will be available in 4.19-rc1.

I think there's a little more than that left to do.  I'm looking at
linux-next 20180720.

Documentation/filesystems/Locking:      int (*fault)(struct vm_area_struct*, struct vm_fault *);
arch/s390/kernel/vdso.c-static int vdso_fault(const struct vm_special_mapping *sm,
arch/s390/kernel/vdso.c:                      struct vm_area_struct *vma, struct vm_fault *vmf)
arch/x86/entry/vdso/vma.c-static int vdso_fault(const struct vm_special_mapping *sm,
arch/x86/entry/vdso/vma.c:                    struct vm_area_struct *vma, struct vm_fault *vmf)
drivers/dax/device.c:static int __dev_dax_pte_fault(struct dev_dax *dev_dax, struct vm_fault *vmf)
drivers/gpu/drm/armada/armada_gem.c:static int armada_gem_vm_fault(struct vm_fault *vmf)
drivers/gpu/drm/etnaviv/etnaviv_gem.c:int etnaviv_gem_fault(struct vm_fault *vmf)
drivers/gpu/drm/msm/msm_gem.c:int msm_gem_fault(struct vm_fault *vmf)
drivers/gpu/drm/virtio/virtgpu_ttm.c:static int virtio_gpu_ttm_fault(struct vm_fault *vmf)
drivers/gpu/drm/vkms/vkms_gem.c:int vkms_gem_fault(struct vm_fault *vmf)
fs/buffer.c:int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
fs/ceph/addr.c:static int ceph_filemap_fault(struct vm_fault *vmf)
fs/ext4/inode.c:int ext4_page_mkwrite(struct vm_fault *vmf)
fs/iomap.c:int iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
fs/userfaultfd.c:int handle_userfault(struct vm_fault *vmf, unsigned long reason)
mm/filemap.c:int filemap_page_mkwrite(struct vm_fault *vmf)
mm/huge_memory.c:static int __do_huge_pmd_anonymous_page(struct vm_fault *vmf, struct page *page,
mm/memory.c:static int do_page_mkwrite(struct vm_fault *vmf)

That's about 18 files left to handle.  I know some of these are still
in flight, but others I don't think I've seen patches for.

To get to the end-goal of eliminating vm_insert_* (leaving only
vmf_insert_*), there are some other tricky customers to satisfy.

remap_vmalloc_range_partial() is one; fortunately neither of the two
callers care about the errno; they choose their own errno to return if
an error happens, so we can change that one too.

I don't have time to go through the rest now ;-)
