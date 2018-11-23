Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FB0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A88020861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ei7C5H2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A88020861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408714AbeKWT3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:29:31 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46432 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbeKWT3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:29:30 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so9585886edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 00:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IBP6iEknUlAOXESiCbGWYm0QlmXrwyi87gOMXGlU0gs=;
        b=Ei7C5H2bObNTb6kUHTFPLl5YV0nGRkKFnGkMQjeD4L8Nas79EsF5QErhuHXaZNnhDx
         2ZD8CKZmSINS9DnDJcPmQ25wSf2hrhUWJCTzfE+E+x5thCK323CTsl2wYO0+BC4oLCiZ
         K+bXHwfIlCr7/BzcVWmBfXLiE+L/0iTQS2qHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IBP6iEknUlAOXESiCbGWYm0QlmXrwyi87gOMXGlU0gs=;
        b=MBPw4/HPI8gm8fBkkBhl12Dxv4CqyJ1oD4qQiqTIoAyoXKgbDLAbb2XJxFHktD3IZi
         MEk2hNpO5WdlHVsrQjrU+7TLyQqOnPdZG3pZlpULfU4GahCgB8jw25KjKslHApo4zVzg
         qdkO4lq5hMY7JDWqIn/Xp/DbqGnP3Jm5Q5tql2ZyJSbCJlFWmCsftMfJKZtjEYpvyxcZ
         hPyChLJJJcnuUwCOOXeD8TrtH/a54HRsWFn8O5Tw/WKm/rtUVMWd1hCHusQ26zETABnb
         KG+urvgVAtqqQZq/QAaurlxZF+nIC7JEDohtP7TcaZLKItALF3kOoz1+zlUuMB8X4vPx
         9B4Q==
X-Gm-Message-State: AA+aEWb5/rjtHgIABZE7Bi1Eyl+ImAHCH8QGc+4PedJJzjR9QsriAKQi
        WVCT0bQXNyUSTX7c6JBFo7KVhw==
X-Google-Smtp-Source: AFSGD/WAOo4bnjvhupV8E/szDlA46H3pqy1HzNBRLK3EYnjytbn1fe3at3O6V2a54WgYgPyqIuknuw==
X-Received: by 2002:a50:b4e9:: with SMTP id x38-v6mr12705305edd.220.1542962772284;
        Fri, 23 Nov 2018 00:46:12 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a11sm10530462edc.28.2018.11.23.00.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 00:46:11 -0800 (PST)
Date:   Fri, 23 Nov 2018 09:46:09 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/3] mm, notifier: Catch sleeping/blocking for !blockable
Message-ID: <20181123084609.GH4266@phenom.ffwll.local>
Mail-Followup-To: "Koenig, Christian" <Christian.Koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
 <20181122165106.18238-3-daniel.vetter@ffwll.ch>
 <f9c39a9a-5afd-4aed-c9ad-0c3fef34a449@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9c39a9a-5afd-4aed-c9ad-0c3fef34a449@amd.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 06:55:17PM +0000, Koenig, Christian wrote:
> Am 22.11.18 um 17:51 schrieb Daniel Vetter:
> > We need to make sure implementations don't cheat and don't have a
> > possible schedule/blocking point deeply burried where review can't
> > catch it.
> >
> > I'm not sure whether this is the best way to make sure all the
> > might_sleep() callsites trigger, and it's a bit ugly in the code flow.
> > But it gets the job done.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: "Jérôme Glisse" <jglisse@redhat.com>
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> >   mm/mmu_notifier.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> > index 59e102589a25..4d282cfb296e 100644
> > --- a/mm/mmu_notifier.c
> > +++ b/mm/mmu_notifier.c
> > @@ -185,7 +185,13 @@ int __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
> >   	id = srcu_read_lock(&srcu);
> >   	hlist_for_each_entry_rcu(mn, &mm->mmu_notifier_mm->list, hlist) {
> >   		if (mn->ops->invalidate_range_start) {
> > -			int _ret = mn->ops->invalidate_range_start(mn, mm, start, end, blockable);
> > +			int _ret;
> > +
> > +			if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP) && !blockable)
> > +				preempt_disable();
> > +			_ret = mn->ops->invalidate_range_start(mn, mm, start, end, blockable);
> > +			if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP) && !blockable)
> > +				preempt_enable();
> 
> Just for the sake of better documenting this how about adding this to 
> include/linux/kernel.h right next to might_sleep():
> 
> #define disallow_sleeping_if(cond)    for((cond) ? preempt_disable() : 
> (void)0; (cond); preempt_disable())
> 
> (Just from the back of my head, might contain peanuts and/or hints of 
> errors).

I think these magic for blocks aren't used in the kernel. goto breaks
them, and we use goto a lot. I think a disallow/allow_sleep() pair with
the conditional preept_disable/enable() calls would be nice though. I can
do that if the overall idea sticks.
-Daniel

> 
> Christian.
> 
> >   			if (_ret) {
> >   				pr_info("%pS callback failed with %d in %sblockable context.\n",
> >   						mn->ops->invalidate_range_start, _ret,
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
