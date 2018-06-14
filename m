Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E73A6C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 04:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87000208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 04:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="udA2l3D7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hbOtpqE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87000208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbeFNEGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 00:06:45 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:44798 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbeFNEGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 00:06:43 -0400
Received: by mail-yw0-f196.google.com with SMTP id k18-v6so1120758ywm.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 21:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Be8oAeVKEIfe1f38u7Kaj2gS5fvTDRqiJ9Rbm+9i+aA=;
        b=udA2l3D7GWhy65HrTnK8zNyBKuMFv1FRZ8zU4WpsrPh/HlAfJR6u1krmKcYY70uvQO
         SvRy4EVPi0GolN7NVtxR8bbQm5ok6ooJwCo1Os8zjceFU39hdK4hAkDvryOn6FUInv2C
         GHZ/E/X/pAafXwdUb8voNGfWKSs7BpuhAViEzf6rCTdi7l0S5D+Gj8qTiWfBt7V6sBSO
         DbFN2t+c9Q/tJyMUFgtuAVtekZuU2KQA9GBEwJE+/YxoyvGcbsVvOZwUnIWbzmbB177a
         QUh8rw/h34UOhapdemjFGu/Y00Sl1lRQHUKCJVzMcMwdvVcZBRhxssGbdAew6ns/mjch
         34Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Be8oAeVKEIfe1f38u7Kaj2gS5fvTDRqiJ9Rbm+9i+aA=;
        b=hbOtpqE49W0B/wfY89vRFRP6TQQWyuAPhjrxb68aJvfIiz+Z3yy9QKRfuIcW3MpdGi
         AeFusONaVZouBMQXFQ6ZpzjzD/6gbASnAaa0Cqulak/uwhoRQaAlxYyZVGMfnHVIg/Ey
         NxsTxaaOpFE+nus+h8lYYI3B6A1zb8e0C9Owk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Be8oAeVKEIfe1f38u7Kaj2gS5fvTDRqiJ9Rbm+9i+aA=;
        b=aUaTnaLya4LzOQDgVy63asUXT+yY+1G+MhrvwXOoZOwn8+6E4AJGYDAkgNTd5bYf/D
         KH8INCcRTtfyZDMTgOrRP75wCNLpne21RbtKGuXm21+WQnwDoqQkCsYLGDgnPi9l/KTH
         LBTpR7ubqzcyn73SJQpL+BSW7+a7FaRsmgZWQZRXUcLXw5NfoktV17s8VBWVR50nXdgX
         jMrvfwpg19/ozX9JeDGFj0hir59EC+cL1LXhUZ1j/ZiKp7FlsXhYdjAF5aQFrJwOzDjj
         aMRnVQhDbJITlXivx+kLbALINJJGsGOgL7J7DhqsiopeOObiye4PP+Hsfo4eZrK16x6t
         dI+g==
X-Gm-Message-State: APt69E1TuAN2gl4Kuzd1/OjpA2YhwJLBBnfT+9W8KNzpXCw5Mvb/G2Eo
        fu2th5v2BgfF2XcWRKkM+uOOzIe8QFphi7wvY/x4aw==
X-Google-Smtp-Source: ADUXVKJ7ZFYT3X8NnRM/xkx/c++x0ON22Cqjob/O+JKIGWljFspzKIsUmyytsnOXW/RSrU23hZtvLPmK/DA8XuXuUrw=
X-Received: by 2002:a81:8743:: with SMTP id x64-v6mr464300ywf.129.1528949202559;
 Wed, 13 Jun 2018 21:06:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 21:06:41
 -0700 (PDT)
In-Reply-To: <20180614013445.6120-1-shuah@kernel.org>
References: <20180614013445.6120-1-shuah@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 13 Jun 2018 21:06:41 -0700
X-Google-Sender-Auth: U_GNwtBKaISMPF9CsAxlbBnCkmQ
Message-ID: <CAGXu5jLXAQxo7mUJThXCOMPEC3yvGU5_wLqjU_YKGtd6sFfuUw@mail.gmail.com>
Subject: Re: [PATCH] selftests: kselftest_harness: return Kselftest Skip code
 for skipped tests
To:     "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 6:34 PM, Shuah Khan (Samsung OSG)
<shuah@kernel.org> wrote:
> When a test is skipped because of unmet dependencies and/or unsupported
> configuration, kselftest_harness exits with error which is treated as a
> fail by the Kselftest framework. This leads to false negative result even
> when the test could not be run.
>
> Change it to return kselftest skip code when a test gets skipped to
> clearly report that the test could not be run. This change add skip
> handling to kselftest_harness with minimal changes adding a new skipped
> field to struct __test_metadata and using it to recognize KSFT_SKIP exit
> from the test function (t->fn) to __run_test() to the test_harness_run()
> to return the right skip code to Kselftest framework.
>
> Kselftest framework SKIP code is 4 and the framework prints appropriate
> messages to indicate that the test is skipped.

Unfortunately this will not work: test step # is used as the failure
code to let test runners know where a child failed. KSFT_SKIP is 4, so
every test failing in step 4 would be seen as a skip instead of a
fail.

Tests must not exit on their own with this harness: only the existing
ASSERT/EXPECT macros can be used. uevent test should never be doing
this:

        if (geteuid()) {
                TH_LOG("Uevent filtering tests require root
privileges. Skipping test");
                _exit(KSFT_SKIP);
        }

Nor the _exit(EXIT_FAILURE) calls. Those must all be ASSERT() instead.

Perhaps a new signal could be used, but the return codes are already being used.

-Kees

>
> This change is tested on uevent test and the results are as follows:
>
> Before:
>
> TAP version 13
> selftests: uevent: uevent_filtering
> ========================================
> [==========] Running 1 tests from 1 test cases.
> [ RUN      ] global.uevent_filtering
> uevent_filtering.c:355:global.uevent_filtering:Uevent filtering tests require root privileges. Skipping test
> global.uevent_filtering: Test skipped at step #4
> [     FAIL ] global.uevent_filtering
> [==========] 0 / 1 tests passed.
> [  FAILED  ]
> not ok 1..1 selftests: uevent: uevent_filtering [FAIL]
>
> After:
>
> TAP version 13
> selftests: uevent: uevent_filtering
> ========================================
> [==========] Running 1 tests from 1 test cases.
> [ RUN      ] global.uevent_filtering
> uevent_filtering.c:355:global.uevent_filtering:Uevent filtering tests require root privileges. Skipping test
> global.uevent_filtering: Test skipped at step #4
> [     SKIP ] global.uevent_filtering
> not ok 1..1 selftests: uevent: uevent_filtering [SKIP]
>
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> ---
>  tools/testing/selftests/kselftest_harness.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 6ae3730c4ee3..7af9ab97b367 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -631,6 +631,7 @@ struct __test_metadata {
>         void (*fn)(struct __test_metadata *);
>         int termsig;
>         int passed;
> +       int skipped;
>         int trigger; /* extra handler after the evaluation */
>         __u8 step;
>         bool no_print; /* manual trigger when TH_LOG_STREAM is not available */
> @@ -694,6 +695,7 @@ void __run_test(struct __test_metadata *t)
>         int status;
>
>         t->passed = 1;
> +       t->skipped = 0;
>         t->trigger = 0;
>         printf("[ RUN      ] %s\n", t->name);
>         child_pid = fork();
> @@ -716,9 +718,12 @@ void __run_test(struct __test_metadata *t)
>                                         t->name,
>                                         WEXITSTATUS(status));
>                         } else if (!t->passed) {
> +                               if (WEXITSTATUS(status) == KSFT_SKIP)
> +                                       t->skipped = 1;
>                                 fprintf(TH_LOG_STREAM,
> -                                       "%s: Test failed at step #%d\n",
> +                                       "%s: Test %s at step #%d\n",
>                                         t->name,
> +                                       (t->skipped ? "skipped" : "failed"),
>                                         WEXITSTATUS(status));
>                         }
>                 } else if (WIFSIGNALED(status)) {
> @@ -743,7 +748,11 @@ void __run_test(struct __test_metadata *t)
>                                 status);
>                 }
>         }
> -       printf("[     %4s ] %s\n", (t->passed ? "OK" : "FAIL"), t->name);
> +       if (t->skipped)
> +               printf("[     %4s ] %s\n", "SKIP", t->name);
> +       else
> +               printf("[     %4s ] %s\n", (t->passed ? "OK" : "FAIL"),
> +                       t->name);
>  }
>
>  static int test_harness_run(int __attribute__((unused)) argc,
> @@ -762,6 +771,8 @@ static int test_harness_run(int __attribute__((unused)) argc,
>                 __run_test(t);
>                 if (t->passed)
>                         pass_count++;
> +               else if (t->skipped)
> +                       return KSFT_SKIP;
>                 else
>                         ret = 1;
>         }
> --
> 2.17.0
>



-- 
Kees Cook
Pixel Security
