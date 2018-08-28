Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90841C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395EF205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hKPKl3ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395EF205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeH1Jju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:39:50 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:46252 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeH1Jju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:39:50 -0400
Received: by mail-yb0-f196.google.com with SMTP id y20-v6so142669ybi.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 22:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UaS7LOMaf4xE5CDmiVdah2G1EB7MWlPGywYevA9nKwM=;
        b=hKPKl3axwfCkcsxDGPUlneYuxVSlPsFR4kxTEWw2dulZWwVLrlNo1dvnlXNX83DdTn
         CDkoXc14tcIQTbyKp6tSCBeKvQD/mIWVICFu84eMWN477HPVfwzoYS+FkY78Wtc+QmNP
         hTtOMWwOmApkpCU+L8tmSFbCmzL9rjIdEgBtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UaS7LOMaf4xE5CDmiVdah2G1EB7MWlPGywYevA9nKwM=;
        b=MhjMGJm2SgMANn7hlVKyYxapIkTdhkxUhCuqoA9dqBEM+Uc5Ny+va4VsFuyfkIqwcM
         RuWSy7AkC7Cwdq1RnNkPlnSIUKnBU/iF1eygjYWKFv8vbhMH64WmzPx/AfkJwTbcYonT
         CK6DJCUjvjjKp1QEzHyJ4WUvfx1Y3+Q9ix7MLsYyLkdj3JUJpv/yMtobMAIOvNqqxrEY
         6lBx9RTmqLp2iAnvYhP/Yct6iCzZX8QYDrVpbnnOpwoBY1CscbCEAil31kCn00V/A7oI
         3tvszCujdsU+nATxBZtwdHtu6GIxiujc7FtPJbdBhlAVgNiqLT9O01oyKdO1yWErMJQF
         2gIg==
X-Gm-Message-State: APzg51C49ST3niSknrtxFfYruLv+cdRH54oa5O4eZyn+NOkprYcvbOAX
        Znwqq3dnolDwNFFm4sLI9z7KBDDUJ2I=
X-Google-Smtp-Source: ANB0VdYXq45ULZqvvG30h4yiPX40GZqOEgG3yBCjemuuIAhgyxDRQk1jKhvbulH0QSOX3mVLrm/RHw==
X-Received: by 2002:a25:b28c:: with SMTP id k12-v6mr25257ybj.30.1535435076205;
        Mon, 27 Aug 2018 22:44:36 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id r12-v6sm46088ywg.67.2018.08.27.22.44.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 22:44:35 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id j131-v6so137280ywc.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 22:44:34 -0700 (PDT)
X-Received: by 2002:a81:9b85:: with SMTP id s127-v6mr12673ywg.47.1535435073943;
 Mon, 27 Aug 2018 22:44:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 22:44:33
 -0700 (PDT)
In-Reply-To: <0fa8a2cb83ade4c525e18261ecf6cfede3015983.camel@perches.com>
References: <CAGXu5jL9b3Ks95fpq5tdqS1avQysasaCBDzaA31-FVmJCqz=Og@mail.gmail.com>
 <c07f1fd50d25077f62efbe586bfc40428959d175.camel@perches.com> <0fa8a2cb83ade4c525e18261ecf6cfede3015983.camel@perches.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 27 Aug 2018 22:44:33 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKCyzqcrTj8h9jvv6_ZMcKQ4=K8BjP6MrcgaUzA1cqYbg@mail.gmail.com>
Message-ID: <CAGXu5jKCyzqcrTj8h9jvv6_ZMcKQ4=K8BjP6MrcgaUzA1cqYbg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Add __ro_after_init to known $Attribute
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:33 PM, Joe Perches <joe@perches.com> wrote:
> __ro_after_init is a specific __attribute__ that checkpatch
> does currently not understand.
>
> Add it to the known $Attribute types so that code that uses
> variables declared with __ro_after_init are not thought to
> be a modifier type.
>
> This appears as a defect in checkpatch output of code like:
>
> static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
> [...]
>        if (trust_cpu && arch_init) {
>
> where checkpatch reports:
>
> ERROR: space prohibited after that '&&' (ctx:WxW)
>         if (trust_cpu && arch_init) {
>

Thanks for tracking this down!

> Reported-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Joe Perches <joe@perches.com>

Tested-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 5219280bf7ff..23cde9d90278 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -380,6 +380,7 @@ our $Attribute      = qr{
>                         __noclone|
>                         __deprecated|
>                         __read_mostly|
> +                       __ro_after_init|
>                         __kprobes|
>                         $InitAttribute|
>                         ____cacheline_aligned|



-- 
Kees Cook
Pixel Security
