Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBEFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824862174C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ExXGgyWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824862174C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbeHMXCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 19:02:11 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40930 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMXCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 19:02:11 -0400
Received: by mail-yw1-f67.google.com with SMTP id z143-v6so14540805ywa.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4llhmx8dM+NoO6zXFNJEAeJZh3bIqLi9zO1XxXSdFPk=;
        b=ExXGgyWG9nnbjrWXo3gQYy74eXBDeZQwgp4g385ZcInUpSg2Jw3yM73pXxYK8ufSbF
         cstbSn/W13iWZGihtcpsqu1O+EE4oTzKlgGb3SzMEh1eAIAynB69LGr2V3xIK+1qxf9L
         TnCzdsD3k/h1R0YdwYgSs3b0mtCjdg8m1EhY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4llhmx8dM+NoO6zXFNJEAeJZh3bIqLi9zO1XxXSdFPk=;
        b=JZtgRsBktCD5mFB7mts6m90RrmxqZfaFKfgNva8svZm/lt7bsRB/4wE6aHkgWPTUvZ
         ub+G8FbKphU9c0IOPBiJqzMKSILUl7oUIMRzgUYmkvPL0CxHsBbhxfUHa+ufE49EdWD4
         TCqTzEpP9qO0JdQVkf/5IkGrOXOlEYdZuyNbWayuwSSaV7HPGP3ZmSt0dmFrlq8srj5j
         U4hjAr2OiF9LrmKBPIphclKsJDo0lxDMcwOoX+pC4zJQQhh1ag8+yfLS/XpFNFu4fxAY
         NeIxnb8ojdcD0D/ul6j/LJHlPWbuh0K50GZBjHfdG7z2Opw8tIN+biFlcTesVJifm5ox
         WsXA==
X-Gm-Message-State: AOUpUlHBZix/rGmKyfZ6jn6/Pnp+gJMwPIndu7PL3M4ttBaenAsAhOLq
        fXU/VBL9VIJoZzOOvcG70eohwOEFEwE=
X-Google-Smtp-Source: AA+uWPyA/3KUMrYtxz1VTbZKA5tnMXNFKSzBD+3LwFV0e2wXauoVOdhVZ+QY1wtcnbhdofzTAGtPYQ==
X-Received: by 2002:a81:9251:: with SMTP id j78-v6mr10897631ywg.5.1534191505531;
        Mon, 13 Aug 2018 13:18:25 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id 21-v6sm8453894ywf.79.2018.08.13.13.18.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 13:18:24 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id r3-v6so14551765ywc.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 13:18:23 -0700 (PDT)
X-Received: by 2002:a25:af4a:: with SMTP id c10-v6mr10728529ybj.463.1534191503289;
 Mon, 13 Aug 2018 13:18:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2316:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 13:18:22
 -0700 (PDT)
In-Reply-To: <CAGXu5jKHbx-L+n+CCExshtW1uQqkRX6MS5SoEH068DzoB+oKEg@mail.gmail.com>
References: <20180811094853.32167-1-stefan@agner.ch> <CAK7LNAQ2THEDLB8so3zahGykH_BWaWAU7Tg_2yGEPKo+ApsxHg@mail.gmail.com>
 <CAGXu5jKHbx-L+n+CCExshtW1uQqkRX6MS5SoEH068DzoB+oKEg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 13 Aug 2018 13:18:22 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ_XZ0Rwve_JKsWtPpdVDed4jYT=Qrg-XkmQqMuJZQmgQ@mail.gmail.com>
Message-ID: <CAGXu5jJ_XZ0Rwve_JKsWtPpdVDed4jYT=Qrg-XkmQqMuJZQmgQ@mail.gmail.com>
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

On Mon, Aug 13, 2018 at 1:10 PM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Aug 13, 2018 at 12:38 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-08-11 18:48 GMT+09:00 Stefan Agner <stefan@agner.ch>:
>>> Unsurprisingly GCC plugins require GCC as a compiler. This avoids
>>> GCC plugins being selectable when using clang.
>>>
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>> ---
>>>  arch/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>> index 1aa59063f1fd..8c693a837ed7 100644
>>> --- a/arch/Kconfig
>>> +++ b/arch/Kconfig
>>> @@ -422,7 +422,7 @@ config HAVE_GCC_PLUGINS
>>>
>>>  menuconfig GCC_PLUGINS
>>>         bool "GCC plugins"
>>> -       depends on HAVE_GCC_PLUGINS
>>> +       depends on HAVE_GCC_PLUGINS && CC_IS_GCC
>>>         depends on PLUGIN_HOSTCC != ""
>>>         help
>>>           GCC plugins are loadable modules that provide extra features to the
>>> --
>>> 2.18.0
>>>
>>
>> I guess the more correct way is to fix
>> scripts/gcc-plugin.sh
>>
>> This shell script should exit 0
>> only when GCC plugin is supported.
>
> I'm of two minds: we already have the gcc test in Kconfig so we might
> want to avoid redundant checks, but maybe the script should be a
> "complete" test. I guess the latter. I will send a patch.

Actually, how about we do the test in Kconfig, but ahead of the
script? That will reduce redundancy:

diff --git a/arch/Kconfig b/arch/Kconfig
index 1aa59063f1fd..18f518624e41 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -409,7 +409,7 @@ preferred-plugin-hostcc := $(if-success,[
$(gcc-version) -ge 40800 ],$(HOSTCXX),

 config PLUGIN_HOSTCC
        string
-       default "$(shell,$(srctree)/scripts/gcc-plugin.sh
"$(preferred-plugin-hostcc)" "$(HOSTCXX)" "$(CC)")"
+       default "$(shell,$(srctree)/scripts/gcc-plugin.sh
"$(preferred-plugin-hostcc)" "$(HOSTCXX)" "$(CC)")" if CC_IS_GCC
        help
          Host compiler used to build GCC plugins.  This can be $(HOSTCXX),
          $(HOSTCC), or a null string if GCC plugin is unsupported.


-Kees

-- 
Kees Cook
Pixel Security
