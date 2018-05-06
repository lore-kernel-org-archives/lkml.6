Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeEFHm6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 03:42:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44281 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbeEFHmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 03:42:55 -0400
X-Google-Smtp-Source: AB8JxZqNRhe3h+nkivEbFXsTtgXGONoYpsY76K3kUyq/TaJYKXaL06BlFeGfYWEuYarmj3zx1BTF0A==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1525532191.5406.15.camel@gmx.de>
Date: Sun, 6 May 2018 09:42:51 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
Message-Id: <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
 <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
 <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
 <1525532191.5406.15.camel@gmx.de>
To: Mike Galbraith <efault@gmx.de>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w467h3A6009756



> Il giorno 05 mag 2018, alle ore 16:56, Mike Galbraith <efault@gmx.de> ha scritto:
> 
> On Sat, 2018-05-05 at 12:39 +0200, Paolo Valente wrote:
>> 
>> BTW, if you didn't run out of patience with this permanent issue yet,
>> I was thinking of two o three changes to retry to trigger your failure
>> reliably.
> 
> Sure, fire away, I'll happily give the annoying little bugger
> opportunities to show its tender belly.

I've attached a compressed patch (to avoid possible corruption from my
mailer).  I'm little confident, but no pain, no gain, right?

If possible, apply this patch on top of the fix I proposed in this
thread, just to eliminate possible further noise. Finally, the
patch content follows.

Hoping for a stroke of luck,
Paolo

diff --git a/block/bfq-mq-iosched.c b/block/bfq-mq-iosched.c
index 118f319af7c0..6662efe29b69 100644
--- a/block/bfq-mq-iosched.c
+++ b/block/bfq-mq-iosched.c
@@ -525,8 +525,13 @@ static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
        if (unlikely(bfqd->sb_shift != bt->sb.shift))
                bfq_update_depths(bfqd, bt);
 
+#if 0
        data->shallow_depth =
                bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
+#else
+       data->shallow_depth = 1;
+#endif
+
 
        bfq_log(bfqd, "wr_busy %d sync %d depth %u",
                        bfqd->wr_busy_queues, op_is_sync(op),


> 
> 	-Mike
> 
