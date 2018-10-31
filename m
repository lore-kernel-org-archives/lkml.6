Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624BAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F6420821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iONEao9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F6420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeJaTkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:40:35 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:41437 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbeJaTke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:40:34 -0400
Received: by mail-oi1-f171.google.com with SMTP id i10-v6so818113oii.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 03:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VofoMDnFH/D7xo/byhQInwutEsvv1T0KIYZsmuUjDmo=;
        b=iONEao9mDiBEGTJGculGXMwKKa5aJ11ZSlID71Hk8JPT+pGq8DEFdz1Hk/qXfxABTY
         CdzUAY3gUM//SViOTjwWI+h3n5CHLevyZ2GV9Q8Aa67DvXz2fzaEPFKcnnEP55d/5ZTi
         iInTeajhIZKczjsXgvLEWOFkgJegrkMLymxD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VofoMDnFH/D7xo/byhQInwutEsvv1T0KIYZsmuUjDmo=;
        b=a4Xum4LZijCcuFqqfc36MNycmDepSILnW+cGeoik1C10d0V6zQtN+mYvzz3a8oPivq
         BQ236OYkfgFn0rpbRIH+Ww3gjiJklX4kc4dmi64+eJTbMh50ljhaCtD9AqVxyrMlYzon
         XmJ6IbReYTWwWHLz2juBLHVNQ78cCn7qEh5RkKDBcKh2Ksq03kxDp2c6LspjpEW6s9Mw
         V0aoa8/gDNKi/lAF2c5sgzdEoDQCWPZI2uYjgQh5UkXF/KOePrw2+wFI6l4MNrOI6Z5i
         4m9y1bYq7F7Af9tBVzii/Hy5ArVe12TdAktNmE1W49dscPOkYa7RosRWVaBUglB/X/5n
         9DEQ==
X-Gm-Message-State: AGRZ1gKmF0/frIzgEJTVrhvYlBNpGlHV7466Vgo1BKpi+DbjptEHStyM
        GZpcStm6HgE1NzoOcbOOt/4IipWgBL3wi1t72tqF
X-Google-Smtp-Source: AJdET5cRn2aA0R1SkOIk1bvqPrWCXaWSYxYtAzG0slWSoCvbHIxb8fUsECZe74IxE9a8jxN+RXa+LqIb/CNh1Ylh+Vc=
X-Received: by 2002:aca:b784:: with SMTP id h126-v6mr1503006oif.298.1540982580958;
 Wed, 31 Oct 2018 03:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181031081945.207709-1-vovoy@chromium.org> <154097891543.4007.9898414288875202246@skylake-alporthouse-com>
In-Reply-To: <154097891543.4007.9898414288875202246@skylake-alporthouse-com>
From:   Vovo Yang <vovoy@chromium.org>
Date:   Wed, 31 Oct 2018 18:42:50 +0800
Message-ID: <CAEHM+4q-70qnjqdJ1HNq4GWU5=rVoiWNDFRa=7oSNWfTxsrp-g@mail.gmail.com>
Subject: Re: [PATCH v3] mm, drm/i915: mark pinned shmemfs pages as unevictable
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        peterz@infradead.org, akpm@linux-foundation.org,
        dave.hansen@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 5:42 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> Will do. As you are confident, I'll try a few different machines. :)
> -Chris
Great! Thanks for your help. :)

Vovo
