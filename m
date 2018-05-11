Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeEKUSQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 16:18:16 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:46512 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbeEKUSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 16:18:14 -0400
X-Google-Smtp-Source: AB8JxZr9lhKQsx8kSaVCVT6Rf4mxI7Lv7hpcwMlecJmKAenG5RhbzbsmpRtipvIGNQ3f9zxxgcJJG7+f2vmSaoxVAoE=
MIME-Version: 1.0
In-Reply-To: <20180509170159.29682-8-ilina@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org> <20180509170159.29682-8-ilina@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 11 May 2018 13:18:12 -0700
X-Google-Sender-Auth: nSM2PPACjUPVEwp3mD5GAPiQMpE
Message-ID: <CAD=FV=VLQRHfWgbVhcCBJxd5iRh+R_kbdtT=fPixK0O_iqYwOg@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] drivers: qcom: rpmh: cache sleep/wake state requests
To: Lina Iyer <ilina@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, rplsssn@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 9, 2018 at 10:01 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>  /**
>   * struct rpmh_request: the message to be sent to rpmh-rsc
>   *
> @@ -54,9 +71,15 @@ struct rpmh_request {
>   * struct rpmh_ctrlr: our representation of the controller
>   *
>   * @drv: the controller instance
> + * @cache: the list of cached requests
> + * @lock: synchronize access to the controller data

nit: this makes it sound like this lock will be grabbed for all calls
into rpmh-rsc.  In fact, it only protects access to the cache.
Ideally name it cache_lock and document that it's for protecting the
cache.


> +/**
> + * rpmh_flush: Flushes the buffered active and sleep sets to TCS
> + *
> + * @dev: The device making the request
> + *
> + * Return: -EBUSY if the controller is busy, probably waiting on a response
> + * to a RPMH request sent earlier.
> + *
> + * This function is generally called from the sleep code from the last CPU

"is generally" implies that sometimes it's not called from the sleep
code.  Change to "is always".  If "is generally" is more correct, you
can't run lockless right?


-Doug
