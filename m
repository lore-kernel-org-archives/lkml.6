Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6126AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B1D2154D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B1D2154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbeHBWqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:46:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729774AbeHBWqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:46:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8C664074442;
        Thu,  2 Aug 2018 20:53:13 +0000 (UTC)
Received: from redhat.com (ovpn-117-57.ams2.redhat.com [10.36.117.57])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4E4D2215670D;
        Thu,  2 Aug 2018 20:53:09 +0000 (UTC)
Date:   Thu, 2 Aug 2018 23:53:08 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
        haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180802235233-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
 <20180730155633-mutt-send-email-mst@kernel.org>
 <20180731173052.GA17153@infradead.org>
 <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
 <20180802003823-mutt-send-email-mst@kernel.org>
 <7779442d7889ee943b3e4ff6c63ec90b4a58b79d.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7779442d7889ee943b3e4ff6c63ec90b4a58b79d.camel@kernel.crashing.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 02 Aug 2018 20:53:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 02 Aug 2018 20:53:13 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 10:33:05AM -0500, Benjamin Herrenschmidt wrote:
> On Thu, 2018-08-02 at 00:56 +0300, Michael S. Tsirkin wrote:
> > > but it's not, VMs are
> > > created in "legacy" mode all the times and we don't know at VM creation
> > > time whether it will become a secure VM or not. The way our secure VMs
> > > work is that they start as a normal VM, load a secure "payload" and
> > > call the Ultravisor to "become" secure.
> > > 
> > > So we're in a bit of a bind here. We need that one-liner optional arch
> > > hook to make virtio use swiotlb in that "IOMMU bypass" case.
> > > 
> > > Ben.
> > 
> > And just to make sure I understand, on your platform DMA APIs do include
> > some of the cache flushing tricks and this is why you don't want to
> > declare iommu support in the hypervisor?
> 
> I'm not sure I parse what you mean.
> 
> We don't need cache flushing tricks.

You don't but do real devices on same platform need them?

> The problem we have with our
> "secure" VMs is that:
> 
>  - At VM creation time we have no idea it's going to become a secure
> VM, qemu doesn't know anything about it, and thus qemu (or other
> management tools, libvirt etc...) are going to create "legacy" (ie
> iommu bypass) virtio devices.
> 
>  - Once the VM goes secure (early during boot but too late for qemu),
> it will need to make virtio do bounce-buffering via swiotlb because
> qemu cannot physically access most VM pages (blocked by HW security
> features), we need to bounce buffer using some unsecure pages that are
> accessible to qemu.
> 
> That said, I wouldn't object for us to more generally switch long run
> to changing qemu so that virtio on powerpc starts using the IOMMU as a
> default provided we fix our guest firmware to understand it (it
> currently doesn't), and provided we verify that the performance impact
> on things like vhost is negligible.
> 
> Cheers,
> Ben.
> 
