Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206EDC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC492081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z2xcV5px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC492081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeKAVJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:09:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39027 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKAVJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:09:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id g27so4620568oth.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 05:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qAZYRxI4k6444heYdVb1xsjRt+hchOlW2DsnTf3xsVU=;
        b=Z2xcV5pxo653ew7J7+71KeMoVcsbrj1djbAiXQc6o0LmXgLTaU170HzU+6XgAX6ono
         zxUqwJ5J/MNmhi/4jBeK4nDS76XI7KrT3ZXEoVuOLvAalr5tzi71M/xjIq0mZeXlG9E2
         LNoAJOpqrVoqHvpOl+kaCd2wYdNlxi68TG4Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qAZYRxI4k6444heYdVb1xsjRt+hchOlW2DsnTf3xsVU=;
        b=pAX+jOy0Z7mOsmTHO8iqmy47A379cTsqWnrAL1nRK59flFvsI/RW9dularMeIprQyg
         uLE0Jsh7+utB/FNc1uB5V9a+ie7vSm3ROgtrsJXSUCc5MXoXGlyBQ/qBpoTJYsgVqeM1
         HsHA4DRUkD/lcoBqMxgzUKh1xZPmyxzlB/pnHlhx/VdeSTTdmR+lydXIXPSLHZgy3zYt
         mv819aSHeFMU+vZqMdH+GlFxrG6ljlHdSew5Iz8kZUGB2spjAD/P9avhkn4JODty7jcI
         kfW1G6LAr3Ck6O7fCcWh6nCNgc0ahsJxmr6sRNH31hQRcPQ04HMcCen5Gc9rrMb88d8V
         0afQ==
X-Gm-Message-State: AGRZ1gL1GCIu3IDY56cnvIqMWrJTtc5DJkcvJBSxHkVujWBrp1/3nhZ/
        iOrWy2PZqt8J1FaOL6Ks+gEbDw+nxp0O4phazrXj
X-Google-Smtp-Source: AJdET5c6qR3hQ1UHhwy/MgOTFD/k+MVohgvIeyDI0WV8fxH9bvv7J0KIoFH4RgBgNe8SQFDnV7dZvOtCz3Tw0UDIQvI=
X-Received: by 2002:a9d:48c6:: with SMTP id a6mr4487637otj.181.1541073983358;
 Thu, 01 Nov 2018 05:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181031081945.207709-1-vovoy@chromium.org> <039b2768-39ff-6196-9615-1f0302ee3e0e@intel.com>
In-Reply-To: <039b2768-39ff-6196-9615-1f0302ee3e0e@intel.com>
From:   Vovo Yang <vovoy@chromium.org>
Date:   Thu, 1 Nov 2018 20:06:12 +0800
Message-ID: <CAEHM+4q7V3d+EiHR6+TKoJC=6Ga0eCLWik0oJgDRQCpWps=wMA@mail.gmail.com>
Subject: Re: [PATCH v3] mm, drm/i915: mark pinned shmemfs pages as unevictable
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     owner-linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Michal Hocko <mhocko@suse.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:19 PM Dave Hansen <dave.hansen@intel.com> wrote:
> On 10/31/18 1:19 AM, owner-linux-mm@kvack.org wrote:
> > -These are currently used in two places in the kernel:
> > +These are currently used in three places in the kernel:
> >
> >   (1) By ramfs to mark the address spaces of its inodes when they are created,
> >       and this mark remains for the life of the inode.
> > @@ -154,6 +154,8 @@ These are currently used in two places in the kernel:
> >       swapped out; the application must touch the pages manually if it wants to
> >       ensure they're in memory.
> >
> > + (3) By the i915 driver to mark pinned address space until it's unpinned.
>
> mlock() and ramfs usage are pretty easy to track down.  /proc/$pid/smaps
> or /proc/meminfo can show us mlock() and good ol' 'df' and friends can
> show us ramfs the extent of pinned memory.
>
> With these, if we see "Unevictable" in meminfo bump up, we at least have
> a starting point to find the cause.
>
> Do we have an equivalent for i915?

AFAIK, there is no way to get i915 unevictable page count, some
modification to i915 debugfs is required.
