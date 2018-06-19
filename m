Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C71AC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2152420874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2152420874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754412AbeFSXB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:01:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39734 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeFSXBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:01:54 -0400
Received: from localhost (s169.156.222.122.fls.vectant.ne.jp [122.222.156.169])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B4FFD100B;
        Tue, 19 Jun 2018 23:01:53 +0000 (UTC)
Date:   Wed, 20 Jun 2018 07:56:03 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alistair Strachan <astrachan@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org,
        kernel-team@android.com
Subject: Re: [PATCH] staging: android: ashmem: Fix mmap size validation
Message-ID: <20180619225603.GB23389@kroah.com>
References: <20180619222444.134928-1-astrachan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180619222444.134928-1-astrachan@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 03:24:44PM -0700, Alistair Strachan wrote:
> The ashmem driver did not check that the size/offset of the vma passed
> to its .mmap() function was not larger than the ashmem object being
> mapped. This could cause mmap() to succeed, even though accessing parts
> of the mapping would later fail with a segmentation fault.
> 
> Ensure an error is returned by the ashmem_mmap() function if the vma
> size is larger than the ashmem object size. This enables safer handling
> of the problem in userspace.

Is this going to break current users of this api as their original call
was succeeding?

> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Martijn Coenen <maco@android.com>
> Cc: devel@driverdev.osuosl.org
> Cc: kernel-team@android.com
> Signed-off-by: Alistair Strachan <astrachan@google.com>
> ---
>  drivers/staging/android/ashmem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index a1a0025b59e0..1eeedb529a10 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -366,6 +366,12 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  		goto out;
>  	}
>  
> +	/* requested mapping size larger than object size */
> +	if (unlikely(vma->vm_end - vma->vm_start > PAGE_ALIGN(asma->size))) {
> +		ret = -EINVAL;
> +		goto out;
> +	}

Unless you can measure the speed difference, never use likely/unlikely.
The CPU and compiler almost always knows how to do this better than we
do.  I know there are other checks like this in this function, those
should also be fixed as well.

thanks,

greg k-h
