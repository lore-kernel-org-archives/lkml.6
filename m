Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D1EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077812083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077812083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeHaOAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:00:47 -0400
Received: from foss.arm.com ([217.140.101.70]:55462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbeHaOAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:00:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A03A218A;
        Fri, 31 Aug 2018 02:54:05 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 71DF43F721;
        Fri, 31 Aug 2018 02:54:05 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 0C3B71AE3614; Fri, 31 Aug 2018 10:54:18 +0100 (BST)
Date:   Fri, 31 Aug 2018 10:54:18 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/12] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
Message-ID: <20180831095417.GF13166@arm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
 <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
 <20180831110054.475a3534@roar.ozlabs.ibm.com>
 <CA+55aFyweLwdAeeLnPv1ceje2y9Qc2AkM+LdMzK_z29fFb96ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyweLwdAeeLnPv1ceje2y9Qc2AkM+LdMzK_z29fFb96ug@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 06:04:12PM -0700, Linus Torvalds wrote:
> On Thu, Aug 30, 2018 at 6:01 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Well it would help if powerpc say wanted to start using them without a
> > merge cycle lag. Not a huge issue because powerpc already does
> > reasonably well here and there's other work that can be done.
> 
> Sure. If somebody wants to send the generic changes I can just take
> them directly to make it easier for people to work on this.

Tell you what: how about I stick the following patches (with Nick's and
Peter's acks) on a separate, stable branch:

  asm-generic/tlb: Track which levels of the page tables have been cleared
  asm-generic/tlb: Track freeing of page-table directories in struct mmu_gather
  asm-generic/tlb: Guard with #ifdef CONFIG_MMU

and then anybody who needs them can just pull that in for the merge window?

Also, how would people feel about adding a MAINTAINERS entry for all the
tlb.h files? A big part of the recent "fun" was us figuring out what the
code is actually doing ("It used to do foo() but that may have changed").
and it certainly took me the best part of a day to figure things out again.
If we're trying to do more in the generic code and less in the arch code,
it would help if we're on top of the changes in this area.

Proposal below (omitted Linus because that seems to be the pattern elsewhere
in the file and he's not going to shout at himself when things break :)
Anybody I've missed?

Will

--->8

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..7224b5618883 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9681,6 +9681,15 @@ S:	Maintained
 F:	arch/arm/boot/dts/mmp*
 F:	arch/arm/mach-mmp/
 
+MMU GATHER AND TLB INVALIDATION
+M:	Will Deacon <will.deacon@arm.com>
+M:	Nick Piggin <npiggin@gmail.com>
+M:	Peter Zijlstra <peterz@infradead.org>
+L:	linux-arch@vger.kernel.org
+S:	Maintained
+F:	include/asm-generic/tlb.h
+F:	arch/*/include/asm/tlb.h
+
 MN88472 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
