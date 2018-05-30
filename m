Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932622AbeE3VuI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:50:08 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40720 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932580AbeE3VuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:50:04 -0400
X-Google-Smtp-Source: ADUXVKJcpLul/gJF34JM6DRz036tkwXTHkXzId/sNVkoEpzFbEvBiUwos65hpwNsDjjP0gNgZbxWOKi9POdbubyyQAE=
MIME-Version: 1.0
In-Reply-To: <1527158731-17685-10-git-send-email-rplsssn@codeaurora.org>
References: <1527158731-17685-1-git-send-email-rplsssn@codeaurora.org> <1527158731-17685-10-git-send-email-rplsssn@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 May 2018 14:50:01 -0700
X-Google-Sender-Auth: e4oulgn-W5AqngpGQPwkaCeAmao
Message-ID: <CAD=FV=X7Bv587F753AXJ2VtxedLdeBhk8JQf-a8E4h33JfFiWA@mail.gmail.com>
Subject: Re: [PATCH v9 09/10] drivers: qcom: rpmh: add support for batch RPMH request
To: Raju P L S S S N <rplsssn@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 24, 2018 at 3:45 AM, Raju P L S S S N
<rplsssn@codeaurora.org> wrote:
>  #define DEFINE_RPMH_MSG_ONSTACK(dev, s, q, name)       \
>         struct rpmh_request name = {                    \
> @@ -35,6 +37,7 @@
>                 .completion = q,                        \
>                 .dev = dev,                             \
>                 .needs_free = false,                            \
> +               .wait_count = NULL,                     \

You ignored my feedback on v8 that wait_count is not useful.  Please
squash in <http://crosreview.com/1079905>.  That also has a fix where
it introduces a WARN_ON for the timeout case in batch mode too.


> +/**
> + * rpmh_write_batch: Write multiple sets of RPMH commands and wait for the
> + * batch to finish.
> + *
> + * @dev: the device making the request
> + * @state: Active/sleep set
> + * @cmd: The payload data
> + * @n: The array of count of elements in each batch, 0 terminated.
> + *
> + * Write a request to the RSC controller without caching. If the request
> + * state is ACTIVE, then the requests are treated as completion request
> + * and sent to the controller immediately. The function waits until all the
> + * commands are complete. If the request was to SLEEP or WAKE_ONLY, then the
> + * request is sent as fire-n-forget and no ack is expected.
> + *
> + * May sleep. Do not call from atomic contexts for ACTIVE_ONLY requests.
> + */
> +int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
> +                    const struct tcs_cmd *cmd, u32 *n)
> +{
> +       struct rpmh_request *rpm_msg[RPMH_MAX_REQ_IN_BATCH] = { NULL };
> +       DECLARE_COMPLETION_ONSTACK(compl);
> +       atomic_t wait_count = ATOMIC_INIT(0);
> +       struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
> +       int count = 0;
> +       int ret, i, j;
> +
> +       if (IS_ERR(ctrlr) || !cmd || !n)
> +               return -EINVAL;
> +
> +       while (n[count++] > 0)
> +               ;
> +       count--;
> +       if (!count || count > RPMH_MAX_REQ_IN_BATCH)
> +               return -EINVAL;
> +
> +       for (i = 0; i < count; i++) {
> +               rpm_msg[i] = __get_rpmh_msg_async(state, cmd, n[i]);
> +               if (IS_ERR(rpm_msg[i])) {
> +                       ret = PTR_ERR(rpm_msg[i]);
> +                       for (j = i-1; j >= 0; j--) {
> +                               if (rpm_msg[j]->needs_free)

How could needs_free be false here?


> +                                       kfree(rpm_msg[j]);
> +                       }
> +                       return ret;
> +               }
> +               cmd += n[i];
> +       }
> +
> +       if (state != RPMH_ACTIVE_ONLY_STATE)
> +               return cache_batch(ctrlr, rpm_msg, count);

Previously I said:
> Don't you need to free rpm_msg items in this case?

...but I think that wasn't clear enough.  Perhaps I should have said:

Don't you need to free rpm_msg items in the case where cache_batch
returns an error?  AKA squash in <http://crosreview.com/1079906>.


> +
> +       atomic_set(&wait_count, count);
> +
> +       for (i = 0; i < count; i++) {
> +               rpm_msg[i]->completion = &compl;
> +               rpm_msg[i]->wait_count = &wait_count;
> +               ret = rpmh_rsc_send_data(ctrlr->drv, &rpm_msg[i]->msg);
> +               if (ret) {
> +                       int j;

You're shadowing another "j" variable.  Please squash in
<http://crosreview.com/1080027>.

> +
> +                       pr_err("Error(%d) sending RPMH message addr=%#x\n",
> +                              ret, rpm_msg[i]->msg.cmds[0].addr);
> +                       for (j = i; j < count; j++)
> +                               rpmh_tx_done(&rpm_msg[j]->msg, ret);

Previously I said:

> Note that you'll probably do your error handling in this
> function a favor if you rename __get_rpmh_msg_async()
> to __fill_rpmh_msg() and remove the memory
> allocation from there

I tried to implement this but then I realized cache_batch() requires
individual allocation.  Sigh.

OK, I attempted this in <http://crosreview.com/1080028>.  This gets
rid of several static-sized arrays and gets rid of all of the little
memory allocations in rpmh_write_batch(), replacing it with one bigger
one.  In my mind this is an improvement, but I welcome other opinions.

As discussed previously, I'm still of the belief that we'll be better
off getting rid of separate "batch" data structures.  I'll see if I
can find some time to do that too and see how it looks.


-Doug
