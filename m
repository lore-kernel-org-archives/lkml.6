Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B025C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D102C2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jRg4ajig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D102C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbeKFVOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:14:47 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42457 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729878AbeKFVOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:14:47 -0500
Received: by mail-oi1-f196.google.com with SMTP id x63-v6so6716725oix.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 03:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbii29wtiRg6flUAAWtEvchYtVMTaKWWsTFXyHnDj9A=;
        b=jRg4ajigMTBqkJMaMAXMFtcsPw6bUCUBlm9i8NQrvM/DH92kfOAAdF/aZi4iNSyuWw
         mdf+B67EtEaqR3OeE36wwI//fhuesz7HjcM97OLfkHIkvJIRGHwnMZ6BhpflSYVn73LM
         Q4s0K7Iuw9DM9BmQzz17xlRi+y4/LqKsmG5AA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbii29wtiRg6flUAAWtEvchYtVMTaKWWsTFXyHnDj9A=;
        b=HAK3YRQJEOfpBuiTZmZSa4tqRUEiFp1is4xpW0mu51poPJBxrJA64Q8Royg/Xb7G3s
         5OlSOULMFwarXKB89y9MYrLZel8FnHzY+qqLFq5/aFgd62PE26nplQgdShN6GaMvaRUc
         Pzq6dKlQbZl+mkbpDEU2tfj62UMLKLf11Tky1BUMaw+ZCtFa59ddb70nkzUfJO+c3fuj
         w4c1mN8EoG3gxTj16eXkZ9LCXYvSJVnP8oxUeDMkjFzMnEzFpDu/cwoRLHiDicYs/Svl
         a6i4KLIAxcMzANQNi4Qpzg8xXt+e4UgHCjIyr0cwuvdXwDDyHP9u73aD27BthG+wX5GT
         SXTg==
X-Gm-Message-State: AGRZ1gJU6OFP+sJHYxZy3oca6B3qT2RYw7kxg0F3fl7ZzL2wPgIvyWXc
        /QbD65Ls17yNF/ne2Zuz0l9y5ANDz28TM8Rw6FNv
X-Google-Smtp-Source: AJdET5eT4p4gzuoBk/XKScrj0CWGwKR95C6aVcSCTYoOyEl54o4OS7zWBsSJqjeUtEMn9qiglzoRNe69Dd+8ttUzBSg=
X-Received: by 2002:aca:f50b:: with SMTP id t11-v6mr15914576oih.57.1541504997070;
 Tue, 06 Nov 2018 03:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20181106093100.71829-1-vovoy@chromium.org> <154150241813.6179.68008798371252810@skylake-alporthouse-com>
In-Reply-To: <154150241813.6179.68008798371252810@skylake-alporthouse-com>
From:   Kuo-Hsin Yang <vovoy@chromium.org>
Date:   Tue, 6 Nov 2018 19:49:46 +0800
Message-ID: <CAEHM+4rEibRffjO0dDncqRpc++8cAOpk-E0PNMW-4E-cMjkNnQ@mail.gmail.com>
Subject: Re: [PATCH v6] mm, drm/i915: mark pinned shmemfs pages as unevictable
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 7:07 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> This gave disappointing syslatency results until I put a cond_resched()
> here and moved the one in put_pages_gtt to before the page alloc, see
> https://patchwork.freedesktop.org/patch/260332/
>
> The last really nasty wart for syslatency is the spin in
> i915_gem_shrinker, for which I'm investigating
> https://patchwork.freedesktop.org/patch/260365/
>
> All 3 patches together give very reasonable syslatency results! (So
> good that it's time to find a new worst case scenario!)
>
> The challenge for the patch as it stands, is who lands it? We can take
> it through drm-intel (for merging in 4.21) but need Andrew's ack on top
> of all to agree with that path. Or we split the patch and only land the
> i915 portion once we backmerge the mm tree. I think pushing the i915
> portion through the mm tree is going to cause the most conflicts, so
> would recommend against that.

Splitting the patch and landing the mm part first sounds reasonable to me.
