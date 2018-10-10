Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF61EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688842085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZem73lK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688842085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeJKDH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:07:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34480 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeJKDH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:07:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id o17-v6so7153414qtr.1;
        Wed, 10 Oct 2018 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=YQbFuSMIJgEO1rmqFRKP5GJn8wpflo7ihoezXwF9sQ8=;
        b=MZem73lKNgB3oFPiaBIZPXATmXDiT0UU9aeABOFCdqSseC9DTjUji+5W/+pJ0Mr5s1
         ZI0PujD03VU/l+VDKFX4vhXi8Fa4e62zOzrRmF+uRfnlfQFmv4lDKEmXm95A2k1NPx6/
         sMp4TlYyNsG11l+hWO1dMdba2Cqlkj71JDBs4VyToj6w+nl3iYhyC4GQSU62PGyb3Wz4
         5onjNc9c7YjL4n/65rP2KkryCiTGBtJsKSAzELAVIZXxKT5Zy/VA99a65kVkDSafUXUh
         00LUeKZRToFPo/29VCjaOZFrgy+ujpIVkk0zSy9zdv23cshHCOYRUBMtQKv124rHO9PP
         5NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=YQbFuSMIJgEO1rmqFRKP5GJn8wpflo7ihoezXwF9sQ8=;
        b=j2+zW1xeMVwDXZM3pBWon50sw/iUAhTCkOpH2/qqpWM1triM1AGditM7YWQzs82wVT
         JRnwNLQLeTPesa5yAKJjYEzix5B1n3E2pfgt5LSNQDdY7zizSvtFvh92dufwjAJqYlsw
         tQQDvswbvxyoqoD6wjn/2qbMf3edRo4tcKvVW5P0Dya9l787xpLaVOCkB0mknLtRUqFj
         BR2W7XNHgTcrRY4Mvbj2PtVIhVJHU9i/rTumDphVWlXqzzuTgWtK8XaOvu/TgzDAfUzg
         +vBKrx+I0X3Np2AiaWEt+RM8G6aYu6bDg69sb808moj6/pIpccW2AgElbx1sRPte51TI
         8rNg==
X-Gm-Message-State: ABuFfohM3TxMEKdtZYJjjwXXGF4o55QnO5SdK3/7sizqGTpoxq+9IS/w
        C7IPXbYe6dMYGuvt2o5pVA96yUg5HSC6FWQf2YZexg==
X-Google-Smtp-Source: ACcGV612IOx554vr6ere9ylC7j/owpFFzzGtBqPJJ3oabGXBFQm45psERBBqH8sj7kwQixeW81Ti1xD6B79D7C4munQ=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr28872513qtd.319.1539200628919;
 Wed, 10 Oct 2018 12:43:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:524f:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 12:43:39
 -0700 (PDT)
In-Reply-To: <20181010192658.GA27646@thunk.org>
References: <20181010142813.1918180-1-arnd@arndb.de> <20181010192658.GA27646@thunk.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Oct 2018 21:43:39 +0200
X-Google-Sender-Auth: eiKKwDRJy0U1bOp5XVaZLTfZNX0
Message-ID: <CAK8P3a0Ms--dFOA8Frz+SsBGHgrV9_uYvxg6G8YT+VhDBJZGeg@mail.gmail.com>
Subject: Re: [PATCH] ext4: avoid unused variable warning
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Eric Biggers <ebiggers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Wed, Oct 10, 2018 at 04:27:58PM +0200, Arnd Bergmann wrote:
>> The two new variables are only used in an #ifdef, so they cause a
>> warning without CONFIG_QUOTA:
>>
>> fs/ext4/super.c: In function 'parse_options':
>> fs/ext4/super.c:1977:26: error: unused variable 'grp_qf_name'
>> [-Werror=unused-variable]
>>   char *p, *usr_qf_name, *grp_qf_name;
>>                           ^~~~~~~~~~~
>> fs/ext4/super.c:1977:12: error: unused variable 'usr_qf_name'
>> [-Werror=unused-variable]
>>   char *p, *usr_qf_name, *grp_qf_name;
>>
>> Fixes: 20cefcdc2040 ("ext4: fix use-after-free race in ext4_remount()'s
>> error path")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Hmm, I wonder if we should do something like:
>
> #define EXT4_UNUSED_VAR __attribute__ ((unused))
>
> and then we could do:
>
> 	char *p, *usr_qf_name EXT4_UNUSED_VAR, *grp_qf_name EXT4_UNUSED_VAR;
>
> More generally, I wonder if this is something we should have defined
> for the whole kernel, as opposed to a one-off hack that ACPI and ext4
> subsystems use.

I think the global __maybe_unused macro should work fine here.
I though about using that instead, but picked the #ifdef for
consistency with the other ifdef in the same function.

>  It's a little ugly, but I think it's much nicer than
> having extra #ifdefs such as:
>
> 	char *p;
> #ifdef CONFIG_QUOTA
> 	char *usr_qf_name, *grp_qf_name;
> #endif
>
> After all, the compiler is perfectly capable of ignoring variables
> which are unused.  And if it's only because of an #ifdef later in the
> function, it would be nice to not have an extra #ifdef in the variable
> declarations.

Another alternative that often results in more readable code is
to use a check like

        if (IS_ENABLED(CONFIG_QUOTA)) {
             ....
        }

around the conditional code instead of the #ifdef. This should usually
work unless the code accesses some struct members that are
also hidden in that #ifdef. I have not checked if that is the case here.

        Arnd
