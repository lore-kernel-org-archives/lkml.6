Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE27C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E46204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="W0SNpHlw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E46204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeICMLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:11:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38028 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbeICMLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:11:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id h33-v6so69254edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 00:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EEXtVDHPvci+1a2hIcDJutGUqhq4qTc5VQty/zvbR8o=;
        b=W0SNpHlwL3tY614EWeQMhiFkdQrVDj7cskNy8QTfEoX1RgGKx0OOzySLzv6SHxuaWM
         nwVnCO/MvSRQdPiFBFBifCgQKawuqvx81iHghxNBn7hGnW7rbWGv2wDs0wqeWP+LHy4M
         3r0sV/0rrX/UH219+v+yFx9XeUAOg/5ralp70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=EEXtVDHPvci+1a2hIcDJutGUqhq4qTc5VQty/zvbR8o=;
        b=JcM5GzAAogHtMSZ0lkG87q6DQwYsUo3Usj9ZxvktNYPpy/5EJ0vrui0BGjDZNbL0oX
         tJWfVXdxzTVkHT9gv36INaq8XSyVrZtiWg68GtqxmNWDbG1tI2ItiGgR2vq+D6r/qeNH
         oXO/VSRISYewDOZ8uhOiLOu8/b00vPw8Z+4t/4kHJKbQycjQCIMt+mL0cheaNjYY2bNM
         yNLzKcgIe3hkUcOzePOEi9i9eYsVi7BlCoMCvQZiB15bWROfkZCimT2D8b1im2f65QXR
         wKS8DnxChmU+3CpG+hkLeLb2R011fRH4DkDxzekNUYgWsuSmja8TOxbwl+shS87fb2nT
         eqnA==
X-Gm-Message-State: APzg51BGf4cjsAhSUaEvEkOYU5Dd+XJ7zrJepedXp3z5fOXRRbuXJIaT
        flTjlW1nOZAaIbJwq1NIJEoghw==
X-Google-Smtp-Source: ANB0VdZYiSkm0OwSZ3HP72Z0LA/F0a2kGSuL17hQin6XgMkzVmrxMa5TN5qxTrI3RFqbX5M3Zfbg1Q==
X-Received: by 2002:a50:954f:: with SMTP id v15-v6mr30625703eda.286.1535961167285;
        Mon, 03 Sep 2018 00:52:47 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id b9-v6sm9128923edk.62.2018.09.03.00.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 00:52:46 -0700 (PDT)
Date:   Mon, 3 Sep 2018 09:52:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexdeucher@gmail.com>,
        amd-gfx@lists.freedesktop.org, David Zhou <David1.Zhou@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] gpu: drm: drm_mm: Fix a sleep-in-atomic-context bug in
 show_leaks()
Message-ID: <20180903075244.GE21634@phenom.ffwll.local>
Mail-Followup-To: Chris Wilson <chris@chris-wilson.co.uk>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org,
        David Zhou <David1.Zhou@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
References: <20180901122041.2357-1-baijiaju1990@gmail.com>
 <153580517420.12034.2035309606925619207@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153580517420.12034.2035309606925619207@skylake-alporthouse-com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 01:32:54PM +0100, Chris Wilson wrote:
> Quoting Jia-Ju Bai (2018-09-01 13:20:41)
> > The driver may sleep with holding a spinlock.
> > 
> > The function call paths (from bottom to top) in Linux-4.16 are:
> > 
> > [FUNC] kmalloc(GFP_KERNEL)
> > drivers/gpu/drm/drm_mm.c, 130: 
> >         kmalloc in show_leaks
> > drivers/gpu/drm/drm_mm.c, 913: 
> >         show_leaks in drm_mm_takedown
> > drivers/gpu/drm/drm_vma_manager.c, 107: 
> >         drm_mm_takedown in drm_vma_offset_manager_destroy
> > drivers/gpu/drm/drm_vma_manager.c, 106: 
> >         _raw_write_lock in drm_vma_offset_manager_destroy
> > 
> > [FUNC] kmalloc(GFP_KERNEL)
> > drivers/gpu/drm/drm_mm.c, 130: 
> >         kmalloc in show_leaks
> > drivers/gpu/drm/drm_mm.c, 913: 
> >         show_leaks in drm_mm_takedown
> > drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c, 71: 
> >         drm_mm_takedown in amdgpu_vram_mgr_fini
> > drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c, 70: 
> >         spin_lock in amdgpu_vram_mgr_fini
> > 
> > [FUNC] kmalloc(GFP_KERNEL)
> > drivers/gpu/drm/drm_mm.c, 130: 
> >         kmalloc in show_leaks
> > drivers/gpu/drm/drm_mm.c, 913: 
> >         show_leaks in drm_mm_takedown
> > drivers/gpu/drm/ttm/ttm_bo_manager.c, 128: 
> >         drm_mm_takedown in ttm_bo_man_takedown
> > drivers/gpu/drm/ttm/ttm_bo_manager.c, 126: 
> >         spin_lock in ttm_bo_man_takedown
> > 
> > To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
> 
> The bug are above, since those spinlocks do not protect the data and
> imply use-after-free.

Adding amdgpu, since that's where the bug seems to be.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
