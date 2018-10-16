Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA083C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB04208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB04208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJPTC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:02:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:35182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbeJPTC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:02:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB6E4AF3F;
        Tue, 16 Oct 2018 11:12:30 +0000 (UTC)
Date:   Tue, 16 Oct 2018 13:12:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] mm: Shuffle initial free memory
Message-ID: <20181016111230.GR18839@dhcp22.suse.cz>
References: <153922180166.838512.8260339805733812034.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153922180696.838512.12621709717839260874.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAGXu5j+PStxYhiJaWM-mt4+WWbS_WAfvyHoyZYD5ndDLN2SY6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+PStxYhiJaWM-mt4+WWbS_WAfvyHoyZYD5ndDLN2SY6w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15-10-18 15:25:47, Kees Cook wrote:
> On Wed, Oct 10, 2018 at 6:36 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > While SLAB_FREELIST_RANDOM reduces the predictability of some local slab
> > caches it leaves vast bulk of memory to be predictably in order
> > allocated. That ordering can be detected by a memory side-cache.
> >
> > The shuffling is done in terms of CONFIG_SHUFFLE_PAGE_ORDER sized free
> > pages where the default CONFIG_SHUFFLE_PAGE_ORDER is MAX_ORDER-1 i.e.
> > 10, 4MB this trades off randomization granularity for time spent
> > shuffling.  MAX_ORDER-1 was chosen to be minimally invasive to the page
> > allocator while still showing memory-side cache behavior improvements,
> > and the expectation that the security implications of finer granularity
> > randomization is mitigated by CONFIG_SLAB_FREELIST_RANDOM.
> 
> Perhaps it would help some of the detractors of this feature to make
> this a runtime choice? Some benchmarks show improvements, some show
> regressions. It could just be up to the admin to turn this on/off
> given their paranoia levels? (i.e. the shuffling could become a no-op
> with a given specific boot param?)

Sure, making this a opt-in is really necessary but it would be even
_better_ to actually evaluate how much security relevance it has as
well. If for nothing else then to allow an educated decision rather than
a fear driven one. And that pretty much involves evaluation on how hard
it is to bypass the randomness. If I am going to pay some overhead I
would like to know how much hardening I get in return, right? Something
completely missing in the current evaluation so far.
-- 
Michal Hocko
SUSE Labs
