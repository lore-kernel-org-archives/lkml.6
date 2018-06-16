Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F96C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 18:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166012087E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 18:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFWgFxfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166012087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeFPSud (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 14:50:33 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36034 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932482AbeFPSub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 14:50:31 -0400
Received: by mail-ua0-f195.google.com with SMTP id c23-v6so8434223uan.3;
        Sat, 16 Jun 2018 11:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFdMHNPs8ziCdFtG5v7nJ85VkXeoczbgS7JwBJXSK0E=;
        b=EFWgFxfYuqrBoX9J5y88ykkHK9m2Za3JCJbfmLemA3p/mAJyqm13JjtmOpl/7BvFMZ
         58snthhplOoSIrAEi9Ic5QxruCjesRf6L0xolKFWo7CPb+2ivIan3QsRRoScwv7pAYC2
         qzbrLik31taVDu0XSpnVRgthbLFCEEYxe4WcLODf6ZuNxd6Ew3CNaM4qxQaDuNVpuR5O
         2Tkol4C3u5wDXQxeQOH24uxmqHOz70q0aTDOvENDp9Ze2PeFZJlf6R4JzF95v1oiI5eY
         sjiv1ICk0U2tdbUlwC12K3F9+RwYa4xaYCbY05kFptMk6vyi9ztJNhj1RfZui0CnK0RM
         kYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFdMHNPs8ziCdFtG5v7nJ85VkXeoczbgS7JwBJXSK0E=;
        b=a2Y1P/m31xVgmkbxsr7MMSf7eblFtuadsTeWmHU0ILMi+WJHWZu2Dql2NOmMLFLZGa
         FD+COLaqCO32+3D5CnyiEJywoj7EDgUKzxeKsUdd/wAH380mIaN4I0ZbkWyirFWPUv7t
         +kd749igWkRkJyCOaW1vXQJQRfMaOWHdJSrtsFq/VvTKS7sm6nWJX7qO56cXEpI7uVrn
         5W0HagPnVDsZMLVz5j0XrcUi617pqqcG/0LfZ9IRyBplqXfb/xwMcNBPQJKIKGelFHWT
         iV2IdFVgr3amYlOduiAnysZcnjw68VHNAlTw+I8RiooSqMk8GNZB5PnJAl3+EWZDKDQg
         WMEw==
X-Gm-Message-State: APt69E2YB/PMuUgTROogfeAD10B+ebR368SfbGfrcPVmZwLItHP5GKpD
        GvCZgXkd7TFo12Lh2pbIO8tNTGeYzDH6VS+ME3M=
X-Google-Smtp-Source: ADUXVKJTnfsmY72A8ro5gf1P5UY5KdlB+kpFE147nRN/7s1+p6SeBPtGQ/Pq13RfYA6z1zSrlzSAWc/T9hlNtDnvqXY=
X-Received: by 2002:a9f:3613:: with SMTP id r19-v6mr4435543uad.49.1529175030811;
 Sat, 16 Jun 2018 11:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
 <20180615132017.23889-5-andriy.shevchenko@linux.intel.com> <20180615220610.GB371@yury-thinkpad>
In-Reply-To: <20180615220610.GB371@yury-thinkpad>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 Jun 2018 21:50:19 +0300
Message-ID: <CAHp75Ve_EMq=+4gvF449z1tM_oMHwRyYx03WCY-Lcet2JwJsjg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] Input: gpio-keys - Switch to bitmap_zalloc()
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        agk@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, shli@kernel.org, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 1:08 AM Yury Norov <ynorov@caviumnetworks.com> wrote:
>
> On Fri, Jun 15, 2018 at 04:20:16PM +0300, Andy Shevchenko wrote:
> > External Email
> >
> > Switch to bitmap_zalloc() to show clearly what we are allocating.
> > Besides that it returns pointer of bitmap type instead of opaque void *.
>
> Nit. There's no special type for bitmaps, bitmap_zalloc() returns long *.
> Is it less opaque than void *, not sure.

Yes, it enables type checking by compiler, which is good thing.
You can't supply other pointer to this API, like

unsigned char *bar = kmalloc(BITS_PER_LONGS(nbits) * sizeof(unsigned
long), GFP_KERNEL);
...

bitmap_free(bar); //<< compiler will not pass this silently!

Or other way around:

unsigned char *foo = bitmap_alloc(nbits, GFP_KERNEL); //<< wrong types!

-- 
With Best Regards,
Andy Shevchenko
