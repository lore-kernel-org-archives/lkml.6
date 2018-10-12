Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BEDC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C87F2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C87F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbeJLXTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:19:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53538 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbeJLXTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:19:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12B01F;
        Fri, 12 Oct 2018 08:46:29 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D90D93F5BC;
        Fri, 12 Oct 2018 08:46:28 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 57A0F1AE09F2; Fri, 12 Oct 2018 16:46:29 +0100 (BST)
Date:   Fri, 12 Oct 2018 16:46:29 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com
Subject: [GIT PULL] Couple more arm64 fixes for 4.19
Message-ID: <20181012154629.GB11387@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull these two arm64 fixes for 4.19. One of them fixes a nasty
WARN() that has started triggering because we assumed that memory
reservations from firmware would always correspond to regions of the
physical address space that we have mapped as memory. Unfortunately,
some existing device-tree files break this assumption and we need to
continue supporting them. The other fix addresses an issue where a
CHAIN PMU event can be requested as a 32-bit counter via perf, which
makes no sense in isolation since these events are intended to be used
in conjunction with another event when creating a 64-bit counter.

This is summarised in the tag.

Cheers,

Will

--->8

The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to ca2b497253ad01c80061a1f3ee9eb91b5d54a849:

  arm64: perf: Reject stand-alone CHAIN events for PMUv3 (2018-10-12 15:25:17 +0100)

----------------------------------------------------------------
More arm64 fixes

- Reject CHAIN PMU events when they are not part of a 64-bit counter

- Fix WARN_ON_ONCE() that triggers for reserved regions that don't
  correspond to mapped memory

----------------------------------------------------------------
Will Deacon (2):
      arm64: Fix /proc/iomem for reserved but not memory regions
      arm64: perf: Reject stand-alone CHAIN events for PMUv3

 arch/arm64/kernel/perf_event.c |  7 ++++++
 arch/arm64/kernel/setup.c      | 56 ++++++++++++++++++++----------------------
 drivers/perf/arm_pmu.c         |  8 +++++-
 include/linux/perf/arm_pmu.h   |  1 +
 4 files changed, 42 insertions(+), 30 deletions(-)
