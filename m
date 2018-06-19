Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132FAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2EB20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="n7IfIAbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2EB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030414AbeFSUU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:20:29 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:46821 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755265AbeFSUU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:20:28 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d8d794b5
        for <linux-kernel@vger.kernel.org>;
        Tue, 19 Jun 2018 20:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=RYmmXi/6qoEk2ZGY65XQwZDUqsU=; b=n7IfIA
        bZxCzkj9SHjo8NmT5o1Kar87MdnhaaAEDAaVxzND9vs6wMyYmAEgeTMYI+WlYL8f
        M0zWvqFvNj8neSKfKq5Siq4kzC0hkiRpMF2FN1cVTap7yY7eJvRjptzv+3Y7uHfc
        b0D8Q25j6pXM16UjhWyLa95JZbD/jpQXBR/OZQXttM99SCmcxfO59ceB/PTrtzE+
        2PlmbtGHRix43w7pevKPUSLOtqOwOQukEgOr93EMMRjA0t/9IimHy0lY5agbUYHR
        piaiG8RxA22woa97EjBfbeZr3xN9NlH6rZoC4Cp9Gw0ELbp8Ocv25qIQZIySMcpK
        tAvfDXIxgSf4iylQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 42d1fd0a (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 19 Jun 2018 20:14:33 +0000 (UTC)
Received: by mail-oi0-f42.google.com with SMTP id l22-v6so946497oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 13:20:27 -0700 (PDT)
X-Gm-Message-State: APt69E2SINEtr+ENTTYJqMUO6OA3PRPo2qb7sMuCUPKKk8PcdCilPvwA
        7b5wzztx0Nq1GMvRSYJNgAU4ifjKlNTkv/mgScA=
X-Google-Smtp-Source: ADUXVKI8aCWjkL96JflmuNdKz7PCHT2K/7Q0imfjRe8ZWuaUk/1IIbKNTVfrfesvr+aT1F7Xbtmn3sjxOXqMrB2+6tU=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr10686912oie.105.1529439626736;
 Tue, 19 Jun 2018 13:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9q7aKGNiYauCjyy6Fu+bryPphEoLEMbAObTJgTrTfS2uw@mail.gmail.com>
 <20180619192139.31781-1-shakeelb@google.com>
In-Reply-To: <20180619192139.31781-1-shakeelb@google.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 19 Jun 2018 22:20:15 +0200
X-Gmail-Original-Message-ID: <CAHmME9ppVOWn7Fo4DzaKN9M+-EZpDpA3Rp_4JoQVoSu8SEX=uw@mail.gmail.com>
Message-ID: <CAHmME9ppVOWn7Fo4DzaKN9M+-EZpDpA3Rp_4JoQVoSu8SEX=uw@mail.gmail.com>
Subject: Re: Possible regression in "slab, slub: skip unnecessary kasan_cache_shutdown()"
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, aryabinin@virtuozzo.com,
        Alexander Potapenko <glider@google.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shakeel,

On Tue, Jun 19, 2018 at 9:21 PM Shakeel Butt <shakeelb@google.com> wrote:
> Jason, can you try the following patch?

Your patch also fixed the problem, which was also fixed by enabling
CONFIG_SLUB_DEBUG, per the other email. I haven't checked to see if
your patch is simply a subset of what SLUB_DEBUG is doing or what. But
hopefully this points in the right direction now.

Jason
