Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A45EC43610
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5B120892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q1p1V0Na"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5B120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeKIJeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:34:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44331 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbeKIJeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:34:12 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so39489lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 15:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80zrIZsUXfXNB/MvVB/kSXiY40mCOydBaqte94B3krw=;
        b=Q1p1V0NaZ0hdAQiEGRukIJ5WnZfGiwR7F9EtrCymmj3SJTguuZAPCpL3d5blKVqZks
         hIIEExVZ3maRY2C3yBKIkrRE3qL7R/FyO9I7JDxW5bi/JM9u+F+Nk0gogAxnL/ElMl3H
         Xs3Qg+d7UAL4rVidHbXaW7gC5EK7HtYofqGDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80zrIZsUXfXNB/MvVB/kSXiY40mCOydBaqte94B3krw=;
        b=YVrI6VCfj51t0dABf5wQAxRvpji/ynaC+9tw+BTkzOm0U3cUIVFwj/fFvkTPra4YHg
         mF1ZOSFcvDyHU6Sg7V0A/f6bty1YMqqZZb3UUokVBQwfba4UqG1WsLl6Pt8S8MvqijO1
         XVBMsyDhCu+Jh29141Ry+aFsis8ONnb7fHNwrAEFKv9ZJx/2kFh+5ivczdoYazrEeREd
         vY4x0Kw6F1dAWnH5kXr5llsXKp+16y54nc/Pl9U1GcIJDaZtRfCbBw5xH7MOheVuHOk3
         /qWGr5O4Flciyafv/ryoCvpItNvEW1Dl2Pm+8UGXXU3Q8Cgf5M85F4kHA7nCGAwoAkYn
         JwIg==
X-Gm-Message-State: AGRZ1gLuAoQqPSaAMyUfTdjayuiz1ZpqSWFw+w+9POJZo5C8nauuWFo0
        K5q1Turw4uQK4LB57TNXicP2PWAiHhg=
X-Google-Smtp-Source: AJdET5cx9fIXNEuIW9EiJUNsj3FuuwymOh/4rZcgFm986IPa7++FOPWDRj7E5jXDKgABRhod/GTYbw==
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr4054804ljc.66.1541721372143;
        Thu, 08 Nov 2018 15:56:12 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id l13-v6sm896990lji.7.2018.11.08.15.56.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 15:56:11 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id s15-v6so68993lji.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 15:56:11 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr3976819ljh.59.1541721370634;
 Thu, 08 Nov 2018 15:56:10 -0800 (PST)
MIME-Version: 1.0
References: <20181108224000.GB15721@magnolia>
In-Reply-To: <20181108224000.GB15721@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Nov 2018 17:55:54 -0600
X-Gmail-Original-Message-ID: <CAHk-=wgd6HgnbLZ8ngvBj-WS9X5Mi01jhRqbG-zvg4UsA6nHNg@mail.gmail.com>
Message-ID: <CAHk-=wgd6HgnbLZ8ngvBj-WS9X5Mi01jhRqbG-zvg4UsA6nHNg@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: fixes for v4.20-rc2
To:     darrick.wong@oracle.com
Cc:     david@fromorbit.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 4:40 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> - fix incorrect dropping of error code from bmap
>
> - print buffer offsets instead of useless hashed pointers when dumping
>   corrupt metadata
>
> - fix integer overflow in attribute verifier

Pulled,

              Linus
