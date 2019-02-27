Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBB9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8605A218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfB0BF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:05:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55570 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbfB0BF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:05:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3C6480D;
        Tue, 26 Feb 2019 17:05:56 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 100243F5C1;
        Tue, 26 Feb 2019 17:05:56 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2e.com, Andre.Przywara@arm.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v5 00/10] arm64: add system vulnerability sysfs entries
Date:   Tue, 26 Feb 2019 19:05:34 -0600
Message-Id: <20190227010544.597579-1-jeremy.linton@arm.com>
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

v4->v5:
	Revert the changes to remove the CONFIG_EXPERT hidden
	       options, but leave the detection paths building
	       without #ifdef wrappers. Also remove the
	       CONFIG_GENERIC_CPU_VULNERABILITIES #ifdefs
	       as we are 'select'ing the option in the Kconfig.
	       This allows us to keep all three variations of
	       the CONFIG/enable/disable paths without a lot of
	       (CONFIG_X || CONFIG_Y) checks.
	Various bits/pieces moved between the patches in an attempt
		to keep similar features/changes together.

v3->v4:
        Drop the patch which selectivly exports sysfs entries
        Remove the CONFIG_EXPERT hidden options which allowed
               the kernel to be built without the vulnerability
               detection code.
        Pick Marc Z's patches which invert the white/black
               lists for spectrev2 and clean up the firmware
               detection logic.
        Document the existing kpti controls
        Add a nospectre_v2 option to boot time disable the
             mitigation

v2->v3:
        Remove "Unknown" states, replace with further blacklists
               and default vulnerable/not affected states.
        Add the ability for an arch port to selectively export
               sysfs vulnerabilities.

v1->v2:
        Add "Unknown" state to ABI/testing docs.
        Minor tweaks.

Jeremy Linton (6):
  arm64: Provide a command line to disable spectre_v2 mitigation
  arm64: add sysfs vulnerability show for meltdown
  arm64: Always enable spectrev2 vulnerability detection
  arm64: add sysfs vulnerability show for spectre v2
  arm64: Always enable ssb vulnerability detection
  arm64: add sysfs vulnerability show for speculative store bypass

Marc Zyngier (2):
  arm64: Advertise mitigation of Spectre-v2, or lack thereof
  arm64: Use firmware to detect CPUs that are not affected by Spectre-v2

Mian Yousaf Kaukab (2):
  arm64: add sysfs vulnerability show for spectre v1
  arm64: enable generic CPU vulnerabilites support

 .../admin-guide/kernel-parameters.txt         |   8 +-
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/include/asm/cpufeature.h           |   4 -
 arch/arm64/kernel/cpu_errata.c                | 239 +++++++++++++-----
 arch/arm64/kernel/cpufeature.c                |  47 +++-
 5 files changed, 216 insertions(+), 83 deletions(-)

-- 
2.20.1

