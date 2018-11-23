Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874F3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A5D20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dXagLtVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A5D20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408731AbeKWTc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:32:57 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46047 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbeKWTc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:32:56 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so9595849edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 00:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QBKPVV0ShgVR63w55Mb7QhxH7Aq7rLQZiK95d74RRXE=;
        b=dXagLtVcnx3O7MV6pkD3pBq1jVK6tWqCMOtpHGetdpuX9iPXXJHXBATYjp8A2LV7pW
         E0q37Idw5MUBFXToeSAtIKuCkpO5Vj+8l8EeGYU0BFGrMBDBGDZoD9b7ML50JJyfsKbT
         GVtIP/XDKGlMLTTLBAcRDHr1wbWGw9uOYgAy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=QBKPVV0ShgVR63w55Mb7QhxH7Aq7rLQZiK95d74RRXE=;
        b=E61EHmQLVoPxKiP+TIgELw/bA9u/cfurhNTISyM8ydvRj+67D50hWlPAIA2qafzvBS
         lhS1fq5QmeLych9lq85TwPCMadwfc1GeJcaee1vu/wmyU5AuOMAk/y/mMr0TLRnsOd3f
         drfluv+7apJidWkhXnaZNNvRKhvLiTVGTRmxq94JLCrg2LWf1JttE6DarKgwcQW+vZmv
         C7c+O1OTu+f06c4vh9b8TbzkKRKlgJkgSbKJFgb2RA4s0ix6zdAVZb/KSY5tnLS3JBmQ
         U0ykP5AK/W3BbHpHYgAkBAZREs09uRzYMhP6m2N/3/Mm/N3uYaqobi8zwyRwjuKOSnIu
         M4Ow==
X-Gm-Message-State: AA+aEWY1mLZQVsDdy36uexwKna03iGdw6JYJXjt6KTWaLCxnfOmc3xXx
        wLSk1SgmTBwDAkyvGmcWWe0LUQ==
X-Google-Smtp-Source: AFSGD/U3a5UfDx2t2wTwmlp8B4YbNopTmfoyLIYaG1uATMqvW1G6rbwZkXz+lkmEWpz60hvciwOt+Q==
X-Received: by 2002:a50:af65:: with SMTP id g92-v6mr12435394edd.274.1542962977683;
        Fri, 23 Nov 2018 00:49:37 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g31sm7271531eda.96.2018.11.23.00.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 00:49:36 -0800 (PST)
Date:   Fri, 23 Nov 2018 09:49:34 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [Intel-gfx] [PATCH 1/3] mm: Check if mmu notifier callbacks are
 allowed to fail
Message-ID: <20181123084934.GI4266@phenom.ffwll.local>
Mail-Followup-To: Chris Wilson <chris@chris-wilson.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
 <20181122165106.18238-2-daniel.vetter@ffwll.ch>
 <154290561362.11623.15299444358726283678@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154290561362.11623.15299444358726283678@skylake-alporthouse-com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 04:53:34PM +0000, Chris Wilson wrote:
> Quoting Daniel Vetter (2018-11-22 16:51:04)
> > Just a bit of paranoia, since if we start pushing this deep into
> > callchains it's hard to spot all places where an mmu notifier
> > implementation might fail when it's not allowed to.
> 
> Most callers could handle the failure correctly. It looks like the
> failure was not propagated for convenience.

I have no idea whether the mm is semantically ok if pte shootdown doesn't
work for all sorts of strange reasons. From the commit that introduced the
error code it souded like this was very much only ok in the limited case
of an already killed process, in the oom killer path, where it's really
only about trying to free any kind of memory. And where the process is
gone already, so semantics of what exactly happens don't matter that much
anymore.

And even if a lot more paths could support some kind of error recovery
(they'd need to restart stuff, at least for your i915 patch to work I
think), as long as we have paths where that's not allowed I think it's
good to catch any bugs where a nonzero errno is errornously returned.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
