Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD397C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937B420819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ShFM9qWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937B420819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbeKEXxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:53:25 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38905 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeKEXxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:53:25 -0500
Received: by mail-oi1-f196.google.com with SMTP id v83-v6so7595745oia.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cY70111Ih58IqEWv1cT4KftiBxviHf5HTOPzwjhLziU=;
        b=ShFM9qWt7EYtC/i4WHk4bBuJrc2vfEikhb5bahRHyOUMz32i5JEJG9MVYU6awLv0ph
         624TSKccPRlvbLEMR//Ak3s/0EKjdy7HRe1Sg8em2n1OQCfUVHapGavYhxx5l9ZGjaeC
         EFIp1P8JuW4zfWzHtAwH8fypn3Qc2gjgkTpKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cY70111Ih58IqEWv1cT4KftiBxviHf5HTOPzwjhLziU=;
        b=VqmsKsV2hFxp4xh8ulOBfmyJzPVLxtZQcTn85zRr+PEwZn5o/kwMx4ZKXWoQmmaiwp
         m5N30k8EByRHXrncA4g2JfIGCppu4atDvhMmewyEehKAk74Tr7bzQq5Y0mQsVQf/Bmvn
         Gkod7aIpGoalUiTLS3giuBx4JEthZjvH56LikEQAr0/YSxRb/sWYqrzlE5afthAjRQ32
         3DKm4nGi98KP5nI7+Z5Ad2XFKi0w3kkmJJBRTmkZS4r4S9aXTjTacPfzYpbsaVS63CJx
         b85od4SE9lVY+cv+C1+ACIOm3V09Futg4nStL5XxsY75rUaAhMielPiuFrGoRdETyJ+2
         I8TA==
X-Gm-Message-State: AGRZ1gJDCgQB0of08D2plXyojZGSul/Qz00AyuD4blTErpoy5Vnlh9hz
        4UMJ5/4oiqWZzkzue04iuQyRCQeaX/da0+T53x90
X-Google-Smtp-Source: AJdET5dY1j34LbuOZLHr6jTCk7utkjy3KZ+FLxwIn+jq9iK3VmLe4uwwMAUWZ3F4Kfm9COKwtbl7Qj0y2P9aq57Uu4M=
X-Received: by 2002:aca:e514:: with SMTP id c20-v6mr13515887oih.75.1541428405068;
 Mon, 05 Nov 2018 06:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20181105111348.182492-1-vovoy@chromium.org> <20181105130209.GI4361@dhcp22.suse.cz>
In-Reply-To: <20181105130209.GI4361@dhcp22.suse.cz>
From:   Kuo-Hsin Yang <vovoy@chromium.org>
Date:   Mon, 5 Nov 2018 22:33:13 +0800
Message-ID: <CAEHM+4r4gRiBdRHaziiAFzwB5VD785zpUEr31zFLbx4sNUW6TQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm, drm/i915: mark pinned shmemfs pages as unevictable
To:     mhocko@kernel.org
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 9:02 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 05-11-18 19:13:48, Kuo-Hsin Yang wrote:
> > The i915 driver uses shmemfs to allocate backing storage for gem
> > objects. These shmemfs pages can be pinned (increased ref count) by
> > shmem_read_mapping_page_gfp(). When a lot of pages are pinned, vmscan
> > wastes a lot of time scanning these pinned pages. In some extreme case,
> > all pages in the inactive anon lru are pinned, and only the inactive
> > anon lru is scanned due to inactive_ratio, the system cannot swap and
> > invokes the oom-killer. Mark these pinned pages as unevictable to speed
> > up vmscan.
> >
> > Export pagevec API check_move_unevictable_pages().
>
> Thanks for reworking the patch. This looks much more to my taste. At
> least the mm part. I haven't really looked at the the drm part.
>
> Just a nit below
>
> > This patch was inspired by Chris Wilson's change [1].
> >
> > [1]: https://patchwork.kernel.org/patch/9768741/
>
> I would recommend using msg-id based url.

I didn't find a msg-id based url for the [1] patch. This patch is sent
to intel-gfx@lists.freedesktop.org and linux-mm@kvack.org, but not to
linux-kernel@vger.kernel.org .

>
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
>
> other than that
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> [...]
>
> > @@ -4184,15 +4185,13 @@ int page_evictable(struct page *page)
> >
> >  #ifdef CONFIG_SHMEM
> >  /**
> > - * check_move_unevictable_pages - check pages for evictability and move to appropriate zone lru list
> > - * @pages:   array of pages to check
> > - * @nr_pages:        number of pages to check
> > + * check_move_unevictable_pages - move evictable pages to appropriate evictable
> > + * lru lists
>
> I am not sure this is an improvement. I would just keep the original
> wording. It is not great either but the explicit note about check for
> evictability sounds like a better fit to me.

OK, will keep the original wording.

>
> > + * @pvec: pagevec with pages to check
> >   *
> > - * Checks pages for evictability and moves them to the appropriate lru list.
> > - *
> > - * This function is only used for SysV IPC SHM_UNLOCK.
> > + * This function is only used to move shmem pages.
>
> I do not really see anything that would be shmem specific here. We can
> use this function for any LRU pages unless I am missing something
> obscure. I would just drop the last sentence.

OK, this function should not be specific to shmem pages.

Is it OK to remove the #ifdef SHMEM surrounding check_move_unevictable_pages?

>
> A note that this function should be only used for LRU pages would be
> nice.
>
> >   */
> > -void check_move_unevictable_pages(struct page **pages, int nr_pages)
> > +void check_move_unevictable_pages(struct pagevec *pvec)
> >  {
> >       struct lruvec *lruvec;
> >       struct pglist_data *pgdat = NULL;
> > @@ -4200,8 +4199,8 @@ void check_move_unevictable_pages(struct page **pages, int nr_pages)
> >       int pgrescued = 0;
> >       int i;
> >
> > -     for (i = 0; i < nr_pages; i++) {
> > -             struct page *page = pages[i];
> > +     for (i = 0; i < pvec->nr; i++) {
> > +             struct page *page = pvec->pages[i];
> >               struct pglist_data *pagepgdat = page_pgdat(page);
> >
> >               pgscanned++;
> > @@ -4233,4 +4232,5 @@ void check_move_unevictable_pages(struct page **pages, int nr_pages)
> >               spin_unlock_irq(&pgdat->lru_lock);
> >       }
> >  }
> > +EXPORT_SYMBOL(check_move_unevictable_pages);
> >  #endif /* CONFIG_SHMEM */
> > --
> > 2.19.1.930.g4563a0d9d0-goog
> >
>
> --
> Michal Hocko
> SUSE Labs
