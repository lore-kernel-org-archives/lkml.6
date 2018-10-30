Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE0AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B7E20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VhVKgECg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B7E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeJaGr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:47:58 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37227 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeJaGr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:47:58 -0400
Received: by mail-yb1-f193.google.com with SMTP id d18-v6so5739582yba.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f5w/W1+nr6ApqY6EEBtwiamN+f4N0KJAEOCfR2aTiyE=;
        b=VhVKgECgGSZpQGqE+zaqe1wdF9ezZ4zFFlEXUkvzYazAOhX/psGNuWnDqpM0SmIUA0
         kBcS35F8giql1XkpSPfKQv83Q6naTeX0QSU1i4nWY7hnNnSk6hRRJP7+OXHSAnRfoDr/
         aQkNb2Ml/VSPVPh2nHgGrY6y7+9zAaTcB7QkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f5w/W1+nr6ApqY6EEBtwiamN+f4N0KJAEOCfR2aTiyE=;
        b=HsDdYnhA+lRsgo4K+YtL6ZnSv3a6xnO6LvijgyKXs3CjGjyVvCOceE+XaKH5RIi7qV
         dX4aC2GrDTDcKpCOTCepQQ62vfh2nOhYPoayTQQOB8le6oGOUviWZ1cxa+DsYq6e4maC
         vasGS/zRKv4MXMX0f9vRpO11fIxZJwRFVu+XmhGmdYEnnYsExKFsVByRrk6tiX79V4f3
         +L1/StAFGt1R/UrNYqcaeAdKv+TzMsBbkd2CVgEUT9uEaClOvxI/Tt6WawlzYPxJtwC5
         vFEN75NP73JLrqf2Mmcd4nV1euAyqUgM2diAaEOdY/b7n7Jx21sRVb6H8j6Yj5MbXEov
         A5eA==
X-Gm-Message-State: AGRZ1gKz4Vfl+YW31/aEkrM9A0BISwbmio9Y4zpij+o9vHlVm5TCL+4Y
        XP8Dc9JXZIsp+u4TpYQjvbQvA8eZ/lo=
X-Google-Smtp-Source: AJdET5fCRf0YcXL8/ldmlXWb5ewQ/e4EXD+OCHpSTEgDJBO9THG9JxJTJ1jiksWJpafHz+jIEZ4I9A==
X-Received: by 2002:a25:7811:: with SMTP id t17-v6mr540549ybc.436.1540936366249;
        Tue, 30 Oct 2018 14:52:46 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id k5-v6sm8155809ywi.94.2018.10.30.14.52.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 14:52:44 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id j202-v6so5588088ywa.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 14:52:44 -0700 (PDT)
X-Received: by 2002:a0d:cd84:: with SMTP id p126-v6mr554030ywd.288.1540936364110;
 Tue, 30 Oct 2018 14:52:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 14:52:43
 -0700 (PDT)
In-Reply-To: <20181030213818.GA32621@google.com>
References: <20181030075234.21137-1-wangpeng15@xiaomi.com> <20181030213818.GA32621@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Oct 2018 14:52:43 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+tRWseaecob04U5iXHa-P_z=Hvj3PmhE5YWFUO=LT7Sw@mail.gmail.com>
Message-ID: <CAGXu5j+tRWseaecob04U5iXHa-P_z=Hvj3PmhE5YWFUO=LT7Sw@mail.gmail.com>
Subject: Re: [PATCH v4] pstore: Avoid duplicate call of persistent_ram_zap()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peng Wang <wangpeng15@xiaomi.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, vipwangerxiao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 2:38 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Tue, Oct 30, 2018 at 03:52:34PM +0800, Peng Wang wrote:
>> When initialing prz with invalid data in buffer(no PERSISTENT_RAM_SIG),
>> function call path is like this:
>>
>> ramoops_init_prz ->
>> |
>> |-> persistent_ram_new -> persistent_ram_post_init -> persistent_ram_zap
>> |
>> |-> persistent_ram_zap
>>
>> As we can see, persistent_ram_zap() is called twice.
>> We can avoid this by adding an option to persistent_ram_new(), and
>> only call persistent_ram_zap() when it is needed.
>>
>> Signed-off-by: Peng Wang <wangpeng15@xiaomi.com>
>> ---
>>  fs/pstore/ram.c            | 4 +---
>>  fs/pstore/ram_core.c       | 5 +++--
>>  include/linux/pstore_ram.h | 1 +
>>  3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
>> index ffcff6516e89..b51901f97dc2 100644
>> --- a/fs/pstore/ram.c
>> +++ b/fs/pstore/ram.c
>> @@ -640,7 +640,7 @@ static int ramoops_init_prz(const char *name,
>>
>>       label = kasprintf(GFP_KERNEL, "ramoops:%s", name);
>>       *prz = persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
>> -                               cxt->memtype, 0, label);
>> +                               cxt->memtype, PRZ_FLAG_ZAP_OLD, label);
>>       if (IS_ERR(*prz)) {
>>               int err = PTR_ERR(*prz);
>
> Looks good to me except the minor comment below:
>
>>
>> @@ -649,8 +649,6 @@ static int ramoops_init_prz(const char *name,
>>               return err;
>>       }
>>
>> -     persistent_ram_zap(*prz);
>> -
>>       *paddr += sz;
>>
>>       return 0;
>> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
>> index 12e21f789194..2ededd1ea1c2 100644
>> --- a/fs/pstore/ram_core.c
>> +++ b/fs/pstore/ram_core.c
>> @@ -505,15 +505,16 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
>>                       pr_debug("found existing buffer, size %zu, start %zu\n",
>>                                buffer_size(prz), buffer_start(prz));
>>                       persistent_ram_save_old(prz);
>> -                     return 0;
>> +                     if (!(prz->flags & PRZ_FLAG_ZAP_OLD))
>> +                             return 0;
>
> This could be written differently.
>
> We could just do:
>
> if (prz->flags & PRZ_FLAG_ZAP_OLD)
>         persistent_ram_zap(prz);
>
> And remove the zap from below below.

I actually rearranged things a little to avoid additional round-trips
on the mailing list. :)

> Since Kees already took this patch, I can just patch this in my series if
> Kees and you are Ok with this suggestion.

I've put it up here:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=pstore/devel&id=ac564e023248e3f4d87917b91d12376ddfca5000

> Sorry for the delay in my RFC series, I just got back from paternity leave
> and I'm catching up with email.

No worries! It's many weeks until the next merge window. :)

-- 
Kees Cook
