Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549E5C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C862089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C862089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbeJDAWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:22:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54456 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeJDAWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:22:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 260A180D;
        Wed,  3 Oct 2018 10:33:04 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.emea.arm.com [10.4.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9E193F5B3;
        Wed,  3 Oct 2018 10:32:59 -0700 (PDT)
Date:   Wed, 3 Oct 2018 18:32:57 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Evgeniy Stepanov <eugenis@google.com>
Subject: Re: [PATCH v7 7/8] arm64: update
 Documentation/arm64/tagged-pointers.txt
Message-ID: <20181003173256.GG12998@arrakis.emea.arm.com>
References: <cover.1538485901.git.andreyknvl@google.com>
 <47a464307d4df3c0cb65f88d1fe83f9a741dd74b.1538485901.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a464307d4df3c0cb65f88d1fe83f9a741dd74b.1538485901.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 03:12:42PM +0200, Andrey Konovalov wrote:
> diff --git a/Documentation/arm64/tagged-pointers.txt b/Documentation/arm64/tagged-pointers.txt
> index a25a99e82bb1..ae877d185fdb 100644
> --- a/Documentation/arm64/tagged-pointers.txt
> +++ b/Documentation/arm64/tagged-pointers.txt
> @@ -17,13 +17,21 @@ this byte for application use.
>  Passing tagged addresses to the kernel
>  --------------------------------------
>  
> -All interpretation of userspace memory addresses by the kernel assumes
> -an address tag of 0x00.
> +Some initial work for supporting non-zero address tags passed to the
> +kernel has been done. As of now, the kernel supports tags in:

With my maintainer hat on, the above statement leads me to think this
new ABI is work in progress, so not yet suitable for upstream.

Also, how is user space supposed to know that it can now pass tagged
pointers into the kernel? An ABI change (or relaxation), needs to be
advertised by the kernel, usually via a new HWCAP bit (e.g. HWCAP_TBI).
Once we have a HWCAP bit in place, we need to be pretty clear about
which syscalls can and cannot cope with tagged pointers. The "as of now"
implies potential further relaxation which, again, would need to be
advertised to user in some (additional) way.

> -This includes, but is not limited to, addresses found in:
> +  - user fault addresses

While the kernel currently supports this in some way (by clearing the
tag exception entry, el0_da), the above implies (at least to me) that
sigcontext.fault_address would contain the tagged address. That's not
the case (unless I missed it in your patches).

> - - pointer arguments to system calls, including pointers in structures
> -   passed to system calls,
> +  - pointer arguments (including pointers in structures), which don't
> +    describe virtual memory ranges, passed to system calls

I think we need to be more precise here...

> +All other interpretations of userspace memory addresses by the kernel
> +assume an address tag of 0x00. This includes, but is not limited to,
> +addresses found in:
> +
> + - pointer arguments (including pointers in structures), which describe
> +   virtual memory ranges, passed to memory system calls (mmap, mprotect,
> +   etc.)

...and probably a full list here.

-- 
Catalin
