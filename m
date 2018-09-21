Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87952C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFEB21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFEB21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389338AbeIUOaD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:30:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:53236 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbeIUOaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:30:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 01:42:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,284,1534834800"; 
   d="scan'208";a="92491100"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.83])
  by orsmga001.jf.intel.com with SMTP; 21 Sep 2018 01:42:08 -0700
Received: by ubuntu (sSMTP sendmail emulation); Fri, 21 Sep 2018 16:42:06 +0800
Message-ID: <1537519325.19048.0.camel@intel.com>
Subject: Re: [PATCH 3/3] mm: optimise pte dirty/accessed bit setting by
 demand based pte insertion
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
Date:   Fri, 21 Sep 2018 16:42:05 +0800
In-Reply-To: <20180918035337.0727dad0@roar.ozlabs.ibm.com>
References: <20180828112034.30875-1-npiggin@gmail.com>
         <20180828112034.30875-4-npiggin@gmail.com>
         <20180905142951.GA15680@roeck-us.net>
         <20180918035337.0727dad0@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-18 at 03:53 +1000, Nicholas Piggin wrote:
> On Wed, 5 Sep 2018 07:29:51 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > 
> > Hi,
> > 
> > On Tue, Aug 28, 2018 at 09:20:34PM +1000, Nicholas Piggin wrote:
> > > 
> > > Similarly to the previous patch, this tries to optimise
> > > dirty/accessed
> > > bits in ptes to avoid access costs of hardware setting them.
> > > 
> > This patch results in silent nios2 boot failures, silent meaning
> > that
> > the boot stalls.
> Okay I just got back to looking at this. The reason for the hang is
> I think a bug in the nios2 TLB code, but maybe other archs have
> similar
> issues.
> 
> In case of a missing / !present Linux pte, nios2 installs a TLB entry
> with no permissions via its fast TLB exception handler (software TLB
> fill). Then it relies on that causing a TLB permission exception in a
> slower handler that calls handle_mm_fault to set the Linux pte and
> flushes the old TLB. Then the fast exception handler will find the
> new
> Linux pte.
> 
> With this patch, nios2 has a case where handle_mm_fault does not
> flush
> the old TLB, which results in the TLB permission exception
> continually
> being retried.
> 
> What happens now is that fault paths like do_read_fault will install
> a
> Linux pte with the young bit clear and return. That will cause nios2
> to
> fault again but this time go down the bottom of handle_pte_fault and
> to
> the access flags update with the young bit set. The young bit is seen
> to
> be different, so that causes ptep_set_access_flags to do a TLB flush
> and
> that finally allows the fast TLB handler to fire and pick up the new
> Linux pte.
> 
> With this patch, the young bit is set in the first handle_mm_fault,
> so
> the second handle_mm_fault no longer sees the ptes are different and
> does not flush the TLB. The spurious fault handler also does not
> flush
> them unless FAULT_FLAG_WRITE is set.
> 
> What nios2 should do is invalidate the TLB in update_mmu_cache. What
> it
> *really* should do is install the new TLB entry, I have some patches
> to
> make that work in qemu I can submit. But I would like to try getting
> these dirty/accessed bit optimisation in 4.20, so I will send a
> simple
> path to just do the TLB invalidate that could go in Andrew's git
> tree.
> 
> Is that agreeable with the nios2 maintainers?
> 
> Thanks,
> Nick
> 
Hi

Do you have patches to test?

Regards
Ley Foon
