Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FED3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3212064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WK9Af9FF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3212064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeLJRbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:31:00 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33783 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeLJRbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:31:00 -0500
Received: by mail-yb1-f195.google.com with SMTP id f125so5554941ybc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=noaXan9fvv/bxTji2oJ84ZgKJH7hS09sn+6R7x3DB64=;
        b=WK9Af9FF//pYMe3zsM/agbHvKXGTEVl8MGP0hRQoCBaM1PNbaPHeTbY6D+gdKexX/t
         RwHqmwzqWqZh9sZOYUwODBSraNyfocV9iemOMJp9j0vpkuW00ZJnOecKILAGeqUyhYMa
         fvKZNkuCwgjIIKmU5ZetgZDDLlQ3SFeADWd+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noaXan9fvv/bxTji2oJ84ZgKJH7hS09sn+6R7x3DB64=;
        b=SEZmu4P1EJH1fhCrtRQZSmT6ZGfpbBHbR7Vz6DlH4g8JX7TUA9Hi68Djo+fFZYO6IH
         SJdMSMyJ2/L3PYvkmzgOs7EZWv/4WkmAHxtlK1GzQ7DDJPv39FaGZT1xMHG0ichf+Vpk
         0aNxIgQHh7SFioz47JdQ2PbUwgkm8XVV9t3GyY9xWs8QovgqUqD47uuu1Z2ERUuBj91r
         0YIMoWlMgEv4sl5rif+6/nBEJu/xZdg2wgX1LSmqZEbsqowqEdBeEKFnZVtoe+qjwegQ
         OPTD6jjcR2btV6Jv3A25bf7rydRwpmMRZZIqu0FXY1F2mllxdJrlisqn748B0pGsh89O
         EyXQ==
X-Gm-Message-State: AA+aEWYlX2kG7t2W6tsHcFdQD81PUTLJAoAWubtYog3MX+uNHM4EYUWJ
        59rObAobWooJlx99pYuFaCUOkKJP8T0=
X-Google-Smtp-Source: AFSGD/URoVLquj0vMNIDq3sZC8UeDYQiBaicbs8eaqHo00LZInqzvSFhVx3gWqVuE/vH3sTg/wlEAw==
X-Received: by 2002:a25:4c82:: with SMTP id z124-v6mr12488192yba.125.1544463058084;
        Mon, 10 Dec 2018 09:30:58 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id v78sm5022294ywa.103.2018.12.10.09.30.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:30:57 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id s15so5526486ybk.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:30:57 -0800 (PST)
X-Received: by 2002:a25:1cc1:: with SMTP id c184-v6mr13024940ybc.421.1544463056642;
 Mon, 10 Dec 2018 09:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20181209230047.GA1738@altlinux.org>
In-Reply-To: <20181209230047.GA1738@altlinux.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 10 Dec 2018 09:30:45 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKLHbfgZLGqxwG8LRs=0hy+iJGYQd61Ad5LghrkDWV=4w@mail.gmail.com>
Message-ID: <CAGXu5jKLHbfgZLGqxwG8LRs=0hy+iJGYQd61Ad5LghrkDWV=4w@mail.gmail.com>
Subject: Re: [PATCH] selftests: do not macro-expand failed assertion expressions
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 9, 2018 at 3:00 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> I've stumbled over the current macro-expand behaviour of the test
> harness:
>
> $ gcc -Wall -xc - <<'__EOF__'
> TEST(macro) {
>         int status = 0;
>         ASSERT_TRUE(WIFSIGNALED(status));
> }
> TEST_HARNESS_MAIN
> __EOF__
> $ ./a.out
> [==========] Running 1 tests from 1 test cases.
> [ RUN      ] global.macro
> <stdin>:4:global.macro:Expected 0 (0) != (((signed char) (((status) & 0x7f) + 1) >> 1) > 0) (0)
> global.macro: Test terminated by assertion
> [     FAIL ] global.macro
> [==========] 0 / 1 tests passed.
> [  FAILED  ]
>
> With this change the output of the same test looks much more
> comprehensible:
>
> [==========] Running 1 tests from 1 test cases.
> [ RUN      ] global.macro
> <stdin>:4:global.macro:Expected 0 (0) != WIFSIGNALED(status) (0)
> global.macro: Test terminated by assertion
> [     FAIL ] global.macro
> [==========] 0 / 1 tests passed.
> [  FAILED  ]
>
> The issue is very similar to the bug fixed in glibc assert(3)
> three years ago:
> https://sourceware.org/bugzilla/show_bug.cgi?id=18604
>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Yeah, good idea.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees


> ---
>  tools/testing/selftests/kselftest_harness.h | 42 ++++++++++-----------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 6ae3730c4ee3..76d654ef3234 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -354,7 +354,7 @@
>   * ASSERT_EQ(expected, measured): expected == measured
>   */
>  #define ASSERT_EQ(expected, seen) \
> -       __EXPECT(expected, seen, ==, 1)
> +       __EXPECT(expected, #expected, seen, #seen, ==, 1)
>
>  /**
>   * ASSERT_NE(expected, seen)
> @@ -365,7 +365,7 @@
>   * ASSERT_NE(expected, measured): expected != measured
>   */
>  #define ASSERT_NE(expected, seen) \
> -       __EXPECT(expected, seen, !=, 1)
> +       __EXPECT(expected, #expected, seen, #seen, !=, 1)
>
>  /**
>   * ASSERT_LT(expected, seen)
> @@ -376,7 +376,7 @@
>   * ASSERT_LT(expected, measured): expected < measured
>   */
>  #define ASSERT_LT(expected, seen) \
> -       __EXPECT(expected, seen, <, 1)
> +       __EXPECT(expected, #expected, seen, #seen, <, 1)
>
>  /**
>   * ASSERT_LE(expected, seen)
> @@ -387,7 +387,7 @@
>   * ASSERT_LE(expected, measured): expected <= measured
>   */
>  #define ASSERT_LE(expected, seen) \
> -       __EXPECT(expected, seen, <=, 1)
> +       __EXPECT(expected, #expected, seen, #seen, <=, 1)
>
>  /**
>   * ASSERT_GT(expected, seen)
> @@ -398,7 +398,7 @@
>   * ASSERT_GT(expected, measured): expected > measured
>   */
>  #define ASSERT_GT(expected, seen) \
> -       __EXPECT(expected, seen, >, 1)
> +       __EXPECT(expected, #expected, seen, #seen, >, 1)
>
>  /**
>   * ASSERT_GE(expected, seen)
> @@ -409,7 +409,7 @@
>   * ASSERT_GE(expected, measured): expected >= measured
>   */
>  #define ASSERT_GE(expected, seen) \
> -       __EXPECT(expected, seen, >=, 1)
> +       __EXPECT(expected, #expected, seen, #seen, >=, 1)
>
>  /**
>   * ASSERT_NULL(seen)
> @@ -419,7 +419,7 @@
>   * ASSERT_NULL(measured): NULL == measured
>   */
>  #define ASSERT_NULL(seen) \
> -       __EXPECT(NULL, seen, ==, 1)
> +       __EXPECT(NULL, "NULL", seen, #seen, ==, 1)
>
>  /**
>   * ASSERT_TRUE(seen)
> @@ -429,7 +429,7 @@
>   * ASSERT_TRUE(measured): measured != 0
>   */
>  #define ASSERT_TRUE(seen) \
> -       ASSERT_NE(0, seen)
> +       __EXPECT(0, "0", seen, #seen, !=, 1)
>
>  /**
>   * ASSERT_FALSE(seen)
> @@ -439,7 +439,7 @@
>   * ASSERT_FALSE(measured): measured == 0
>   */
>  #define ASSERT_FALSE(seen) \
> -       ASSERT_EQ(0, seen)
> +       __EXPECT(0, "0", seen, #seen, ==, 1)
>
>  /**
>   * ASSERT_STREQ(expected, seen)
> @@ -472,7 +472,7 @@
>   * EXPECT_EQ(expected, measured): expected == measured
>   */
>  #define EXPECT_EQ(expected, seen) \
> -       __EXPECT(expected, seen, ==, 0)
> +       __EXPECT(expected, #expected, seen, #seen, ==, 0)
>
>  /**
>   * EXPECT_NE(expected, seen)
> @@ -483,7 +483,7 @@
>   * EXPECT_NE(expected, measured): expected != measured
>   */
>  #define EXPECT_NE(expected, seen) \
> -       __EXPECT(expected, seen, !=, 0)
> +       __EXPECT(expected, #expected, seen, #seen, !=, 0)
>
>  /**
>   * EXPECT_LT(expected, seen)
> @@ -494,7 +494,7 @@
>   * EXPECT_LT(expected, measured): expected < measured
>   */
>  #define EXPECT_LT(expected, seen) \
> -       __EXPECT(expected, seen, <, 0)
> +       __EXPECT(expected, #expected, seen, #seen, <, 0)
>
>  /**
>   * EXPECT_LE(expected, seen)
> @@ -505,7 +505,7 @@
>   * EXPECT_LE(expected, measured): expected <= measured
>   */
>  #define EXPECT_LE(expected, seen) \
> -       __EXPECT(expected, seen, <=, 0)
> +       __EXPECT(expected, #expected, seen, #seen, <=, 0)
>
>  /**
>   * EXPECT_GT(expected, seen)
> @@ -516,7 +516,7 @@
>   * EXPECT_GT(expected, measured): expected > measured
>   */
>  #define EXPECT_GT(expected, seen) \
> -       __EXPECT(expected, seen, >, 0)
> +       __EXPECT(expected, #expected, seen, #seen, >, 0)
>
>  /**
>   * EXPECT_GE(expected, seen)
> @@ -527,7 +527,7 @@
>   * EXPECT_GE(expected, measured): expected >= measured
>   */
>  #define EXPECT_GE(expected, seen) \
> -       __EXPECT(expected, seen, >=, 0)
> +       __EXPECT(expected, #expected, seen, #seen, >=, 0)
>
>  /**
>   * EXPECT_NULL(seen)
> @@ -537,7 +537,7 @@
>   * EXPECT_NULL(measured): NULL == measured
>   */
>  #define EXPECT_NULL(seen) \
> -       __EXPECT(NULL, seen, ==, 0)
> +       __EXPECT(NULL, "NULL", seen, #seen, ==, 0)
>
>  /**
>   * EXPECT_TRUE(seen)
> @@ -547,7 +547,7 @@
>   * EXPECT_TRUE(measured): 0 != measured
>   */
>  #define EXPECT_TRUE(seen) \
> -       EXPECT_NE(0, seen)
> +       __EXPECT(0, "0", seen, #seen, !=, 0)
>
>  /**
>   * EXPECT_FALSE(seen)
> @@ -557,7 +557,7 @@
>   * EXPECT_FALSE(measured): 0 == measured
>   */
>  #define EXPECT_FALSE(seen) \
> -       EXPECT_EQ(0, seen)
> +       __EXPECT(0, "0", seen, #seen, ==, 0)
>
>  /**
>   * EXPECT_STREQ(expected, seen)
> @@ -597,7 +597,7 @@
>         if (_metadata->passed && _metadata->step < 255) \
>                 _metadata->step++;
>
> -#define __EXPECT(_expected, _seen, _t, _assert) do { \
> +#define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
>         /* Avoid multiple evaluation of the cases */ \
>         __typeof__(_expected) __exp = (_expected); \
>         __typeof__(_seen) __seen = (_seen); \
> @@ -606,8 +606,8 @@
>                 unsigned long long __exp_print = (uintptr_t)__exp; \
>                 unsigned long long __seen_print = (uintptr_t)__seen; \
>                 __TH_LOG("Expected %s (%llu) %s %s (%llu)", \
> -                        #_expected, __exp_print, #_t, \
> -                        #_seen, __seen_print); \
> +                        _expected_str, __exp_print, #_t, \
> +                        _seen_str, __seen_print); \
>                 _metadata->passed = 0; \
>                 /* Ensure the optional handler is triggered */ \
>                 _metadata->trigger = 1; \
> --
> ldv



--
Kees Cook
