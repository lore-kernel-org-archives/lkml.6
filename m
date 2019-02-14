Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC94C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E632A222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407184AbfBNNwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:52:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43804 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407169AbfBNNvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:51:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0181F80D;
        Thu, 14 Feb 2019 05:51:55 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A0943F675;
        Thu, 14 Feb 2019 05:51:53 -0800 (PST)
Subject: Re: [PATCH 2/8] initramfs: free initrd memory if opening
 /initrd.image fails
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org
References: <20190213174621.29297-1-hch@lst.de>
 <20190213174621.29297-3-hch@lst.de>
From:   Steven Price <steven.price@arm.com>
Message-ID: <e4246b25-628e-de5e-56ba-8d45ad9c9fa6@arm.com>
Date:   Thu, 14 Feb 2019 13:51:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213174621.29297-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2019 17:46, Christoph Hellwig wrote:
> We free the initrd memory for all successful or error cases except
> for the case where opening /initrd.image fails, which looks like an
> oversight.

This also changes the behaviour when CONFIG_INITRAMFS_FORCE is enabled -
specifically it means that the initrd is freed (previously it was
ignored and never freed). But that seems like reasonable behaviour and
the previous behaviour looks like another oversight. FWIW:

Reviewed-by: Steven Price <steven.price@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  init/initramfs.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 7cea802d00ef..1cba6bbeeb75 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -610,13 +610,12 @@ static int __init populate_rootfs(void)
>  		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
>  		err = unpack_to_rootfs((char *)initrd_start,
>  			initrd_end - initrd_start);
> -		if (!err) {
> -			free_initrd();
> +		if (!err)
>  			goto done;
> -		} else {
> -			clean_rootfs();
> -			unpack_to_rootfs(__initramfs_start, __initramfs_size);
> -		}
> +
> +		clean_rootfs();
> +		unpack_to_rootfs(__initramfs_start, __initramfs_size);
> +
>  		printk(KERN_INFO "rootfs image is not initramfs (%s)"
>  				"; looks like an initrd\n", err);
>  		fd = ksys_open("/initrd.image",
> @@ -630,7 +629,6 @@ static int __init populate_rootfs(void)
>  				       written, initrd_end - initrd_start);
>  
>  			ksys_close(fd);
> -			free_initrd();
>  		}
>  	done:
>  		/* empty statement */;
> @@ -642,9 +640,9 @@ static int __init populate_rootfs(void)
>  			printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
>  			clean_rootfs();
>  		}
> -		free_initrd();
>  #endif
>  	}
> +	free_initrd();
>  	flush_delayed_fput();
>  	return 0;
>  }
> 

