Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933492AbeE1T10 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 15:27:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755765AbeE1T1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 15:27:23 -0400
Subject: Re: [PATCH] vfio/pci: remove a bogus cast in vfio_msi_set_block()
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20180528074756.bgl5fxvn7foe5uhn@kili.mountain>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8df5c218-cc97-3dbc-e820-f8bdc710ac17@redhat.com>
Date: Mon, 28 May 2018 21:27:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180528074756.bgl5fxvn7foe5uhn@kili.mountain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 05/28/2018 09:47 AM, Dan Carpenter wrote:
> This cast is confusing...  The "start" variable is an unsigned int.  We
> absolutely do not want to cast it to a negative int so why is the cast
> there?  It turns out, when you look at the context, it's a no-op and we
> can just remove it.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 1c46045b0e7f..2724fed62129 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -368,7 +368,7 @@ static int vfio_msi_set_block(struct vfio_pci_device *vdev, unsigned start,
>  	}
>  
>  	if (ret) {
> -		for (--j; j >= (int)start; j--)
> +		for (--j; j >= start; j--)
I think this was done one purpose as j can be -1 while start is an
unsigned.

See b95d9305e8cb8d432ca02da1b759fef59bc50ace
"../.., -1 being compared as unsigned doesn't produce the intended stop
condition."

If I remember correctly this led to a bug.

Thanks

Eric
>  			vfio_msi_set_vector_signal(vdev, j, -1, msix);
>  	}
>  
> 
