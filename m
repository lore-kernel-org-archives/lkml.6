Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B06C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE84D23F32
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE84D23F32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeGDWII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 18:08:08 -0400
Received: from foss.arm.com ([217.140.101.70]:43144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752815AbeGDWIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 18:08:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D7E618A;
        Wed,  4 Jul 2018 15:08:07 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B6863F5A0;
        Wed,  4 Jul 2018 15:08:05 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        dave.martin@arm.com
Subject: [PATCH 0/2] arm64: Handle mismatched cache type registers
Date:   Wed,  4 Jul 2018 23:07:44 +0100
Message-Id: <1530742066-16276-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, we detect mismatches in the cache line sizes (exposed
via CTR_EL0) across CPUs and trap userspace accesses to the register
to provide a system wide safe value. We also hotpatch the kernel
to use the safe values for kernel cache operations.

However, with the recent additions of IDC & DIC fields to the CTR,
our checks could detect the mismatch and take all the steps above
with a following message:

"CPU features: enabling workaround for Mismatched cache line size"

which could be confusing even if the cache line sizes match.
Also the kernel doesn't need patching if there is no minline
size mismatch. This series fixes this issue by splitting the
checks to :

 1) Mismatch on D/I minline sizes
 2) Everything "strict" except (1).


Applies on 4.18-rc2

Suzuki K Poulose (2):
  arm64: Fix mismatched cache line size detection
  arm64: Handle mismatched cache type

 arch/arm64/include/asm/cache.h   |  4 ++++
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/kernel/cpu_errata.c   | 23 ++++++++++++++++++-----
 arch/arm64/kernel/cpufeature.c   |  2 +-
 4 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.9.5

