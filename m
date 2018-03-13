Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932805AbeCMMVl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:21:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932491AbeCMMVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:21:40 -0400
From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 1/3] vfio/pci: Pull BAR mapping setup from read-write path
To: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
References: <20180228195504.25283.45666.stgit@gimli.home>
 <20180228201446.25283.82272.stgit@gimli.home>
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, peterx@redhat.com,
        aik@ozlabs.ru
Message-ID: <dd769f9e-b617-69a6-474f-ced7219f50f9@redhat.com>
Date: Tue, 13 Mar 2018 13:21:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180228201446.25283.82272.stgit@gimli.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,
On 28/02/18 21:14, Alex Williamson wrote:
> This creates a common helper that we'll use for ioeventfd setup.

> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/vfio/pci/vfio_pci_rdwr.c |   39 ++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 357243d76f10..5f2b376dcebd 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -113,6 +113,30 @@ static ssize_t do_io_rw(void __iomem *io, char __user *buf,
>  	return done;
>  }
>  
> +static int vfio_pci_setup_barmap(struct vfio_pci_device *vdev, int bar)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	int ret;
> +	void __iomem *io;
> +
> +	if (vdev->barmap[bar])
> +		return 0;
> +
> +	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
> +	if (ret)
> +		return ret;
> +
> +	io = pci_iomap(pdev, bar, 0);
> +	if (!io) {
> +		pci_release_selected_regions(pdev, 1 << bar);
> +		return -ENOMEM;
> +	}
> +
> +	vdev->barmap[bar] = io;
> +
> +	return 0;
> +}
> +
>  ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev, char __user *buf,
>  			size_t count, loff_t *ppos, bool iswrite)
>  {
> @@ -147,22 +171,13 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev, char __user *buf,
>  		if (!io)
>  			return -ENOMEM;
>  		x_end = end;
> -	} else if (!vdev->barmap[bar]) {
> -		int ret;
> -
> -		ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
> +	} else {
> +		int ret = vfio_pci_setup_barmap(vdev, bar);
>  		if (ret)
>  			return ret;
>  
> -		io = pci_iomap(pdev, bar, 0);
> -		if (!io) {
> -			pci_release_selected_regions(pdev, 1 << bar);
> -			return -ENOMEM;
> -		}
> -
> -		vdev->barmap[bar] = io;
> -	} else
>  		io = vdev->barmap[bar];
> +	}
>  
>  	if (bar == vdev->msix_bar) {
>  		x_start = vdev->msix_offset;
> 
