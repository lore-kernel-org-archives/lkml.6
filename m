Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2C9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D511217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbeLRMOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:14:12 -0500
Received: from foss.arm.com ([217.140.101.70]:44492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbeLRMOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:14:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E1C980D;
        Tue, 18 Dec 2018 04:14:11 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 943A33F575;
        Tue, 18 Dec 2018 04:14:09 -0800 (PST)
Date:   Tue, 18 Dec 2018 12:14:03 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, kbuild-all@01.org,
        Alan Hayward <alan.hayward@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/3] arm64/sve: Disentangle <uapi/asm/ptrace.h> from
 <uapi/asm/sigcontext.h>
Message-ID: <20181218121307.GA22067@e103592.cambridge.arm.com>
References: <1544556407-19897-4-git-send-email-Dave.Martin@arm.com>
 <201812151729.IIgleZIH%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201812151729.IIgleZIH%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 05:20:29PM +0800, kbuild test robot wrote:
> Hi Dave,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on arm64/for-next/core]
> [also build test WARNING on v4.20-rc6 next-20181214]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Dave-Martin/arm64-sve-UAPI-Disentangle-ptrace-h-from-sigcontext-h/20181214-225154
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: arm64-allmodconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm64 
> 
> All warnings (new ones prefixed by >>):
> 
> >> ./usr/include/asm/sve_context.h:30: found __[us]{8,16,32,64} type without #include <linux/types.h>

Since the new header is not meant to be included directly (and has a
guard to that effect), we don't strictly need to do anything here.

The way to include <asm/sve_context.h> in userspace is via
<asm/sigcontext.h> or <asm/ptrace.h>, both of which include
<linux/types.h> first.


Ironically, the type casts in sve_context.h that necessitate this
#include are probably not needed either.  I misunderstood the C
standard as indicating that if vq is a 16-bit type (which is the case
in some places) then the result of multiplying it by something may be
truncated to 16 bits.  This is not the case: the operands of * are
promoted at least to int first, and int is large enough to hold the
result of these multiplication for all valid vq values.

Removing the cast causes some otherwise __u32 expressions to become
ints (albeit with the same numeric value).

This affects semantics and code generation, so it's probably safest
not to touch these casts now given that they have already been exposed
as UAPI.

We should probably add the #include for cleanliness, but nothing should
break if we don't.

Cheers
---Dave
