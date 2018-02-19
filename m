Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeBSLcm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:32:42 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40411 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeBSLck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:32:40 -0500
X-Google-Smtp-Source: AH8x227masSpacXy9HjsDV+ICOfjjEKQIv4/tSmrYFU6kcKvGaipLPw1I5Q8aNIjlyYlewJ+Z5jxzKwgWzfDnmViXcI=
MIME-Version: 1.0
In-Reply-To: <1514904162-11201-12-git-send-email-sudeep.holla@arm.com>
References: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com> <1514904162-11201-12-git-send-email-sudeep.holla@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 19 Feb 2018 12:32:39 +0100
X-Google-Sender-Auth: XW_eujaIlE_U-GSKWz7f0iYn4L8
Message-ID: <CAK8P3a31CMsLUSm0rsHLdvM4sbjZ6fwocKmA1JiuCtF97vj3PQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/20] firmware: arm_scmi: add support for polling
 based SCMI transfers
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ALKML <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
        Roy Franz <roy.franz@cavium.com>,
        Harb Abdulhamid <harba@codeaurora.org>, Nishanth Menon <nm@ti.com>,
        Loc Ho <lho@apm.com>, Alexey Klimov <klimov.linux@gmail.com>,
        Ryan Harkin <Ryan.Harkin@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 2, 2018 at 3:42 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> +#define SCMI_MAX_POLLING_TIMEOUT_NS    (100 * NSEC_PER_USEC)
>  /**
>   * scmi_do_xfer() - Do one transfer
>   *
> @@ -389,14 +406,30 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)

> +       if (xfer->hdr.poll_completion) {
> +               ktime_t stop, cur;
> +
> +               stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLLING_TIMEOUT_NS);
> +               do {
> +                       udelay(5);
> +                       cur = ktime_get();
> +               } while (!scmi_xfer_poll_done(info, xfer) &&
> +                        ktime_before(cur, stop));

The 5 microsecond back-off isn't that much smaller than the 100 microsecond
timeout, given that udelay() often waits much longer than the specified time.

How did you come up with those two numbers? Are you sure this is better
than just using a cpu_relax() instead of the udelay()?

      Arnd
