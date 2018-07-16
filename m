Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8BFECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38222083D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38222083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeGPN6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:58:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:45074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726841AbeGPN6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:58:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18A2FAD4C;
        Mon, 16 Jul 2018 13:30:32 +0000 (UTC)
Date:   Mon, 16 Jul 2018 15:30:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Fix vma_is_anonymous() false-positives
Message-ID: <20180716133028.GQ17280@dhcp22.suse.cz>
References: <20180710134821.84709-1-kirill.shutemov@linux.intel.com>
 <20180710134821.84709-2-kirill.shutemov@linux.intel.com>
 <20180710134858.3506f097104859b533c81bf3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710134858.3506f097104859b533c81bf3@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-07-18 13:48:58, Andrew Morton wrote:
> On Tue, 10 Jul 2018 16:48:20 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> 
> > vma_is_anonymous() relies on ->vm_ops being NULL to detect anonymous
> > VMA. This is unreliable as ->mmap may not set ->vm_ops.
> > 
> > False-positive vma_is_anonymous() may lead to crashes:
> > 
> > ...
> > 
> > This can be fixed by assigning anonymous VMAs own vm_ops and not relying
> > on it being NULL.
> > 
> > If ->mmap() failed to set ->vm_ops, mmap_region() will set it to
> > dummy_vm_ops. This way we will have non-NULL ->vm_ops for all VMAs.
> 
> Is there a smaller, simpler fix which we can use for backporting
> purposes and save the larger rework for development kernels?

Why cannot we simply keep anon vma with null vm_ops and set dummy_vm_ops
for all users who do not initialize it in their mmap callbacks?
Basically have a sanity check&fixup in call_mmap?
-- 
Michal Hocko
SUSE Labs
