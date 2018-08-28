Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55073C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10032087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oGsQoo9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10032087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeH2Ccy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:32:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47426 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH2Ccy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CHR6yfCTsbi1KAqQ5FwvXn7p1hvi1VuxLule3+VUZFo=; b=oGsQoo9D0+KzsODCVRYhxPKvV8
        bbcks5a5m+npY7flOAOT3sNY6KQgelwzERdy4PUnwUIdasAmRt6wiIT1/yZEEevvT2IfqsXhwxjG5
        KzkXYl08CH4XHNbASLHxWS5OtPHL2/oG+c1IhCqSbDpal8s1HyUkYGdqcq/j7H5NvxGJ/lPS/cNKS
        4QHpEQFe0KgdiZxjULPJoIx7FpLh87way319mJlkeVLFFWQY+nTkvaXuHxIGqpMyR8opdf6bqK/H4
        ybh7DDFP/eYSTPpYiHjieHh7EAKfd0pAkVVt4mRWh7hJ3ZYWoU2t86Mdb8dHyPmb3gBgYLsc2sN0j
        pKWFkqxg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fumdb-0005SY-3a; Tue, 28 Aug 2018 22:39:03 +0000
Subject: Re: Tagged pointers in the XArray
To:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180828222727.GD11400@bombadil.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fc15502d-8bf3-b7e3-af82-4645dc84e9cd@infradead.org>
Date:   Tue, 28 Aug 2018 15:39:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828222727.GD11400@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a question, please...

On 08/28/2018 03:27 PM, Matthew Wilcox wrote:
> 
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index c74556ea4258..d1b383f3063f 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -150,6 +150,54 @@ static inline int xa_err(void *entry)
>  	return 0;
>  }
>  
> +/**
> + * xa_tag_pointer() - Create an XArray entry for a tagged pointer.
> + * @p: Plain pointer.
> + * @tag: Tag value (0, 1 or 3).
> + *

What's wrong with a tag value of 2?

and what happens when one is used?  [I don't see anything preventing that.]


> + * If the user of the XArray prefers, they can tag their pointers instead
> + * of storing value entries.  Three tags are available (0, 1 and 3).
> + * These are distinct from the xa_tag_t as they are not replicated up
> + * through the array and cannot be searched for.
> + *
> + * Context: Any context.
> + * Return: An XArray entry.
> + */
> +static inline void *xa_tag_pointer(void *p, unsigned long tag)
> +{
> +	return (void *)((unsigned long)p | tag);
> +}
> +
> +/**
> + * xa_untag_pointer() - Turn an XArray entry into a plain pointer.
> + * @entry: XArray entry.
> + *
> + * If you have stored a tagged pointer in the XArray, call this function
> + * to get the untagged version of the pointer.
> + *
> + * Context: Any context.
> + * Return: A pointer.
> + */
> +static inline void *xa_untag_pointer(void *entry)
> +{
> +	return (void *)((unsigned long)entry & ~3UL);
> +}
> +
> +/**
> + * xa_pointer_tag() - Get the tag stored in an XArray entry.
> + * @entry: XArray entry.
> + *
> + * If you have stored a tagged pointer in the XArray, call this function
> + * to get the tag of that pointer.
> + *
> + * Context: Any context.
> + * Return: A tag.
> + */
> +static inline unsigned int xa_pointer_tag(void *entry)
> +{
> +	return (unsigned long)entry & 3UL;
> +}

thanks,
-- 
~Randy
