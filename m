Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FCDC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F03E21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="J13ARZIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F03E21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbeIXU3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:29:47 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:46781 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeIXU3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:29:46 -0400
Received: by mail-io1-f51.google.com with SMTP id y12-v6so17701780ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yd+MC/OV2Kl7oTAK02UeN9wb+JsQnv59pHxxbXE5IbI=;
        b=J13ARZIn+Z/qA4m4l2vJ1YWgUsyDypokqA3Rp4gklny6ARxf3K7t22Oc6OC8F0Slz8
         JdWHfb3ZORepDeU4DJamorRnx1LVHGm52x8h+we2/+uxKrGUdumucTZGp03xhWLP4ghk
         y8P9Gd0OXiHlHeH0AJrzT9eOuOjzRCuVEYv3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yd+MC/OV2Kl7oTAK02UeN9wb+JsQnv59pHxxbXE5IbI=;
        b=isaH7RG8aHZK2hPje+uh6v1ImdwREmpmy8UMr93CkqtigxvuOgIc8n/EUdb3y8ybEk
         n+cYX+wjavJqncdU2TFkqXOa5CpGf5YhaGW4rLRACLL5gMvN7RM1qeaN2QUbH3GfOJPs
         soTDQcDJbpPbaTP496FmU4t4VKqTRdavYm56Hm4/8K6XTJX7+4U3/V+2ZTBbZjTV1OxN
         cMEdieEU4MbCimh4iK0U7MWczMw6fUZ4NI9Vs/q8ZE5JBwTAMCcCxP+UBWK3SeOY4EYJ
         Cu47TVqoioZgEsdS6z+CDEk92N6URaLNv6a5aqbPoWmo5x0Gy/FN2UcNQnnpOTXkpr62
         lTtQ==
X-Gm-Message-State: ABuFfoh6BkzAp0SELoXjfhiq2pH828rgSFOwnXBrgIh6hHzlKxbsPVxO
        38MA+kecZlGFBKVVIK3C+zcR9kDrCpQBVIuCXzHcoQ==
X-Google-Smtp-Source: ACcGV635FnLzQdosisIrwOoH66VF3vJMKfqW2Eh/HO3rey++h64gF7thb2NhlziS72cV8J1KLwvsILGgwIRpkpCI824=
X-Received: by 2002:a6b:fe09:: with SMTP id x9-v6mr7179214ioh.294.1537799242402;
 Mon, 24 Sep 2018 07:27:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 07:27:21
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <be262e04-df8a-c248-26a8-d42bf081be1c@virtuozzo.com>
References: <00000000000059484105767ac88f@google.com> <be262e04-df8a-c248-26a8-d42bf081be1c@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 24 Sep 2018 16:27:21 +0200
Message-ID: <CAJfpeguTiN22KqMCH9NMs0Hj+ZcshdzFUk7Mb38Jt0ewHEOHpg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in fuse_dev_do_read
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     syzbot <syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 2:06 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> Fix from my previous message makes the use-after-free does not reproduce
> with the reproducer in my setup.

Excellent.

>
> I can prepare the patch, but before this some comments from Miklos would
> be welcome.
>
> Miklos, what you think about this?

I like the patch.

We could optimize away the get/put by moving the set_bit/test_bit part
inside the fpq->lock-ed region and only get the refcount for the
(unlikely) interrupted case.  OTOH it's probably not worth the extra
complexity, so let's stay with this simpler fix.

Thanks,
Miklos
