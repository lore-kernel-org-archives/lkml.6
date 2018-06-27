Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1488C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904132600A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904132600A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965657AbeF0RSH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:18:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35084 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965051AbeF0RSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:18:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39EBB18A;
        Wed, 27 Jun 2018 10:18:05 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.cambridge.arm.com [10.1.206.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F35983F5C0;
        Wed, 27 Jun 2018 10:18:00 -0700 (PDT)
Date:   Wed, 27 Jun 2018 18:17:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Will Deacon <Will.Deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>, nd <nd@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
Message-ID: <20180627171757.amucnh5znld45cpc@armageddon.cambridge.arm.com>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <0cef1643-a523-98e7-95e2-9ec595137642@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cef1643-a523-98e7-95e2-9ec595137642@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 04:08:09PM +0100, Ramana Radhakrishnan wrote:
> On 27/06/2018 16:05, Andrey Konovalov wrote:
> > On Tue, Jun 26, 2018 at 7:29 PM, Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> >> On Tue, Jun 26, 2018 at 02:47:50PM +0200, Andrey Konovalov wrote:
> >>> On Wed, Jun 20, 2018 at 5:24 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> >>>> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> >>>> tags into the top byte of each pointer. Userspace programs (such as
> >>>> HWASan, a memory debugging tool [1]) might use this feature and pass
> >>>> tagged user pointers to the kernel through syscalls or other interfaces.
> >>>>
> >>>> This patch makes a few of the kernel interfaces accept tagged user
> >>>> pointers. The kernel is already able to handle user faults with tagged
> >>>> pointers and has the untagged_addr macro, which this patchset reuses.
> >>>>
> >>>> We're not trying to cover all possible ways the kernel accepts user
> >>>> pointers in one patchset, so this one should be considered as a start.
> >>>>
> >>>> Thanks!
> >>>>
> >>>> [1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html
> >>>
> >>> Is there anything I should do to move forward with this?
> >>>
> >>> I've received zero replies to this patch set (v3 and v4) over the last
> >>> month.
> >>
> >> The patches in this series look fine but my concern is that they are not
> >> sufficient and we don't have (yet?) a way to identify where such
> >> annotations are required. You even say in patch 6 that this is "some
> >> initial work for supporting non-zero address tags passed to the kernel".
> >> Unfortunately, merging (or relaxing) an ABI without a clear picture is
> >> not really feasible.
> >>
> >> While I support this work, as a maintainer I'd like to understand
> >> whether we'd be in a continuous chase of ABI breaks with every kernel
> >> release or we have a better way to identify potential issues. Is there
> >> any way to statically analyse conversions from __user ptr to long for
> >> example? Or, could we get the compiler to do this for us?
> > 
> > OK, got it, I'll try to figure out a way to find these conversions.
> 
> This sounds like the kind of thing we should be able to get sparse to do
> already, no ? It's been many years since I last looked at it but I
> thought sparse was the tool of choice in the kernel to do this kind of
> checking.

sparse is indeed an option. The current implementation doesn't warn on
an explicit cast from (void __user *) to (unsigned long) since that's a
valid thing in the kernel. I couldn't figure out if there's any other
__attribute__ that could be used to warn of such conversion.

-- 
Catalin
