Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B211C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318C42480F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B2lyQlnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318C42480F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934556AbeFVTpR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:45:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54664 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934111AbeFVTpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0o6v2bzvM5nIE+l8CrVO6hQZkUi2HWECIrT4GGbiDGo=; b=B2lyQlnBfwfiIYdGQLsoChtXuM
        C3Elweyx3Svx/lFM03Phtsa/d/xBclORF38itHnVsp8K0dyHEATpZOqFv6JwXaoG0c9xQkjHbviD/
        FzLN7BvuAYiKYFwVTXovP1R6S+pL1puEUdOW0QErbUxJDnr3Fj4/+wisZ6eipL3FmjlxyZGCaOZlX
        Y6c4s7nDdNKfU9Y6teurmQYIKwNLU8fK7pdIe0YdlGxuZGopmKfRmV0Y+CSvJLTmXc0ppyVhJKpZN
        q87XATPp7WI6O5bFtUAp1YW+HlJmCWQbRMejUKR2jlCoWERXABl/fUlydjfgSeK93NRpaudwnaB/W
        08DVOgKQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWRze-0003BA-PC; Fri, 22 Jun 2018 19:45:14 +0000
Subject: Re: [PATCH 05/26] fs: Convert unnamed_dev_ida to new API
To:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-6-willy@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a403bace-a7b4-aa3e-8fa7-4c47051a7916@infradead.org>
Date:   Fri, 22 Jun 2018 12:45:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621212835.5636-6-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2018 02:28 PM, Matthew Wilcox wrote:
> The new API is much easier for this user.  Also add kerneldoc for
> get_anon_bdev().
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---
>  fs/super.c | 63 +++++++++++++++++++-----------------------------------
>  1 file changed, 22 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 50728d9c1a05..3e7a0aea716a 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -978,58 +978,42 @@ void emergency_thaw_all(void)
>  	}
>  }
>  
> -/*
> - * Unnamed block devices are dummy devices used by virtual
> - * filesystems which don't use real block-devices.  -- jrs
> - */
> -
>  static DEFINE_IDA(unnamed_dev_ida);
> -static DEFINE_SPINLOCK(unnamed_dev_lock);/* protects the above */
> -/* Many userspace utilities consider an FSID of 0 invalid.
> - * Always return at least 1 from get_anon_bdev.
> - */
> -static int unnamed_dev_start = 1;
>  
> +/**
> + * get_anon_bdev - Allocate a block device for filesystems which don't have one.
> + * @p: Pointer to a dev_t.
> + *
> + * Filesystems which don't use real block devices can call this function
> + * to allocate a virtual block device.
> + *
> + * Context: Any context.  Frequently called while holding sb_lock.
> + * Return: 0 on success, -EMFILE if there are no anonymous bdevs left
> + * or -EAGAIN if memory allocation failed.

Looks to me like the code used to return -ENOMEM and used -EAGAIN as an
internal retry code.

confused?  (/me)

> + */
>  int get_anon_bdev(dev_t *p)
>  {
>  	int dev;
> -	int error;
>  
> - retry:
> -	if (ida_pre_get(&unnamed_dev_ida, GFP_ATOMIC) == 0)
> -		return -ENOMEM;
> -	spin_lock(&unnamed_dev_lock);
> -	error = ida_get_new_above(&unnamed_dev_ida, unnamed_dev_start, &dev);
> -	if (!error)
> -		unnamed_dev_start = dev + 1;
> -	spin_unlock(&unnamed_dev_lock);
> -	if (error == -EAGAIN)
> -		/* We raced and lost with another CPU. */
> -		goto retry;
> -	else if (error)
> +	/*
> +	 * Many userspace utilities consider an FSID of 0 invalid.
> +	 * Always return at least 1 from get_anon_bdev.
> +	 */
> +	dev = ida_alloc_range(&unnamed_dev_ida, 1, (1 << MINORBITS) - 1,
> +			GFP_ATOMIC);
> +	if (dev == -ENOSPC)
> +		return -EMFILE;
> +	if (dev < 0)
>  		return -EAGAIN;
>  
> -	if (dev >= (1 << MINORBITS)) {
> -		spin_lock(&unnamed_dev_lock);
> -		ida_remove(&unnamed_dev_ida, dev);
> -		if (unnamed_dev_start > dev)
> -			unnamed_dev_start = dev;
> -		spin_unlock(&unnamed_dev_lock);
> -		return -EMFILE;
> -	}
> -	*p = MKDEV(0, dev & MINORMASK);
> +	*p = MKDEV(0, dev);
>  	return 0;
>  }
>  EXPORT_SYMBOL(get_anon_bdev);



-- 
~Randy
