Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04321C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF95221920
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391515AbfBMKkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:40:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfBMKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:40:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6E3289AD3;
        Wed, 13 Feb 2019 10:39:59 +0000 (UTC)
Received: from [10.36.116.102] (ovpn-116-102.ams2.redhat.com [10.36.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEBF760856;
        Wed, 13 Feb 2019 10:39:51 +0000 (UTC)
Subject: Re: [PATCH] vfio_pci: Enable memory accesses before calling
 pci_map_rom
To:     eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, alex.williamson@redhat.com
References: <20190213101406.3934-1-eric.auger@redhat.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <e827c0f3-74dc-6a45-1cbe-03cda74ffdf6@redhat.com>
Date:   Wed, 13 Feb 2019 11:39:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213101406.3934-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 13 Feb 2019 10:39:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 2/13/19 11:14 AM, Eric Auger wrote:
> pci_map_rom/pci_get_rom_size() performs memory access in the ROM.
> In case the Memory Space accesses were disabled, readw() is likely to
> crash the host with a synchronous external abort (aarch64).
> 
> In case memory accesses were disabled, re-enable them before the call
> and disable them back again just after.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index ff60bd1ea587..96b8bbd909d7 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -706,8 +706,10 @@ static long vfio_pci_ioctl(void *device_data,
>  			break;
>  		case VFIO_PCI_ROM_REGION_INDEX:
>  		{
> +			bool mem_access_disabled;
>  			void __iomem *io;
>  			size_t size;
> +			u16 cmd;
>  
>  			info.offset = VFIO_PCI_INDEX_TO_OFFSET(info.index);
>  			info.flags = 0;
> @@ -723,6 +725,13 @@ static long vfio_pci_ioctl(void *device_data,
>  					break;
>  			}
>  
> +			pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +			mem_access_disabled = !(cmd & PCI_COMMAND_MEMORY);
> +			if (mem_access_disabled) {
> +				cmd |= PCI_COMMAND_MEMORY;
> +				pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +			}
> +
>  			/* Is it really there? */
>  			io = pci_map_rom(pdev, &size);
>  			if (!io || !size) {
> @@ -731,6 +740,11 @@ static long vfio_pci_ioctl(void *device_data,
>  			}
>  			pci_unmap_rom(pdev, io);
>  
> +			if (mem_access_disabled) {
> +				cmd &= ~PCI_COMMAND_MEMORY;
> +				pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +			}
I failed to re-enable in case of error. I will respin.

Thanks

Eric
> +
>  			info.flags = VFIO_REGION_INFO_FLAG_READ;
>  			break;
>  		}
> 
