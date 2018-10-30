Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B5EC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B340F2082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B340F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJ3Lwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 07:52:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeJ3Lwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 07:52:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A65C4356CD;
        Tue, 30 Oct 2018 03:01:01 +0000 (UTC)
Received: from xz-x1 (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D1105D75F;
        Tue, 30 Oct 2018 03:00:53 +0000 (UTC)
Date:   Tue, 30 Oct 2018 11:00:51 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Simon Guo <wei.guo.simon@linux.alibaba.com>,
        Eric Auger <eric.auger@redhat.com>,
        qixuan.wu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: Can VFIO pin only a specific region of guest mem when use pass
 through devices?
Message-ID: <20181030030051.GA22523@xz-x1>
References: <20181029024228.GA4279@simonLocalRHEL7.x64>
 <e4be89df-2bf9-76a2-497f-c6ba3256c95a@redhat.com>
 <20181029122922.7b2a9b0c@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181029122922.7b2a9b0c@t450s.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 30 Oct 2018 03:01:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 12:29:22PM -0600, Alex Williamson wrote:
> On Mon, 29 Oct 2018 17:14:46 +0800
> Jason Wang <jasowang@redhat.com> wrote:
> 
> > On 2018/10/29 上午10:42, Simon Guo wrote:
> > > Hi,
> > >
> > > I am using network device pass through mode with qemu x86(-device vfio-pci,host=0000:xx:yy.z)
> > > and “intel_iommu=on” in host kernel command line, and it shows the whole guest memory
> > > were pinned(vfio_pin_pages()), viewed by the “top” RES memory output. I understand it is due
> > > to device can DMA to any guest memory address and it cannot be swapped.
> > >
> > > However can we just pin a rang of address space allowed by iommu group of that device,
> > > instead of pin whole address space? I do notice some code like vtd_host_dma_iommu().
> > > Maybe there is already some way to enable that?
> > >
> > > Sorry if I missed some basics. I googled some but no luck to find the answer yet. Please
> > > let me know if any discussion already raised on that.
> > >
> > > Any other suggestion will also be appreciated. For example, can we modify the guest network
> > > card driver to allocate only from a specific memory region(zone), and qemu advises guest
> > > kernel to only pin that memory region(zone) accordingly?
> > >
> > > Thanks,
> > > - Simon  
> > 
> > 
> > One possible method is to enable IOMMU of VM.
> 
> Right, making use of a virtual IOMMU in the VM is really the only way
> to bound the DMA to some subset of guest memory, but vIOMMU usage by
> the guest is optional on x86 and even if the guest does use it, it might
> enable passthrough mode, which puts you back at the problem that all
> guest memory is pinned with the additional problem that it might also
> be accounted for once per assigned device and may hit locked memory
> limits.  Also, the DMA mapping and unmapping path with a vIOMMU is very
> slow, so performance of the device in the guest will be abysmal unless
> the use case is limited to very static mappings, such as userspace use
> within the guest for nested assignment or perhaps DPDK use cases.
> 
> Modifying the guest to only use a portion of memory for DMA sounds like
> a quite intrusive option.  There are certainly IOMMU models where the
> IOMMU provides a fixed IOVA range, but creating dynamic mappings within
> that range doesn't really solve anything given that it simply returns
> us to a vIOMMU with slow mapping.  A window with a fixed identity
> mapping used as a DMA zone seems plausible, but again, also pretty
> intrusive to the guest, possibly also to the drivers.  Host IOMMU page
> faulting can also help the pinned memory footprint, but of course
> requires hardware support and lots of new code paths, many of which are
> already being discussed for things like Scalable IOV and SVA.  Thanks,

Agree with Jason's and Alex's comments.  One trivial additional: the
whole guest RAM will possibly still be pinned for a very short period
during guest system boot (e.g., when running guest BIOS) and before
the guest kernel enables the vIOMMU for the assigned device since the
bootup code like BIOS would still need to be able to access the whole
guest memory.

Thanks,

-- 
Peter Xu
