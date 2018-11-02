Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A7CC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5169E2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OzNc1DMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5169E2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeKCDH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:07:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34040 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKCDH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:07:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so2518847ljd.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ay/FUro+vOYwiD12O0cfjYWCCBKIYNTIfpHJol5OePk=;
        b=OzNc1DMci1BwN3IfZr4aP8+J0JaYvj/9YSx0kuTp2QdOK37aGXFQBYhb8n/O0+0D8M
         uHkcbZ4Hr++FLw9tcWIiXtwkWsnOmXeywn1KFmxjNzj5rI0rw0zR5+RGUha6Voo3P3CN
         I8I6Lb2kswpwX5VpaiAxU0iquOhp+fV9mCE78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ay/FUro+vOYwiD12O0cfjYWCCBKIYNTIfpHJol5OePk=;
        b=DRhq3xtaJMaFN8TBUpkfRuU8tJnzjMdUqsm3nXq6MxYGvt0n1ipMYXWehwdRFWm0mT
         I7gNheATkmeslBIBbuacyKHAvaV7FybV5lO09bqjfYXiDA4Iw6BK18xU4RC/geM2f8Wr
         QXOLOiIQnoGMHP9WyEKK0D9dtlyokhmwZous0TUBJmOWF43uptDiA4no614Y4hEqVb3W
         rcoZ5AWyxymofhD14LUG9Noane2Z0WTIm31r8bIXUN2JOnFX14dzN+qR0oHj019qgQiG
         R1dpt2n8gJ5huxCTFOK4AUoA2xP1DXnKvGrFoDC3h60FGw9hsTlJEQBpZGnbWIL1Hp5K
         aj+g==
X-Gm-Message-State: AGRZ1gIgReQP7sHyYQ3h5VkvdjEvFCllglNZUlVAZOEJEl6h3ARUKsnW
        1nudbuwM6KG4/vn1nQy3jmlS26rMGCwzyg==
X-Google-Smtp-Source: AJdET5eH1il3NnL7alyuPHj2TtckFjet8a++ikivq+wsp2oqzFEvFcrpNxJOATzTstUrj/V1Y24zJw==
X-Received: by 2002:a2e:9e53:: with SMTP id g19-v6mr9131647ljk.39.1541181594971;
        Fri, 02 Nov 2018 10:59:54 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id y1-v6sm610455ljh.39.2018.11.02.10.59.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 10:59:54 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id s15-v6so2513495lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 10:59:53 -0700 (PDT)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr8947547lji.133.1541181593391;
 Fri, 02 Nov 2018 10:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txf-NoKSEa+9-6-K-kSATevai54ma_tFepDpkQZCaUviA@mail.gmail.com>
In-Reply-To: <CAPM=9txf-NoKSEa+9-6-K-kSATevai54ma_tFepDpkQZCaUviA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Nov 2018 10:59:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgF5WYTxWcQa4n6NJQwG5poAJ1CJddrTqaD2-GytibsPg@mail.gmail.com>
Message-ID: <CAHk-=wgF5WYTxWcQa4n6NJQwG5poAJ1CJddrTqaD2-GytibsPg@mail.gmail.com>
Subject: Re: [git pull] drm next fixes for 4.20-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 10:32 PM Dave Airlie <airlied@gmail.com> wrote:
>
> Pretty much a normal fixes pull pre-rc1, mostly amdgpu fixes, one i915
> link training regression fix, and a couple of minor panel/bridge fixes
> and a panel quirk.

Pulled,

                      Linus
