Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FBCC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C18920882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XONv45NB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C18920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeILWud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:50:33 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43046 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeILWud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:50:33 -0400
Received: by mail-yb1-f194.google.com with SMTP id k5-v6so2089709ybo.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6LovSrH+spJzds4ijmcICpipT3pn5dTLPqngJWpGET8=;
        b=XONv45NBHgTgMSfhUjVdWN9BTx8UvPo0j5ES9zg4hdNxn/BBYxDpu3YZ8ef18w/ann
         ZyttmhD/I6uk2x6kJf21uKhT3Xet5zgyRkQMyAYRwidu8J7ITIEJv403DjjwCuGv/aVs
         Z65eiOqAHhnTEkl6wE8vYoYQTVz77aq5o0bM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6LovSrH+spJzds4ijmcICpipT3pn5dTLPqngJWpGET8=;
        b=HpMCd+Zkdcw9O+KSj53WYppixOLMppYRIQ7NQf7TJUpfwqVA40TuwI9Hni/bSJuZnv
         xiTiZ3ulktOo/FgYGIs/7us/76LvJck24L1PrUFcTh7C1pjLdMoh2vN5TIRA/kiBuNdo
         PtVgJ0O5o0Se3u7gDzsiK//P0BqIrgNcIZbFlXyJyc2hmpzORZyms/E3oYSYPgMveOG1
         Fo10pSR72fXeDIxrcrm0TxdLxnhUu15u0IuNzPmqWdNf9/o34yLX4LtMEth/69ozupuo
         CYjn29/hHn8LJCtMFM/LDOFTAlhxbgjCOof1MFXWo1lOi1OIrPK98Ige3UH6TM+gedFn
         2TTg==
X-Gm-Message-State: APzg51C5UO/o8EPClAJPSIqosHPNOAcb85bxiJjfm8q8Yp5Bcg6e9iYw
        S/viXGNLq6WN8hj57w7QCCLBZFOSU1w=
X-Google-Smtp-Source: ANB0Vdb55yK4cpYdhxmcdir1d9agOklyooG2pTNfdIgdUhiK8QXMWCfK5XjCTlkVFEEUR7Bhe7afqQ==
X-Received: by 2002:a25:2ce:: with SMTP id 197-v6mr1458792ybc.215.1536774297605;
        Wed, 12 Sep 2018 10:44:57 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id u8-v6sm428539ywl.59.2018.09.12.10.44.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 10:44:55 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id d34-v6so2110274yba.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 10:44:55 -0700 (PDT)
X-Received: by 2002:a25:7d44:: with SMTP id y65-v6mr1525114ybc.421.1536774295167;
 Wed, 12 Sep 2018 10:44:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 10:44:54
 -0700 (PDT)
In-Reply-To: <1536723394-14616-1-git-send-email-bin.yang@intel.com>
References: <1536723394-14616-1-git-send-email-bin.yang@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 12 Sep 2018 10:44:54 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+C9pApyP4ab6usOudFFFBqX5WpZQYaH6m2BpmABB2W6w@mail.gmail.com>
Message-ID: <CAGXu5j+C9pApyP4ab6usOudFFFBqX5WpZQYaH6m2BpmABB2W6w@mail.gmail.com>
Subject: Re: [PATCH] pstore: fix incorrect persistent ram buffer mapping
To:     Bin Yang <bin.yang@intel.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 8:36 PM, Bin Yang <bin.yang@intel.com> wrote:
> persistent_ram_vmap() returns the page start vaddr.
> persistent_ram_iomap() supports non-page-aligned mapping.

Oh, yes, good catch. This should probably be explicitly mentioned in
comments for these functions.

> persistent_ram_buffer_map() always adds offset-in-page to the vaddr
> returned from these two functions, which causes incorrect mapping of
> non-page-aligned persistent ram buffer.

How did you find this problem, and/or how was the problem manifesting?

> Signed-off-by: Bin Yang <bin.yang@intel.com>
> ---
>  fs/pstore/ram_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index 951a14e..7c05fdd 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -429,7 +429,7 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size,
>         vaddr = vmap(pages, page_count, VM_MAP, prot);
>         kfree(pages);
>
> -       return vaddr;
> +       return vaddr + offset_in_page(start);
>  }
>
>  static void *persistent_ram_iomap(phys_addr_t start, size_t size,
> @@ -468,7 +468,7 @@ static int persistent_ram_buffer_map(phys_addr_t start, phys_addr_t size,
>                 return -ENOMEM;
>         }
>
> -       prz->buffer = prz->vaddr + offset_in_page(start);
> +       prz->buffer = prz->vaddr;
>         prz->buffer_size = size - sizeof(struct persistent_ram_buffer);
>
>         return 0;
> @@ -515,7 +515,7 @@ void persistent_ram_free(struct persistent_ram_zone *prz)
>
>         if (prz->vaddr) {
>                 if (pfn_valid(prz->paddr >> PAGE_SHIFT)) {
> -                       vunmap(prz->vaddr);
> +                       vunmap(prz->vaddr - offset_in_page(prz->paddr));
>                 } else {
>                         iounmap(prz->vaddr);
>                         release_mem_region(prz->paddr, prz->size);
> --
> 2.7.4
>

Regardless, yes, this patch looks correct. Thanks! I'll add it to my tree.

-Kees

-- 
Kees Cook
Pixel Security
