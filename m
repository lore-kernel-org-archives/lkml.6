Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E99C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF5621715
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hqgmc9k4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF5621715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbeHOCGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:06:20 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50316 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbeHOCGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:06:20 -0400
Received: by mail-it0-f68.google.com with SMTP id j81-v6so20912663ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 16:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24jK8A7jkNIu2WgqU9zP0yRp+02coOoQHaoLJQ7Q6O0=;
        b=Hqgmc9k47hrE4UoBhiZSh9KyXSgZ6f1L221vCvMqO1pRK2BXopaH2ox0thUqjonmYO
         w4kHOi0yZjLKjSmhaQ0FvvwmrFumBKqtmv89A84m3uABXVqechxEj6q3M8IA8tLfF18m
         HWQe2Uz6WXRqKzbc7Yq0/+J7Pl7DEFXkr2ozU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24jK8A7jkNIu2WgqU9zP0yRp+02coOoQHaoLJQ7Q6O0=;
        b=CmPT0evOpotl+MQFNThjWpvsOmWi9Efhnpp/Bd8AdLsgv1VPRaiTVHZ/wWJ4gLNu3t
         Wexvi7bxYvEYjAqfYh7/4JqlAIm7N3gMWjP6jV0H0AGEMn54UHmXhT65qbAS/obGsBGG
         d+GKQffbl1XPM8T808V6Cl2dTmLEII59UQvmVVRnj/akc0Dv6frKo6SCH3LgmFkrpVgT
         49fdoyj/iKyc0UWctQZ1kJjMl3SR1blrcW/LKpR9hB6ECj8n9NIxezm86gP1J/YF9sKM
         CyDItDMKPjJXXhTfL4yIEjSsEkOiCGZ1vBkPb/oNrMIf4cbIeUvfGrDbsjTcXCIADK/5
         456A==
X-Gm-Message-State: AOUpUlGplUam0dJE7AuWmD4CoS1u+p3MdTB4wqhGmi+zNxx83kgCexdF
        0WwmuzD9MHZY7piOFDy189bO/BJngv78iiqqecw=
X-Google-Smtp-Source: AA+uWPxsXNeAxKUvxsOk4Yk2pH/lwWpG20AWcIr0v131rPE1khYsahL84GbTqy3O2ZntK2SCovXgHtqIzegw7YXWxFA=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr20505299jas.72.1534288613120;
 Tue, 14 Aug 2018 16:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180814221735.62804-1-wnukowski@google.com> <20180814225716.GA3224@localhost.localdomain>
In-Reply-To: <20180814225716.GA3224@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Aug 2018 16:16:41 -0700
Message-ID: <CA+55aFw-Fed2QJCYBosGby71AsXAVKGq8mG-HYR13rEnD9V2Lg@mail.gmail.com>
Subject: Re: [PATCH] Bugfix for handling of shadow doorbell buffer.
To:     keith.busch@linux.intel.com
Cc:     wnukowski@google.com, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>, yigitfiliz@google.com,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guys, you're both wrong.

On Tue, Aug 14, 2018 at 03:17:35PM -0700, Michal Wnukowski wrote:
>
> With memory barrier in place, the volatile keyword around *dbbuf_ei is
> redundant.

No. The memory barrier enforces _ordering_, but it doesn't enforce
that the accesses are only done once. So when you do

>              *dbbuf_db = value;

to write to dbbuf_db, and

>    *dbbuf_ei

to read from dbbuf_ei, without the volatile the write (or the read)
could be done multiple times, which can cause serious confusion.

So the "mb()" enforces ordering, and the volatile means that the
accesses will each be done as one single access.

Two different issues entirely.

However, there's a more serious problem with your patch:

> +             /*
> +              * Ensure that the doorbell is updated before reading
> +              * the EventIdx from memory
> +              */
> +             mb();

Good comment. Except what about the other side?

When you use memory ordering rules, as opposed to locking, there's
always *two* sides to any access order. There's this "write dbbuf_db"
vs "read dbbuf_ei" ordering.

But there's the other side: what about the side that writes dbbuf_ei,
and reads dbbuf_db?

I'm assuming that's the actual controller hardware, but it needs a
comment about *that* access being ordered too, because if it isn't,
then ordering this side is pointless.

On Tue, Aug 14, 2018 at 3:56 PM Keith Busch <keith.busch@linux.intel.com> wrote:
>
> You just want to ensure the '*dbbuf_db = value' isn't reordered, right?
> The order dependency might be more obvious if done as:
>
>         WRITE_ONCE(*dbbuf_db, value);
>
>         if (!nvme_dbbuf_need_event(READ_ONCE(*dbbuf_ei), value, old_value))
>                 return false;
>
> And 'volatile' is again redundant.

Yes, using READ_ONCE/WRITE_ONCE obviates the need for volatile, but it
does *not* impose a memory ordering.

It imposes an ordering on the compiler, but not on the CPU, so you
still want the "mb()" there (or the accesses need to be to uncached
memory or something, but then you should be using "readl()/writel()",
so that's not the case here).

                 Linus
