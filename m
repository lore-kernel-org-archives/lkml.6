Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12502C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07FD222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546729746;
	bh=9LCgL3b8FPlLq0KBZbOtXNELxfCxMSKnCZb/LTW7Tm8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=P03/9L3nrMraTzYG9H9SyfaF3pInzjuXgkq6auRIgMikjERrl3LlyHkC/HePD9B3x
	 0jgvvwrdqwtN9RepfmQpEijkxpkf2PPxNhpZamDutUcVDLakWl5uHp0shiPZWzg7f3
	 qpY9S9PbJWSHEFc2plZJKU/f2jHqOELyPHeSWUg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfAEXJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 18:09:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:48796 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbfAEXJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 18:09:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2861DAD57;
        Sat,  5 Jan 2019 23:09:04 +0000 (UTC)
Date:   Sun, 6 Jan 2019 00:09:02 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jann Horn <jannh@google.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
In-Reply-To: <CAG48ez2jAp9xkPXQmVXm0PqNrFGscg9BufQRem2UD8FGX-YzPw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1901060001590.16954@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <CAG48ez2jAp9xkPXQmVXm0PqNrFGscg9BufQRem2UD8FGX-YzPw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2019, Jann Horn wrote:

> > Provide vm.mincore_privileged sysctl, which makes it possible to mincore()
> > start returning -EPERM in case it's invoked by a process lacking
> > CAP_SYS_ADMIN.
> >
> > The default behavior stays "mincore() can be used by anybody" in order to
> > be conservative with respect to userspace behavior.
> >
> > [1] https://www.theregister.co.uk/2019/01/05/boffins_beat_page_cache/
> 
> Just checking: I guess /proc/$pid/pagemap (iow, the pagemap_read()
> handler) is less problematic because it only returns data about the
> state of page tables, and doesn't query the address_space? In other
> words, it permits monitoring evictions, but non-intrusively detecting
> that something has been loaded into memory by another process is
> harder?

So I was just about to immediately reply that we don't expose pagemap 
anymore due to rowhammer, but apparently that's not true any more 
(this behavioud was originally introduced by ab676b7d6fbf, but then 
changed via 1c90308e7a77 (and further adjusted for swap entries in 
ab6ecf247a, but I guess that's not all that interesting).

Hmm.

But unless it has been mapped with MAP_POPULATE (whcih is outside the 
attacker's control), there is no guarantee that the mappings would 
actually be there, right?

-- 
Jiri Kosina
SUSE Labs

