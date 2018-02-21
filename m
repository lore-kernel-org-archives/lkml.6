Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeBUVmc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:42:32 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35911 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeBUVlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:41:51 -0500
X-Google-Smtp-Source: AH8x225N4Pa4LFtYuP/KfE7P/dD/chwibfEW4LxbhSq53Nzb1KLD+5Y+CDUub2ninJhuKym0K/ojeTvvhUj3FDX1gBA=
MIME-Version: 1.0
In-Reply-To: <20180221213334.19969-1-anders.roxell@linaro.org>
References: <20180221213334.19969-1-anders.roxell@linaro.org>
From: =?UTF-8?Q?Daniel_D=C3=ADaz_Rodr=C3=ADguez?=
        <daniel.diaz@linaro.org>
Date: Wed, 21 Feb 2018 15:41:49 -0600
Message-ID: <CAEUSe7-4pyGvDXKECtc_aoikmNERWGvLecuCYXBCAxLO44gwmw@mail.gmail.com>
Subject: Re: [PATCH] tools/gpio/gpio-event-mon: fix warning
To: Anders Roxell <anders.roxell@linaro.org>
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1LLgbil000462

On 21 February 2018 at 15:33, Anders Roxell <anders.roxell@linaro.org> wrote:
> PRIu64 is defined in user space to match libc's uint64_t definition.
> However, gpioevent_data structure in the kernel is defined using the
> kernel's own __u64 type.
>
> gpio-event-mon.c: In function ‘monitor_device’:
> gpio-event-mon.c:102:19: warning: format ‘%lu’ expects argument of type
>     ‘long unsigned int’, but argument 3 has type ‘__u64 {aka long long
>     unsigned int}’ [-Wformat=]
>    fprintf(stdout, "GPIO EVENT %" PRIu64 ": ", event.timestamp);
>                    ^~~~~~~~~~~~~~
>   LD       /tmp/kselftest/gpiogpio-event-mon-in.o
>   LINK     /tmp/kselftest/gpiogpio-event-mon
>
> Fix is to replace PRIu64 with llu, which we know is what the kernel uses
> for __u64.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Tested-by: Daniel Díaz <daniel.diaz@linaro.org>


> ---
>  tools/gpio/gpio-event-mon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/gpio/gpio-event-mon.c b/tools/gpio/gpio-event-mon.c
> index dac4d4131d9b..c864544efe05 100644
> --- a/tools/gpio/gpio-event-mon.c
> +++ b/tools/gpio/gpio-event-mon.c
> @@ -99,7 +99,7 @@ int monitor_device(const char *device_name,
>                         ret = -EIO;
>                         break;
>                 }
> -               fprintf(stdout, "GPIO EVENT %" PRIu64 ": ", event.timestamp);
> +               fprintf(stdout, "GPIO EVENT %llu: ", event.timestamp);
>                 switch (event.id) {
>                 case GPIOEVENT_EVENT_RISING_EDGE:
>                         fprintf(stdout, "rising edge");
> --
> 2.11.0
