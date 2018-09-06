Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2213C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634E620659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ViuEr3Zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634E620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbeIGBFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:05:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbeIGBFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VYRxey2F2SF2w6DYxw+ashBEESMxJqIHgALGpyOpbOo=; b=ViuEr3ZkDSPKk1r7AqMin/Sbc9
        hgTucbA8Bt2/IGtGlvvv1Ffys9TnG/sAwqqtXAWxYEQiOtyH1K5Sl0/sQcR2qqiCQ4rudbo9Irvvc
        a9vgGp11WdfZvKuVcG8643ITG8EoUgq0fUeD4N4CBq3IUUCuC60jOf1+gs8dJn906csLUZr52FrN/
        Ro4L3DHIVluyIvFiNVTmXlnpkDBn1epvcVNg8oGX+H0E3O6k1rcHtNB5uGW6M1wZ3ga3ms7fXuEjn
        ughUpwB085H/fKUEIAgDfWyi/iY4YdaDxQPcF4UAQ3IZmuZtyW2hdF9G3wbxN7jWStkzbFoGsVu6o
        GXbv/Dhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fy0sV-0002hq-Rl; Thu, 06 Sep 2018 20:27:48 +0000
Received: by worktop (Postfix, from userid 1000)
        id E93676E0AA9; Thu,  6 Sep 2018 22:27:46 +0200 (CEST)
Date:   Thu, 6 Sep 2018 22:27:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86: use WRITE_ONCE() when setting PTEs
Message-ID: <20180906202746.GD9358@worktop.programming.kicks-ass.net>
References: <20180902181451.80520-1-namit@vmware.com>
 <20180906195731.GE4816@worktop.programming.kicks-ass.net>
 <10030BE1-FE29-4C60-9963-4BE932EF09BA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10030BE1-FE29-4C60-9963-4BE932EF09BA@gmail.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:12:14PM -0700, Nadav Amit wrote:
> at 12:57 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Sun, Sep 02, 2018 at 11:14:50AM -0700, Nadav Amit wrote:
> >> When page-table entries are set, the compiler might optimize their
> >> assignment by using multiple instructions to set the PTE. This might
> >> turn into a security hazard if the user somehow manages to use the
> >> interim PTE. L1TF does not make our lives easier, making even an interim
> >> non-present PTE a security hazard.
> >> 
> >> Using WRITE_ONCE() to set PTEs and friends should prevent this potential
> >> security hazard.
> >> 
> >> I skimmed the differences in the binary with and without this patch. The
> >> differences are (obviously) greater when CONFIG_PARAVIRT=n as more
> >> code optimizations are possible. For better and worse, the impact on the
> >> binary with this patch is pretty small. Skimming the code did not cause
> >> anything to jump out as a security hazard, but it seems that at least
> >> move_soft_dirty_pte() caused set_pte_at() to use multiple writes.
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Also, its corollary would also make sense/be required, use READ_ONCE()
> > when reading these.
> 
> I don’t know. This would obviously be much more intrusive. I can add a
> get_pte() and write a Coccinelle script to use it instead of reading the
> PTE, but in most cases, I presume, it would be an overkill.
> 
> The reason for that is that the PTEs are supposed to be accessed while
> holding the page-table lock, and the hardware can only change dirty & access
> bits. I think that any code that assumes that these bits do not change while
> holding the lock is already broken in more ways.

There are lockless readers, but I just checked, mm/gup.c already uses
READ_ONCE(), so that should be fine.
