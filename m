Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbeBZUS6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:18:58 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34771 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbeBZUS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:18:56 -0500
X-Google-Smtp-Source: AH8x227CnL+rX5Zp9kp2BYr/4fInNAAWvllQEFcTOsPArFy7j4hKR29uJsZfkjvVyrEZ8MLFgOvZxQ2m/RZXlmVpEo0=
MIME-Version: 1.0
In-Reply-To: <1515007850-17169-1-git-send-email-prime.zeng@hisilicon.com>
References: <1515007850-17169-1-git-send-email-prime.zeng@hisilicon.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 26 Feb 2018 21:18:54 +0100
Message-ID: <CAHUa44FCXVrcoBNKmGk=WP15X8v3sHeTMnK2K0zaW3Lddqmv+g@mail.gmail.com>
Subject: Re: [PATCH] optee: fix the dead loop problem when there is signal pending
To: Zeng Tao <prime.zeng@hisilicon.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zeng Tao,

On Wed, Jan 3, 2018 at 8:30 PM, Zeng Tao <prime.zeng@hisilicon.com> wrote:
> when the current process is doing a rpc call from optee, and if there
> is a signal pending on the process, it will enter dead loop if the
> tee-supplicant is working correctly, fix the problem by breaking out
> the loop when the rpc job is finished.
>
> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> ---
>  drivers/tee/optee/supp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
> index b4ea067..170dedb 100644
> --- a/drivers/tee/optee/supp.c
> +++ b/drivers/tee/optee/supp.c
> @@ -107,6 +107,13 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
>                 mutex_unlock(&supp->ctx_mutex);
>                 if (interruptable)
>                         break;
> +
> +               /*
> +                * if there is signal pending, and the supplicant has finished
> +                * the rpc job, we need to break out the loop
> +                */
> +               if (try_wait_for_completion(&supp->data_from_supp))
> +                       break;
>         }
>
>         ret = supp->ret;
> --
> 2.7.4
>

Since this patch was posted there has been changes (during the merge
window) to this part of the code. Please rebase, test and post again.

Thanks,
Jens
