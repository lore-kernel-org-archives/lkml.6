Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68155C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D88216FB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SN3Ftiza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D88216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbeHCSkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:40:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41214 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeHCSkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vqJvmSLvi7nAYcR/wjKk0KgIP5D4tOk69+zSwfsoGeM=; b=SN3FtizaEwn9018rJBofPEFsV
        pGAO1YvOa7vNb2XUsURkIB/Hi6wZM2eG9V2m1wXXEDdkh5iOO8Rq8eP0kHE2Q714lIJIl8VgGUh6H
        HQ5Rcj4JAa5abuXTDZ3vMWm/7j1YydJSnJDGjGMu2oFAWM9XCKtUT7t9CE+d68bugBmsuD/f5FfQW
        6zJUM9/pin/a8Whiu6rdzn4VK2J00WMM95S8N+sgH/xOQfEa5KuTqqR8vJlLJke8LKdS32A33ra+B
        +L6wJxC1PFRisoA/5z8cHtc2jLzPAyJgesGJaAVzd+KbTb9hc+rS/iEXumN+V82PR7Rf6VpXALhRl
        VZhHP0tjg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fldAv-0001qP-Ut; Fri, 03 Aug 2018 16:43:37 +0000
Date:   Fri, 3 Aug 2018 09:43:37 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        linux-kselftest@vger.kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arch@vger.kernel.org, Jacob Bramley <Jacob.Bramley@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
Message-ID: <20180803164337.GB4718@bombadil.infradead.org>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <CAAeHK+wJbbCZd+-X=9oeJgsqQJiq8h+Aagz3SQMPaAzCD+pvFw@mail.gmail.com>
 <CAAeHK+yWF05XoU+0iuJoXAL3cWgdtxbeLoBz169yP12W4LkcQw@mail.gmail.com>
 <20180801174256.5mbyf33eszml4nmu@armageddon.cambridge.arm.com>
 <CAAeHK+zb7vcehuX9=oxLUJVJr1ZcgmRTODQz7wsPy+rJb=3kbQ@mail.gmail.com>
 <CAAeHK+xTxPhfbVTNxcbsx7VdwQ21Bt-vo2ZU1tEM1_JX7uKnng@mail.gmail.com>
 <20180803150945.GC9297@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803150945.GC9297@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 05:09:45PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 03, 2018 at 04:59:18PM +0200, Andrey Konovalov wrote:
> > Started looking at this. When I run sparse with default checks enabled
> > (make C=1) I get countless warnings. Does anybody actually use it?
> 
> Try using a more up-to-date version of sparse.  Odds are you are using
> an old one, there is a newer version in a different branch on kernel.org
> somewhere...

That's not true.  Building the current version of sparse from
git://git.kernel.org/pub/scm/devel/sparse/sparse.git leaves me with a
thousand errors just building the mm/ directory.  A sample:

../mm/filemap.c:2353:21: warning: expression using sizeof(void)
../mm/filemap.c:2618:35: warning: symbol 'generic_file_vm_ops' was not declared. Should it be static?
../include/linux/slab.h:666:13: error: undefined identifier '__builtin_mul_overflow'
../include/linux/slab.h:666:13: warning: call with no type!
../include/linux/rcupdate.h:683:9: warning: context imbalance in 'find_lock_task_mm' - wrong count at exit
../include/linux/sched/mm.h:141:37: warning: dereference of noderef expression
../mm/page_alloc.c:886:1: error: directive in argument list
../include/trace/events/vmscan.h:79:1: warning: cast from restricted gfp_t
../include/trace/events/vmscan.h:196:1: warning: too many warnings (ahem!)
../mm/mmap.c:137:9: warning: cast to non-scalar
../mm/mmap.c:137:9: warning: cast from non-scalar
../mm/page_vma_mapped.c:134:29: warning: Using plain integer as NULL pointer
../include/linux/slab.h:631:13: warning: call with no type!

Basically, nobody is fixing their shit.  The only way that sparse output
is useful is to log the warnings before your changes, log them afterwards
and run diff.  The worst offender (as in: fixing it would remove most of
the warnings) is the new min()/max() macro:

        ra->start = max_t(long, 0, offset - ra->ra_pages / 2);

produces that first warning at line 2353 of filemap.c.  I have no idea if
this is a sparse mistake or something it's genuinely warning us about,
but the sparse warnings are pretty ineffectual because nobody's paying
attention to them.
