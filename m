Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B71C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C3E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IVlxy/Fe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C3E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbeK1Eyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:54:54 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36482 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731749AbeK1Eyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:54:53 -0500
Received: by mail-yw1-f68.google.com with SMTP id y194so9509089ywg.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JW0aEvufzitQixWSWQWj26FogOCWOXctwaJai/3NkaM=;
        b=IVlxy/FedZwhPFUBQWpe8Wav7myRdSfCDzFwJNqjid/+IutjwpXwWOHrP1+oPxFhX6
         FMG/vDK5CmB2EbaNBR/n+KpH9hCtu/KelW3X2UbZ7rblg1BtSYwyN0scBeBt0TH7gT0V
         tB4BOJobqsP9FpGVj8bxBk6WTrRbeXrVkCuj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JW0aEvufzitQixWSWQWj26FogOCWOXctwaJai/3NkaM=;
        b=P8hWOmQBgu6qUbTco/oTnoOD5GEPOj1GXHJGh5ZsaCiDSrMiG6tTf2bamhedVVGAgz
         niBR5yNXg2uVU1Y2i5xNz8HOJQkDVlOCefM5ivmzMJamMtT41e4/8zGSCfZeLbSaRNE+
         IZt9Zb1UlM6tq9epd5IyqkhdWYHF7Ul53WXX7jExIkcrQca/+IvwPuM0ivHoYeqxU5+a
         jmDotcEsc/8mZMdylvbRDymKozVrLKb8XzAGjpSdQFqleNZWjWKS7wLhcf9moPE/7Q01
         mlVHnlleQgKb2hCgntRpu4h2pmSk5SqREpDSw571FHpiIMLvp28/x+/ouH7qx3zXkkd9
         r4IQ==
X-Gm-Message-State: AGRZ1gLU4YicT5xr7KEyQikkPGVIeIm1xiSeWu5jY8AMkeveh5O6xvYt
        tQa0TFDqhKF/huiK3P2DhtcN36hP5D4=
X-Google-Smtp-Source: AJdET5eu2JieWZi1xgI0HdR5R660eFXL8FPfHkZLnb0KLYH1FIN4sF9H4WU/dZsw6rRDK5R6SkA2Ew==
X-Received: by 2002:a81:36d8:: with SMTP id d207-v6mr35941066ywa.71.1543341371598;
        Tue, 27 Nov 2018 09:56:11 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id 206-v6sm2167967ywp.0.2018.11.27.09.56.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 09:56:10 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id i17-v6so9414344ybp.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:56:10 -0800 (PST)
X-Received: by 2002:a25:7644:: with SMTP id r65-v6mr29657454ybc.403.1543341369944;
 Tue, 27 Nov 2018 09:56:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 09:56:09
 -0800 (PST)
In-Reply-To: <20181127031218.24419-2-dan.rue@linaro.org>
References: <20181127031218.24419-1-dan.rue@linaro.org> <20181127031218.24419-2-dan.rue@linaro.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Nov 2018 09:56:09 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJWQX2qwwL4_1wQUWOGU9ZDay8ddZaLLJQJ-1S8h5cgzA@mail.gmail.com>
Message-ID: <CAGXu5jJWQX2qwwL4_1wQUWOGU9ZDay8ddZaLLJQJ-1S8h5cgzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: firmware: remove use of non-standard diff
 -Z option
To:     Dan Rue <dan.rue@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 7:12 PM, Dan Rue <dan.rue@linaro.org> wrote:
> diff -Z is used to trim the trailing whitespace when comparing the
> loaded firmware file with the source firmware file. However, per the
> comment in the source code, -Z should not be necessary. In testing, the
> input and output files are identical.
>
> Additionally, -Z is not a standard option and is not available in
> environments such as busybox. When -Z is not supported, diff fails with
> a usage error, which is suppressed, but then causes read_firmwares() to
> exit with a false failure message.
>
> Signed-off-by: Dan Rue <dan.rue@linaro.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/firmware/fw_filesystem.sh | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
> index a4320c4b44dc..466cf2f91ba0 100755
> --- a/tools/testing/selftests/firmware/fw_filesystem.sh
> +++ b/tools/testing/selftests/firmware/fw_filesystem.sh
> @@ -155,11 +155,8 @@ read_firmwares()
>  {
>         for i in $(seq 0 3); do
>                 config_set_read_fw_idx $i
> -               # Verify the contents are what we expect.
> -               # -Z required for now -- check for yourself, md5sum
> -               # on $FW and DIR/read_firmware will yield the same. Even
> -               # cmp agrees, so something is off.
> -               if ! diff -q -Z "$FW" $DIR/read_firmware 2>/dev/null ; then
> +               # Verify the contents match
> +               if ! diff -q "$FW" $DIR/read_firmware 2>/dev/null ; then
>                         echo "request #$i: firmware was not loaded" >&2
>                         exit 1
>                 fi
> @@ -171,7 +168,7 @@ read_firmwares_expect_nofile()
>         for i in $(seq 0 3); do
>                 config_set_read_fw_idx $i
>                 # Ensures contents differ
> -               if diff -q -Z "$FW" $DIR/read_firmware 2>/dev/null ; then
> +               if diff -q "$FW" $DIR/read_firmware 2>/dev/null ; then
>                         echo "request $i: file was not expected to match" >&2
>                         exit 1
>                 fi
> --
> 2.19.1
>



-- 
Kees Cook
