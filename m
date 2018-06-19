Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4D9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A46E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A46E20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937875AbeFSMwm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:52:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49280 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937814AbeFSMwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:52:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10D3080D;
        Tue, 19 Jun 2018 05:52:40 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6F093F557;
        Tue, 19 Jun 2018 05:52:39 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7BB071AE35A5; Tue, 19 Jun 2018 13:53:15 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        yamada.masahiro@socionext.com, Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCH v2 0/9] Rewrite asm-generic/bitops/{atomic,lock}.h and use on arm64
Date:   Tue, 19 Jun 2018 13:53:05 +0100
Message-Id: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a resend of the patches I previously sent here:

  RFCv1: https://www.spinics.net/lists/arm-kernel/msg634719.html
  RFCv2: https://www.spinics.net/lists/arm-kernel/msg636875.html
     v1: https://www.spinics.net/lists/arm-kernel/msg655262.html
     v2: https://lkml.org/lkml/2018/6/1/619

The only change is that I have rebased onto v4.18-rc1.

Ingo -- please can you queue this via -tip when you start picking up
patches for 4.19? It doesn't conflict with Mark's atomic API rework.

Thanks,

Will

--->8

Will Deacon (9):
  h8300: Don't include linux/kernel.h in asm/atomic.h
  m68k: Don't use asm-generic/bitops/lock.h
  asm-generic: Move some macros from linux/bitops.h to a new bits.h file
  openrisc: Don't pull in all of linux/bitops.h in asm/cmpxchg.h
  sh: Don't pull in all of linux/bitops.h in asm/cmpxchg-xchg.h
  asm-generic/bitops/atomic.h: Rewrite using atomic_*
  asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*
  arm64: Replace our atomic/lock bitop implementations with asm-generic
  arm64: bitops: Include <asm-generic/bitops/ext2-atomic-setbit.h>

 arch/arm64/include/asm/bitops.h     |  21 +---
 arch/arm64/lib/Makefile             |   2 +-
 arch/arm64/lib/bitops.S             |  76 ---------------
 arch/h8300/include/asm/atomic.h     |   4 +-
 arch/m68k/include/asm/bitops.h      |   6 +-
 arch/openrisc/include/asm/cmpxchg.h |   3 +-
 arch/sh/include/asm/cmpxchg-xchg.h  |   3 +-
 include/asm-generic/bitops/atomic.h | 188 +++++++-----------------------------
 include/asm-generic/bitops/lock.h   |  68 ++++++++++---
 include/linux/bitops.h              |  22 +----
 include/linux/bits.h                |  26 +++++
 11 files changed, 131 insertions(+), 288 deletions(-)
 delete mode 100644 arch/arm64/lib/bitops.S
 create mode 100644 include/linux/bits.h

-- 
2.1.4

