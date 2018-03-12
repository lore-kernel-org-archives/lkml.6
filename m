Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeCLNwX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:52:23 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38229 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeCLNwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:52:21 -0400
X-Google-Smtp-Source: AG47ELso+whDnhskpTsF8ZL6gRkhVggtQ4kNo87XqDQlJY7WKXMncktL1FNNzaghsTZfErnN7H7e4QtCHFOmjSTDFIY=
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1803112233070.28583@knanqh.ubzr>
References: <20180220215954.4092811-1-arnd@arndb.de> <20180220215954.4092811-2-arnd@arndb.de>
 <nycvar.YSQ.7.76.1803112233070.28583@knanqh.ubzr>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 12 Mar 2018 14:52:20 +0100
X-Google-Sender-Auth: VQH5_PGEQ5ARbgwAsX3FHoQs8ZY
Message-ID: <CAK8P3a06_zke6Zy77TCX6aUS1C0aK2btvnLA7APxRykkxS6S_w@mail.gmail.com>
Subject: Re: [PATCH 1/7] ARM: disallow combining XIP and LTO
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 3:40 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 20 Feb 2018, Arnd Bergmann wrote:

>> Obviously we want to make the combination work, no idea why it doesn't.
>
> Well, it does work regardless of the noise. Here the nm output is piped
> into sed, and the later exits early when it finds what it is looking
> for, causing nm to complain about the broken pipe.
>
> Here's a patch silencing this bogus error message and fixing other minor
> issues.
>
> ----- >8
> Subject: [PATCH] ARM: deflate_xip_data.sh: minor fixes
>
> Send nm complaints about broken pipe (when sed exits early) to /dev/null.
> All errors should be printed to stderr.
> Don't trap on normal exit so the trap can return an error code.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Ah, that explains it, thanks!

Tested-by: Arnd Bergmann <arnd@arndb.de>

> diff --git a/arch/arm/boot/deflate_xip_data.sh b/arch/arm/boot/deflate_xip_data.sh
> index 1189598a25..5e7d758ebd 100755
> --- a/arch/arm/boot/deflate_xip_data.sh
> +++ b/arch/arm/boot/deflate_xip_data.sh
> @@ -30,7 +30,7 @@ esac
>
>  sym_val() {
>         # extract hex value for symbol in $1
> -       local val=$($NM "$VMLINUX" | sed -n "/ $1$/{s/ .*$//p;q}")
> +       local val=$($NM "$VMLINUX" 2>/dev/null | sed -n "/ $1\$/{s/ .*$//p;q}")
>         [ "$val" ] || { echo "can't find $1 in $VMLINUX" 1>&2; exit 1; }
>         # convert from hex to decimal
>         echo $((0x$val))
> @@ -48,12 +48,12 @@ data_end=$(($_edata_loc - $base_offset))
>  file_end=$(stat -c "%s" "$XIPIMAGE")
>  if [ "$file_end" != "$data_end" ]; then
>         printf "end of xipImage doesn't match with _edata_loc (%#x vs %#x)\n" \
> -              $(($file_end + $base_offset)) $_edata_loc 2>&1
> +              $(($file_end + $base_offset)) $_edata_loc 1>&2
>         exit 1;
>  fi
>
>  # be ready to clean up
> -trap 'rm -f "$XIPIMAGE.tmp"' 0 1 2 3
> +trap 'rm -f "$XIPIMAGE.tmp"; exit 1' 1 2 3
>
>  # substitute the data section by a compressed version
>  $DD if="$XIPIMAGE" count=$data_start iflag=count_bytes of="$XIPIMAGE.tmp"
