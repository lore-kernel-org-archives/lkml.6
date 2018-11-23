Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97EDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9567A20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WpqmA6fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9567A20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504301AbeKWXPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:15:04 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46450 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504288AbeKWXPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:15:03 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so10094926edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 04:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1i5cJD7dtBPIKUJ1vk1tbF/Vq8rFtrmvcUuxYJfDHKo=;
        b=WpqmA6fq9ypZEqgOHA32IioWamFR+pLfw/q8VAbZhYzZj/nb3BeDnn82na90PfBLqT
         4gP7Zn0Qr2qLGa/j2Zz2YQut6TRFCIfOU5n1TNKxvJVwzTTltmyREUapXdmiCiLRdN5y
         av/Ay+uu40MgsBQKAoDCV1u9uEeXJXJgu4cqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1i5cJD7dtBPIKUJ1vk1tbF/Vq8rFtrmvcUuxYJfDHKo=;
        b=o8LDV20dUBj6CRy6bDT7Tmc+vZ8QAuADKJp4BXLLrl2WagIJiXshlMCcokRknd3KfY
         u2PqTGV2OzblVcTV2kBkUGXF03dr2t2U4ZxRfTEvjul5tu++ctC3+zOe/4kAhsQtgzgv
         7yxRECwJVLbtg4Lj7wVnrDYyNcmgyTBFDuAmi5KgobsCoO9kyWtAS9x+0+NIgYFpj3qf
         3pNuhrndLO3RB8ihg0sA4cDIr5HJQ9SRgWWbulS/CHbQcByu98V9Ff8cjlIKO0DcvxWR
         l3iEiWOYVscUvSmb+qpvDkrRcI+w4mMk2dMtbPFdblCfzcIRxUAGtdqOGacBgABxcxJz
         B85g==
X-Gm-Message-State: AGRZ1gK7sba2P9Pd6CU+HV40hBRmP5SVRh1eJuWR2W4yhJi8kEkO+7GB
        qRyygJI0k9HM2dlccBxtoD13Ww==
X-Google-Smtp-Source: AJdET5cO93AsubCsxW2yEPYBnQBfAqxgpkrQ/C/JWqhWmAsUE5VUwY95cc/qQLrIt8vDHC4XtemPGA==
X-Received: by 2002:a17:906:64cb:: with SMTP id p11-v6mr11494968ejn.181.1542976260719;
        Fri, 23 Nov 2018 04:31:00 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e35sm9195196eda.13.2018.11.23.04.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 04:30:59 -0800 (PST)
Date:   Fri, 23 Nov 2018 13:30:57 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 1/3] mm: Check if mmu notifier callbacks are allowed to
 fail
Message-ID: <20181123123057.GK4266@phenom.ffwll.local>
Mail-Followup-To: Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
 <20181122165106.18238-2-daniel.vetter@ffwll.ch>
 <20181123111557.GG8625@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181123111557.GG8625@dhcp22.suse.cz>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 12:15:57PM +0100, Michal Hocko wrote:
> On Thu 22-11-18 17:51:04, Daniel Vetter wrote:
> > Just a bit of paranoia, since if we start pushing this deep into
> > callchains it's hard to spot all places where an mmu notifier
> > implementation might fail when it's not allowed to.
> 
> What does WARN give you more than the existing pr_info? Is really
> backtrace that interesting?

Automated tools have to ignore everything at info level (there's too much
of that). I guess I could do something like

if (blockable)
	pr_warn(...)
else
	pr_info(...)

WARN() is simply my goto tool for getting something at warning level
dumped into dmesg. But I think the pr_warn with the callback function
should be enough indeed.

If you wonder where all the info level stuff happens that we have to
ignore: suspend/resume is a primary culprit (fairly important for
gfx/desktops), but there's a bunch of other places. Even if we ignore
everything at info and below we still need filters because some drivers
are a bit too trigger-happy (i915 definitely included I guess, so everyone
contributes to this problem).

Cheers, Daniel

> 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: "Jérôme Glisse" <jglisse@redhat.com>
> > Cc: linux-mm@kvack.org
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> >  mm/mmu_notifier.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> > index 5119ff846769..59e102589a25 100644
> > --- a/mm/mmu_notifier.c
> > +++ b/mm/mmu_notifier.c
> > @@ -190,6 +190,8 @@ int __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
> >  				pr_info("%pS callback failed with %d in %sblockable context.\n",
> >  						mn->ops->invalidate_range_start, _ret,
> >  						!blockable ? "non-" : "");
> > +				WARN(blockable,"%pS callback failure not allowed\n",
> > +				     mn->ops->invalidate_range_start);
> >  				ret = _ret;
> >  			}
> >  		}
> > -- 
> > 2.19.1
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
