Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D484C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDEB20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbfAON6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:58:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51624 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfAON6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:58:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F6CFA78;
        Tue, 15 Jan 2019 05:58:37 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99E083F70D;
        Tue, 15 Jan 2019 05:58:35 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com, hpa@zytor.com,
        valentin.schneider@arm.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v3 0/4] uaccess: Add unsafe accessors for arm64
Date:   Tue, 15 Jan 2019 13:58:25 +0000
Message-Id: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First version of this series[1] was briefly in linux-next but had to be
reverted due to a bug where schedule would end up being called while
user_access was active[2].

After clarifications[3], rescheduling while in a user_access region is not
allowed.

* Patches 1 and 2 implement the unsafe accessors for arm64
* Patches 3 and 4 clarify this restriction in the API and attempts to
  check against violations of the restriction.

Changes since v2[4]:
- Rebase on v5.0-rc2
- access_ok() is now done in user_access_begin(), so rework accessors
  so access_ok() is not called in unsafe_get/put_user()
- Split addition of unsafe accessors and the user_access_region check
  into separate patches
- Avoid reading SCTLR_EL1 in user_access_region check
- Add build option for user_access_region checking
- Reword clarifications on unsafe accessors API

Changes since v1[1]:
- Add a way to detect code calling schedule within a user_access region
- Make sure put_user/get_user arguments are evaluated before disabling PAN

[1] https://www.spinics.net/lists/arm-kernel/msg674925.html
[2] https://patchwork.kernel.org/patch/10634783/
[3] https://lkml.org/lkml/2018/11/28/50
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-December/617080.html

Cheers,

Julien

-->

Julien Thierry (4):
  arm64: uaccess: Cleanup get/put_user()
  arm64: uaccess: Implement unsafe accessors
  uaccess: Check no rescheduling function is called in unsafe region
  arm64: uaccess: Implement user_access_region_active

 arch/arm64/include/asm/sysreg.h  |   2 +
 arch/arm64/include/asm/uaccess.h | 123 ++++++++++++++++++++++++++-------------
 include/linux/kernel.h           |  11 +++-
 include/linux/uaccess.h          |  13 +++++
 kernel/sched/core.c              |  22 +++++++
 lib/Kconfig.debug                |   8 +++
 6 files changed, 135 insertions(+), 44 deletions(-)

--
1.9.1
