Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006D221B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfBKR6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:58:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfBKR6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:58:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01238369A0;
        Mon, 11 Feb 2019 17:58:17 +0000 (UTC)
Received: from redhat.com (ovpn-120-40.rdu2.redhat.com [10.10.120.40])
        by smtp.corp.redhat.com (Postfix) with SMTP id 64A9E5C21A;
        Mon, 11 Feb 2019 17:58:15 +0000 (UTC)
Date:   Mon, 11 Feb 2019 12:58:14 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rkrcmar@redhat.com, alexander.h.duyck@linux.intel.com,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org
Subject: Re: [RFC PATCH 3/4] kvm: Add guest side support for free memory hints
Message-ID: <20190211124925-mutt-send-email-mst@kernel.org>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
 <20190204181552.12095.46287.stgit@localhost.localdomain>
 <20190209194437-mutt-send-email-mst@kernel.org>
 <0d12ccec-d05f-80b8-9498-710d521c81d2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d12ccec-d05f-80b8-9498-710d521c81d2@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 11 Feb 2019 17:58:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:48:11AM -0800, Dave Hansen wrote:
> On 2/9/19 4:49 PM, Michael S. Tsirkin wrote:
> > On Mon, Feb 04, 2019 at 10:15:52AM -0800, Alexander Duyck wrote:
> >> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>
> >> Add guest support for providing free memory hints to the KVM hypervisor for
> >> freed pages huge TLB size or larger. I am restricting the size to
> >> huge TLB order and larger because the hypercalls are too expensive to be
> >> performing one per 4K page.
> > Even 2M pages start to get expensive with a TB guest.
> 
> Yeah, but we don't allocate and free TB's of memory at a high frequency.
> 
> > Really it seems we want a virtio ring so we can pass a batch of these.
> > E.g. 256 entries, 2M each - that's more like it.
> 
> That only makes sense for a system that's doing high-frequency,
> discontiguous frees of 2M pages.  Right now, a 2M free/realloc cycle
> (THP or hugetlb) is *not* super-high frequency just because of the
> latency for zeroing the page.

Heh but with a ton of free memory, and a thread zeroing some of
it out in the background, will this still be the case?
It could be that we'll be able to find clean pages
at all times.


> A virtio ring seems like an overblown solution to a non-existent problem.

It would be nice to see some traces to help us decide one way or the other.

-- 
MST
