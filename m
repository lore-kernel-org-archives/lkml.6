Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F591C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DE82229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503028AbfBNUQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:16:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387876AbfBNUQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:16:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E64441A33;
        Thu, 14 Feb 2019 20:16:31 +0000 (UTC)
Received: from w520.home (ovpn-116-24.phx2.redhat.com [10.3.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4325319745;
        Thu, 14 Feb 2019 20:16:28 +0000 (UTC)
Date:   Thu, 14 Feb 2019 13:16:28 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2] vfio_pci: Enable memory accesses before calling
 pci_map_rom
Message-ID: <20190214131628.54ca06fc@w520.home>
In-Reply-To: <015103e3-c317-22f3-e209-f5ccf890bafb@redhat.com>
References: <20190213110610.4834-1-eric.auger@redhat.com>
        <20190213105200.1deafb62@w520.home>
        <015103e3-c317-22f3-e209-f5ccf890bafb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 14 Feb 2019 20:16:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 19:27:15 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Alex,
> 
> On 2/13/19 6:52 PM, Alex Williamson wrote:
> > On Wed, 13 Feb 2019 12:06:10 +0100
> > Eric Auger <eric.auger@redhat.com> wrote:
> >   
> >> pci_map_rom/pci_get_rom_size() performs memory access in the ROM.
> >> In case the Memory Space accesses were disabled, readw() is likely to
> >> crash the host with a synchronous external abort (aarch64).  
> > 
> > As implied in response to Konrad, the likeliness really depends on the
> > whole platform, not just the CPU architecture.  It's a class of
> > problems that depends on OS control or error handling, which we simply
> > don't have on many systems.  But we can fix this instance of it.  
> 
> Agreed, I just hit this issue on one specific aarch64 machine
> >   
> >> In case memory accesses were disabled, re-enable them before the call
> >> and disable them back again just after.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>  
> > 
> > This has been around since the beginning, but maybe a Fixes tag would
> > be useful:
> > 
> > Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")  
> OK
> >   
> >>
> >> ---
> >>
> >> v1 -> v2:
> >> - also re-enable in case of error
> >> ---
> >>  drivers/vfio/pci/vfio_pci.c | 17 ++++++++++++++++-
> >>  1 file changed, 16 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> >> index ff60bd1ea587..721aa55424a4 100644
> >> --- a/drivers/vfio/pci/vfio_pci.c
> >> +++ b/drivers/vfio/pci/vfio_pci.c
> >> @@ -706,8 +706,10 @@ static long vfio_pci_ioctl(void *device_data,
> >>  			break;
> >>  		case VFIO_PCI_ROM_REGION_INDEX:
> >>  		{
> >> +			bool mem_access_disabled;
> >>  			void __iomem *io;
> >>  			size_t size;
> >> +			u16 cmd;
> >>  
> >>  			info.offset = VFIO_PCI_INDEX_TO_OFFSET(info.index);
> >>  			info.flags = 0;
> >> @@ -723,15 +725,28 @@ static long vfio_pci_ioctl(void *device_data,
> >>  					break;
> >>  			}
> >>  
> >> +			pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> >> +			mem_access_disabled = !(cmd & PCI_COMMAND_MEMORY);
> >> +			if (mem_access_disabled) {
> >> +				cmd |= PCI_COMMAND_MEMORY;
> >> +				pci_write_config_word(pdev, PCI_COMMAND, cmd);
> >> +			}
> >> +
> >>  			/* Is it really there? */
> >>  			io = pci_map_rom(pdev, &size);
> >>  			if (!io || !size) {
> >>  				info.size = 0;
> >> -				break;
> >> +				goto rom_info_out;
> >>  			}
> >>  			pci_unmap_rom(pdev, io);
> >>  
> >>  			info.flags = VFIO_REGION_INFO_FLAG_READ;
> >> +rom_info_out:
> >> +			if (mem_access_disabled) {
> >> +				cmd &= ~PCI_COMMAND_MEMORY;
> >> +				pci_write_config_word(pdev, PCI_COMMAND, cmd);
> >> +			}
> >> +
> >>  			break;
> >>  		}
> >>  		case VFIO_PCI_VGA_REGION_INDEX:  
> > 
> > I don't think we need to be so timid about the command register and we
> > can also avoid the goto by modifying the test (testing io and size in
> > the original is probably overly paranoid), perhaps simply:  
> Yes looks fine.
> 
> Do you want to respin or do you prefer I do?

Please take it, test it, and repost it, I haven't tested it at all.
Thanks,

Alex
