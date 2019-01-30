Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39B0C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866CD2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbfA3SWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:22:02 -0500
Received: from foss.arm.com ([217.140.101.70]:59700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732830AbfA3SWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:22:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29B0380D;
        Wed, 30 Jan 2019 10:22:01 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A6743F557;
        Wed, 30 Jan 2019 10:21:59 -0800 (PST)
Date:   Wed, 30 Jan 2019 18:21:57 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Jann Horn <jannh@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ARM64 suggestion: reduce the compat address limit (currently
 0x100000000)?
Message-ID: <20190130182157.GP18558@fuggles.cambridge.arm.com>
References: <CAG48ez0QRmU9fGV3x7nceGqBGADNTb66MnG4PW_xu+xnGUqg=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0QRmU9fGV3x7nceGqBGADNTb66MnG4PW_xu+xnGUqg=g@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jann,

On Wed, Jan 30, 2019 at 05:32:00PM +0100, Jann Horn wrote:
> At the moment, compat tasks running on ARM64 can allocate memory up to
> 0x100000000 (TASK_SIZE_32). Testing on an Android device (with an
> admittedly somewhat old kernel):

[...]

> ffff1000-100000000 rw-p 00000000 00:00 0
> 
> This means that mmap() allocations do not adhere to section 6.5.8 of
> C99 ("If the
> expression P points to an element of an array object and the
> expression Q points to the
> last element of the same array object, the pointer expression Q+1
> compares greater than
> P.") if you treat mmap() allocations as returning an array.

Oh, good point.

> In practice, I've also seen code that does things like computing a
> pointer that is out of bounds by a few bytes and then comparing it
> against the end of the array; while this is UB according to C99, it
> probably makes sense to try to avoid breaking such code.

Agreed, and since the current behaviour isn't something you can portably
rely on anyway, I think we're ok to change it.

> X86-64's compat code uses the limit 0xFFFFe000 (IA32_PAGE_OFFSET),
> which I think makes more sense. Would it make sense to do something
> like the following (untested)?

Can't we just go with 0x100000000 - PAGE_SIZE instead?

Will
