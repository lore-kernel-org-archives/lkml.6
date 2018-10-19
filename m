Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB24ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4BD21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W48iTrVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4BD21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJTCtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:49:11 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44417 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeJTCtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:49:10 -0400
Received: by mail-yb1-f193.google.com with SMTP id x5-v6so13634276ybl.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GHdCJSoI+zu3PbazuLHwj91d31caO5n91pvxwEyTTqU=;
        b=W48iTrVymcEREQFSSzxJclxoLFAkfSXZMwqkicZwfRU5ICGamBrkVhF0GN0ZAEFkaz
         K8/GZkuotNzZT7dNST7C2py4DaHWnCBH+PeMCkJKKPECHjg59BgsL7nJOyXiRGEXXH6O
         JLKvDCaw0/WPK2fnZDGVp7qjK7TLf2x7p/JQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GHdCJSoI+zu3PbazuLHwj91d31caO5n91pvxwEyTTqU=;
        b=AYGSL7pU0c49f43rwf+K5IAEu+fQwohyhFi+O7q1n97CLSq6DSpV31FdjGmH+DWYN/
         nfLfRc2GEeVkEpHefbMDWGg9UBzEBKUopKt0ns7B6/j73VSR7EPtr4nWe200JijqzkUY
         RQnOZJQv1sC8F+AFSdpzMNaDEdRJvlDLEgTLPYvQzmnhdqiiWHPmwGOo+0s15bmRDumv
         ve11uYhc3qlr7wKAdl2yUheBp6PTVF/aQQ1TgkoZlwi3EEFD8xbkmVTU8IykIe4HnqOI
         rgWFz6yOkr60zIOA7aZYSEj7mNwLfTrf2fd2L3fv5x8K9bFlDRxFq80eUVvwQ+oTjYL5
         aXSA==
X-Gm-Message-State: ABuFfoipoRMw4fZJLalRfbirKYYeI9zGrIwTEpYmrU6SAuF/sg37TnvN
        26zI/tQ12r3nS7UZ2SPFUcmweQd5on4=
X-Google-Smtp-Source: ACcGV63nDYivkE2OnpEJvUDh1X1VKax+HG6M8bsRY+rtYV1gMQXfUg5XWlXxijseLh69QvXc6zdzaw==
X-Received: by 2002:a25:8546:: with SMTP id f6-v6mr24010664ybn.506.1539974512970;
        Fri, 19 Oct 2018 11:41:52 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id j81-v6sm5828656ywc.93.2018.10.19.11.41.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 11:41:51 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id v92-v6so891549ybi.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 11:41:51 -0700 (PDT)
X-Received: by 2002:a25:3588:: with SMTP id c130-v6mr23841530yba.410.1539974510920;
 Fri, 19 Oct 2018 11:41:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 11:41:50
 -0700 (PDT)
In-Reply-To: <20181019183729.27684-1-natechancellor@gmail.com>
References: <20181019183729.27684-1-natechancellor@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 19 Oct 2018 11:41:50 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKtfNDwygALbkwusMH+ann55FV5tjOTw3zFNFRjb379jw@mail.gmail.com>
Message-ID: <CAGXu5jKtfNDwygALbkwusMH+ann55FV5tjOTw3zFNFRjb379jw@mail.gmail.com>
Subject: Re: [PATCH] pstore: Fix annotation on declaration of pstore_exit_fs
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 11:37 AM, Nathan Chancellor
<natechancellor@gmail.com> wrote:
> Clang warns (trimmed for brevity):
>
> fs/pstore/inode.c:504:6: error: section does not match previous
> declaration [-Werror,-Wsection]
> void __exit pstore_exit_fs(void)
>      ^
> fs/pstore/internal.h:42:6: note: previous attribute is here
> void __init     pstore_exit_fs(void);
>      ^
>
> Fixes: a4fb3d2fefd2 ("pstore: Centralize init/exit routines")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  fs/pstore/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
> index 98bb4fa6e6a7..7062ea4bc57c 100644
> --- a/fs/pstore/internal.h
> +++ b/fs/pstore/internal.h
> @@ -39,6 +39,6 @@ extern void   pstore_record_init(struct pstore_record *record,
>
>  /* Called during pstore init/exit. */
>  int __init     pstore_init_fs(void);
> -void __init    pstore_exit_fs(void);
> +void __exit    pstore_exit_fs(void);

Whoops! Thanks, I'll fold this fix into the patch.

-Kees

>
>  #endif
> --
> 2.19.1
>



-- 
Kees Cook
Pixel Security
