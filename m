Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3E7C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085A02086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085A02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJIVEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:04:36 -0400
Received: from foss.arm.com ([217.140.101.70]:38196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbeJIVEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:04:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E9B415BE;
        Tue,  9 Oct 2018 06:47:33 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0EBD73F5B7;
        Tue,  9 Oct 2018 06:47:31 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, pelcan@codeaurora.org,
        shankerd@codeaurora.org, suzuki.poulose@arm.com
Subject: [PATCH v2 0/3] arm64: cpufeature: Fix handling of CTR_EL0
Date:   Tue,  9 Oct 2018 14:47:04 +0100
Message-Id: <20181009134707.3479-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009134707.3479-1-suzuki.poulose@arm.com>
References: <20181009134707.3479-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes sure that we handle the CTR_EL0 field mismatches
properly, especially for the IDC field. Also, skip trapping CTR
accesses on a CPU if it matches the safe value.

Applies on arm64 for-next/core.

Changes since v1
 - Fix wrong hunk in has_cache_idc()
 - Allow a late secondary CPU with raw CTR_EL0.IDC = 0 and effective
   CTR_EL0.IDC = 1, to boot on a system without IDC available.

Suzuki K Poulose (3):
  arm64: cpufeature: ctr: Fix cpu capability check for late CPUs
  arm64: cpufeature: Fix handling of CTR_EL0.IDC field
  arm64: cpufeature: Trap CTR_EL0 access only where it is necessary

 arch/arm64/include/asm/cache.h | 40 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c | 34 +++++++++++++++++++++++++----
 arch/arm64/kernel/cpufeature.c | 35 +++++++++++++++++++++++++----
 arch/arm64/kernel/cpuinfo.c    | 10 ++++++++-
 4 files changed, 110 insertions(+), 9 deletions(-)

-- 
2.19.0

