Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1000C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CAB205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dyVQu218"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CAB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbeJSCDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:03:50 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43044 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbeJSCDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:03:49 -0400
Received: by mail-yb1-f193.google.com with SMTP id w80-v6so12205017ybe.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 11:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kKlDE4g/KLD4YIpmlhD27m5tibyOGMjxmAw4ddLA/9o=;
        b=dyVQu218HHt1p2w/ALkeYcPlheX50n2sRH4dtJ6Mdzf39PByRYTG06TeX6dEq7JDGY
         uiYFWxF0qALSTzt4THRrB88F1xRDqW0NhSwMZlUyrWcgNkDsKhQLnW/qVZ1kqvWshPJM
         HBj4vpwDvCXPLUKsJerSsZZJ2ogPkauJ3fwbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kKlDE4g/KLD4YIpmlhD27m5tibyOGMjxmAw4ddLA/9o=;
        b=cITacsy1BDIMbh00Ys5HIt9qAC9FI3xPC906iRHhPVp8+ju3QKCzrA6JlRADHlnMj5
         ySNTjQtaGQ417v6gXNaKz0XVUE9ptaF633n29qFjvy9JqwbWuF4xK2S68laN88OSdw9b
         hiRhNLGaXkvSOzP9ODrvMEV4VTHVi7USWkMLGYDeFu8FKdL9iIoKaLeXMzz320vEHDef
         wnD8+u7X/jYXJew3sRMe++u16CARn8/V8WalpGfOXi/vl23jHINzf8nATEL5NM/ifQMg
         HWMMpferFpbOVAqXqZaYOampkEvDqRwvmhFSwOyVVXShqw9P/inyIszo3MrATqMwsgv2
         mYbg==
X-Gm-Message-State: ABuFfojJ2aHzirm+EZgKL6Dugwt+O93k87iUXvFGAoWNRMd3JjPMAIBF
        y4wpmmr8viAZ1DbKdJ1lTUQBX8kvWdo=
X-Google-Smtp-Source: ACcGV60kZt1y7KeOUTwqFPKAhqrYbaE3CBjq+Blusl/oYAcAhAaDiYK6ofmwr58sEYKMz1HMsxaSCw==
X-Received: by 2002:a25:2c8:: with SMTP id 191-v6mr2595786ybc.302.1539885702347;
        Thu, 18 Oct 2018 11:01:42 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id i62-v6sm5314197ywb.32.2018.10.18.11.01.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 11:01:40 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id d126-v6so12168394ywa.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 11:01:39 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr19826401ywg.353.1539885699421;
 Thu, 18 Oct 2018 11:01:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 11:01:38
 -0700 (PDT)
In-Reply-To: <10d9618bf794d6e07b537455344b30238d5f4e80.camel@perches.com>
References: <20181017214124.GA8239@beast> <10d9618bf794d6e07b537455344b30238d5f4e80.camel@perches.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Oct 2018 11:01:38 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL0eh3SQz5PEJTtSjgjkEoVYLZEfCjrpg-J3jF7edjDqA@mail.gmail.com>
Message-ID: <CAGXu5jL0eh3SQz5PEJTtSjgjkEoVYLZEfCjrpg-J3jF7edjDqA@mail.gmail.com>
Subject: Re: [PATCH] pstore: Refactor compression initialization
To:     Joe Perches <joe@perches.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 10:14 AM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-10-17 at 14:41 -0700, Kees Cook wrote:
>> With compression initialization now separated from pstore_register(),
>> there is no longer a good reason to do compression method selection
>> during fs init. Instead, merge everything together into the late init.
>> Additionally cleans up the reporting to be more clear.
> []
>> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> []
>> @@ -274,36 +274,56 @@ static int pstore_decompress(void *in, void *out,
> []
>> -     big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
>> -     if (!big_oops_buf) {
>> -             pr_err("allocate compression buffer error!\n");
>> +     buf = kmalloc(size, GFP_KERNEL);
>> +     if (!buf) {
>> +             pr_err("Failed %d byte compression buffer allocation for: %s\n",
>> +                    size, zbackend->name);
>
> Given that there is a generic OOM message emitted on
> kmalloc failures, rather than expanding the unnecessary
> alloc failure message, how about just deleting it instead?

I prefer including more context (i.e. the desired compression method).

-Kees

-- 
Kees Cook
Pixel Security
