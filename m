Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B431C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87BE2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87BE2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbeGYO5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:57:03 -0400
Received: from foss.arm.com ([217.140.101.70]:39022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbeGYO5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:57:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DF2B15A2;
        Wed, 25 Jul 2018 06:45:17 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5044A3F6A8;
        Wed, 25 Jul 2018 06:45:17 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 48CDA1AE0851; Wed, 25 Jul 2018 14:45:17 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linux@dominikbrodowski.net, ebiederm@xmission.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        oleg@redhat.com, steve.mcintyre@arm.com, dave.martin@arm.com,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/2] Don't use SIGMINSTKSZ when enforcing alternative signal stack size for compat tasks
Date:   Wed, 25 Jul 2018 14:45:10 +0100
Message-Id: <1532526312-26993-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The Debian folks have observed a failure in the 32-bit arm glibc testsuite
when running under a 64-bit kernel. They tracked this down to sigaltstack(2)
enforcing the alternative signal stack to be at least SIGMINSTKSZ bytes,
which is higher for native arm64 tasks than compat 32-bit tasks.

These patches resolve the issue by allowing an architecture to define
COMPAT_SIGMINSTKSZ for compat tasks, which is then used by the sigaltstack
checking code.

Feedback welcome,

Will

--->8

Will Deacon (2):
  signal: Introduce COMPAT_SIGMINSTKSZ for use in compat_sys_sigaltstack
  arm64: compat: Provide definition for COMPAT_SIGMINSTKSZ

 arch/arm64/include/asm/compat.h |  1 +
 include/linux/compat.h          |  3 +++
 kernel/signal.c                 | 14 +++++++++-----
 3 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.1.4

