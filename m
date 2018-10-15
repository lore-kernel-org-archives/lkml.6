Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3707C04EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9209D208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X31WJ5iW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9209D208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeJPGNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:13:04 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38677 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeJPGND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:13:03 -0400
Received: by mail-yb1-f195.google.com with SMTP id e190-v6so8130439ybb.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tGQTXa6yqh0YUXaEj9WFxwmA0DYHjWfa/FO75TlyDeQ=;
        b=X31WJ5iW/B8k7G2uE6kLvAnFJMt/6w6ZHI2mZTqaYwPYulojA3gS0WrKXrgdT9nFfX
         7Vcofv4PvCldOr9AHka3eHO6B0MtkRFMMkWNxdik3sldo+suOGoM/nrK6nGlKRzQbNK8
         faMwDIxy5PGc4x4VMOWdqeTaNuVKlnkvkpmAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tGQTXa6yqh0YUXaEj9WFxwmA0DYHjWfa/FO75TlyDeQ=;
        b=Q8EwGk/chz6uzAIzpbvKDwcyUAy4Cowksd40IltRhcBXYySsvfuQHri7P+Adsg7cZU
         ux6HAgojx2zXpYDnja444wYQKm/S/Brs5KM5lZP8kuEBC87Te6qZ/sK5qioMWtSaBtyl
         M6uDy3sEtQX5fOciNTpQ4Lv1lEs+3glERc+bV51PwaQLlYkznnS3POu4BY45Jj3zFvug
         CPTNIKFvxnu1Oawo5eJ6JqtAqUtBZdeRwvU0Mmp3Gk9W/IjbnOUplWtqEZNzxPSmSnBj
         ITPQY8qjGWaW0Y11NBBZte3DzmmgNIViOU11yMsTvgT3D9KjARh6e4lYfO7r0Qlu3A48
         VBDw==
X-Gm-Message-State: ABuFfoh2G6kBw01TU4vjYHPy5bwHyZCR/g/tWmYaXrq0x5ygtRhvGA6F
        pJVEz3rHy04HyIOZXwvdyFRRaNTMGtA=
X-Google-Smtp-Source: ACcGV61rU8BIQ7CYC/4UkxoEm6skfioMxrEhRciZ2+5I7FN9iFKRasJKIPp2JTpadOpjumxlEIEcVg==
X-Received: by 2002:a25:7811:: with SMTP id t17-v6mr10347419ybc.436.1539642350057;
        Mon, 15 Oct 2018 15:25:50 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id 1-v6sm3438205ywm.3.2018.10.15.15.25.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 15:25:48 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id j75-v6so8148318ywj.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:25:48 -0700 (PDT)
X-Received: by 2002:a81:2908:: with SMTP id p8-v6mr10737345ywp.407.1539642347982;
 Mon, 15 Oct 2018 15:25:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 15:25:47
 -0700 (PDT)
In-Reply-To: <153922180696.838512.12621709717839260874.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153922180166.838512.8260339805733812034.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153922180696.838512.12621709717839260874.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Oct 2018 15:25:47 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+PStxYhiJaWM-mt4+WWbS_WAfvyHoyZYD5ndDLN2SY6w@mail.gmail.com>
Message-ID: <CAGXu5j+PStxYhiJaWM-mt4+WWbS_WAfvyHoyZYD5ndDLN2SY6w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] mm: Shuffle initial free memory
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 6:36 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> While SLAB_FREELIST_RANDOM reduces the predictability of some local slab
> caches it leaves vast bulk of memory to be predictably in order
> allocated. That ordering can be detected by a memory side-cache.
>
> The shuffling is done in terms of CONFIG_SHUFFLE_PAGE_ORDER sized free
> pages where the default CONFIG_SHUFFLE_PAGE_ORDER is MAX_ORDER-1 i.e.
> 10, 4MB this trades off randomization granularity for time spent
> shuffling.  MAX_ORDER-1 was chosen to be minimally invasive to the page
> allocator while still showing memory-side cache behavior improvements,
> and the expectation that the security implications of finer granularity
> randomization is mitigated by CONFIG_SLAB_FREELIST_RANDOM.

Perhaps it would help some of the detractors of this feature to make
this a runtime choice? Some benchmarks show improvements, some show
regressions. It could just be up to the admin to turn this on/off
given their paranoia levels? (i.e. the shuffling could become a no-op
with a given specific boot param?)

-Kees

-- 
Kees Cook
Pixel Security
