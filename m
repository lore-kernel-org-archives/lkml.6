Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AC2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BC920890
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BC920890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754471AbeGBLy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:54:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:53044 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753424AbeGBLy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:54:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0F1CACB0;
        Mon,  2 Jul 2018 11:54:24 +0000 (UTC)
Date:   Mon, 2 Jul 2018 13:54:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [RFC PATCH] mm, oom: distinguish blockable mode for mmu notifiers
Message-ID: <20180702115423.GK19043@dhcp22.suse.cz>
References: <20180622150242.16558-1-mhocko@kernel.org>
 <20180627074421.GF32348@dhcp22.suse.cz>
 <71f4184c-21ea-5af1-eeb6-bf7787614e2d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71f4184c-21ea-5af1-eeb6-bf7787614e2d@amd.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-07-18 11:14:58, Christian König wrote:
> Am 27.06.2018 um 09:44 schrieb Michal Hocko:
> > This is the v2 of RFC based on the feedback I've received so far. The
> > code even compiles as a bonus ;) I haven't runtime tested it yet, mostly
> > because I have no idea how.
> > 
> > Any further feedback is highly appreciated of course.
> 
> That sounds like it should work and at least the amdgpu changes now look
> good to me on first glance.
> 
> Can you split that up further in the usual way? E.g. adding the blockable
> flag in one patch and fixing all implementations of the MMU notifier in
> follow up patches.

But such a code would be broken, no? Ignoring the blockable state will
simply lead to lockups until the fixup parts get applied.
Is the split up really worth it? I was thinking about that but had hard
times to end up with something that would be bisectable. Well, except
for returning -EBUSY until all notifiers are implemented. Which I found
confusing.

> This way I'm pretty sure Felix and I can give an rb on the amdgpu/amdkfd
> changes.

If you are worried to give r-b only for those then this can be done even
for larger patches. Just make your Reviewd-by more specific
R-b: name # For BLA BLA
-- 
Michal Hocko
SUSE Labs
