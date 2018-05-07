Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeEGCnY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 22:43:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:41911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbeEGCnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 22:43:22 -0400
Message-ID: <1525660992.5105.1.camel@gmx.de>
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
Date: Mon, 07 May 2018 04:43:12 +0200
In-Reply-To: <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
         <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
         <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
         <1525532191.5406.15.camel@gmx.de>
         <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pq3SE9Qa/r4YewY2V05PAzveedUXpk9ENRrmpPZaoZ82VeRyKWv
 gxx0yIZxpGyjza4WkYXgfWAKrsmNmG1n6ldgWJ2CuAzxbDmH368KjmDNCcoIigr8Y0wHgpR
 7CBDW1GjiXDZg3fORgCyU6i6Jfk7RZvQLciw6ARDJiGw7YE/6vtOABEEq1uow73vyULt71/
 JAwGFhfOPgK1VNv6vYLWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e4jCQZmuxzk=:p49Ci39QctJM0Rbgj579Ti
 QNUjwxhCaPlyrhIllJbeKmDVuSx8CQUsSI/UEApDxWkhiVfcEzstnhd5EkbeA2Rq85ZXMiIrd
 EJMvpXH2WViTPJ4ORiUBJdzW5PCIc1UxJZ34M5SMZnmhwXA/CJ9Zcv8TyZNL5inwE0Zj1qiQ0
 cCYQK+yzvwnKG+lxdIYRlFCWklyniYrq2Vrno571R/6ddE7U8l/6wonpv1n7dqTuf/3zwp3pd
 lfgDTwznQPLBKCS01HH7Tr8gIO4zeX3rCuwztQ/lQsxhN3BaPlThuHmtUWvBUClAkW/1MkAsL
 zQ2GGlstXPkJVTxLclOF2Zb46VxMHSHOdLrThuuxGM0miWDZ8xL8kqvOy5qgXr2/+odOmnp01
 +UPxU6bQpv2v9Gh5H9xL6ozinr03tBD9srM2tTmuZ/gS4vY9/JjnDui0BQti6wrbZuVpowpNI
 B80xmX+3kp6ygNJiBO6wgNwm8wczcg4V4/Z7rWUTsKNg7cEsE1Gzm9ydKfu2WMUNPv8Ig2gze
 wF3a33u7RckZx6qwiTa/ymv1huU4hv6zBcAuKmFEy8Wnr1kK5V9rp4NBRTtKAxbmIb0ovPyiF
 59+pLQTPwrw2/3giMJlKmOBa1aZt+5rUh30Al0jl0rR6o2CMk/AZDOO+IJCzq8DLkv2xsssfV
 QEQKwGFG016+M5sDEku6kuMtcWPYyMSBO7RBtWVoHYtUCid5kwaWAUh+EJ0/3ahQhTpI6GfrZ
 zWBpqvuZ9v+seMMcLHp7+A08nGHA4fpM10QomGrPYWnXeWr2Eix6hcIEZx69aaexM03QcSceH
 WRc9fd7
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-05-06 at 09:42 +0200, Paolo Valente wrote:
> 
> I've attached a compressed patch (to avoid possible corruption from my
> mailer).  I'm little confident, but no pain, no gain, right?
> 
> If possible, apply this patch on top of the fix I proposed in this
> thread, just to eliminate possible further noise. Finally, the
> patch content follows.
> 
> Hoping for a stroke of luck,

FWIW, box didn't survive the first full build of the morning.

> Paolo
> 
> diff --git a/block/bfq-mq-iosched.c b/block/bfq-mq-iosched.c
> index 118f319af7c0..6662efe29b69 100644
> --- a/block/bfq-mq-iosched.c
> +++ b/block/bfq-mq-iosched.c

That doesn't exist in master, so I applied it like so.

---
 block/bfq-iosched.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -554,8 +554,12 @@ static void bfq_limit_depth(unsigned int
        if (unlikely(bfqd->sb_shift != bt->sb.shift))
                bfq_update_depths(bfqd, bt);
 
+#if 0
        data->shallow_depth =
                bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
+#else
+       data->shallow_depth = 1;
+#endif
 
        bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
                        __func__, bfqd->wr_busy_queues, op_is_sync(op),
