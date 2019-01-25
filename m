Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8195BC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B12C218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548401829;
	bh=kiYamaLSuGBcP32tmUPMuRMgE9E4VGPMNK+Mu+YCKMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=np1Ii5CYWgtiQJMhjJxtzxJYFOlh+XksbmjHFSjvSmq7cB6wWugJE5QOpbMEKFWdH
	 aqIHiVkhsLxnG9YHXeXYL2Iy4xub4iYgse0a4mnR4tx8UMWDARyb0Eo7Cg2QBEjAmQ
	 iV3Z4cwjPPl6SWtWwV15EnX7iSuMIwF/vfLrohMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfAYHhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:37:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:42808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726271AbfAYHhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:37:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4689ACD2;
        Fri, 25 Jan 2019 07:37:05 +0000 (UTC)
Date:   Fri, 25 Jan 2019 08:37:04 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     robert shteynfeld <robert.shteynfeld@gmail.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Bob Picco <bob.picco@oracle.com>
Subject: Re: kernel panic due to
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2830bf6f05fb3e05bc4743274b806c821807a684
Message-ID: <20190125073704.GC3560@dhcp22.suse.cz>
References: <CADfvbxqC1+XoSsn0sEDqFE16tN1Pq46-QDAaCu=AXJdZeY3rDQ@mail.gmail.com>
 <CAHk-=wh-1wB_X2MG0vW5e755rWJ5pBN8yyXLo2syOdcMV6qYoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh-1wB_X2MG0vW5e755rWJ5pBN8yyXLo2syOdcMV6qYoQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-01-19 17:48:32, Linus Torvalds wrote:
> [ Just adding a lot of other people to the cc ]
> 
> Robert, could you add a dmesg of a successful boot to that bugzilla,
> or just as an attachement in email to this group of people..
> 
> This looks to be with the Fedora kernel config. Two people reporting
> it, it looks like similar machines.
> 
> I assume it's some odd memory sizing detail that happens to trigger a
> particular case.

Quite possible.

> I absolutely *hate* those "let's lazily clear 'struct page' array"
> patches. They've caused problems before, and I'm not convinced the
> pain has been worth it. Maybe we should revert them (again) and
> promise to never ever take things like that again? Andrew?

The performance numbers were pretty dramatic on the other hand. This was
especially seen for very large NVDIMMs initialization when a userspace
was timing out without these applied.

I am certainly not very happy about regressions which we still do see. I
was worried about that early when reviewing these patches because it is
really hard to find all those weird places which simply happened to work
even when broken before. E.g. unitialized struct pages were simply
with zeroed and that means that they seemed to belong to node zero and
zone DMA and nothing really blown up. With the poisoning in place we
have an explicit VM_BUG_ON and Fedora kernels do enable VM debugging so
those problems are visible.

I still think we should chase after those issue and fix them regardless.
Lazy initialization revert will not solve those problems. It will just
paper over them.
-- 
Michal Hocko
SUSE Labs
