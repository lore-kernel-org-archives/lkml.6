Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932842AbeBLFXz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 00:23:55 -0500
Received: from ozlabs.org ([103.22.144.67]:52927 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932543AbeBLFXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 00:23:52 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
        hbabu@us.ibm.com, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] powerpc/vas: Fix cleanup when VAS is not configured
In-Reply-To: <1518234567-24869-2-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com> <1518234567-24869-2-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 16:23:50 +1100
Message-ID: <87d11awzkp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> When VAS is not configured in the system, make sure to remove
> the VAS debugfs directory and unregister the platform driver.
>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
...
> diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
> index aebbe95..f83e27d8 100644
> --- a/arch/powerpc/platforms/powernv/vas.c
> +++ b/arch/powerpc/platforms/powernv/vas.c
> @@ -169,8 +169,11 @@ static int __init vas_init(void)
>  		found++;
>  	}
>  
> -	if (!found)
> +	if (!found) {
> +		platform_driver_unregister(&vas_driver);
> +		vas_cleanup_dbgdir();
>  		return -ENODEV;
> +	}

The better patch would be to move the call to vas_init_dbgdir() down
here, where we know we have successfully registered the driver.

cheers
