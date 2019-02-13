Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D196DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9CE2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbfBMRMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:12:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbfBMRL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:11:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C8DF300ADE;
        Wed, 13 Feb 2019 17:11:59 +0000 (UTC)
Received: from w520.home (ovpn-116-24.phx2.redhat.com [10.3.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9811D19C7B;
        Wed, 13 Feb 2019 17:11:58 +0000 (UTC)
Date:   Wed, 13 Feb 2019 10:11:58 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vfio_pci: Enable memory accesses before calling
 pci_map_rom
Message-ID: <20190213101158.707d963d@w520.home>
In-Reply-To: <20190213162821.GC22883@char.us.oracle.com>
References: <20190213101406.3934-1-eric.auger@redhat.com>
        <20190213162821.GC22883@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 13 Feb 2019 17:11:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 11:28:21 -0500
Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:

> On Wed, Feb 13, 2019 at 11:14:06AM +0100, Eric Auger wrote:
> > pci_map_rom/pci_get_rom_size() performs memory access in the ROM.
> > In case the Memory Space accesses were disabled, readw() is likely to
> > crash the host with a synchronous external abort (aarch64).  
> 
> Ouch. Is there an CVE for this?
> 
> Also I think this can cause x86 machines to blow up.
> 
> See https://xenbits.xen.org/xsa/advisory-120.html

The far more common response to a target abort on x86 is simply a -1
return.  Device assignment quickly becomes unfeasible in the general
case, as outlined in the above link by restricting only to SR-IOV VFs,
if we try to claim there is no possible way that the device cannot
trigger a fatal error on the host.  Systems implementing APEI pretty
much guarantee that by escalating device specific faults to fatal
errors and removing the host OS from the error handling path.  Some
platforms will even trigger a fatal error for a DMA outside of the
range mapped for the device by the IOMMU.  We can't probe for this
behavior to restrict the devices, we cannot know how DMA is programmed
for every device in order to babysit it, nor can we guarantee that the
PCI config space command register is the only way a device manages
access to I/O resources hosted on the device.  Restricting user access
to the command register therefore seems like a false sense of security,
potentially with behavioral issues to the user.

It would be great if we always had a hook into the error handling path
such that we could declare this as a user generated fault, kill the
user process, and keep running, but we're limited by the error handling
capabilities of the hardware and the degree to which the
platform/firmware allows OS control of that error handling.  Thanks,

Alex

> > 
> > In case memory accesses were disabled, re-enable them before the call
> > and disable them back again just after.
> > 
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > ---
> >  drivers/vfio/pci/vfio_pci.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index ff60bd1ea587..96b8bbd909d7 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -706,8 +706,10 @@ static long vfio_pci_ioctl(void *device_data,
> >  			break;
> >  		case VFIO_PCI_ROM_REGION_INDEX:
> >  		{
> > +			bool mem_access_disabled;
> >  			void __iomem *io;
> >  			size_t size;
> > +			u16 cmd;
> >  
> >  			info.offset = VFIO_PCI_INDEX_TO_OFFSET(info.index);
> >  			info.flags = 0;
> > @@ -723,6 +725,13 @@ static long vfio_pci_ioctl(void *device_data,
> >  					break;
> >  			}
> >  
> > +			pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > +			mem_access_disabled = !(cmd & PCI_COMMAND_MEMORY);
> > +			if (mem_access_disabled) {
> > +				cmd |= PCI_COMMAND_MEMORY;
> > +				pci_write_config_word(pdev, PCI_COMMAND, cmd);
> > +			}
> > +
> >  			/* Is it really there? */
> >  			io = pci_map_rom(pdev, &size);
> >  			if (!io || !size) {
> > @@ -731,6 +740,11 @@ static long vfio_pci_ioctl(void *device_data,
> >  			}
> >  			pci_unmap_rom(pdev, io);
> >  
> > +			if (mem_access_disabled) {
> > +				cmd &= ~PCI_COMMAND_MEMORY;
> > +				pci_write_config_word(pdev, PCI_COMMAND, cmd);
> > +			}
> > +
> >  			info.flags = VFIO_REGION_INFO_FLAG_READ;
> >  			break;
> >  		}
> > -- 
> > 2.20.1
> >   

