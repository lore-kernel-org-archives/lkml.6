Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EF985C5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A306208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HOra5Z8i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kcw8BKtl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A306208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934907AbeFMACF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:02:05 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:46661 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934634AbeFMACD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:02:03 -0400
Received: by mail-yw0-f195.google.com with SMTP id v197-v6so261546ywc.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 17:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rWkz+1Mt3IOjq4J128zktzgOcXHllswKWBfcGQb5kVU=;
        b=HOra5Z8i2cRiatjnqfm4t0NJPK6QZMHek1VaZZwBhSJ9FWitKEU4IQh9dklgpSv2i+
         b9PwE+JWk8sHhR6ME0Jv4WVEDnjYpJGJUOibCCNg1UFTxTgiP7Lp5d+I20Td6Ld5dlmb
         2gdARiXXHPUzylLoBj/pDz8fdI426/xaHdE+S3HhlgdBvqI8ldMDCobVYzrktGlClQXT
         4vX/++Wp8XJn8G5mu+Kk0GmM69IZO7Y3fWaALBTBts1VQcLI8sy8XCzRQ3XgtAVGYxvT
         RkO/vs772lLegcnhRNT/GOOC+YPar0RNZLtiTlNErlZ9tkaN7GmgWvWR4YMDLV3UZfYM
         6lmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rWkz+1Mt3IOjq4J128zktzgOcXHllswKWBfcGQb5kVU=;
        b=kcw8BKtldDi8tbmulJtGIqTebNHoRCZFkAQHnVNxoX9+2Tvz+9cnVvObfuGzEyg2k8
         rgJ0H3EHo9ADn2lv1QtAaIdPx+epd+Vpz36BjYYAK/6uTFXy46WBVIFADbOVjV8u6ibE
         +R+HWc1VBCtPH5zXztmv4a+3r4/Ff5Tk4mQEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rWkz+1Mt3IOjq4J128zktzgOcXHllswKWBfcGQb5kVU=;
        b=Lk4roit3+Vdn1cWtFVajj9GhJ+XKtVPLJ5suYsJ7hHB5l08QgTJEwCmj5WsG8kFh2c
         bIddZg+fn7hxw2JUz+60pQM362RJn5vc3iDMf792VGML5x3q4i9hD/eOMH9JTYwEcnb7
         7+pF7P3FcmJ5w+JksvVDp9QP0V8xfAAyjSxBWRSKLEVh/Q3IVG4TahHKWFG5tTsrbhIe
         x3gqfJ2+nXwW+nOe7KAIuojGhuJw91A4uqNgaPYsUrvfdv2sJZNt5p5YrOo08KxA6P19
         JmbYoatDQE1ydRO2QVzKVBgZjNu3ZgucDZdZiaBDb9RFk4cEevYik+JpX3YXSMHFw5lZ
         nr8Q==
X-Gm-Message-State: APt69E09lT6Lp9S3HS1e4kTucJkMylor9klVCfSLP5wzbahc51rslRy1
        eOoLAveEM4x9z1+CVYC4CUpPCzCJfkc+u5DBirARaA==
X-Google-Smtp-Source: ADUXVKKj4GJ7x+7HlR3JJBDTqUHyUcP7a5DfemBh/Exu+fK0nYr9Qm5DHpie65yoKmahe9dT6atTNWW6cdsIU71aGI8=
X-Received: by 2002:a81:4a05:: with SMTP id x5-v6mr1329841ywa.116.1528848122865;
 Tue, 12 Jun 2018 17:02:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 17:02:02
 -0700 (PDT)
In-Reply-To: <20180612232230.27864-1-shuah@kernel.org>
References: <20180612232230.27864-1-shuah@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Jun 2018 17:02:02 -0700
X-Google-Sender-Auth: Oli6NhlZTpVKDuRRowSbqReT5SI
Message-ID: <CAGXu5j+QyS_RCKgyL-hH9HO4vo1ZR0BuWbeBtzHBt8AnWMPU2A@mail.gmail.com>
Subject: Re: [PATCH] selftests: pstore: return Kselftest Skip code for skipped tests
To:     "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 4:22 PM, Shuah Khan (Samsung OSG)
<shuah@kernel.org> wrote:
> When pstore_post_reboot test gets skipped because of unmet dependencies
> and/or unsupported configuration, it returns 0 which is treated as a pass
> by the Kselftest framework. This leads to false positive result even when
> the test could not be run.
>
> Change it to return kselftest skip code when a test gets skipped to clearly
> report that the test could not be run.
>
> Kselftest framework SKIP code is 4 and the framework prints appropriate
> messages to indicate that the test is skipped.
>
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

> ---
>  tools/testing/selftests/pstore/pstore_post_reboot_tests | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/pstore/pstore_post_reboot_tests b/tools/testing/selftests/pstore/pstore_post_reboot_tests
> index 6ccb154cb4aa..22f8df1ad7d4 100755
> --- a/tools/testing/selftests/pstore/pstore_post_reboot_tests
> +++ b/tools/testing/selftests/pstore/pstore_post_reboot_tests
> @@ -7,13 +7,16 @@
>  #
>  # Released under the terms of the GPL v2.
>
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
>  . ./common_tests
>
>  if [ -e $REBOOT_FLAG  ]; then
>      rm $REBOOT_FLAG
>  else
>      prlog "pstore_crash_test has not been executed yet. we skip further tests."
> -    exit 0
> +    exit $ksft_skip
>  fi
>
>  prlog -n "Mounting pstore filesystem ... "
> --
> 2.17.0
>



-- 
Kees Cook
Pixel Security
