Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4421C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E84920675
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfAIXzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:55:49 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53288 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfAIXzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:55:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27E7CA78;
        Wed,  9 Jan 2019 15:55:48 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7F47F3F5AF;
        Wed,  9 Jan 2019 15:55:47 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, linux-kernel@vger.kernel.org,
        ykaukab@suse.de, julien.thierry@arm.com, mlangsdo@redhat.com,
        steven.price@arm.com, stefan.wahren@i2se.com,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 0/7] arm64: add system vulnerability sysfs entries
Date:   Wed,  9 Jan 2019 17:55:37 -0600
Message-Id: <20190109235544.2992426-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm64 machines should be displaying a human readable
vulnerability status to speculative execution attacks in
/sys/devices/system/cpu/vulnerabilities 

This series enables that behavior by providing the expected
functions. Those functions expose the cpu errata and feature
states, as well as whether firmware is responding appropriately
to display the overall machine status. This means that in a
heterogeneous machine we will only claim the machine is mitigated
or safe if we are confident all booted cores are safe or
mitigated.

v2->v3:
	Remove "Unknown" states, replace with further blacklists
	       and default vulnerable/no affected states.
	Add the ability for an arch port to selectively export
	       sysfs vulnerabilities.

v1->v2:
	Add "Unknown" state to ABI/testing docs.
	Minor tweaks.
	
Jeremy Linton (4):
  sysfs/cpu: Allow individual architectures to select vulnerabilities
  arm64: add sysfs vulnerability show for meltdown
  arm64: add sysfs vulnerability show for spectre v2
  arm64: add sysfs vulnerability show for speculative store bypass

Mian Yousaf Kaukab (3):
  arm64: add sysfs vulnerability show for spectre v1
  arm64: kpti: move check for non-vulnerable CPUs to a function
  arm64: enable generic CPU vulnerabilites support

 arch/arm64/Kconfig             |   1 +
 arch/arm64/kernel/cpu_errata.c | 126 +++++++++++++++++++++++++++++++--
 arch/arm64/kernel/cpufeature.c |  45 +++++++++---
 drivers/base/cpu.c             |  19 +++++
 include/linux/cpu.h            |   7 ++
 5 files changed, 185 insertions(+), 13 deletions(-)

-- 
2.17.2

