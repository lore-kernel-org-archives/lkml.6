Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1600BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB52A20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uQSOon7q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gFrpFz4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB52A20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934976AbeFMAXE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:23:04 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43192 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934860AbeFMAXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:23:02 -0400
Received: by mail-yw0-f195.google.com with SMTP id r19-v6so279128ywc.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 17:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cEeBd8jb5cIuky1vCO2tHjgNDZHPOUsQtKZwb5dl/1Q=;
        b=uQSOon7qB6vTSuvS7zKAcnRZr7yuIyHjdSs/egKhxQ+u7gI1HyGU8O5+ojfIGhzAD0
         BLoKddG6sHLb9jvU0KkfNVxEfiZ43m4/YO9hzRR9ML9RkBvocZhcedYoI17v/fjJ7udZ
         tEwl21JnMEObY6qYJvJMtBzN7+6cScKdl9usvoeAUITKXwijskB8Tptr+CxmbyPiG7Qp
         w3HvupXRE/ShUvDHBUkJxhrH+cizZ5158aMA8g2hdHgdDhVPqOAcy4UfZVYeq4DSe5Np
         fPdgGidv/eE9VtjhKqeNlDZ0SgkFZ5JOW/PY77EA9Rfdv5b1gfFo7A5Z+l7LQr8c79I3
         dq0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cEeBd8jb5cIuky1vCO2tHjgNDZHPOUsQtKZwb5dl/1Q=;
        b=gFrpFz4uz06tfLwJSuwhI4zcVBjYsnS97pOt21Iso0PF1gP83gwYRu+5aP12zuG16E
         v2XBazTTRROX92SRtTEXMFqm3HlvhhKbpHIQpPwUCkWKKcw0InrQC5z7cCHZIfPvebwH
         uQy2eRMyK0IUmHx7ji+MIphrwXibuzJ1SDmPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cEeBd8jb5cIuky1vCO2tHjgNDZHPOUsQtKZwb5dl/1Q=;
        b=OYK9p+29/+LqgiI91INMvg9yz2iWbBLxYWde4moQBKfWFjoWoi3zgKSV1CNH3Q5IXe
         7ILDNx1m27LTgeCm9+7nRnkYqyFf6KSIQ3dAXlrrmS65WiGMxltExDIks6BB8z28WnbT
         Jzwea0Y59Q14xPWz3ruwwsQufcgyKhIWzhA8av9PkuZMvLzYlFWe8XkW4cRJB3JvZkTX
         0jfdVvxe0J+vFx0Jun8MwNChzC0XzRQZjTBz620YYhXMGh08A2gcxzzIAUbi3m4doUOM
         A1qucNJoXUUkgKzobRKayPdDZ4z6y4+YjgOY7EABUbEqfg3K1Dz+3N7YcvzEZ3blW3jh
         KvCQ==
X-Gm-Message-State: APt69E0p9dC0oV/iHNwEYYzlCIFWrH8AFbuKoOKwnN/QjsQP74y5zLtp
        Wh0RwUcAh+Ywi2SVJLQg6cK9CTSwoiE0/6pmFalIBpX+
X-Google-Smtp-Source: ADUXVKIAdvLGFABADPImBLCaAKeOx2g5J3JO7FWnyZgRbnHCEfhqpP465Lj5T5UaV03PeiMCCDr/qHL+INqFAGWzUZY=
X-Received: by 2002:a81:4a05:: with SMTP id x5-v6mr1358855ywa.116.1528849381668;
 Tue, 12 Jun 2018 17:23:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 17:23:01
 -0700 (PDT)
In-Reply-To: <20180613001924.30082-1-shuah@kernel.org>
References: <20180613001924.30082-1-shuah@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Jun 2018 17:23:01 -0700
X-Google-Sender-Auth: 4xHovD_wc4w2SFtt2VmJkVlfOxo
Message-ID: <CAGXu5jJXR+BfKri71yjJWdPw-yf9+Cf_i-N0FPvbqidtdLz7-Q@mail.gmail.com>
Subject: Re: [PATCH] selftests: sysctl: return Kselftest Skip code for skipped tests
To:     "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 5:19 PM, Shuah Khan (Samsung OSG)
<shuah@kernel.org> wrote:
> When sysctl test is skipped because of unmet dependencies and/or
> unsupported configuration, it exits with error which is treated as
> a fail by the Kselftest framework. This leads to false negative result
> even when the test could not be run.
>
> Change it to return kselftest skip code when a test gets skipped to
> clearly report that the test could not be run.
>
> Changed return code to kselftest skip code in skip error legs that check
> requirements and module probe test error leg.
>
> Kselftest framework SKIP code is 4 and the framework prints appropriate
> messages to indicate that the test is skipped.
>
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  tools/testing/selftests/sysctl/sysctl.sh | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
> index ec232c3cfcaa..584eb8ea780a 100755
> --- a/tools/testing/selftests/sysctl/sysctl.sh
> +++ b/tools/testing/selftests/sysctl/sysctl.sh
> @@ -14,6 +14,9 @@
>
>  # This performs a series tests against the proc sysctl interface.
>
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
>  TEST_NAME="sysctl"
>  TEST_DRIVER="test_${TEST_NAME}"
>  TEST_DIR=$(dirname $0)
> @@ -41,7 +44,7 @@ test_modprobe()
>                 echo "$0: $DIR not present" >&2
>                 echo "You must have the following enabled in your kernel:" >&2
>                 cat $TEST_DIR/config >&2
> -               exit 1
> +               exit $ksft_skip
>         fi
>  }
>
> @@ -98,28 +101,30 @@ test_reqs()
>         uid=$(id -u)
>         if [ $uid -ne 0 ]; then
>                 echo $msg must be run as root >&2
> -               exit 0
> +               exit $ksft_skip
>         fi
>
>         if ! which perl 2> /dev/null > /dev/null; then
>                 echo "$0: You need perl installed"
> -               exit 1
> +               exit $ksft_skip
>         fi
>         if ! which getconf 2> /dev/null > /dev/null; then
>                 echo "$0: You need getconf installed"
> -               exit 1
> +               exit $ksft_skip
>         fi
>         if ! which diff 2> /dev/null > /dev/null; then
>                 echo "$0: You need diff installed"
> -               exit 1
> +               exit $ksft_skip
>         fi
>  }
>
>  function load_req_mod()
>  {
> -       trap "test_modprobe" EXIT
> -
>         if [ ! -d $DIR ]; then
> +               if ! modprobe -q -n $TEST_DRIVER; then
> +                       echo "$0: module $TEST_DRIVER not found [SKIP]"
> +                       exit $ksft_skip
> +               fi
>                 modprobe $TEST_DRIVER
>                 if [ $? -ne 0 ]; then
>                         exit
> @@ -765,6 +770,7 @@ function parse_args()
>  test_reqs
>  allow_user_defaults
>  check_production_sysctl_writes_strict
> +test_modprobe
>  load_req_mod
>
>  trap "test_finish" EXIT
> --
> 2.17.0
>



-- 
Kees Cook
Pixel Security
