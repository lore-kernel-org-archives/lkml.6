Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F20C43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C1920675
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546544459;
	bh=VUmibzLFAQKusNUkDmRjirpcFMoVOfuZi5Kh4EeyLIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TYSBigWf8zTnlY8lBjr7yiEBj7iWghN7gEckK1JS9Ut9BK0u3adBYM39bZ/Lly0f/
	 CUbqJZxcsXbeg1iNuMFSdRLdRcDs8XDXfWIRLAOijH9N19Fmm1t3qZUq/2Ye0PPnY3
	 HsUwIupdIlzRdXSvQuPYrX3FoTeFZQngYtQFlB24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfACTk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:40:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:46344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727032AbfACTk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:40:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E161AC5F;
        Thu,  3 Jan 2019 19:40:56 +0000 (UTC)
Date:   Thu, 3 Jan 2019 20:40:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/vmalloc: fix size check for
 remap_vmalloc_range_partial()
Message-ID: <20190103194054.GB31793@dhcp22.suse.cz>
References: <20190103145954.16942-1-rpenyaev@suse.de>
 <20190103145954.16942-2-rpenyaev@suse.de>
 <20190103151357.GR31793@dhcp22.suse.cz>
 <dba7cb2c2882e034c8c99b09a432313a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dba7cb2c2882e034c8c99b09a432313a@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-01-19 20:27:26, Roman Penyaev wrote:
> On 2019-01-03 16:13, Michal Hocko wrote:
> > On Thu 03-01-19 15:59:52, Roman Penyaev wrote:
> > > area->size can include adjacent guard page but get_vm_area_size()
> > > returns actual size of the area.
> > > 
> > > This fixes possible kernel crash when userspace tries to map area
> > > on 1 page bigger: size check passes but the following
> > > vmalloc_to_page()
> > > returns NULL on last guard (non-existing) page.
> > 
> > Can this actually happen? I am not really familiar with all the callers
> > of this API but VM_NO_GUARD is not really used wildly in the kernel.
> 
> Exactly, by default (VM_NO_GUARD is not set) each area has guard page,
> thus the area->size will be bigger.  The bug is not reproduced if
> VM_NO_GUARD is set.
> 
> > All I can see is kasan na arm64 which doesn't really seem to use it
> > for vmalloc.
> > 
> > So is the problem real or this is a mere cleanup?
> 
> This is the real problem, try this hunk for any file descriptor which
> provides
> mapping, or say modify epoll as example:

OK, my response was more confusing than I intended. I meant to say. Is
there any in kernel code that would allow the bug have had in mind?
In other words can userspace trick any existing code?

-- 
Michal Hocko
SUSE Labs
