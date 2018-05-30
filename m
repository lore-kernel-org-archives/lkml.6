Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755437AbeE3B7q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 21:59:46 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37559 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeE3B7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 21:59:42 -0400
X-Google-Smtp-Source: ADUXVKKUtsdOAUQZo4Ac9zZv9CpJng83/Eb5EMs6U5YOFnut4nQhRIeFsdRsIjp6cK1tKTXvBGbyIbyq7Np2B7mhe90=
MIME-Version: 1.0
In-Reply-To: <1527574913-10561-1-git-send-email-nick.desaulniers@gmail.com>
References: <1527574913-10561-1-git-send-email-nick.desaulniers@gmail.com>
From: Nick Desaulniers <nick.desaulniers@gmail.com>
Date: Tue, 29 May 2018 18:59:41 -0700
Message-ID: <CAH7mPvh7rQG5TPeWUXNEkF=WuPNroAozHrWAvZfLGPw0dSmBBQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: prefer strlcpy to strncpy
To: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>,
        linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ebiggers@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:21 PM, Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
> Fixes a stringop-truncation warning from gcc-8.
>
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> ---
>  fs/ext4/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index eb104e8..d47c85f 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -323,11 +323,11 @@ static void __save_error_info(struct super_block *sb, const char *func,
>                 return;
>         es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
>         es->s_last_error_time = cpu_to_le32(get_seconds());
> -       strncpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
> +       strlcpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
>         es->s_last_error_line = cpu_to_le32(line);
>         if (!es->s_first_error_time) {
>                 es->s_first_error_time = es->s_last_error_time;
> -               strncpy(es->s_first_error_func, func,
> +               strlcpy(es->s_first_error_func, func,
>                         sizeof(es->s_first_error_func));
>                 es->s_first_error_line = cpu_to_le32(line);
>                 es->s_first_error_ino = es->s_last_error_ino;
> --
> 2.7.4
>

Eric points out this will leave the rest of dest uninitialized if size
is less than length of src.
