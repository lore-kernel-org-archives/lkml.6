Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569C5C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 01:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049D12082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 01:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ELRWixqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049D12082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeKDKvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 05:51:37 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35866 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeKDKvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 05:51:36 -0500
Received: by mail-lj1-f194.google.com with SMTP id s15-v6so4950530lji.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 18:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5J8FQK+VC4DTcgcmkOXqt4Po3zlC+ACrKnigvhFvxg=;
        b=ELRWixqLFwe0/OLf5BWy3AGI2GDVPJe7qCwr8VDhFZAD6/7MSGPtL2pGeg5C+1Tmpy
         GQ50WzJR0ksgzueWe5ViiWxxVP/V8IFy15FmZ8wKi5jQSFjh2iIOeIe6rKE6XOBpgaB3
         ropUIKCEgiZpSLZ9rl+19k1yRWGt6ZTQLI0ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5J8FQK+VC4DTcgcmkOXqt4Po3zlC+ACrKnigvhFvxg=;
        b=Oat9xni2oJdrhsIhYv9djXp6oKN7Vp6hvegZrBCDZP6/BE0hDcxwiTa4rFrX7BPLNz
         yJFVS0FCwG2OLfx+Rs0lDmJyCywTpq9ZUxck+KdVWBx4j94bEC6HqfD+jt2wo+Ge1/eR
         1EsFZtketiKID4TEEiEKWPIJAcxq+GGEk8PYuimwEwLwEczvs4FMm3Po2zgrQVTocZ8y
         xuN+heLTttdhNo+cpX8EZ8SFIdTzz4YsKo8uJeTM8udSnqJCUe7saXqtFA95uxgHfPk8
         PyGl967JpyKSQa/IwfO3XmgGFf757DkbFgtDF4jKQkIgaVyvTXUSU/Uqw23X4jVsVYjm
         NM1A==
X-Gm-Message-State: AGRZ1gJNbkQXIUkmsrSg4zpXxxvz8UwJ3wTVx9LEHR7UrG5GCjIPHiZ/
        Fb7JccKYgrzqngHDF1JF3iGGgXTK7SM=
X-Google-Smtp-Source: AJdET5c14DJjHh0/G3hzMV0HObkQAahEjo80wzdOZjCwXHe3O3cUpqnIRQFyzZDLeExZNOwScNEn0w==
X-Received: by 2002:a2e:5356:: with SMTP id t22-v6mr8729376ljd.26.1541295509448;
        Sat, 03 Nov 2018 18:38:29 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id t19-v6sm294240lje.23.2018.11.03.18.38.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 18:38:28 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id e5-v6so798001lja.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 18:38:28 -0700 (PDT)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr11964820ljj.6.1541295507637;
 Sat, 03 Nov 2018 18:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181103235216.GA46027@gmail.com>
In-Reply-To: <20181103235216.GA46027@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Nov 2018 18:38:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-SaR-HfYv1X9Owovrf+FGMyZ7=Nvj=b8PDLn9e6z4aQ@mail.gmail.com>
Message-ID: <CAHk-=wh-SaR-HfYv1X9Owovrf+FGMyZ7=Nvj=b8PDLn9e6z4aQ@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler fixes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, tglx@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 4:52 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> A memory (under-)allocation fix and a comment fix.

Pulled,

                 Linus
