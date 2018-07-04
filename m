Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550EEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C81021532
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C81021532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbeGDPXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:23:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39272 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753021AbeGDPXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:23:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F3E018A;
        Wed,  4 Jul 2018 08:23:42 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 70AB93F5AD;
        Wed,  4 Jul 2018 08:23:42 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 68C081AE189D; Wed,  4 Jul 2018 16:24:22 +0100 (BST)
Date:   Wed, 4 Jul 2018 16:24:22 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCHv2 11/11] arm64: use instrumented atomics
Message-ID: <20180704152422.GK4828@arm.com>
References: <20180625105952.3756-1-mark.rutland@arm.com>
 <20180625105952.3756-12-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625105952.3756-12-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:59:52AM +0100, Mark Rutland wrote:
> Now that the generic atomic headers provide instrumented wrappers of all
> the atomics implemented by arm64, let's migrate arm64 over to these.
> 
> The additional instrumentation will help to find bugs (e.g. when fuzzing
> with Syzkaller).
> 
> Mostly this change involes adding an arch_ prefix to a number of
> function names and macro definitions. Due to the way we call the LL/SC
> atomics via the LSE atomic wrappers, this requires adding an arch_
> prefix to some arm64-specific atomic primitives.
> 
> Some unusual whitespace in the cmpxchg wrappers is fixed up as part of
> the change.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/atomic.h      | 237 ++++++++++++++++++-----------------
>  arch/arm64/include/asm/atomic_lse.h  |  51 ++++----
>  arch/arm64/include/asm/cmpxchg.h     | 106 ++++++++--------
>  arch/arm64/include/asm/lse.h         |   2 +-
>  arch/arm64/include/asm/sync_bitops.h |  16 +--
>  5 files changed, 212 insertions(+), 200 deletions(-)

This is mostly straightforward, but the cmpxchg/cmpxchg_double cases grow
an 'arch' prefix which suggests that they're part of the API with the core
atomics and also makes them horribly ugly. This just looks to be an artifact
of __LL_SC_CALL pasting that in. Can you drop that auto pasting of 'arch',
and instead change the non-cmpxchg-case callers of the macro to include the
arch prefix instead, please?

Will
