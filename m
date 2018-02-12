Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934883AbeBLMyP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:54:15 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43274 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934856AbeBLMx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:53:58 -0500
X-Google-Smtp-Source: AH8x224jHUW6Rsw51ZENbKhaMBHaLgxTRR/oph7iSuFw/CASpEQtBp8TBTJkon8O6VrVz2LE/DdIuDfLcO8SGWhUuWs=
MIME-Version: 1.0
In-Reply-To: <1516095490-83827-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1516095490-83827-1-git-send-email-wangxiongfeng2@huawei.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 12 Feb 2018 13:53:57 +0100
Message-ID: <CANiq72=AeytaT5KBtujTBUkfbNTFFxMPAeToqzmZJOr790R6yw@mail.gmail.com>
Subject: Re: [PATCH V2] auxdisplay: use correct string length
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>, Willy Tarreau <w@1wt.eu>
Cc: Dan <dan.carpenter@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2018 at 10:38 AM, Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
> From: Xiongfeng Wang <xiongfeng.wang@linaro.org>
>
> gcc-8 reports
>
> drivers/auxdisplay/panel.c: In function 'panel_attach':
> ./include/linux/string.h:245:9: warning: '__builtin_strncpy' specified
> bound 12 equals destination size [-Wstringop-truncation]
>
> We need one less byte or call strlcpy() to make it a nul-terminated
> string.
>
> Signed-off-by: Xiongfeng Wang <xiongfeng.wang@linaro.org>
> ---
>  drivers/auxdisplay/panel.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
> index ea7869c..d288900 100644
> --- a/drivers/auxdisplay/panel.c
> +++ b/drivers/auxdisplay/panel.c
> @@ -1506,10 +1506,10 @@ static struct logical_input *panel_bind_key(const char *name, const char *press,
>         key->rise_time = 1;
>         key->fall_time = 1;
>
> -       strncpy(key->u.kbd.press_str, press, sizeof(key->u.kbd.press_str));
> -       strncpy(key->u.kbd.repeat_str, repeat, sizeof(key->u.kbd.repeat_str));
> +       strncpy(key->u.kbd.press_str, press, sizeof(key->u.kbd.press_str) - 1);
> +       strncpy(key->u.kbd.repeat_str, repeat, sizeof(key->u.kbd.repeat_str) - 1);
>         strncpy(key->u.kbd.release_str, release,
> -               sizeof(key->u.kbd.release_str));
> +               sizeof(key->u.kbd.release_str) - 1);

Are you sure about this patch? `kbd` says "strings can be non null-terminated".

Willy, maybe those should just be memcpy()s? (unless the remaining
bytes, if any, must be 0).

Thanks,
Miguel

>         list_add(&key->list, &logical_inputs);
>         return key;
>  }
> --
> 1.8.3.1
>
