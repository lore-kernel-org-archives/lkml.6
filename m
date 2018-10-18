Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D923C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009B4214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HTqLVrvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009B4214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeJRMnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:43:10 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43970 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeJRMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 08:43:10 -0400
Received: by mail-yb1-f193.google.com with SMTP id w80-v6so11324451ybe.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 21:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tNPfEht7TzrQE0Vjmq76I7z19H6D76VzVVzmUXiD8ok=;
        b=HTqLVrvjLZjJH0zycgzlT3iRrGR41CYuUCoEPUXshtRmCJxx0FJ+mQcdfOtk/bRRjI
         CvF8W2J8CckSjJcdfXmKuywJYsY48OZ2ofHCnCWf9o6zcQsAKpXTXfqIbBjjajxR0bTj
         aFIpQZtcgicOAZ9BO3hvmkuWB4nDM7/+ir8sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tNPfEht7TzrQE0Vjmq76I7z19H6D76VzVVzmUXiD8ok=;
        b=MHOyKIMc+GBNXBjcFaDA/oyEWOjYXwzpi9OyAmB4gjhCqswAMAFWDwkWmroFCui0AN
         swV8g1vTlERhbKoySmM1WYiHqK3/bTZyhQYDGqwBji1H91r2YT2ym8+Lh/xfyvj7z2fV
         M7ok4aCAcOvWQY4NbWnIuBwc03xbCN5GwpDiKeRMfktRTWGvjQLIlTbr+WGzA1oMEUoJ
         WGW66jRYu7eTLwT736moA0zWRI5g0sz1O5jXidlUauyNEnLWUV9Pij0Mr0xw5ofBPcn+
         PMwQPZBWcjp+XZ53j9TPYLLG8mAgH66z/3VSSkFSZq0PUBssJXbYGSpi427wofcYgngE
         uTKg==
X-Gm-Message-State: ABuFfojOZlWT7slrsAW6KichH8xXeSkprX1yvXJS02Bx/MDOL/U8T0yf
        j0qJHZ8yq5H51S8NnhA0WeURXS0ZjHg=
X-Google-Smtp-Source: ACcGV63wH2qe/AVCBvOrWXzecOV69M9+MpwO5EC5jQt6skY4rDk22H0jmDVXpgPoHCehOy+UjK8IeQ==
X-Received: by 2002:a25:b089:: with SMTP id f9-v6mr11906972ybj.206.1539837845063;
        Wed, 17 Oct 2018 21:44:05 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id g126-v6sm4736513ywf.9.2018.10.17.21.44.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 21:44:03 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id k132-v6so193169ybc.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 21:44:03 -0700 (PDT)
X-Received: by 2002:a25:23cd:: with SMTP id j196-v6mr4500012ybj.137.1539837842791;
 Wed, 17 Oct 2018 21:44:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 17 Oct 2018 21:44:01
 -0700 (PDT)
In-Reply-To: <20181018013001.GA99677@joelaf.mtv.corp.google.com>
References: <20181017214124.GA8239@beast> <20181018013001.GA99677@joelaf.mtv.corp.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 17 Oct 2018 21:44:01 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKqjMrrGi17EQ5-oCq3_pHVtoehajSzSfhaxOyJw-ZNKA@mail.gmail.com>
Message-ID: <CAGXu5jKqjMrrGi17EQ5-oCq3_pHVtoehajSzSfhaxOyJw-ZNKA@mail.gmail.com>
Subject: Re: [PATCH] pstore: Refactor compression initialization
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 6:30 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Wed, Oct 17, 2018 at 02:41:24PM -0700, Kees Cook wrote:
>> With compression initialization now separated from pstore_register(),
>> there is no longer a good reason to do compression method selection
>> during fs init. Instead, merge everything together into the late init.
>> Additionally cleans up the reporting to be more clear.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> This patch goes on top of Joel's. I'll have both in linux-next shortly...
>> ---
>>  fs/pstore/inode.c    |  2 --
>>  fs/pstore/internal.h |  3 --
>>  fs/pstore/platform.c | 65 ++++++++++++++++++++++++++++----------------
>>  3 files changed, 41 insertions(+), 29 deletions(-)
>>
>> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
>> index 5fcb845b9fec..d814723fb27d 100644
>> --- a/fs/pstore/inode.c
>> +++ b/fs/pstore/inode.c
>> @@ -486,8 +486,6 @@ static int __init init_pstore_fs(void)
>>  {
>>       int err;
>>
>> -     pstore_choose_compression();
>> -
>>       /* Create a convenient mount point for people to access pstore */
>>       err = sysfs_create_mount_point(fs_kobj, "pstore");
>>       if (err)
>> diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
>> index fb767e28aeb2..c029314478fa 100644
>> --- a/fs/pstore/internal.h
>> +++ b/fs/pstore/internal.h
>> @@ -37,7 +37,4 @@ extern bool pstore_is_mounted(void);
>>  extern void  pstore_record_init(struct pstore_record *record,
>>                                  struct pstore_info *psi);
>>
>> -/* Called during module_init() */
>> -extern void __init pstore_choose_compression(void);
>> -
>>  #endif
>> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
>> index f09066db2d4d..e4737a5fa68c 100644
>> --- a/fs/pstore/platform.c
>> +++ b/fs/pstore/platform.c
>> @@ -274,36 +274,56 @@ static int pstore_decompress(void *in, void *out,
>>
>>  static void allocate_buf_for_compression(void)
>>  {
>> +     struct crypto_comp *ctx;
>> +     int size;
>> +     char *buf;
>> +
>> +     /* Skip if not built-in or compression backend not selected yet. */
>>       if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !zbackend)
>>               return;
>>
>> +     /* Skip if no pstore backend yet or compression init already done. */
>> +     if (!psinfo || tfm)
>> +             return;
>> +
>>       if (!crypto_has_comp(zbackend->name, 0, 0)) {
>> -             pr_err("No %s compression\n", zbackend->name);
>> +             pr_err("Unknown compression: %s\n", zbackend->name);
>>               return;
>>       }
>>
>> -     big_oops_buf_sz = zbackend->zbufsize(psinfo->bufsize);
>> -     if (big_oops_buf_sz <= 0)
>> +     size = zbackend->zbufsize(psinfo->bufsize);
>> +     if (size <= 0) {
>> +             pr_err("Invalid compression size for %s: %d\n",
>> +                    zbackend->name, size);
>>               return;
>> +     }
>>
>> -     big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
>> -     if (!big_oops_buf) {
>> -             pr_err("allocate compression buffer error!\n");
>> +     buf = kmalloc(size, GFP_KERNEL);
>> +     if (!buf) {
>> +             pr_err("Failed %d byte compression buffer allocation for: %s\n",
>> +                    size, zbackend->name);
>>               return;
>>       }
>>
>> -     tfm = crypto_alloc_comp(zbackend->name, 0, 0);
>> -     if (IS_ERR_OR_NULL(tfm)) {
>> -             kfree(big_oops_buf);
>> -             big_oops_buf = NULL;
>> -             pr_err("crypto_alloc_comp() failed!\n");
>> +     ctx = crypto_alloc_comp(zbackend->name, 0, 0);
>> +     if (IS_ERR_OR_NULL(ctx)) {
>> +             kfree(buf);
>> +             pr_err("crypto_alloc_comp('%s') failed: %ld\n", zbackend->name,
>> +                    PTR_ERR(ctx));
>>               return;
>>       }
>> +
>> +     /* A non-NULL big_oops_buf indicates compression is available. */
>> +     tfm = ctx;
>> +     big_oops_buf_sz = size;
>> +     big_oops_buf = buf;
>> +
>> +     pr_info("Using compression: %s\n", zbackend->name);
>>  }
>>
>>  static void free_buf_for_compression(void)
>>  {
>> -     if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && !IS_ERR_OR_NULL(tfm))
>> +     if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm)
>>               crypto_free_comp(tfm);
>>       kfree(big_oops_buf);
>>       big_oops_buf = NULL;
>> @@ -764,31 +784,28 @@ static void pstore_timefunc(struct timer_list *unused)
>>                         jiffies + msecs_to_jiffies(pstore_update_ms));
>>  }
>>
>> -void __init pstore_choose_compression(void)
>> +static int __init pstore_compression_late_init(void)
>>  {
>>       const struct pstore_zbackend *step;
>>
>>       if (!compress)
>> -             return;
>> +             return 0;
>>
>> +     /* Locate desired compression method. */
>>       for (step = zbackends; step->name; step++) {
>>               if (!strcmp(compress, step->name)) {
>>                       zbackend = step;
>> -                     pr_info("using %s compression\n", zbackend->name);
>> -                     return;
>> +                     break;
>>               }
>>       }
>> -}
>>
>> -static int __init pstore_compression_late_init(void)
>> -{
>>       /*
>> -      * Check if any pstore backends registered earlier but did not allocate
>> -      * for compression because crypto was not ready, if so then initialize
>> -      * compression.
>> +      * Check if any pstore backends registered earlier but did not
>> +      * initialize compression because crypto was not ready. If so,
>> +      * then initialize compression now.
>>        */
>> -     if (psinfo && !tfm)
>> -             allocate_buf_for_compression();
>> +     allocate_buf_for_compression();
>
> We can also get rid of the 'zbackend' global variable since choosing the
> compression backend and allocating the buffers are done at the same time?

That's my intention once I push the zbufsize functions up into the
crypto subsystem (there's a separate series for this that I need to
refresh).

> Otherwise looks good to me,
>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
