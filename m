Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2E1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38236218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfBKRpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:45:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54870 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbfBKRpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:45:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AE43EBD;
        Mon, 11 Feb 2019 09:45:50 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E22B03F675;
        Mon, 11 Feb 2019 09:45:48 -0800 (PST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andrew.murray@arm.com, arnd@arndb.de,
        catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/2] Ensure inX() is ordered wrt delay() routines
Date:   Mon, 11 Feb 2019 17:45:42 +0000
Message-Id: <20190211174544.4302-1-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Ordering port read accesses against non-memory-mapped clocksource reads can
require funky dependency code in conjunction with memory barriers. This isn't
possible to implement with the asm-generic definition of io.h, since the value
read from the device is not passed through to the underlying barrier macro and
therefore the dependency information is lost.

This series passes the value through and hooks up the fence on arm64.

Will

--->8

Will Deacon (2):
  asm-generic/io: Pass result on inX() accessor to __io_par()
  arm64: io: Hook up __io_par() for inX() ordering

 arch/arm64/include/asm/io.h | 1 +
 include/asm-generic/io.h    | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.11.0

