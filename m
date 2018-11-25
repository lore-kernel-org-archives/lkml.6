Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E6AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 02:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E58D20867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 02:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jf4l21Fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E58D20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeKYNjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 08:39:49 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45204 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeKYNjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 08:39:49 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so13549612ljd.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 18:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LL/IjMVB1fuDGhC0eQP6BeGt6zUHCd493B6c/b23v6E=;
        b=Jf4l21FcS0sJka/kBsKaSL0PMwGRyUa0KGEwfBNoak91tr8CC1FbAChm/6Q5Mwdh2U
         mJXcym+CRpmorLhT5Px3cdPHjKJKUXBI75PAg3UX6eOZlanHDVjipKadjEWxBlVNJcE4
         tvjCPYHZRBFHtWBtvOAFarWJHynKZJMlO2zd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LL/IjMVB1fuDGhC0eQP6BeGt6zUHCd493B6c/b23v6E=;
        b=cmrgwDsXnOt79WaCkEzLmCCGlqnQhR9tIhr0fpHxOwUma6Byk/kdqlvMuxNH7noDAb
         zgEM3jFIokCv4vXb4LX/7MSs/b1UVqDeFAQjOf4n0KcRpVfgrwoXVXHY0kF8wgWOplZM
         BT+g6rJIVZ3Ajyn4rSgYD5i/bEuOLnCQAXsp026JzXv56jZ01SEzMYNZHJzzphlRMkZX
         MG3D97qH2wBH8eBKgzvVD07ei7ZKJ4nGBuVtvu76D87k/k4x3p30HDeT94DJcFrfSEeY
         NpiRwssngmBWYjCmW/Yeie18MgCB6/TyZWCAFUaqJpfCPMnbXnsZNErs/WoS2rH/j6iD
         lxxw==
X-Gm-Message-State: AA+aEWbY5VVsL2GZnmpKHGBprMoyvPZIhLtlIqepbFDhQJGf+f1fl3xB
        gdzvaJ1wCT1N511pAt7TUuGVHDDTkLs=
X-Google-Smtp-Source: AFSGD/XdSPJbdB4evkcX9fot2ATqbKvh0bG5sXV675lcV9DRHB9Q/5QwV0u/5HjAHFv9ig7UELW26w==
X-Received: by 2002:a2e:1603:: with SMTP id w3-v6mr13409365ljd.33.1543114187987;
        Sat, 24 Nov 2018 18:49:47 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id u12-v6sm8650264ljk.79.2018.11.24.18.49.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 18:49:47 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id l15-v6so13564440lja.9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 18:49:46 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr14615333lji.133.1543114186236;
 Sat, 24 Nov 2018 18:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20181124173209.GZ3065@bombadil.infradead.org> <CAHk-=wgHTcLXY4P-EJiXd4MbwXjp9QdEfQ+udVUGRuUzT-8ZFA@mail.gmail.com>
 <20181125023814.GB3065@bombadil.infradead.org>
In-Reply-To: <20181125023814.GB3065@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 24 Nov 2018 18:49:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=whU1RMvzGvCwq8HaApYZuJ4STyfAYC5b_qDPFTwcTWD=Q@mail.gmail.com>
Message-ID: <CAHk-=whU1RMvzGvCwq8HaApYZuJ4STyfAYC5b_qDPFTwcTWD=Q@mail.gmail.com>
Subject: Re: [GIT PULL] XArray updates
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 6:38 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> I generated a new key 5EC42E41545C1F5E and signed a new tag
> xarray-4.20-rc4

Hmm. Did you publicize it on any keyservers? I'm not finding the key
on pgp.mit.edu or on the sks-keyservers.net pool..

> I've signed that key with my old DSA key 2218C81E8E7C03FF which has
> about 400 signatures on it, but I understand is not terribly trustable
> these days.

.. but at least I can find that one.  I think a 1024-bit DSA key may
be borderline in theory, but it's a lot better than no key at all.

               Linus
