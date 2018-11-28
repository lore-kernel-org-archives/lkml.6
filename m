Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E105C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C5C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C5C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeK1UZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:25:16 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60228 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbeK1UZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:25:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24B7A35E4;
        Wed, 28 Nov 2018 01:24:18 -0800 (PST)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF5573F5A0;
        Wed, 28 Nov 2018 01:24:16 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:24:10 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [GIT PULL] atomic regeneration (was "[PATCHv2] locking/atomics:
 build atomic headers as required")
Message-ID: <20181128092410.y4ws24brpxce324c@salmiak>
References: <20181128085455.1164-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128085455.1164-1-mark.rutland@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Peter suggested you'd prefer a pull request for the atomic scripting rework, so
hopefully this is sufficient. :)

The rework means that the atomics are now rebuilt as-required. The headers are
built in parallel, along with other early build steps, so this isn't as
noticeable on a reasonably powerful machine. Once the headers are built,
they'll only be regenerated when their dependencies change, and can be cleaned
with a mrproper.

Thanks,
Mark.

The following changes since commit bdf37b4dd35d2517cadc10735cd33022da7df133:

  locking/atomics: Fix out-of-tree build (2018-11-09 09:06:01 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/regenerate

for you to fetch changes up to 12eea59cbedcd46fe8b526a16a7f429c8548187d:

  locking/atomics: build atomic headers as required (2018-11-27 13:25:09 +0000)

----------------------------------------------------------------
Mark Rutland (1):
      locking/atomics: build atomic headers as required

 Kbuild                                    |   18 +-
 Makefile                                  |    8 +-
 arch/arm64/include/asm/atomic.h           |    2 +-
 arch/x86/include/asm/atomic.h             |    2 +-
 include/asm-generic/atomic-instrumented.h | 1787 ----------------------
 include/asm-generic/atomic-long.h         | 1012 -------------
 include/linux/atomic-fallback.h           | 2294 -----------------------------
 include/linux/atomic.h                    |    4 +-
 scripts/Makefile.genheader                |   26 +
 scripts/atomic/check-atomics.sh           |   19 -
 10 files changed, 38 insertions(+), 5134 deletions(-)
 delete mode 100644 include/asm-generic/atomic-instrumented.h
 delete mode 100644 include/asm-generic/atomic-long.h
 delete mode 100644 include/linux/atomic-fallback.h
 create mode 100644 scripts/Makefile.genheader
 delete mode 100755 scripts/atomic/check-atomics.sh
