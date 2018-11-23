Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D32C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7691F20659
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7691F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503647AbeKWV6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:58:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:53110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409552AbeKWV6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:58:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4CE5BAD93;
        Fri, 23 Nov 2018 11:14:29 +0000 (UTC)
Date:   Fri, 23 Nov 2018 12:14:28 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20181123111428.GF8625@dhcp22.suse.cz>
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
 <20181122165106.18238-2-daniel.vetter@ffwll.ch>
 <154290561362.11623.15299444358726283678@skylake-alporthouse-com>
 <20181123084934.GI4266@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123084934.GI4266@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-11-18 09:49:34, Daniel Vetter wrote:
> On Thu, Nov 22, 2018 at 04:53:34PM +0000, Chris Wilson wrote:
> > Quoting Daniel Vetter (2018-11-22 16:51:04)
> > > Just a bit of paranoia, since if we start pushing this deep into
> > > callchains it's hard to spot all places where an mmu notifier
> > > implementation might fail when it's not allowed to.
> > 
> > Most callers could handle the failure correctly. It looks like the
> > failure was not propagated for convenience.
> 
> I have no idea whether the mm is semantically ok if pte shootdown doesn't
> work for all sorts of strange reasons. From the commit that introduced the
> error code it souded like this was very much only ok in the limited case
> of an already killed process, in the oom killer path, where it's really
> only about trying to free any kind of memory. And where the process is
> gone already, so semantics of what exactly happens don't matter that much
> anymore.

Yes this was indeed the case. There is still the exit path which would
do the rest of the work so we are not leaving anything behind. 
-- 
Michal Hocko
SUSE Labs
