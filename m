Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9C2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3991D20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="c/zY8oCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3991D20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437447AbeKWBKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:10:46 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42806 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388795AbeKWBKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:10:45 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so7862389edp.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9NNs2bPnIF0J9e1VjXBtE16QDMcausS9Z9XExmE1C6s=;
        b=c/zY8oCCrXQzifH44p6KAW42GU0zr3HtF8oTt7JajzVEDJp0n+JW70wHPb1kgfw0nS
         KFD69R8BcGE7eGNAExW/EgM8/Gdc3LnUHHqpeE8YQvcYUENLDcZNxjF+xEowUpbsHYpz
         UuG5CDew4D29+NpuhNqEWXt7u8BCWLnLGBqHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9NNs2bPnIF0J9e1VjXBtE16QDMcausS9Z9XExmE1C6s=;
        b=rzQ2Bp1OzST3I8beNCDskVcTrVbejoi3VfryYEGBIH0kL6qx/p/7FoklAo+EH8mEek
         Da/SNmIlYjtwo9NUdpFVNjo3EjG0hhwmReEVrjxBjyhXWjCwsGLjY4y7YkAXRleQuxLb
         JLTL6re6/3n/Qzqmh6s3jnqmCdeIfRzOvhPinRtsjcmDkL6Mhi12xykyN3uWfoMYcbJ9
         r+aQINjAein4YsSo/Ia4u6hGrB6+O4/lVnz7hAE/aIn9hxem55bjYmKEG2jUuaPWcWR+
         g3PYs6NhpW+1V45bTpgiTjey7tSsiefU/lrOm/iOU2bjUyjhTecoF5wF04Ppl3wypSww
         V0Tg==
X-Gm-Message-State: AA+aEWZXolhIgMnwl5PlXzgi9IYj5jpkv8YL1lUzMFHijg/lHEVFjUOH
        wUZtJEALJ7/NsLTTNljjvC1ycg==
X-Google-Smtp-Source: AFSGD/VlX1Tqfa4UxNkct7uC7mvJHfyMC+XyHejrIU5rfRJAf8thoxPZ0weMxVzNOyfURo21UuyMAg==
X-Received: by 2002:a50:9472:: with SMTP id q47mr9791998eda.251.1542897067267;
        Thu, 22 Nov 2018 06:31:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r46sm1287466edd.18.2018.11.22.06.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 06:31:06 -0800 (PST)
Date:   Thu, 22 Nov 2018 15:31:04 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     jglisse@redhat.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] gpu/i915: use HMM mirror for userptr buffer object.
Message-ID: <20181122143104.GF4266@phenom.ffwll.local>
Mail-Followup-To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        jglisse@redhat.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
References: <20180910005736.5805-1-jglisse@redhat.com>
 <20180910005736.5805-3-jglisse@redhat.com>
 <154289518994.19402.3481838548028068213@jlahtine-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <154289518994.19402.3481838548028068213@jlahtine-desk.ger.corp.intel.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 03:59:50PM +0200, Joonas Lahtinen wrote:
> Hi Jerome,
> 
> Bit late reply, but here goes :)
> 
> We're working quite hard to avoid pinning any pages unless they're in
> the GPU page tables. And when they are in the GPU page tables, they must
> be pinned for whole of that duration, for the reason that our GPUs can
> not take a fault. And to avoid thrashing GPU page tables, we do leave
> objects in page tables with the expectation that smart userspace
> recycles buffers.
> 
> So what I understand of your proposal, it wouldn't really make a
> difference for us in the amount of pinned pages (which I agree,
> we'd love to see going down). When we're unable to take a fault,
> the first use effectively forces us to pin any pages and keep them
> pinned to avoid thrashing GPU page tables.
> 
> So from i915 perspective, it just seems to be mostly an exchange of
> an API to an another for getting the pages. You already mentioned
> the fast path is being worked on, which is an obvious difference.
> But is there some other improvement one would be expecting, beyond
> the page pinning?
> 
> Also, is the requirement for a single non-file-backed VMA in the
> plans of being eliminated or is that inherent restriction of the
> HMM_MIRROR feature? We're currently not imposing such a limitation.

I think a clear plus for HMM would be if this helps us fix the deadlocks
and races we're seeing. But I have no idea whether this gets us any closer
here or not.
-Daniel

> 
> Regards, Joonas
> 
> Quoting jglisse@redhat.com (2018-09-10 03:57:36)
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > This replace existing code that rely on get_user_page() aka GUP with
> > code that now use HMM mirror to mirror a range of virtual address as
> > a buffer object accessible by the GPU. There is no functional changes
> > from userspace point of view.
> > 
> > From kernel point of view we no longer pin pages for userptr buffer
> > object which is a welcome change (i am assuming that everyone dislike
> > page pin as i do).
> > 
> > Another change, from kernel point of view, is that it does no longer
> > have a fast path with get_user_pages_fast() this can eventually added
> > back through HMM.
> > 
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: intel-gfx@lists.freedesktop.org

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
