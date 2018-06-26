Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFDEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3B3269AE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3B3269AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932771AbeFZR3K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:29:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50082 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932340AbeFZR3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:29:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1D727A9;
        Tue, 26 Jun 2018 10:29:07 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.cambridge.arm.com [10.1.206.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA7C73F5AD;
        Tue, 26 Jun 2018 10:29:03 -0700 (PDT)
Date:   Tue, 26 Jun 2018 18:29:01 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
Message-ID: <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Tue, Jun 26, 2018 at 02:47:50PM +0200, Andrey Konovalov wrote:
> On Wed, Jun 20, 2018 at 5:24 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> > arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> > tags into the top byte of each pointer. Userspace programs (such as
> > HWASan, a memory debugging tool [1]) might use this feature and pass
> > tagged user pointers to the kernel through syscalls or other interfaces.
> >
> > This patch makes a few of the kernel interfaces accept tagged user
> > pointers. The kernel is already able to handle user faults with tagged
> > pointers and has the untagged_addr macro, which this patchset reuses.
> >
> > We're not trying to cover all possible ways the kernel accepts user
> > pointers in one patchset, so this one should be considered as a start.
> >
> > Thanks!
> >
> > [1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html
> 
> Is there anything I should do to move forward with this?
> 
> I've received zero replies to this patch set (v3 and v4) over the last
> month.

The patches in this series look fine but my concern is that they are not
sufficient and we don't have (yet?) a way to identify where such
annotations are required. You even say in patch 6 that this is "some
initial work for supporting non-zero address tags passed to the kernel".
Unfortunately, merging (or relaxing) an ABI without a clear picture is
not really feasible.

While I support this work, as a maintainer I'd like to understand
whether we'd be in a continuous chase of ABI breaks with every kernel
release or we have a better way to identify potential issues. Is there
any way to statically analyse conversions from __user ptr to long for
example? Or, could we get the compiler to do this for us?

Thanks.

-- 
Catalin
