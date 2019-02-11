Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEF5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151F021773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfBKQbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:31:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:49284 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfBKQbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:31:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 08:31:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="117019570"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga008.jf.intel.com with ESMTP; 11 Feb 2019 08:31:34 -0800
Message-ID: <869a170e9232ffbc8ddbcf3d15535e8c6daedbde.camel@linux.intel.com>
Subject: Re: [RFC PATCH 3/4] kvm: Add guest side support for free memory
 hints
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rkrcmar@redhat.com, x86@kernel.org,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, pbonzini@redhat.com,
        tglx@linutronix.de, akpm@linux-foundation.org
Date:   Mon, 11 Feb 2019 08:31:34 -0800
In-Reply-To: <20190209194437-mutt-send-email-mst@kernel.org>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
         <20190204181552.12095.46287.stgit@localhost.localdomain>
         <20190209194437-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-02-09 at 19:49 -0500, Michael S. Tsirkin wrote:
> On Mon, Feb 04, 2019 at 10:15:52AM -0800, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > 
> > Add guest support for providing free memory hints to the KVM hypervisor for
> > freed pages huge TLB size or larger. I am restricting the size to
> > huge TLB order and larger because the hypercalls are too expensive to be
> > performing one per 4K page.
> 
> Even 2M pages start to get expensive with a TB guest.

Agreed.

> Really it seems we want a virtio ring so we can pass a batch of these.
> E.g. 256 entries, 2M each - that's more like it.

The only issue I see with doing that is that we then have to defer the
freeing. Doing that is going to introduce issues in the guest as we are
going to have pages going unused for some period of time while we wait
for the hint to complete, and we cannot just pull said pages back. I'm
not really a fan of the asynchronous nature of Nitesh's patches for
this reason.

> > Using the huge TLB order became the obvious
> > choice for the order to use as it allows us to avoid fragmentation of higher
> > order memory on the host.
> > 
> > I have limited the functionality so that it doesn't work when page
> > poisoning is enabled. I did this because a write to the page after doing an
> > MADV_DONTNEED would effectively negate the hint, so it would be wasting
> > cycles to do so.
> 
> Again that's leaking host implementation detail into guest interface.
> 
> We are giving guest page hints to host that makes sense,
> weird interactions with other features due to host
> implementation details should be handled by host.

I don't view this as a host implementation detail, this is guest
feature making use of all pages for debugging. If we are placing poison
values in the page then I wouldn't consider them an unused page, it is
being actively used to store the poison value. If we can achieve this
and free the page back to the host then even better, but until the
features can coexist we should not use the page hinting while page
poisoning is enabled.

This is one of the reasons why I was opposed to just disabling page
poisoning when this feature was enabled in Nitesh's patches. If the
guest has page poisoning enabled it is doing something with the page.
It shouldn't be prevented from doing that because the host wants to
have the option to free the pages.

