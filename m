Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07710C7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6312207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gBSaw3I7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6312207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeJXTQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:16:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39536 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbeJXTQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:16:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id p1-v6so4296110ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 03:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjhJy2C/nhCp5K5exIPr0+iG29RUhRQdf03e9ezu1fs=;
        b=gBSaw3I7jd1fjqCzFEJsk8Mqy5gaVU9+uJD6jxVsIXdQcyE4Ihc5eV6NJTF4is7xjT
         OjcSjwQLwU8Ieug4JML6Z5isEHZFFv2dKfbvPmJ599/Ob+7Gq10PuuKCm7R6+qBp0q+q
         6ayotGuv7IVj35Te+FuIHehp/sTrE3WYPdnao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjhJy2C/nhCp5K5exIPr0+iG29RUhRQdf03e9ezu1fs=;
        b=qeAngGzsQQpXviJjU6GDEAiiFIHftLg+rCdhs6oHrYk8cQJONCV2WoCRVLJVBA963D
         gBC+u1m45+KPPM+t/10hlh2p2E62e0ZE2TupuNWb+E8AbalJp6lldRfZiOghzS3PM8Eu
         dh96Uf0VFd1EYNBijYO6/KGb/Chcno8aw9dBIsbqu7I+95KBx5dTKxPk9lYJ4P/47hgf
         TVJuVmwXeqHO8W+f76a2RfBBQ6b/xzfRaZM6g/K34Zco0LwoE9F2zWiaCCSKh3Tqd4RB
         7LvtfXHqGOXuWqPXaZc52DPiL+F4vxhq/EDPSqOrH4xblbUHp+2fhCJQpITO9uMvkOpB
         EHpA==
X-Gm-Message-State: AGRZ1gJhDiBWqT1AluAnEyKwNzQD2qfORnH0Z+vH0qQw20JtED0FERKd
        gqryKousIFmxZvy5WkZYXsGBKWc+kLwvIJQJ
X-Google-Smtp-Source: AJdET5cOzZeyzHxePOlpHaEr3Ag0SoGflb+At4bg+EQbFJ7Z5/JQ032ZVDiq7xD7hdqxJ+zEHohxyg==
X-Received: by 2002:a2e:4751:: with SMTP id u78-v6mr1403119lja.72.1540378152250;
        Wed, 24 Oct 2018 03:49:12 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id d2-v6sm640743lfc.11.2018.10.24.03.49.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 03:49:11 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id x22-v6so1111906ljc.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 03:49:11 -0700 (PDT)
X-Received: by 2002:a2e:9584:: with SMTP id w4-v6mr1423488ljh.118.1540378150673;
 Wed, 24 Oct 2018 03:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRHCOZL5WTwiyPQxknO2SAHCeDLuSJmkKWmYLYb4WFXng@mail.gmail.com>
In-Reply-To: <CAHC9VhRHCOZL5WTwiyPQxknO2SAHCeDLuSJmkKWmYLYb4WFXng@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 11:48:54 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjhfhKGWapO18bohQvkPtBB2ut1Rn+3x01CEtFzbPWKNQ@mail.gmail.com>
Message-ID: <CAHk-=wjhfhKGWapO18bohQvkPtBB2ut1Rn+3x01CEtFzbPWKNQ@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v4.20
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 1:55 AM Paul Moore <paul@paul-moore.com> wrote:
>
> Three SELinux patches for v4.20, all fall under the bug-fix or
> behave-better category, which is good.  All three have pretty good
> descriptions too, which is even better.  Please merge this for v4.20.

Pulled,

               Linus
