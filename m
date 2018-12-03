Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D267C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2A7206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2A7206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeLCN4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:56:33 -0500
Received: from foss.arm.com ([217.140.101.70]:37836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeLCN4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:56:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A73361682;
        Mon,  3 Dec 2018 05:55:25 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 009853F614;
        Mon,  3 Dec 2018 05:55:23 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com, hpa@zytor.com,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v2 0/2] uaccess: Add unsafe accessors for arm64
Date:   Mon,  3 Dec 2018 13:55:16 +0000
Message-Id: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
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

* Patch 1 clarifies this restriction in the API and attempts to check
  against violations of the restriction.
* Patch 2 implements the unsafe accessors for arm64

Changes since v1:
- Add a way to detect code calling schedule within a user_access region
- Make sure put_user/get_user arguments are evaluated before disabling PAN

[1] https://www.spinics.net/lists/arm-kernel/msg674925.html
[2] https://patchwork.kernel.org/patch/10634783/
[3] https://lkml.org/lkml/2018/11/28/50

Cheers,

Julien

-->

Julien Thierry (2):
  uaccess: Check no rescheduling function is called in unsafe region
  arm64: uaccess: Implement unsafe accessors

 arch/arm64/include/asm/sysreg.h  |  2 +
 arch/arm64/include/asm/uaccess.h | 89 +++++++++++++++++++++++++++++++---------
 include/linux/kernel.h           |  6 ++-
 include/linux/uaccess.h          | 11 +++++
 kernel/sched/core.c              | 19 +++++++++
 5 files changed, 105 insertions(+), 22 deletions(-)

--
1.9.1
