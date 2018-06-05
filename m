Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeFEMnY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:43:24 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39493 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbeFEMnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:43:23 -0400
X-Google-Smtp-Source: ADUXVKJhQSR1ChhxexrFzXOz0rlXoey/BqhXFtsBL7HgPBEcP1s8bfI28H2EyCnFPjfDcpaU0NTbtK5X/rMO0hSSmMo=
MIME-Version: 1.0
In-Reply-To: <20180604113708.11554-1-thierry.escande@linaro.org>
References: <20180604113708.11554-1-thierry.escande@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 15:43:22 +0300
Message-ID: <CAHp75VdUFH7wQ2qC=uMs_ybiiZsmzpJH6Q2q-dV9aH-zOcERwg@mail.gmail.com>
Subject: Re: [PATCH RESEND] lib/test_printf.c: call wait_for_random_bytes()
 before plain %p tests
To: Thierry Escande <thierry.escande@linaro.org>,
        Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Petr. I suppose test_printf is going through his tree as well as
vsnprintf itself. At least it logically makes sense.

On Mon, Jun 4, 2018 at 2:37 PM, Thierry Escande
<thierry.escande@linaro.org> wrote:
> If the test_printf module is loaded before the crng is initialized, the
> plain 'p' tests will fail because the printed address will not be hashed
> and the buffer will contain '(ptrval)' instead.
> This patch adds a call to wait_for_random_bytes() before plain 'p' tests
> to make sure the crng is initialized.
>
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> Acked-by: Tobin C. Harding <me@tobin.cc>
> ---
>  lib/test_printf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 71ebfa43ad05..839be9385a8a 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -260,6 +260,13 @@ plain(void)
>  {
>         int err;
>
> +       /*
> +        * Make sure crng is ready. Otherwise we get "(ptrval)" instead
> +        * of a hashed address when printing '%p' in plain_hash() and
> +        * plain_format().
> +        */
> +       wait_for_random_bytes();
> +
>         err = plain_hash();
>         if (err) {
>                 pr_warn("plain 'p' does not appear to be hashed\n");
> --
> 2.14.1
>



-- 
With Best Regards,
Andy Shevchenko
