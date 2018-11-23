Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F191AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD67120672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD67120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409878AbeKWX2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:28:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:38132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388147AbeKWX2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:28:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 624CCAEC0;
        Fri, 23 Nov 2018 12:43:59 +0000 (UTC)
Date:   Fri, 23 Nov 2018 13:43:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
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
Message-ID: <20181123124358.GJ8625@dhcp22.suse.cz>
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
 <20181122165106.18238-2-daniel.vetter@ffwll.ch>
 <20181123111557.GG8625@dhcp22.suse.cz>
 <20181123123057.GK4266@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123123057.GK4266@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-11-18 13:30:57, Daniel Vetter wrote:
> On Fri, Nov 23, 2018 at 12:15:57PM +0100, Michal Hocko wrote:
> > On Thu 22-11-18 17:51:04, Daniel Vetter wrote:
> > > Just a bit of paranoia, since if we start pushing this deep into
> > > callchains it's hard to spot all places where an mmu notifier
> > > implementation might fail when it's not allowed to.
> > 
> > What does WARN give you more than the existing pr_info? Is really
> > backtrace that interesting?
> 
> Automated tools have to ignore everything at info level (there's too much
> of that). I guess I could do something like
> 
> if (blockable)
> 	pr_warn(...)
> else
> 	pr_info(...)
> 
> WARN() is simply my goto tool for getting something at warning level
> dumped into dmesg. But I think the pr_warn with the callback function
> should be enough indeed.

I wouldn't mind s@pr_info@pr_warn@
 
> If you wonder where all the info level stuff happens that we have to
> ignore: suspend/resume is a primary culprit (fairly important for
> gfx/desktops), but there's a bunch of other places. Even if we ignore
> everything at info and below we still need filters because some drivers
> are a bit too trigger-happy (i915 definitely included I guess, so everyone
> contributes to this problem).

Thanks for the clarification.
-- 
Michal Hocko
SUSE Labs
