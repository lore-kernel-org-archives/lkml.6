Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1A8C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1908D208E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1908D208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbeHFPz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:55:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbeHFPz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:55:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 763857CBBA;
        Mon,  6 Aug 2018 13:46:45 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.7])
        by smtp.corp.redhat.com (Postfix) with SMTP id AB58476EC;
        Mon,  6 Aug 2018 13:46:41 +0000 (UTC)
Date:   Mon, 6 Aug 2018 16:46:40 +0300
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
Message-ID: <20180806164106-mutt-send-email-mst@kernel.org>
References: <20180802200646-mutt-send-email-mst@kernel.org>
 <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
 <20180802225738-mutt-send-email-mst@kernel.org>
 <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
 <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803220443-mutt-send-email-mst@kernel.org>
 <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
 <20180805031046-mutt-send-email-mst@kernel.org>
 <fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 06 Aug 2018 13:46:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 06 Aug 2018 13:46:45 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 02:52:54PM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2018-08-05 at 03:22 +0300, Michael S. Tsirkin wrote:
> > I see the allure of this, but I think down the road you will
> > discover passing a flag in libvirt XML saying
> > "please use a secure mode" or whatever is a good idea.
> > 
> > Even thought it is probably not required to address this
> > specific issue.
> > 
> > For example, I don't think ballooning works in secure mode,
> > you will be able to teach libvirt not to try to add a
> > balloon to the guest.
> 
> Right, we'll need some quirk to disable balloons  in the guest I
> suppose.
> 
> Passing something from libvirt is cumbersome because the end user may
> not even need to know about secure VMs. There are use cases where the
> security is a contract down to some special application running inside
> the secure VM, the sysadmin knows nothing about.
> 
> Also there's repercussions all the way to admin tools, web UIs etc...
> so it's fairly wide ranging.
> 
> So as long as we only need to quirk a couple of devices, it's much
> better contained that way.

So just the balloon thing already means that yes management and all the
way to the user tools must know this is going on. Otherwise
user will try to inflate the balloon and wonder why this does not work.

> > > Later on, (we may have even already run Linux at that point,
> > > unsecurely, as we can use Linux as a bootloader under some
> > > circumstances), we start a "secure image".
> > > 
> > > This is a kernel zImage that includes a "ticket" that has the
> > > appropriate signature etc... so that when that kernel starts, it can
> > > authenticate with the ultravisor, be verified (along with its ramdisk)
> > > etc... and copied (by the UV) into secure memory & run from there.
> > > 
> > > At that point, the hypervisor is informed that the VM has become
> > > secure.
> > > 
> > > So at that point, we could exit to qemu to inform it of the change,
> > 
> > That's probably a good idea too.
> 
> We probably will have to tell qemu eventually for migration, as we'll
> need some kind of key exchange phase etc... to deal with the crypto
> aspects (the actual page copy is sorted via encrypting the secure pages
> back to normal pages in qemu, but we'll need extra metadata).
> 
> > > and
> > > have it walk the qtree and "Switch" all the virtio devices to use the
> > > IOMMU I suppose, but it feels a lot grosser to me.
> > 
> > That part feels gross, yes.
> > 
> > > That's the only other option I can think of.
> > > 
> > > > However in this specific case, the flag does not need to come from the
> > > > hypervisor, it can be set by arch boot code I think.
> > > > Christoph do you see a problem with that?
> > > 
> > > The above could do that yes. Another approach would be to do it from a
> > > small virtio "quirk" that pokes a bit in the device to force it to
> > > iommu mode when it detects that we are running in a secure VM. That's a
> > > bit warty on the virito side but probably not as much as having a qemu
> > > one that walks of the virtio devices to change how they behave.
> > > 
> > > What do you reckon ?
> > 
> > I think you are right that for the dma limit the hypervisor doesn't seem
> > to need to know.
> 
> It's not just a limit mind you. It's a range, at least if we allocate
> just a single pool of insecure pages. swiotlb feels like a better
> option for us.
> 
> > > What we want to avoid is to expose any of this to the *end user* or
> > > libvirt or any other higher level of the management stack. We really
> > > want that stuff to remain contained between the VM itself, KVM and
> > > maybe qemu.
> > > 
> > > We will need some other qemu changes for migration so that's ok. But
> > > the minute you start touching libvirt and the higher levels it becomes
> > > a nightmare.
> > > 
> > > Cheers,
> > > Ben.
> > 
> > I don't believe you'll be able to avoid that entirely. The split between
> > libvirt and qemu is more about community than about code, random bits of
> > functionality tend to land on random sides of that fence.  Better add a
> > tag in domain XML early is my advice. Having said that, it's your
> > hypervisor. I'm just suggesting that when hypervisor does somehow need
> > to care then I suspect most people won't be receptive to the argument
> > that changing libvirt is a nightmare.
> 
> It only needs to care at runtime. The problem isn't changing libvirt
> per-se, I don't have a problem with that. The problem is that it means
> creating two categories of machines "secure" and "non-secure", which is
> end-user visible, and thus has to be escalated to all the various
> management stacks, UIs, etc... out there.
> 
> In addition, there are some cases where the individual creating the VMs
> may not have any idea that they are secure.
> 
> But yes, if we have to, we'll do it. However, so far, we don't think
> it's a great idea.
> 
> Cheers,
> Ben.

Here's another example: you can't migrate a secure vm to hypervisor
which doesn't support this feature. Again management tools above libvirt
need to know otherwise they will try.

> > > > > >   To get swiotlb you'll need to then use the DT/ACPI
> > > > > > dma-range property to limit the addressable range, and a swiotlb
> > > > > > capable plaform will use swiotlb automatically.
> > > > > 
> > > > > This cannot be done as you describe it.
> > > > > 
> > > > > The VM is created as a *normal* VM. The DT stuff is generated by qemu
> > > > > at a point where it has *no idea* that the VM will later become secure
> > > > > and thus will have to restrict which pages can be used for "DMA".
> > > > > 
> > > > > The VM will *at runtime* turn itself into a secure VM via interactions
> > > > > with the security HW and the Ultravisor layer (which sits below the
> > > > > HV). This happens way after the DT has been created and consumed, the
> > > > > qemu devices instanciated etc...
> > > > > 
> > > > > Only the guest kernel knows because it initates the transition. When
> > > > > that happens, the virtio devices have already been used by the guest
> > > > > firmware, bootloader, possibly another kernel that kexeced the "secure"
> > > > > one, etc... 
> > > > > 
> > > > > So instead of running around saying NAK NAK NAK, please explain how we
> > > > > can solve that differently.
> > > > > 
> > > > > Ben.
