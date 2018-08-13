Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CDAC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194A82174B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MH3vs9IT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194A82174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbeHMWyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:54:41 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43229 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMWyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:54:41 -0400
Received: by mail-yw1-f66.google.com with SMTP id l189-v6so14521471ywb.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 13:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TA7kO+FncHcoxIHVtIyIwye/KldsAXYgtZJNLg0aO58=;
        b=MH3vs9ITToe6t6KxPhW2X5Nwsbu6Y6q6bYxCyg8i3EllbHEge+kGFwTEjpZ6urdsvh
         6sSiRUxMyXAcepn7hWfZ/xoyGeiznGKZbxZQQo5vLuSGhxAnMd2xlpfIG5sExTydIp3A
         K+IZzFk9/IJo9j0dmJKuhnnnGrfLvPynOXRFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TA7kO+FncHcoxIHVtIyIwye/KldsAXYgtZJNLg0aO58=;
        b=Tgq9MnH8HYhTIvrNzStGxHJX9IRWJKae8C3ATzmr149GhZ2Yg4GW2NYNuswjyWatDq
         yWr/raN7sQXqcaaV7a5TopYoTDs5QjEczL77iqV96BDlVREh6LRDTfwTwBaGCY8LXYsF
         I0wtKzDZnFJgSKvuB8t89JgvIhalPTJ0FFf+uXyB0JttxDH+oRGgBZcpgYhQEM2Jav2K
         ZQXGOU6HSOWcTPcopCidK1FXxCSPIm17FRy/RPUr4WCssQBP4V4RKll7RQmsbhM2qyAQ
         gCMSuL7+N3c+01x/zCNg42alc3kEPZefgDuSduYX5761pgYF7LAQb+Txb1An8DVgvXGv
         EEKA==
X-Gm-Message-State: AOUpUlHCASFbUzV2BqTxlrmjILzg0yrogADtQuHiHTojjTkBK0A2bKiJ
        s0ATc8lSPO7BJxPXfeDJhHzJcDeLLwM=
X-Google-Smtp-Source: AA+uWPy+8oih1KA6oIA5MpR+2ip4zUg2Bc1sZJGiw8iZ1uh+Qwb/N9gtOAV+qTo6JRl2YgllyKK8hw==
X-Received: by 2002:a25:a029:: with SMTP id x38-v6mr10822021ybh.353.1534191057133;
        Mon, 13 Aug 2018 13:10:57 -0700 (PDT)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id b135-v6sm16962271ywh.24.2018.08.13.13.10.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 13:10:55 -0700 (PDT)
Received: by mail-yw1-f54.google.com with SMTP id q129-v6so14529904ywg.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 13:10:53 -0700 (PDT)
X-Received: by 2002:a25:afce:: with SMTP id d14-v6mr9578765ybj.343.1534191053536;
 Mon, 13 Aug 2018 13:10:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2316:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 13:10:52
 -0700 (PDT)
In-Reply-To: <CAK7LNAQ2THEDLB8so3zahGykH_BWaWAU7Tg_2yGEPKo+ApsxHg@mail.gmail.com>
References: <20180811094853.32167-1-stefan@agner.ch> <CAK7LNAQ2THEDLB8so3zahGykH_BWaWAU7Tg_2yGEPKo+ApsxHg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 13 Aug 2018 13:10:52 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKHbx-L+n+CCExshtW1uQqkRX6MS5SoEH068DzoB+oKEg@mail.gmail.com>
Message-ID: <CAGXu5jKHbx-L+n+CCExshtW1uQqkRX6MS5SoEH068DzoB+oKEg@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: require GCC
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <jbacik@fb.com>, Emese Revfy <re.emese@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 12:38 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-08-11 18:48 GMT+09:00 Stefan Agner <stefan@agner.ch>:
>> Unsurprisingly GCC plugins require GCC as a compiler. This avoids
>> GCC plugins being selectable when using clang.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  arch/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 1aa59063f1fd..8c693a837ed7 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -422,7 +422,7 @@ config HAVE_GCC_PLUGINS
>>
>>  menuconfig GCC_PLUGINS
>>         bool "GCC plugins"
>> -       depends on HAVE_GCC_PLUGINS
>> +       depends on HAVE_GCC_PLUGINS && CC_IS_GCC
>>         depends on PLUGIN_HOSTCC != ""
>>         help
>>           GCC plugins are loadable modules that provide extra features to the
>> --
>> 2.18.0
>>
>
> I guess the more correct way is to fix
> scripts/gcc-plugin.sh
>
> This shell script should exit 0
> only when GCC plugin is supported.

I'm of two minds: we already have the gcc test in Kconfig so we might
want to avoid redundant checks, but maybe the script should be a
"complete" test. I guess the latter. I will send a patch.

-Kees

-- 
Kees Cook
Pixel Security
