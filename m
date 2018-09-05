Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949FBC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7F02075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7F02075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeIETFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:05:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59160 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbeIETFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:05:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9875280D;
        Wed,  5 Sep 2018 07:34:36 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67A343F575;
        Wed,  5 Sep 2018 07:34:36 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id CB7A51AE3546; Wed,  5 Sep 2018 15:34:50 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linux@dominikbrodowski.net, ebiederm@xmission.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        oleg@redhat.com, steve.mcintyre@arm.com, dave.martin@arm.com,
        Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCH 0/2] Don't use SIGMINSTKSZ when enforcing alternative signal stack size for compat tasks
Date:   Wed,  5 Sep 2018 15:34:41 +0100
Message-Id: <1536158083-30166-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a resend of:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593559.html

now based on 4.19-rc2.

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

