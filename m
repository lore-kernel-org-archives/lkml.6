Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86DEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F245208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbfBSVr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:47:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfBSVr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:47:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B652806A8;
        Tue, 19 Feb 2019 21:47:57 +0000 (UTC)
Received: from w520.home (ovpn-116-24.phx2.redhat.com [10.3.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A01B66076;
        Tue, 19 Feb 2019 21:47:55 +0000 (UTC)
Date:   Tue, 19 Feb 2019 14:47:54 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v3] vfio_pci: Enable memory accesses before calling
 pci_map_rom
Message-ID: <20190219144754.278fb075@w520.home>
In-Reply-To: <20190215161606.32334-1-eric.auger@redhat.com>
References: <20190215161606.32334-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 19 Feb 2019 21:47:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 17:16:06 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> pci_map_rom/pci_get_rom_size() performs memory access in the ROM.
> In case the Memory Space accesses were disabled, readw() is likely
> to trigger a synchronous external abort on some platforms.
> 
> In case memory accesses were disabled, re-enable them before the
> call and disable them back again just after.
> 
> Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>

Applied to vfio next branch for v5.1.  Thanks,

Alex

> ---
> v2 -> v3:
> - follow Alex re-writing
> 
> v1 -> v2:
> - also re-enable in case of error
> ---
>  drivers/vfio/pci/vfio_pci.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index ff60bd1ea587..4b0d30f1eabc 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -708,6 +708,7 @@ static long vfio_pci_ioctl(void *device_data,
>  		{
>  			void __iomem *io;
>  			size_t size;
> +			u16 orig_cmd;
>  
>  			info.offset = VFIO_PCI_INDEX_TO_OFFSET(info.index);
>  			info.flags = 0;
> @@ -723,15 +724,23 @@ static long vfio_pci_ioctl(void *device_data,
>  					break;
>  			}
>  
> -			/* Is it really there? */
> -			io = pci_map_rom(pdev, &size);
> -			if (!io || !size) {
> -				info.size = 0;
> -				break;
> -			}
> -			pci_unmap_rom(pdev, io);
> +			/*
> +			 * Is it really there?  Enable memory decode for
> +			 * implicit access in pci_map_rom().
> +			 */
> +			pci_read_config_word(pdev, PCI_COMMAND, &orig_cmd);
> +			pci_write_config_word(pdev, PCI_COMMAND,
> +					      orig_cmd | PCI_COMMAND_MEMORY);
>  
> -			info.flags = VFIO_REGION_INFO_FLAG_READ;
> +			io = pci_map_rom(pdev, &size);
> +			if (io) {
> +				info.flags = VFIO_REGION_INFO_FLAG_READ;
> +				pci_unmap_rom(pdev, io);
> +			} else {
> +				info.size = 0;
> +			}
> +
> +			pci_write_config_word(pdev, PCI_COMMAND, orig_cmd);
>  			break;
>  		}
>  		case VFIO_PCI_VGA_REGION_INDEX:

