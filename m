Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18582C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9EE24CB4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oCHPnNBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9EE24CB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeFWRnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 13:43:17 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:52067 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751582AbeFWRnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 13:43:15 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id db2adfe8
        for <linux-kernel@vger.kernel.org>;
        Sat, 23 Jun 2018 17:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :from:date:message-id:subject:to:cc:content-type; s=mail; bh=ex1
        AqKKaa6UEdWEWnoXHAOUnWaU=; b=oCHPnNBzZK0ygCmJbLzOQPNdLDGETec7z+c
        pOh7RF1UyWMo5aI+2kKwyJt6TRMrWpB07M/ExZbIsk6SYxD1FywdNJcZOgAaPp05
        5a6GnIWk4h/TUJSB8aDo7Z0BCeZbxuynFBzNVzqVaKBXW2tm+MbXwWnpkJ+WXmjb
        o2if+ilyVqcCO9yX5jlwPQqIa7gk1E/FyQora4ZuWW4r+i5C7t8JTtw2O/oXrLIY
        xKkfbbGDjbObN9hT/6fA71UtlXR1543uQz0X5rIrj5vINIOCEcFKKR0oPMwa4zTu
        qvo6smi9ADRwKyLwyElZZheIucwp3Q3Rb2eggx0wZvhdfX/sFXg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7cf8543d (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 23 Jun 2018 17:36:50 +0000 (UTC)
Received: by mail-ot0-f179.google.com with SMTP id c15-v6so10906284otl.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 10:43:14 -0700 (PDT)
X-Gm-Message-State: APt69E3mSc6pwM7TvPCIMLU3Q/vE/vYi7K4Q9wCkUSR/vjhkmA48n5z4
        vmohF3/EhaFQQtgOysPZ3Ond3lbfvQOlvYxpuSo=
X-Google-Smtp-Source: AAOMgpd+PoblveGB0luf3eh168v4RzXxgu30zyuRJMOy5rMD0PhUVyKRTeAxXC+1Lv4+P4o4e5oiPtZBzixng4t+Rto=
X-Received: by 2002:a9d:34c3:: with SMTP id t3-v6mr4002192otd.313.1529775794361;
 Sat, 23 Jun 2018 10:43:14 -0700 (PDT)
MIME-Version: 1.0
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 23 Jun 2018 19:43:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9oc=HD=AWxS9dqtnKYxeGuAkJabDTuBe66fRWV3HBXWiA@mail.gmail.com>
Message-ID: <CAHmME9oc=HD=AWxS9dqtnKYxeGuAkJabDTuBe66fRWV3HBXWiA@mail.gmail.com>
Subject: Accuracy bounds of ktime_get_boot_fast_ns
To:     joelaf@google.com, Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In my driver, I am constantly concerned with determining for how long
a certain object has been alive, in real time, because the lifetime
needs to be more or less synchronized with others on a network. For
this, I'm generally using a formulation like:

void foobar_create(struct foobar *f)
{
    f->birthdate = get_jiffies_64();
}
bool foobar_has_expired(struct foobar *f)
{
    return time_is_before_eq_jiffies64(f->birthdate + DEATH_AGE_SEC * HZ);
}

That works well, except after system suspend, since now that
comparison doesn't actually represent anything real in relation to
others on the network. So the fix is:

void foobar_create(struct foobar *f)
{
    f->birthdate = ktime_get_boottime();
}
bool foobar_has_expired(struct foobar *f)
{
    return !ktime_after(f->birthdate + DEATH_AGE_SEC * NSEC_PER_SEC,
                        ktime_get_boottime());
}

So far, so good. But what if `foobar_has_expired` is called in a
performance critical hotpath? Since precision isn't _that_ important,
maybe I can get away with:

void foobar_create(struct foobar *f)
{
    f->birthdate = ktime_get_boot_fast_ns();
}
bool foobar_has_expired(struct foobar *f)
{
    return f->birthdate + DEATH_AGE_SEC * NSEC_PER_SEC <=
                ktime_get_boot_fast_ns();
}

I'm wondering if I can actually get away with this last iteration.
I've read the comments around the various _fast_ns functions, and they
all indicate that it might not be totally monotonic with respect to
all cpus. But I wonder if that actually matters for my use case. For
example, is it still correct within a 10th or so of a second? Or will
it occasionally be wrong by massive multi-second leaps, which would
make it unsuitable for my usage? In other words, I'm wondering if
there's still a level of accuracy for a certain low degree of
precision?

Thanks,
Jason
