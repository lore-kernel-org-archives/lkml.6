Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97120C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC6D21770
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC6D21770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbeHMMWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:22:37 -0400
Received: from foss.arm.com ([217.140.101.70]:56028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbeHMMWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:22:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A49EF7A9;
        Mon, 13 Aug 2018 02:41:09 -0700 (PDT)
Received: from localhost (e105922-lin.emea.arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24C233F73C;
        Mon, 13 Aug 2018 02:41:09 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Punit Agrawal <punit.agrawal@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com
Subject: [PATCH v2 0/2] KVM: Fix refaulting due to page table update
Date:   Mon, 13 Aug 2018 10:40:47 +0100
Message-Id: <20180813094049.3726-1-punit.agrawal@arm.com>
X-Mailer: git-send-email 2.18.0
X-ARM-No-Footer: FoSSMail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a couple of patches to fix an issue when multiple vcpus fault
on a page table entry[0]. The issue was reported by a user when testing
PUD hugepage support[1] but also exists for PMD and PTE updates though
with a lower probability.

In this version -

* the fix has been split for PMD hugepage and PTE update
* refactored the PMD fix
* applied fixes tag and cc'ing to stable

Thanks,
Punit

[0] https://lkml.org/lkml/2018/8/10/256
[1] https://lkml.org/lkml/2018/7/16/482

Punit Agrawal (2):
  KVM: arm/arm64: Skip updating PMD entry if no change
  KVM: arm/arm64: Skip updating PTE entry if no change

 virt/kvm/arm/mmu.c | 45 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

-- 
2.18.0

