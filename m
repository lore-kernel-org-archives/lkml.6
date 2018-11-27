Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152EBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D746A2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GkJejCkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D746A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbeK1EzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:55:24 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38977 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731749AbeK1EzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:55:23 -0500
Received: by mail-yb1-f196.google.com with SMTP id w17-v6so9428302ybl.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+UdKTrr72ZMfamSGJHOfjJQJkKjC3HcwfZA9g1yZ9kM=;
        b=GkJejCkrWIjAReJ2ehQtGHnWqpNiagLhQnePPH+yiumZEUZ/CU6SKc+747K4PC10p6
         sXxALYpTxZjWjwzYqUEetIsByFR6Bbm98QLuCoW/jFHEnhzfQzQ7gzTOHLqWzdco3Eoz
         77OXz6T3p/LAgAWgWiGlS2GY14SfP/INxM/I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+UdKTrr72ZMfamSGJHOfjJQJkKjC3HcwfZA9g1yZ9kM=;
        b=rp2LFVijG1fLma0UG89O4uzu3t6sRYXiEjefnZCfJ35adSS73bNage6gsXWIAvxhIE
         aXL0Ltyx/lfkCxjGPpGP8zItuH30652KYg5wMMZohviBct6tlNjQeJYT9g/b1a5u62uU
         l28789JKicLYqNx1WPlvGEzdrwMnoNAhb8qcGAK3rJSsgOBf3ELoGbheejgKMwq7jPaN
         5e8ZvUyn9Ppl3hBdWZW0x7nWFFdkw3HxxCioE3WMxkztSk7cesxLWvZZgOjZRlIbfBYO
         pYqQgJUrFaEsqFvXL3tKZfcKjmvVjrFcvG+EehBSDsARppid+PJN9fDeCmWeQ+54Bk1+
         WTUg==
X-Gm-Message-State: AA+aEWb4NbSDz00A/5qI5wQF8fc5Ywtot1JYt1qNWsKKCbPXNkPZglwJ
        rfHFgvbdlBxMBBYeR55GGGrWHnqOxP0=
X-Google-Smtp-Source: AFSGD/Ukrhh5Tle2XytsW96AwdgvAt+gwV6Hk4yM+iQdb9oOfj6Zy3PH9ukLkJ/ROsE7JMkxz+nWxw==
X-Received: by 2002:a25:b081:: with SMTP id f1-v6mr35081061ybj.65.1543341401861;
        Tue, 27 Nov 2018 09:56:41 -0800 (PST)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id f10sm4204163ywb.26.2018.11.27.09.56.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 09:56:40 -0800 (PST)
Received: by mail-yw1-f43.google.com with SMTP id f65so9506195ywc.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:56:40 -0800 (PST)
X-Received: by 2002:a81:2890:: with SMTP id o138mr36415736ywo.168.1543341400228;
 Tue, 27 Nov 2018 09:56:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 09:56:39
 -0800 (PST)
In-Reply-To: <20181127031218.24419-3-dan.rue@linaro.org>
References: <20181127031218.24419-1-dan.rue@linaro.org> <20181127031218.24419-3-dan.rue@linaro.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Nov 2018 09:56:39 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK=oOHsM50iGDcp4PzOHv58r2-XfryAs0N=gfjD+rEaQg@mail.gmail.com>
Message-ID: <CAGXu5jK=oOHsM50iGDcp4PzOHv58r2-XfryAs0N=gfjD+rEaQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: firmware: add CONFIG_FW_LOADER_USER_HELPER_FALLBACK
 to config
To:     Dan Rue <dan.rue@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 7:12 PM, Dan Rue <dan.rue@linaro.org> wrote:
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y is required for fw_fallback.sh.
> Without it, fw_fallback.sh fails with 'usermode helper disabled so
> ignoring test'. Enable the config in selftest so that it gets built by
> default.
>
> Signed-off-by: Dan Rue <dan.rue@linaro.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/firmware/config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/firmware/config b/tools/testing/selftests/firmware/config
> index bf634dda0720..913a25a4a32b 100644
> --- a/tools/testing/selftests/firmware/config
> +++ b/tools/testing/selftests/firmware/config
> @@ -1,5 +1,6 @@
>  CONFIG_TEST_FIRMWARE=y
>  CONFIG_FW_LOADER=y
>  CONFIG_FW_LOADER_USER_HELPER=y
> +CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
> --
> 2.19.1
>



-- 
Kees Cook
