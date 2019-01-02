Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E37C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440D92171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfABKF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:05:26 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35467 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfABKFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:05:25 -0500
Received: by mail-vs1-f67.google.com with SMTP id e7so18579824vsc.2;
        Wed, 02 Jan 2019 02:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAW0x0nkWAqqj6cDRR14z3wRu/XsbNOovskhDOnohBI=;
        b=ZWB95nBYXpfVElMUnH0y2LtDRoYgpkhY2y9rDYUn6hjAe5YSldBeEhy4VlgF728zJQ
         ykTM/kqVZKexI/0QpHzIUgEgkxQPfKOpzxD8+WlRaG4LIrzHB3Abtuxz5935OHAQ7Y9B
         hj8UlP1Wb8BM30AWe39GeFSOE9ULGiWOvr8YiWhCF+EKKiZHsqfxOKUI+9nvrAL3Lblm
         hGoEy//OMQgZ1jbsmBQeTZJgYUiLJR3Re+QXVdY1e4fhidT6++j+87OQfhALj0fOgrVB
         a0VKDCoKSxGF8e+bqZ4+jMJofDHOGyg2XCecMh5gN3nnV3bPTp4AuqjJ9n9tLMS9uO6d
         JvHQ==
X-Gm-Message-State: AJcUukcV/gROy6hroB5ZWix+yxQpZRyO+d/r5EZfBCP6VldsNxMMDfQm
        MLcDBG/fOrXIGtL49Mj6p84Tad8xT7HAS0jvQx1UyddH+UE=
X-Google-Smtp-Source: AFSGD/VxYpw7zWcu7BccCXTZG5aoCVTdDizZftjDb3qJzpcCE2/R4Ti5inSDCgPHRyj7NNga1jnOYWAm8AaglU/WyMA=
X-Received: by 2002:a67:3885:: with SMTP id n5mr14957418vsi.96.1546423524536;
 Wed, 02 Jan 2019 02:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20181216194836.1310998-1-arnd@arndb.de>
In-Reply-To: <20181216194836.1310998-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Jan 2019 11:05:12 +0100
Message-ID: <CAMuHMdWKLccPn0Orf=tv7Nb6YBhraxbL9O-ujXwq_ULoZOU7iA@mail.gmail.com>
Subject: Re: [PATCH] [v2] test_rhashtable: remove semaphore usage
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     netdev <netdev@vger.kernel.org>,
        "Acked-by : Phil Sutter" <phil@nwl.cc>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        NeilBrown <neilb@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Sun, Dec 16, 2018 at 8:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
> This is one of only two files that initialize a semaphore to a negative
> value. We don't really need the two semaphores here at all, but can do
> the same thing in more conventional and more effient way, by using a
> single waitqueue and an atomic thread counter.
>
> This gets us a little bit closer to eliminating classic semaphores from
> the kernel. It also fixes a corner case where we fail to continue after
> one of the threads fails to start up.
>
> An alternative would be to use a split kthread_create()+wake_up_process()
> and completely eliminate the separate synchronization.
>
> Acked-by: Phil Sutter <phil@nwl.cc>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes from v1:
>  - rebase to mainline,
>  - fix pr_err() output
>  - bail out if interrupted

Now this is upstream as 809c67059162e7ba ("test_rhashtable: remove
semaphore usage"), I gave test_rhashtable a try again on m68k/ARAnyM.
And it succeeded, without my workaround from
https://www.mail-archive.com/netdev@vger.kernel.org/msg134240.html
Interestingly, it still succeeded without the workaround after reverting
809c67059162e7ba, so some other change during the last two years must
have fixed this.

I have no plans to bisect this, though.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
