Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968464AbeEYUze (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:55:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968275AbeEYUzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:55:33 -0400
Date: Fri, 25 May 2018 14:55:32 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 08/33] vfio: use match_string() helper
Message-ID: <20180525145532.1de2e94f@w520.home>
In-Reply-To: <1526903890-35761-9-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
        <1526903890-35761-9-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2018 19:57:45 +0800
Yisheng Xie <xieyisheng1@huawei.com> wrote:

> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: kvm@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/vfio/vfio.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Applied to the vfio next branch for v4.18 with Andy's R-b.  Thanks,

Alex

 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 721f97f..6483387 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -630,8 +630,6 @@ static struct vfio_device *vfio_group_get_device(struct vfio_group *group,
>  
>  static bool vfio_dev_whitelisted(struct device *dev, struct device_driver *drv)
>  {
> -	int i;
> -
>  	if (dev_is_pci(dev)) {
>  		struct pci_dev *pdev = to_pci_dev(dev);
>  
> @@ -639,12 +637,9 @@ static bool vfio_dev_whitelisted(struct device *dev, struct device_driver *drv)
>  			return true;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(vfio_driver_whitelist); i++) {
> -		if (!strcmp(drv->name, vfio_driver_whitelist[i]))
> -			return true;
> -	}
> -
> -	return false;
> +	return match_string(vfio_driver_whitelist,
> +			    ARRAY_SIZE(vfio_driver_whitelist),
> +			    drv->name) >= 0;
>  }
>  
>  /*
