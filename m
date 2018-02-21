Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbeBUXZg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:25:36 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34010 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeBUXZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:25:33 -0500
X-Google-Smtp-Source: AH8x225cQJrgJ4S4ZNGnpVfExXxJ5uALpAvD8YfVnlOu6xAuqPpsiMspkYZli9jYI2ZaNj0QC5wPbw==
MIME-Version: 1.0
In-Reply-To: <20180215173507.10989-10-ilina@codeaurora.org>
References: <20180215173507.10989-1-ilina@codeaurora.org> <20180215173507.10989-10-ilina@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 21 Feb 2018 15:24:50 -0800
X-Gmail-Original-Message-ID: <CAE=gft7DV3semzumy+62hQgrUWUvOATJs6BKB5x0mj=0dt+Tig@mail.gmail.com>
Message-ID: <CAE=gft7DV3semzumy+62hQgrUWUvOATJs6BKB5x0mj=0dt+Tig@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] drivers: qcom: rpmh: add support for batch RPMH request
To: Lina Iyer <ilina@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lina,

On Thu, Feb 15, 2018 at 9:35 AM, Lina Iyer <ilina@codeaurora.org> wrote:
> Platform drivers need make a lot of resource state requests at the same
> time, say, at the start or end of an usecase. It can be quite
> inefficient to send each request separately. Instead they can give the
> RPMH library a batch of requests to be sent and wait on the whole
> transaction to be complete.
>
> rpmh_write_batch() is a blocking call that can be used to send multiple
> RPMH command sets. Each RPMH command set is set asynchronously and the
> API blocks until all the command sets are complete and receive their
> tx_done callbacks.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/soc/qcom/rpmh.h |   8 +++
>  2 files changed, 158 insertions(+)
>
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index dff4c46be3af..6f60bb9a4dfa 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
[...]
> @@ -394,6 +537,11 @@ int rpmh_flush(struct rpmh_client *rc)
>         }
>         spin_unlock_irqrestore(&rpm->lock, flags);
>
> +       /* First flush the cached batch requests */
> +       ret = flush_batch(rc);
> +       if (ret)
> +               return ret;
> +
>         /*
>          * Nobody else should be calling this function other than system PM,,
>          * hence we can run without locks.
> @@ -438,6 +586,8 @@ int rpmh_invalidate(struct rpmh_client *rc)
>         if (IS_ERR_OR_NULL(rc))
>                 return -EINVAL;
>
> +       invalidate_batch(rc);
> +

Similarly to my comments in patch 7, aren't there races here with
adding new elements? After flush_batch, but before invalidate_batch,
somebody could call cache_batch, which would add new things on the end
of the array. These new items would be clobbered by invalidate_batch,
without having been flushed first.

-Evan
