Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeFDJR6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:17:58 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36405 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeFDJR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:17:56 -0400
X-Google-Smtp-Source: ADUXVKL/GN5wLDs1SCymyOvzgE6o1B6fjLYt7xAPRbvm5hobbY+HjmqT0qEo36Tatv+GL06KP6MmQOfxDhFamUrTgTs=
MIME-Version: 1.0
In-Reply-To: <8ab19b1665b51364c1f7e607f9a69a86fe084d0d.1528102909.git.baolin.wang@linaro.org>
References: <8ab19b1665b51364c1f7e607f9a69a86fe084d0d.1528102909.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 4 Jun 2018 11:17:54 +0200
X-Google-Sender-Auth: ZoS6WmxDh0hLKCKg4Q0HdaTRUzc
Message-ID: <CAK8P3a1emKA1VAsfgQV=pfUnADwYc=MCLeBrT1idDbvO2WgVAw@mail.gmail.com>
Subject: Re: [PATCH] iio: Convert to use timespec64 variables to get a time stamp
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 11:07 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> The struct timespec is not y2038 safe on 32bit machines, thus this patch
> converts to use timespec64 variables and related APIs to get a time stamp
> for events etc.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Hi Baolin,

I was waiting with this for the new header file cleanup to land. Thomas
merged that one recently, so now we should be able to do this more nicely:


diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 19bdf3d2962a..fcbe92c34a3d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -207,35 +207,27 @@ static int iio_device_set_clock(struct iio_dev
*indio_dev, clockid_t clock_id)
  */
 s64 iio_get_time_ns(const struct iio_dev *indio_dev)
 {
-       struct timespec tp;
+       struct timespec64 tp;

        switch (iio_device_get_clock(indio_dev)) {
        case CLOCK_REALTIME:
-               ktime_get_real_ts(&tp);
-               break;
+               return ktime_get_real_ns();
        case CLOCK_MONOTONIC:
-               ktime_get_ts(&tp);
-               break;
+               return ktime_get_ns();
        case CLOCK_MONOTONIC_RAW:
-               getrawmonotonic(&tp);
-               break;
+               return ktime_get_raw_ns();
        case CLOCK_REALTIME_COARSE:
-               tp = current_kernel_time();
-               break;
+               return ktime_to_ns(ktime_get_coarse_real());
        case CLOCK_MONOTONIC_COARSE:
-               tp = get_monotonic_coarse();
-               break;
+               ktime_get_coarse_ts64(&tp);
+               return timespec64_to_ns(&tp);
        case CLOCK_BOOTTIME:
-               get_monotonic_boottime(&tp);
-               break;
+               return ktime_get_boot_ns();
        case CLOCK_TAI:
-               timekeeping_clocktai(&tp);
-               break;
+               return ktime_get_tai_ns();
        default:
                BUG();
        }
-
-       return timespec_to_ns(&tp);
 }
 EXPORT_SYMBOL(iio_get_time_ns);
