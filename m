Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F3ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653E920870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653E920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeGPOcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:32:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:41577 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbeGPOcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:32:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 07:04:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,361,1526367600"; 
   d="scan'208";a="73171203"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 16 Jul 2018 07:04:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7C09D12D; Mon, 16 Jul 2018 17:04:41 +0300 (EEST)
Date:   Mon, 16 Jul 2018 17:04:41 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Fix vma_is_anonymous() false-positives
Message-ID: <20180716140440.fd3sjw5xys5wozw7@black.fi.intel.com>
References: <20180710134821.84709-1-kirill.shutemov@linux.intel.com>
 <20180710134821.84709-2-kirill.shutemov@linux.intel.com>
 <20180710134858.3506f097104859b533c81bf3@linux-foundation.org>
 <20180716133028.GQ17280@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716133028.GQ17280@dhcp22.suse.cz>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 01:30:28PM +0000, Michal Hocko wrote:
> On Tue 10-07-18 13:48:58, Andrew Morton wrote:
> > On Tue, 10 Jul 2018 16:48:20 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> > 
> > > vma_is_anonymous() relies on ->vm_ops being NULL to detect anonymous
> > > VMA. This is unreliable as ->mmap may not set ->vm_ops.
> > > 
> > > False-positive vma_is_anonymous() may lead to crashes:
> > > 
> > > ...
> > > 
> > > This can be fixed by assigning anonymous VMAs own vm_ops and not relying
> > > on it being NULL.
> > > 
> > > If ->mmap() failed to set ->vm_ops, mmap_region() will set it to
> > > dummy_vm_ops. This way we will have non-NULL ->vm_ops for all VMAs.
> > 
> > Is there a smaller, simpler fix which we can use for backporting
> > purposes and save the larger rework for development kernels?
> 
> Why cannot we simply keep anon vma with null vm_ops and set dummy_vm_ops
> for all users who do not initialize it in their mmap callbacks?
> Basically have a sanity check&fixup in call_mmap?

As I said, there's a corner case of MAP_PRIVATE of /dev/zero. It has to
produce anonymous VMA, but in map_region() we cannot distinguish it from
broken ->mmap handler.

See my attempt

	6dc296e7df4c ("mm: make sure all file VMAs have ->vm_ops set")

and it's revert

	 28c553d0aa0a ("revert "mm: make sure all file VMAs have ->vm_ops set"")

-- 
 Kirill A. Shutemov
