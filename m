Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7607C43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6542173B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546597729;
	bh=vvziJ1q8nIFtfmAM5UuVT+CQ0vvJJQH2vg0DM3PcSY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dVnws6zQ54ETSBeZqYqTA3Wdqtn0VGMolU6HLCbQAyMhY4FIcWxd98CTMBHTFkGyN
	 ZZuXlSJt61lRxAnzHVeWsDl+RkrRUt196Fp+FReUKEsAsTMuIfwk/Sf4QOPTnAQkqy
	 TIWU2HoCX2WGRJwfeYaUYzhJ0hlDU6Ij4a1GIfcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfADK2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:28:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:46490 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726749AbfADK2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:28:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F280AE03;
        Fri,  4 Jan 2019 10:28:47 +0000 (UTC)
Date:   Fri, 4 Jan 2019 11:28:46 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/vmalloc: fix size check for
 remap_vmalloc_range_partial()
Message-ID: <20190104102846.GN31793@dhcp22.suse.cz>
References: <20190103145954.16942-1-rpenyaev@suse.de>
 <20190103145954.16942-2-rpenyaev@suse.de>
 <20190103151357.GR31793@dhcp22.suse.cz>
 <dba7cb2c2882e034c8c99b09a432313a@suse.de>
 <20190103194054.GB31793@dhcp22.suse.cz>
 <5502b64d6c508f5432386d2cfe999844@suse.de>
 <20190104093808.GJ31793@dhcp22.suse.cz>
 <4630dd7797fc7934f98c01ea789105a8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4630dd7797fc7934f98c01ea789105a8@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-01-19 11:21:39, Roman Penyaev wrote:
> On 2019-01-04 10:38, Michal Hocko wrote:
> 
> [...]
> 
> > > >
> > > > OK, my response was more confusing than I intended. I meant to say. Is
> > > > there any in kernel code that would allow the bug have had in mind?
> > > > In other words can userspace trick any existing code?
> > > 
> > > In theory any existing caller of remap_vmalloc_range() which does
> > > not have an explicit size check should trigger an oops, e.g. this is
> > > a good candidate:
> > > 
> > > *** drivers/media/usb/stkwebcam/stk-webcam.c:
> > > v4l_stk_mmap[789]              ret = remap_vmalloc_range(vma,
> > > sbuf->buffer,
> > > 0);
> > 
> > Hmm, sbuf->buffer is allocated in stk_setup_siobuf to have
> > buf->v4lbuf.length. mmap callback maps this buffer to the vma size and
> > that is indeed not enforced to be <= length AFAICS. So you are right!
> > 
> > Can we have an example in the changelog please?
> 
> You mean to resend this particular patch with the list of possible
> candidates for oops in a comment message?  Sure thing.

I would just reply to the original patch with an updated changelog
wording (to include the above example and explain how the vma setup is
completely independent on the buffer allocation and ask Andrew to update
the changelog of the patch that is already in the mmotm tree).

Thanks!
-- 
Michal Hocko
SUSE Labs
