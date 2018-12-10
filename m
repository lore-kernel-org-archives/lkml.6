Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7BBC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFB0204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFB0204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeLJRun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:50:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59846 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbeLJRum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:50:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B3D0EBD;
        Mon, 10 Dec 2018 09:50:42 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C80323F6A8;
        Mon, 10 Dec 2018 09:50:40 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        anders.roxell@linaro.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, naresh.kamboju@linaro.org,
        peterz@infradead.org, will.deacon@arm.com
Subject: [PATCH 0/2] locking/atomics: fix and improvement
Date:   Mon, 10 Dec 2018 17:50:33 +0000
Message-Id: <20181210175035.45096-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I hope that these atomic scripting patches address your concerns with
the atomics scripting infrastructure. These are based on the tip
locking/core branch, leaving the headers checked-in.

The primary improvement is using a hash to detect when the headers have
been erroneously modified, meaning check-atomics.sh takes ~0.15s, which
I believe should be palatable.

It also turns out that some people are building without coreutils, so
I've picked up Anders' fix for this. Since sha1sum is part of coreutils,
the checks are skipped when this isn't present, on the assumption that
anyone actually sending patches will have a working coreutils.

Are you happy to pick these up?

Thanks,
Mark.

Anders Roxell (1):
  locking/atomics: Change 'fold' to 'grep'

Mark Rutland (1):
  locking/atomics: Check atomic headers with sha1sum

 include/asm-generic/atomic-instrumented.h |  1 +
 include/asm-generic/atomic-long.h         |  1 +
 include/linux/atomic-fallback.h           |  1 +
 scripts/atomic/atomic-tbl.sh              |  2 +-
 scripts/atomic/check-atomics.sh           | 26 ++++++++++++++++++++------
 scripts/atomic/gen-atomics.sh             | 20 ++++++++++++++++++++
 6 files changed, 44 insertions(+), 7 deletions(-)
 create mode 100755 scripts/atomic/gen-atomics.sh

-- 
2.11.0

