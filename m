Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeCHVGO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:06:14 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44909 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeCHVGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:06:12 -0500
X-Google-Smtp-Source: AG47ELsKOMIL6mxB39L4WKUJrUNy4pvgp+lNfxIkvomn2ERNUVEzKz/ldIbnXaTTNgwD20VKnfBRMA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180302164317.10554-9-ilina@codeaurora.org>
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
 <20180302164317.10554-9-ilina@codeaurora.org>
Message-ID: <152054316996.219802.9903507378142636932@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 08/10] drivers: qcom: rpmh: allow requests to be sent
 asynchronously
Date: Thu, 08 Mar 2018 13:06:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w28L6KxG014401

Quoting Lina Iyer (2018-03-02 08:43:15)
> @@ -69,6 +71,7 @@ struct rpmh_request {
>         atomic_t *wait_count;
>         struct rpmh_client *rc;
>         int err;
> +       struct rpmh_request *free;
>  };
>  
>  /**
> @@ -114,6 +117,8 @@ void rpmh_tx_done(struct tcs_request *msg, int r)
>                        "RPMH TX fail in msg addr 0x%x, err=%d\n",
>                        rpm_msg->msg.payload[0].addr, r);
>  
> +       kfree(rpm_msg->free);

Is this potentially freeing something which is then used after this call
later in this function? It looks like the compiler could be reloading
from freed memory for the wc and compl variables after this kfree is
called. At the least, please add some sort of comment or if we don't
ever need to free a _different_ rpm_msg than the existing one, make it a
flag so it becomes very obvious that we're freeing the same memory that
we loaded from in this function.

> +
>         /* Signal the blocking thread we are done */
>         if (wc && atomic_dec_and_test(wc) && compl)
>                 complete(compl);
> @@ -257,6 +262,53 @@ static int __rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
>         return ret;
>  }
>  
> +static struct rpmh_request *__get_rpmh_msg_async(struct rpmh_client *rc,
> +                                               enum rpmh_state state,
> +                                               struct tcs_cmd *cmd, int n)
> +{
> +       struct rpmh_request *req;
> +
> +       if (IS_ERR_OR_NULL(rc) || !cmd || n <= 0 || n > MAX_RPMH_PAYLOAD)

unsigned n?

> +               return ERR_PTR(-EINVAL);
> +
> +       req = kcalloc(1, sizeof(*req), GFP_ATOMIC);

kzalloc()?

> +       if (!req)
> +               return ERR_PTR(-ENOMEM);
> +
> +       memcpy(req->cmd, cmd, n * sizeof(*cmd));
> +
> +       req->msg.state = state;
> +       req->msg.payload = req->cmd;
> +       req->msg.num_payload = n;
> +       req->free = req;
> +
> +       return req;
> +}
> +
> +/**
> + * rpmh_write_async: Write a set of RPMH commands

... and don't wait for a result?

> + *
> + * @rc: The RPMh handle got from rpmh_get_dev_channel
> + * @state: Active/sleep set
> + * @cmd: The payload data
> + * @n: The number of elements in payload
> + *
> + * Write a set of RPMH commands, the order of commands is maintained
> + * and will be sent as a single shot.
> + */
> +int rpmh_write_async(struct rpmh_client *rc, enum rpmh_state state,
> +                   struct tcs_cmd *cmd, int n)
> +{
> +       struct rpmh_request *rpm_msg;
> +
> +       rpm_msg = __get_rpmh_msg_async(rc, state, cmd, n);
> +       if (IS_ERR(rpm_msg))
> +               return PTR_ERR(rpm_msg);
> +
> +       return __rpmh_write(rc, state, rpm_msg);
> +}
> +EXPORT_SYMBOL(rpmh_write_async);
> +
>  /**
>   * rpmh_write: Write a set of RPMH commands and block until response
>   *
