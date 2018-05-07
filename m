Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbeEGOEQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:04:16 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:43921 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbeEGOEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:04:10 -0400
X-Google-Smtp-Source: AB8JxZoxig9AwR0VaJ+fpt87I8LuXKWhcGxSBE5ZqzNSBaLWUmFrvNNHj4PPaFOylJar3QtdZus8bA==
From: Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: bug in tag handling in blk-mq?
Message-Id: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
Date: Mon, 7 May 2018 16:03:34 +0200
Cc: linux-block <linux-block@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
To: Mike Galbraith <efault@gmx.de>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w47E4I8J027356

Hi Jens, Christoph, all,
Mike Galbraith has been experiencing hangs, on blk_mq_get_tag, only
with bfq [1].  Symptoms seem to clearly point to a problem in I/O-tag
handling, triggered by bfq because it limits the number of tags for
async and sync write requests (in bfq_limit_depth).

Fortunately, I just happened to find a way to apparently confirm it.
With the following one-liner for block/bfq-iosched.c:

@@ -554,8 +554,7 @@ static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
        if (unlikely(bfqd->sb_shift != bt->sb.shift))
                bfq_update_depths(bfqd, bt);
 
-       data->shallow_depth =
-               bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
+       data->shallow_depth = 1;
 
        bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
                        __func__, bfqd->wr_busy_queues, op_is_sync(op),

Mike's machine now crashes soon and systematically, while nothing bad
happens on my machines, even with heavy workloads (apart from an
expected throughput drop).

This change simply reduces to 1 the maximum possible value for the sum
of the number of async requests and of sync write requests.

This email is basically a request for help to knowledgeable people.  To
start, here are my first doubts/questions:
1) Just to be certain, I guess it is not normal that blk-mq hangs if
async requests and sync write requests can be at most one, right?
2) Do you have any hint to where I could look for, to chase this bug?
Of course, the bug may be in bfq, i.e, it may be a somehow unrelated
bfq bug that causes this hang in blk-mq, indirectly.  But it is hard
for me to understand how.

Looking forward to some help.

Thanks,
Paolo

[1] https://www.spinics.net/lists/stable/msg215036.html
