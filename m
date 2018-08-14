Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D20CC4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC86B21731
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PFm5lOTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC86B21731
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbeHNCr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:47:59 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44550 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeHNCr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:47:58 -0400
Received: by mail-yw1-f67.google.com with SMTP id l9-v6so14948394ywc.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8BpjUYFgmTgixEn9rxptuCfwK+wNMwZAH9WmXlrZhEA=;
        b=PFm5lOThtNTyadfxzmfiZH6MlYniH6OV1z10Ob2xF9JaeQSe8gugD3Xhb3mWTEu8P/
         asoHScoJpk9jUvAWoUXhgoDO0ZeRglns5Bbv+k5Sk4vXzxl9A/XOvAY7b0S26O5zkzq2
         a/bZQT5UJOuPsZaIA+YpRMNOMlvWXCG+l/VVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8BpjUYFgmTgixEn9rxptuCfwK+wNMwZAH9WmXlrZhEA=;
        b=QT7QekYdwIg6/Qc65KUObzD7cAmEwReBGQFhrsaRSwplg/kb8WY+qG60M9Cv5TbOgV
         dxTvPm7ueaQ+xR+WMBwD4kaTsnK3aBOGbZf++MpBp426IlAnajWlcRpJHm9U5uFrc9pk
         EvYyrJvsRzlsLSgcur3M2UmCqEmBd1RRgenbnwL7JOpZI7qmaz8LRM7l+YyvMAYTVUOr
         uNvMorHk5QL01hFpY2OknlIrdVlv+9WTQFv/QwQXwAz9gEU4Lbcl5zC6hFsqumX9HDD3
         AV7GASb0SvnuvHMfDfAND7QioKtCQSO6e0Pq3mUnH8/dE37PR654DwFhOVfIdeGuREnv
         PReg==
X-Gm-Message-State: AOUpUlHIYZEaD68W2KCAYDzVAuhdWOvIUYAaWiE1D3k1anlnpR0gwm1W
        2DT8CSjndw1hhNMxZYynDRiQrd1ZP0g=
X-Google-Smtp-Source: AA+uWPyBJTjxxXqKrGQ1W81DjS/ok+rX15uTk1x3fL+mNS4OMZrRewA2Pa5mf/d8FXGYKYNYm7qLng==
X-Received: by 2002:a81:5b0a:: with SMTP id p10-v6mr10252990ywb.481.1534205003803;
        Mon, 13 Aug 2018 17:03:23 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id o204-v6sm10104082ywd.16.2018.08.13.17.03.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 17:03:22 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id v197-v6so14957003ywg.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:03:22 -0700 (PDT)
X-Received: by 2002:a81:b248:: with SMTP id q69-v6mr10280137ywh.38.1534205001535;
 Mon, 13 Aug 2018 17:03:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2316:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 17:03:20
 -0700 (PDT)
In-Reply-To: <20180809085245.22448-1-vbabka@suse.cz>
References: <cc93080f-2d22-71fe-a1fb-d55d1fcc2441@suse.cz> <20180809085245.22448-1-vbabka@suse.cz>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 13 Aug 2018 17:03:20 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKbiETGSV+Z6HNJwTMzGWFhFxSzPSrjmbGuhJ701ep2kA@mail.gmail.com>
Message-ID: <CAGXu5jKbiETGSV+Z6HNJwTMzGWFhFxSzPSrjmbGuhJ701ep2kA@mail.gmail.com>
Subject: Re: [PATCH] mm, slub: restore the original intention of prefetch_freepointer()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Menzel <pmenzel+linux-mm@molgen.mpg.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 1:52 AM, Vlastimil Babka <vbabka@suse.cz> wrote:
> In SLUB, prefetch_freepointer() is used when allocating an object from cache's
> freelist, to make sure the next object in the list is cache-hot, since it's
> probable it will be allocated soon.
>
> Commit 2482ddec670f ("mm: add SLUB free list pointer obfuscation") has
> unintentionally changed the prefetch in a way where the prefetch is turned to a
> real fetch, and only the next->next pointer is prefetched. In case there is not
> a stream of allocations that would benefit from prefetching, the extra real
> fetch might add a useless cache miss to the allocation. Restore the previous
> behavior.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Daniel Micay <danielmicay@gmail.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
> While I don't expect this to be causing the bug at hand, it's worth fixing.
> For the bug it might mean that the page fault moves elsewhere.
>
>  mm/slub.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 51258eff4178..ce2b9e5cea77 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -271,8 +271,7 @@ static inline void *get_freepointer(struct kmem_cache *s, void *object)
>
>  static void prefetch_freepointer(const struct kmem_cache *s, void *object)
>  {
> -       if (object)
> -               prefetch(freelist_dereference(s, object + s->offset));
> +       prefetch(object + s->offset);

Ah -- gotcha. I think I misunderstood the purpose here. You're not
prefetching what is being pointed at, you're literally prefetching
what is stored there. That wouldn't require dereferencing the freelist
pointer, no.

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

>  }
>
>  static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
> --
> 2.18.0
>



-- 
Kees Cook
Pixel Security
