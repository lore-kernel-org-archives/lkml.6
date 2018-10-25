Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1920FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD67F20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD67F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJZDSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:18:38 -0400
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:44909 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727400AbeJZDSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:18:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 81F3F18000C08;
        Thu, 25 Oct 2018 18:44:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: word91_b9c735ca3608
X-Filterd-Recvd-Size: 2421
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Oct 2018 18:44:39 +0000 (UTC)
Message-ID: <e0cd65fdd6afc17b2be9b3ac64d50b95b2c2f32e.camel@perches.com>
Subject: Re: [PATCH] mm/page_owner: use vmalloc instead of kmalloc
From:   Joe Perches <joe@perches.com>
To:     miles.chen@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 25 Oct 2018 11:44:38 -0700
In-Reply-To: <1540492481-4144-1-git-send-email-miles.chen@mediatek.com>
References: <1540492481-4144-1-git-send-email-miles.chen@mediatek.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-26 at 02:34 +0800, miles.chen@mediatek.com wrote:
> From: Miles Chen <miles.chen@mediatek.com>
> 
> The kbuf used by page owner is allocated by kmalloc(),
> which means it can use only normal memory and there might
> be a "out of memory" issue when we're out of normal memory.
> 
> Use vmalloc() so we can also allocate kbuf from highmem
> on 32bit kernel.

If this is really necessary, using kvmalloc/kvfree would
be better as the vmalloc space is also limited.

> diff --git a/mm/page_owner.c b/mm/page_owner.c
[]
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/debugfs.h>
>  #include <linux/mm.h>
> -#include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include <linux/bootmem.h>
>  #include <linux/stacktrace.h>
> @@ -10,6 +9,7 @@
>  #include <linux/migrate.h>
>  #include <linux/stackdepot.h>
>  #include <linux/seq_file.h>
> +#include <linux/vmalloc.h>
>  
>  #include "internal.h"
>  
> @@ -351,7 +351,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  		.skip = 0
>  	};
>  
> -	kbuf = kmalloc(count, GFP_KERNEL);
> +	kbuf = vmalloc(count);
>  	if (!kbuf)
>  		return -ENOMEM;
>  
> @@ -397,11 +397,11 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  	if (copy_to_user(buf, kbuf, ret))
>  		ret = -EFAULT;
>  
> -	kfree(kbuf);
> +	vfree(kbuf);
>  	return ret;
>  
>  err:
> -	kfree(kbuf);
> +	vfree(kbuf);
>  	return -ENOMEM;
>  }
>  

