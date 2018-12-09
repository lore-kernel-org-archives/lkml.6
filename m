Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1D0C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 16:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28A220837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 16:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28A220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeLIQlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 11:41:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47560 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeLIQlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 11:41:12 -0500
Received: from mail-vs1-f72.google.com ([209.85.217.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1gW27x-0006sw-Au
        for linux-kernel@vger.kernel.org; Sun, 09 Dec 2018 16:40:21 +0000
Received: by mail-vs1-f72.google.com with SMTP id f203so4999017vsd.17
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 08:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKMerKFE87zC5G0vfp3TossQpuuQ25Gn/kQdJFCIzJg=;
        b=Su1Mcc5JHOnSBAK1Em0DjSSysin5ux0r6NJAyotL1H/Ei1vO2NHFQhp9Z9uRuyczWo
         V+lUJDjmL8OTM7R3N5yU4E8R1QYk2UTygYTxbVty9qMNWOAWkY0zNyhc3Vk7fZRx3c7m
         xqa21fcwetUzY7TcztRO/U4bH8lGlU2Pn/XevuA+laZOw4JmPUF5hCS86s4r7FASn6iT
         Cq+aST5TBJg0pX867Vx2WqjKp6QY5BeiN2fR7tb/ISa64luWvscdvqOZjk209U7J+tNg
         NJrd4yOSKgMVK3YSl3UXUtxFyuToAhwJ2hmOLc/DXMiwgfEQUYmEae/zEW6q5l3TDnuc
         HNMw==
X-Gm-Message-State: AA+aEWY32eURyyJB5aHP/WuGQOiBcTVqZaHzNypdJz3rr1SFHzHk0mtT
        UxhVKCzqnyAUJTQ4+jiDT/6CovaB+lw4nlOvIMgIIfo+AE1NpRtzBBWJYqIGJtgA5Cd+GuSBblv
        aDJQBw8Pjb9qTa22SZa///qqrwb9dFaXQ4PF3PW/z19NwuueDqtkUxJnAHA==
X-Received: by 2002:a67:2388:: with SMTP id j8mr4117932vsj.126.1544373620293;
        Sun, 09 Dec 2018 08:40:20 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UooSiby+xaqcaxTkydAbUuSAUyrAJbfgGK587CO1s9kZevIvhMqGENVhICBDSGRA3AwqnKWgoYydKAg+qDQD0=
X-Received: by 2002:a67:2388:: with SMTP id j8mr4117912vsj.126.1544373619965;
 Sun, 09 Dec 2018 08:40:19 -0800 (PST)
MIME-Version: 1.0
References: <20181016223322.16844-1-christian@brauner.io> <20181029145818.4bqmy25itjnqhodg@brauner.io>
 <CAGXu5jJwSRQ3dOgNW_X0Fk+8gT+ACiBZPJ79g-aCfqiWsm=ewg@mail.gmail.com>
In-Reply-To: <CAGXu5jJwSRQ3dOgNW_X0Fk+8gT+ACiBZPJ79g-aCfqiWsm=ewg@mail.gmail.com>
From:   Christian Brauner <christian.brauner@canonical.com>
Date:   Sun, 9 Dec 2018 17:40:09 +0100
Message-ID: <CAPP7u0U72jSkT3km-E2imQdOvk-WRaDCH4t--N07mh8my7PvOQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] sysctl: handle overflow for file-max
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, mcgrof@kernel.org,
        joe.lawrence@redhat.com, Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:44 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Oct 29, 2018 at 7:58 AM, Christian Brauner <christian@brauner.io> wrote:
> > On Wed, Oct 17, 2018 at 12:33:20AM +0200, Christian Brauner wrote:
> >> Hey,
> >>
> >> Here is v3 of this patchset. Changelogs are in the individual commits.
> >>
> >> Currently, when writing
> >>
> >> echo 18446744073709551616 > /proc/sys/fs/file-max
> >>
> >> /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> >> crashes the system.
> >>
> >> The first version of this patch intended to detect the overflow and cap
> >> at ULONG_MAX. However, we should not do this and rather return EINVAL on
> >> overflow. The reasons are:
> >> - this aligns with other sysctl handlers that simply reject overflows
> >>   (cf. [1], [2], and a bunch of others)
> >> - we already do a partial fail on overflow right now
> >>   Namely, when the TMPBUFLEN is exceeded. So we already reject values
> >>   such as 184467440737095516160 (21 chars) but accept values such as
> >>   18446744073709551616 (20 chars) but both are overflows. So we should
> >>   just always reject 64bit overflows and not special-case this based on
> >>   the number of chars.
> >>
> >> (This patchset is in reference to https://lkml.org/lkml/2018/10/11/585.)
> >
> > Just so that we don't forget, can we make sure that this gets picked
> > into linux-next? :)
>
> I was hoping akpm would take this? Andrew, does the v3 look okay to you?

gentle ping again :)

Christian
