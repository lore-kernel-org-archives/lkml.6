Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A03C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 20:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840532084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 20:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHy3eRm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbeLOUit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 15:38:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42413 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeLOUis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 15:38:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so4452222pfr.9;
        Sat, 15 Dec 2018 12:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TV5Z7dS31yC8KHUyvIdoMonSwifCUv+H8Jds2lC/VTU=;
        b=HHy3eRm/OxdfJ6OYjjyBHV8fMNtSJ6eGVg45r+Z3PA8U7y8JBsgoYX1aw105G3PFcb
         mIkr/VRyr5cKXUTtuq24/WURLA1ysD4hy+3wcJQQNV4d66B7uP6Yg5lnJ03WB3Fc51PZ
         2jXn0Wlmfliw2l/xCQSpPw0K4gu8mWud7NNy8QSU5LBRTfaqCL0uASXT7bgp94xpPZB0
         j66Gp6MNY/0mVll78ccqvMQjB+dZzYFXDU6PD7XB9COtpP/J18IGvdA1wGUBoEAPZo1w
         4v0w/dJ49icXAGSUSMb73t7PtsK26ZynbpHg3zyDzIN0yMssysxtqtTmzi5f9mfEQ1rJ
         ZxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TV5Z7dS31yC8KHUyvIdoMonSwifCUv+H8Jds2lC/VTU=;
        b=CsHR0xe94QWcmpJZtPQgHIEZ2t/6q1UhMKAp8v+3PrMKbbQg4nETPqhHge+GmexSSF
         +VLHFHdgoJvLCiq551v84qENRWVK5QpS7GpfG/ALhG8biISUhQMCSpz8EwPSiWeqKT/S
         H9N0DyAtoBq9wvJhtbn6Ls5zklSDaLnAwVlFrgVjQSah5LxVpGaTfsCY0XVeRrkmc3lW
         OOjoXhXfVjyPXKCEqs6zHPkdv7LsISKArgEugO5JkFbvuQkRaen69CzvbQCfLtq4I5ge
         o8aLl4rhpqErPpVMslXikCmKnMnMrXUi9YDIIYvS357EmgQ3Qc8WFiRafA1sEbu9nA0B
         wl2A==
X-Gm-Message-State: AA+aEWasmot6AGFNUugU5CNOkNwzPzQj6PGhfIi/i4x9qEbRFKocysQI
        0M1i+11EtlyXdQqNhudxbbLSGTDyXQ0=
X-Google-Smtp-Source: AFSGD/VmsCHbC65NUwGhdo5z79JPQ6H+K1CVNYvC5MtKfx7IsZznBR0etznn8QOuxkxiyh92AZmuQw==
X-Received: by 2002:a62:68c5:: with SMTP id d188mr7858124pfc.194.1544906327059;
        Sat, 15 Dec 2018 12:38:47 -0800 (PST)
Received: from [0.0.0.0] (104.194.84.186.16clouds.com. [104.194.84.186])
        by smtp.gmail.com with ESMTPSA id w136sm12720191pfd.169.2018.12.15.12.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 12:38:46 -0800 (PST)
Subject: Re: [PATCH] ubifs: Get/put page when changing PG_private
To:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hsiangkao@mail.ru, kirill.shutemov@linux.intel.com,
        stable@vger.kernel.org
References: <20181215150130.19381-1-richard@nod.at>
From:   zhangjun <openzhangj@gmail.com>
Message-ID: <9d539def-2042-9a2e-1251-c3f03d3d616c@gmail.com>
Date:   Sun, 16 Dec 2018 04:38:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181215150130.19381-1-richard@nod.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/15 下午11:01, Richard Weinberger wrote:
> The page migration code assumes that a page with PG_private
> set has its page count elevated by 1.
> UBIFS never did this and therefore the migration code was unable
> to migrate some pages owned by UBIFS.
> The lead to situations where the CMA memory allocator failed to
> allocate memory.
>
> Fix this by using get/put_page when changing PG_private.
>
> Cc: <stable@vger.kernel.org>
> Cc: zhangjun <openzhangj@gmail.com>
> Fixes: 4ac1c17b2044 ("UBIFS: Implement ->migratepage()")
> Reported-by: zhangjun <openzhangj@gmail.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> zhangjun,
>
> Please give this patch a try!
>
> Thanks,
> //richard
> ---
>   fs/ubifs/file.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index 1b78f2e09218..abe940d0767c 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -582,6 +582,7 @@ static int ubifs_write_end(struct file *file, struct address_space *mapping,
>   	}
>   
>   	if (!PagePrivate(page)) {
> +		get_page(page);
>   		SetPagePrivate(page);
>   		atomic_long_inc(&c->dirty_pg_cnt);
>   		__set_page_dirty_nobuffers(page);
> @@ -959,6 +960,7 @@ static int do_writepage(struct page *page, int len)
>   	atomic_long_dec(&c->dirty_pg_cnt);
>   	ClearPagePrivate(page);
>   	ClearPageChecked(page);
> +	put_page(page);
>   
>   	kunmap(page);
>   	unlock_page(page);
> @@ -1318,6 +1320,7 @@ static void ubifs_invalidatepage(struct page *page, unsigned int offset,
>   	atomic_long_dec(&c->dirty_pg_cnt);
>   	ClearPagePrivate(page);
>   	ClearPageChecked(page);
> +	put_page(page);
>   }
>   
>   int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
> @@ -1487,6 +1490,8 @@ static int ubifs_migrate_page(struct address_space *mapping,
>   
>   	if (PagePrivate(page)) {
>   		ClearPagePrivate(page);
> +		put_page(page);
> +		get_page(newpage);
>   		SetPagePrivate(newpage);
>   	}
>   
> @@ -1513,6 +1518,7 @@ static int ubifs_releasepage(struct page *page, gfp_t unused_gfp_flags)
>   	ubifs_assert(c, 0);
>   	ClearPagePrivate(page);
>   	ClearPageChecked(page);
> +	put_page(page);
>   	return 1;
>   }
>   
> @@ -1582,6 +1588,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
>   	else {
>   		if (!PageChecked(page))
>   			ubifs_convert_page_budget(c);
> +		get_page(page);
>   		SetPagePrivate(page);
>   		atomic_long_inc(&c->dirty_pg_cnt);
>   		__set_page_dirty_nobuffers(page);

Hello Richard

After adding your patch,my test did not go wrong.
I think it is ok now.

thanks
//zhangjun

