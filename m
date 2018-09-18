Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40F9ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E42120C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0U0rCge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E42120C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeISEHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:07:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46423 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbeISEHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:07:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so3198764ljj.13;
        Tue, 18 Sep 2018 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXcrpGfAeVrWonoutAN2Glnmb0uDUIJ3wXTovMQaQDw=;
        b=F0U0rCgejfgoHdGNlQhaJmvElZQWUbYQC5xhC6+smSIQGvlKx+OkPdN6HNyKx9d2EG
         BzbLCzRTAc9L3UTf5N3gm5HLzMvGFMzuF5LzmhOZMu+ryY6OgVrNdn94LxzA3LOAV8I/
         G/CxdIpJzrRwUh6YKqA6yt9uZB2zJAoaN62/igUhlUVna8caoSEp9xKfYg5hWeJjYN+U
         wpgwVStwbO3lgnmPyd5t7Gqr/CQWWJl2cg8ab15iE+SAbSZWR17icK8xoAfQzXzS9W2J
         9Tke9w/qRzCFCeuJpCY5aCSk0mnkyPNzXGqxrhGazrPXz1ghKgmeCjFwJ/wFPeB3iEZf
         OU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXcrpGfAeVrWonoutAN2Glnmb0uDUIJ3wXTovMQaQDw=;
        b=CqG2S8OK1LiaKMYnAbEKhzmE2iH4bsh6YXvmiH575HTxB4Hrju7fUkXewqbww8Qmyv
         A1NLbvbGsiYLdcbxYiSeFGrHwQdhGszE9T4tl7bw0yw/M8mhKgt/SDtu3OWWXm61o1Wg
         0o6TkhUa19gBTDJmypQ/qnJmQqGZpvM0bZhYmV+1lGzdZfEHmPBqscJKdMu0xz9p4YMv
         /Wk780rl4g9pV5ImhlCOMYK5I/X9DFe9JlPX/CrccPMoaUJnC4oW0WsMvYFE0SbesiFm
         78pHcr3/rap2jigTTEnd9wBYfcKRqgauz574kMnWdZRyo7oqcGF92Kv7Islgc2SuzLmP
         3r4A==
X-Gm-Message-State: APzg51AYwHYsdTjmc0Jx5lMvwMWb4rEHzoAtQspbHDwd8ychqFAFoTzy
        nfbIdKD8XCgz56TaQDYW6TBIeEvZ5f5oQKK/NII=
X-Google-Smtp-Source: ANB0VdajIGo6TH6yZmhvYmBeXsypQ6Z/TCsbuf4zDyEfze8aRY51pdzBRAwHb1aKGfTYNEwmT3NDm8Lc8IxJwpSnfn8=
X-Received: by 2002:a2e:93c4:: with SMTP id p4-v6mr3799047ljh.150.1537309934900;
 Tue, 18 Sep 2018 15:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180919082500.74401754@canb.auug.org.au>
In-Reply-To: <20180919082500.74401754@canb.auug.org.au>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue, 18 Sep 2018 15:32:03 -0700
Message-ID: <CAKdAkRR8NH8FxfRVsB2DCiyh7QVZLisqZgd1ZgHCnGpUO6KP-g@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the input-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Drake <drake@endlessm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-next <linux-next@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 3:25 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Dmitry,
>
> After merging the input-current tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> ERROR: "mem_sleep_current" [drivers/input/serio/i8042.ko] undefined!
>
> Caused by commit
>
>   1685830e59d4 ("Input: i8042 - enable keyboard wakeups by default when s2idle is used")
>
> I have used the version of input-current from next-20180918 for today.

Ugh, sorry, I dropped that patch from my tree for now.

Daniel, Rafael, I guess we can't make pm_suspend_via_s2idle() static
inline, but instead move it into kernel/power/suspend.c and make it
EXPORT_SYMBOL().

Thanks.

-- 
Dmitry
