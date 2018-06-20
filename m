Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925CFC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CEF20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LMa6fz0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CEF20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753622AbeFTEcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:32:03 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43927 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbeFTEcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:32:01 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so928222pfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 21:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=D8vbeuYR7/CZt0QRYW67bOmQU3zi936URAWqloHwaGE=;
        b=LMa6fz0XLnxieT4/nxZiLiafNNAo9oJHBQ+KooKTsCQ5dWMgkWLAmN3AXm3eDTctWl
         2qw4gDiD+PubxDy01zP79iOnPjD5pmtf5clF1X6l5DSE6e5CmKUqeAMmouhiabKghMBW
         p7IgTujwvm8FecxXnnOFru9x+XmCnRaky0vMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D8vbeuYR7/CZt0QRYW67bOmQU3zi936URAWqloHwaGE=;
        b=L+w6/ZVFmWPN2o40gWkorU14l4s5P/EwPtyq+Zli+pgI01cXkMjDapihtuPc5QDryW
         A/6y8xR4m6Cv/VmrtX4R7eWIkCoPNTBrM5x6wk0znb5wQI9SLCFwwd2kcFnOp4nMC8Qf
         GOAUFOzYMWN3Brp3rNGdnylX6Q1nezaquBX4qropTegA/6kxyqP0N170+nUlpq9h+uEQ
         Hj4kwAEMEJX4p+nTZRJwFohE6tgeQa0+sm5bhOBEL0ltVfla4Gdbnu5Z+K2JMT9Sj9DB
         X5z2YYfHsTEcEbTeXEEVDvKh/eGqWe4/Ku1px9OfTwrK8xJMeuSg5eaKDASAkrYsw0AF
         8TYQ==
X-Gm-Message-State: APt69E1GgA/TwNDbKdjdOijSN8zAWQtwwU9o7lBRLVszeTJo3MC36jwE
        osiRVKKfugYZkk1VPe58alfNng==
X-Google-Smtp-Source: ADUXVKIiSF0oaEt8txxXtwjVBebHt8MunXjtIC1tLgFwh/lWbrA31iSEmDJeTxInWFzB7MnEfva6fg==
X-Received: by 2002:a65:490d:: with SMTP id p13-v6mr16699331pgs.84.1529469121250;
        Tue, 19 Jun 2018 21:32:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id x17-v6sm1276569pgv.15.2018.06.19.21.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 21:32:00 -0700 (PDT)
Date:   Tue, 19 Jun 2018 21:32:00 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alistair Strachan <astrachan@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org,
        kernel-team@android.com
Subject: Re: [PATCH 2/2 v2] staging: android: ashmem: Fix mmap size validation
Message-ID: <20180620043200.GA10888@joelaf.mtv.corp.google.com>
References: <20180620005735.219840-1-astrachan@google.com>
 <20180620005735.219840-2-astrachan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180620005735.219840-2-astrachan@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 05:57:35PM -0700, Alistair Strachan wrote:
> The ashmem driver did not check that the size/offset of the vma passed
> to its .mmap() function was not larger than the ashmem object being
> mapped. This could cause mmap() to succeed, even though accessing parts
> of the mapping would later fail with a segmentation fault.
> 
> Ensure an error is returned by the ashmem_mmap() function if the vma
> size is larger than the ashmem object size. This enables safer handling
> of the problem in userspace.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Martijn Coenen <maco@android.com>
> Cc: devel@driverdev.osuosl.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@android.com
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Signed-off-by: Alistair Strachan <astrachan@google.com>
> ---
> v2: Removed unnecessary use of unlikely() macro
> 
>  drivers/staging/android/ashmem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index c6386e4f5c9b..e392358ec244 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -366,6 +366,12 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  		goto out;
>  	}
>  
> +	/* requested mapping size larger than object size */
> +	if (vma->vm_end - vma->vm_start > PAGE_ALIGN(asma->size)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

