Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeEQKRb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:17:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33152 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbeEQKR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:17:29 -0400
Subject: Re: [RFC PATCH] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        timur@codeaurora.org
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>, linux-arm-kernel@lists.infradead.org
References: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <74ae2347-464c-ddc1-3cb9-f928692e792f@arm.com>
Date: Thu, 17 May 2018 11:17:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/18 19:23, Sinan Kaya wrote:
> A host bridge is allowed to remap BAR addresses using _TRA attribute in
> _CRS windows.
> 
> pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
> pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
> 
> When a VGA device is behind such a host bridge and the resource is
> translated efifb driver is trying to do ioremap against bus address
> rather than the resource address and is failing to probe.
> 
> efifb driver is having difficulty locating the base address from BAR
> address when
> 
> efifb: probing for efifb
> efifb: cannot reserve video memory at 0x1e000000
> efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
> efifb: mode is 800x600x32, linelength=3200, pages=1
> efifb: scrolling: redraw
> efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> 
> Use the host bridge offset information to convert bus address to
> resource address in the fixup.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>   drivers/video/fbdev/efifb.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 46a4484..feef02b 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -428,6 +428,8 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>   {
>   	u64 base = screen_info.lfb_base;
>   	u64 size = screen_info.lfb_size;
> +	struct pci_host_bridge *bridge;
> +	struct resource_entry *window;
>   	int i;
>   
>   	if (efifb_pci_dev || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
> @@ -439,6 +441,27 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>   	if (!base)
>   		return;
>   
> +	bridge = pci_find_host_bridge(dev->bus);
> +	if (!bridge)
> +		return;
> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		phys_addr_t win_start;
> +		phys_addr_t win_end;
> +		size_t win_size;
> +
> +		if (resource_type(window->res) != IORESOURCE_MEM)
> +			continue;
> +
> +		win_start = window->res->start - window->offset;
> +		win_end = window->res->end - window->offset;
> +		win_size = window->res->end - window->res->start + 1;
> +		if (win_start <= base && win_end >= base + win_size - 1) {
> +			base += window->offset;
> +			break;
> +		}
> +	}
> +

Is this not pretty much just pcibios_bus_to_resource()?

Robin.

>   	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
>   		struct resource *res = &dev->resource[i];
>   
> 
