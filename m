Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A75C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CD920851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CD920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeLKWTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:19:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbeLKWTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:19:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCF3BC058CB4;
        Tue, 11 Dec 2018 22:19:39 +0000 (UTC)
Received: from redhat.com (ovpn-124-191.rdu2.redhat.com [10.10.124.191])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 89F3719748;
        Tue, 11 Dec 2018 22:19:37 +0000 (UTC)
Date:   Tue, 11 Dec 2018 17:19:35 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/mmu_notifier: fix mmu_notifier_range_init warning
Message-ID: <20181211221935.GC6478@redhat.com>
References: <20181211200526.3868586-1-arnd@arndb.de>
 <20181211201909.GA6478@redhat.com>
 <alpine.DEB.2.21.1812111310320.87855@chino.kir.corp.google.com>
 <20181211213636.GB6478@redhat.com>
 <alpine.DEB.2.21.1812111341280.97190@chino.kir.corp.google.com>
 <CAK8P3a1yn7RAp7Q29dx5Rcb0mCoDpcHPzxSGqKHdgfJd+=iiNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a1yn7RAp7Q29dx5Rcb0mCoDpcHPzxSGqKHdgfJd+=iiNw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 11 Dec 2018 22:19:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:53:03PM +0100, Arnd Bergmann wrote:
> On Tue, Dec 11, 2018 at 10:43 PM David Rientjes <rientjes@google.com> wrote:
> >
> > On Tue, 11 Dec 2018, Jerome Glisse wrote:
> 
> >
> > Hmm, strange that Arnd's build failure is only reporting about an unused
> > variable instead of MMU_NOTIFY_CLEAR being undefined :/
> >
> > I think this should be done so that anybody using
> > mmu_notifier_range_init() doesn't need to worry about the implications of
> > *any* unused formal parameter as a result of how the #define is formed:
> 
> Your patch below is more or less what I tried at first, and that resulted
> in another build failure for
> 
> mm/hugetlb.c:   mmu_notifier_range_init(&range, mm, start, end,
> MMU_NOTIFY_CLEAR);
> mm/hugetlb.c-   adjust_range_if_pmd_sharing_possible(vma,
> &range.start, &range.end);
> 
> where range.end refers to a nonexisting member of range.
> 
>           Arnd

I will post a v3 with htmldoc fix and build warning fix incorporated.

Cheers,
Jérôme
