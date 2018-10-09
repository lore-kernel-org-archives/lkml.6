Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27F2ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A2E214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ibXoZ1d8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A2E214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJJAwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:52:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38913 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeJJAwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:52:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id p1-v6so2336603ljg.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RknYuLgFYazoahQHRlfw+s7Hco0WViJwC8wm3SuKuI=;
        b=ibXoZ1d8RYk31H9LNel1guKyK7gjEDL5kZBmZW0+aI5eAF4EQ39CS9b++Wb6YKda38
         ONTGPqe4u3KwkHBQ2h7xnkkz0mLNDDedvFgh7/ecPlLiFINNkQ0c6k6hf3i4fa3VUyyG
         M/ozAJcyFudhU8yuyjzfl85iOxSoPynnjiSoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RknYuLgFYazoahQHRlfw+s7Hco0WViJwC8wm3SuKuI=;
        b=PrHouEwvuuaeFFtbi9QySik7brU5FVz/0OAamwIy7J/MX+1HIMXo2STjQA/VhSlEqG
         g9w5llNgDv77sa8mwYyByZeTzajoIiq/YjS/lbwGQaHlH8oGEQe2HfEVxzXHQTI6a9dR
         APvwCld0MLWI1jZN76VjqIK3pvztgrZ0zKULvALVe4LNM9jL68H9suRY8qvnoUS8JVWk
         O1l5E6BFI0mbFAJYxXZebSTmito8ECJaOkhFzVK/i92hTOmNBtmWNTwmNGa7SfzvO2Ci
         TMGgq50ve/1/wrmSZV6G0wp59xOdE9W1BY/Bxl90kOJ7RRH2mzYuYsWKIzVpTxuviAJY
         5Ivg==
X-Gm-Message-State: ABuFfojKEYbE0+3/THObwBWujT7eKPj8wIVh2c0g4rY6DJTrCulOonrv
        Q0wTvpPR84C4udSF8CJwM48CRc4aNGdGJw==
X-Google-Smtp-Source: ACcGV60sdSeokeXT0XmzPaPmBp5bsmIi7ky94Ke29eXinJmjep+FfvYhPDNN1W+3iLNTi+FhuxY+pA==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26-v6mr18532738lja.172.1539106478533;
        Tue, 09 Oct 2018 10:34:38 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id k19-v6sm4520680lfi.51.2018.10.09.10.34.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 10:34:37 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id p34-v6so1879593lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:34:37 -0700 (PDT)
X-Received: by 2002:a19:3855:: with SMTP id d21-v6mr15576232lfj.148.1539106476658;
 Tue, 09 Oct 2018 10:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1810091046050.14430@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1810091046050.14430@cbobk.fhfr.pm>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Tue, 9 Oct 2018 10:34:25 -0700
X-Gmail-Original-Message-ID: <CAE_wzQ8X+BRtoA8ttKU-hncESNAOaRN4v7O8Ay2yKY9dK_PGAg@mail.gmail.com>
Message-ID: <CAE_wzQ8X+BRtoA8ttKU-hncESNAOaRN4v7O8Ay2yKY9dK_PGAg@mail.gmail.com>
Subject: Re: [PATCH] HID: google: drop superfluous const before SIMPLE_DEV_PM_OPS()
To:     Jiri Kosina <jikos@kernel.org>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 1:48 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> From: Jiri Kosina <jkosina@suse.cz>
>
> SIMPLE_DEV_PM_OPS() already implies const for the type; drop the extra
> modifier.
>
> Fixes: eb1aac4c8744f75460c34d71b0c73bebf3e8ee5c ("HID: google: add support tablet mode switch for Whiskers")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

FWIW

Acked-by: Dmitry Torokhov <dtor@chromium.org>

> ---
>
> In hid.git#for-4.20/google
>
>  drivers/hid/hid-google-hammer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> index de3e7d055ca4..ee5e0bdcf078 100644
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -161,7 +161,7 @@ static __maybe_unused int cbas_ec_resume(struct device *dev)
>         return 0;
>  }
>
> -static const SIMPLE_DEV_PM_OPS(cbas_ec_pm_ops, NULL, cbas_ec_resume);
> +static SIMPLE_DEV_PM_OPS(cbas_ec_pm_ops, NULL, cbas_ec_resume);
>
>  static void cbas_ec_set_input(struct input_dev *input)
>  {
>
> --
> Jiri Kosina
> SUSE Labs
