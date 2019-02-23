Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82893C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 02:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F821206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 02:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfBWCCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 21:02:18 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:33429 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWCCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 21:02:18 -0500
Received: by mail-qt1-f172.google.com with SMTP id z39so4799199qtz.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 18:02:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5h5aKB9ypEsmCRZ2jB2Ch/NJ7tYai3CALCA/A6vD5M=;
        b=pSB13+qOb0frKpN6kXwjNUGQRDbMjft8g1PZ2TEwmCw1zGJpTR6KHUzD4icf2do2Qb
         v13rTUdOKC+7i9qaLCq0Wl06E50d7Pu1aYY/ZCBaH/CwiJEHCRUHzYbLMMBHKaL3ZfC4
         2DBmeW3NJU3FsSVlWTS379eZjVLlgHzKmt9tstA9UTgOke+Ln9VCh0TSRB/QNqYrsoS6
         W8uFX0r6eGcO6gStdXzULVB18/xODqmYW5ZpdQ4iJzg3YkkrVVURMxAzUvjVGQcI9FlE
         BFzCWnx5Z7uP4tOZ09wvABhcsgRcXPUmoo5yk/TRjHvteI6HNjHA308dvfIiAMjDsEhP
         nN6Q==
X-Gm-Message-State: AHQUAub6p4lFv1eYazMSuuRv2fSAa6MYwqiAXU3C8yZBVigTOi8GpYBe
        3GYhPnxvsnJEMc5C5/mu7UXIe+uX3X01KAbTH5NAsg==
X-Google-Smtp-Source: AHgI3IY0kafMZZGTUIfZk2QJ3rJEZlwygrP1xFLgTXHklIFlhUJBWp1tWxxFl6kgB5sl5hyjyGpjG8cIchc0NgyBC4Y=
X-Received: by 2002:ac8:2fda:: with SMTP id m26mr5525567qta.312.1550887337521;
 Fri, 22 Feb 2019 18:02:17 -0800 (PST)
MIME-Version: 1.0
References: <70cda2a3-f246-d45b-f600-1f9d15ba22ff@gmail.com>
 <87eflmpqkb.fsf@notabene.neil.brown.name> <20190222211006.GA10987@redhat.com>
 <7f0aeb7b-fdaa-0625-f785-05c342047550@kernel.dk> <20190222235459.GA11726@redhat.com>
In-Reply-To: <20190222235459.GA11726@redhat.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Fri, 22 Feb 2019 21:02:06 -0500
Message-ID: <CAMeeMh-2ANOr_Sb66EyA_HULkVRudD7fyOZsDbpRpDrshwnR2w@mail.gmail.com>
Subject: Re: block: be more careful about status in __bio_chain_endio
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.com>,
        linux-block@vger.kernel.org,
        device-mapper development <dm-devel@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am perhaps not understanding the intricacies here, or not seeing a
barrier protecting it, so forgive me if I'm off base. I think reading
parent->bi_status here is unsafe.
Consider the following sequence of events on two threads.

Thread 0                                 Thread 1
In __bio_chain_endio:                    In __bio_chain_endio:
[A] Child 0 reads parent->bi_status,
    no error.
                                         Child bio 1 reads parent, no error seen
                                         It sets parent->bi_status to an error
                                         It calls bio_put.
Child bio 0 calls bio_put
[end __bio_chain_endio]                  [end __bio_chain_endio]
                                         In bio_chain_endio(), bio_endio(parent)
                                         is called, calling bio_remaining_done()
                                         which decrements __bi_remaining to 1
                                         and returns false, so no further endio
                                         stuff is done.
In bio_chain_endio(), bio_endio(parent)
is called, calling bio_remaining_done(),
decrementing parent->__bi_remaining to
 0, and continuing to finish parent.
Either for block tracing or for parent's
bi_end_io(), this thread tries to read
parent->bi_status again.

The compiler or the CPU may cache the read from [A], and since there
are no intervening barriers, parent->bi_status is still believed on
thread 0 to be success. Thus the bio may still be falsely believed to
have completed successfully, even though child 1 set an error in it.

Am I missing a subtlety here?
