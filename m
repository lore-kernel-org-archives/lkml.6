Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8028C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4EE218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfBGTO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:14:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfBGTO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:14:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5112DC070147;
        Thu,  7 Feb 2019 19:14:57 +0000 (UTC)
Received: from redhat.com (ovpn-123-55.rdu2.redhat.com [10.10.123.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id F367518C4D;
        Thu,  7 Feb 2019 19:14:46 +0000 (UTC)
Date:   Thu, 7 Feb 2019 14:14:46 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>, riel@surriel.com,
        david@redhat.com, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][Patch v8 4/7] KVM: Disabling page poisoning to prevent
 corruption
Message-ID: <20190207140243-mutt-send-email-mst@kernel.org>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-5-nitesh@redhat.com>
 <CAKgT0Ud0-A8MmbSFQTd81X5-ezwtsi67qPLa0uC_MUs4r+bxqw@mail.gmail.com>
 <97de9a69-fb19-3e9e-d88d-b5b8219b0d9f@redhat.com>
 <CAKgT0UeY84gRSK4McRDLzBH6eHP14rOKB9snccbYzx4VFChhJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UeY84gRSK4McRDLzBH6eHP14rOKB9snccbYzx4VFChhJQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 07 Feb 2019 19:14:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 10:24:20AM -0800, Alexander Duyck wrote:
> On Thu, Feb 7, 2019 at 9:56 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
> >
> >
> > On 2/7/19 12:23 PM, Alexander Duyck wrote:
> > > On Mon, Feb 4, 2019 at 2:11 PM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
> > >> This patch disables page poisoning if guest page hinting is enabled.
> > >> It is required to avoid possible guest memory corruption errors.
> > >> Page Poisoning is a feature in which the page is filled with a specific
> > >> pattern of (0x00 or 0xaa) after arch_free_page and the same is verified
> > >> before arch_alloc_page to prevent following issues:
> > >>     *information leak from the freed data
> > >>     *use after free bugs
> > >>     *memory corruption
> > >> Selection of the pattern depends on the CONFIG_PAGE_POISONING_ZERO
> > >> Once the guest pages which are supposed to be freed are sent to the
> > >> hypervisor it frees them. After freeing the pages in the global list
> > >> following things may happen:
> > >>     *Hypervisor reallocates the freed memory back to the guest
> > >>     *Hypervisor frees the memory and maps a different physical memory
> > >> In order to prevent any information leak hypervisor before allocating
> > >> memory to the guest fills it with zeroes.
> > >> The issue arises when the pattern used for Page Poisoning is 0xaa while
> > >> the newly allocated page received from the hypervisor by the guest is
> > >> filled with the pattern 0x00. This will result in memory corruption errors.
> > >>
> > >> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> > > This seems kind of backwards to me. Why disable page poisoning instead
> > > of just not hinting about the free pages? There shouldn't be that many
> > > instances when page poisoning is enabled, and when it is it would make
> > > more sense to leave it enabled rather than silently disable it.
> > As I have mentioned in the cover email, I intend to reuse Wei's already
> > merged work.
> >
> > This will enable the guest to communicate the poison value which is in
> > use to the host.
> 
> That is far from being reliable given that you are having to buffer
> the pages for some period of time. I really think it would be better
> to just allow page poisoning to function and when you can support
> applying poison to a newly allocated page then you could look at
> re-enabling it.
> 
> What I am getting at is that those that care about poisoning won't
> likely care about performance and I would lump the memory hinting in
> with other performance features.

It's not just a performance issue.

There is an issue is with the host/guest API. Once host discards pages it
currently always gives you back zero-filled pages.
So guest that looks for the poison using e.g. unpoison_page
will crash unless the poison value is 0.

Idea behind current code is just to let host know:
it can either be more careful with these pages,
or skip them completely.


-- 
MST
