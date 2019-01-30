Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A317EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DE32087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D1abGlM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbfA3Qct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:32:49 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:55864 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731857AbfA3Qcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:32:48 -0500
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 3661C10C1BA5;
        Wed, 30 Jan 2019 08:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548865968; bh=V2gRfCZnxmm+k81VFJn/B8RzUM52Kcq6e8esGa6OhfM=;
        h=From:To:Cc:Subject:Date:From;
        b=D1abGlM5LEiYHF5ETcYJ0KTzSCOflkLNuXWyd/w9Ik6hpgEwsFiFpoHNwIpwN96TT
         9kjE6PBt0Wo5e8c6QmLyHBFHCQYqds/mGCBSIRDaOhBY7W38qUTabOG/BIktaDUzbI
         KS7Wa6POf6g+gvlWjXReLHG30mhrevPXszUCR5ZT7BlUpZHnvgPpPpNKUXPOJc6NiW
         3wBPnCt1VUNXrGQXUPiWhEEboKQjiuEzE5FI5ISBTbim6gEHKmZ6WCCCP7qK/EG1np
         6nSxK4kQo5uT6QJX3BaJqfTtvipXrq51WTVPROL9zOj2I1NT6gLUDKOpNJKhIFMDeB
         XJPm/DIsJbKyQ==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.46])
        by mailhost.synopsys.com (Postfix) with ESMTP id C8422A008B;
        Wed, 30 Jan 2019 16:32:46 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH v2 0/5] introduce unaligned access under a Kconfig option
Date:   Wed, 30 Jan 2019 19:32:39 +0300
Message-Id: <20190130163244.10870-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today we enable unaligned access unconditionally on ARCv2.
Lets move it under Kconfig option and use it actively in SW if it is
enabled.

While I'm at it fix and optimise ARCv2 memcpy implementaion.

Changes v1->v2:
 * Rebase onto last ARC changes.
 * Don't add dummy symbol to ARC Kconfig
 * Print info about unaligned access status in kernel log

Eugeniy Paltsev (5):
  ARCv2: lib: memcpy: fix doing prefetchw outside of buffer
  ARCv2: introduce unaligned access under a Kconfig option
  ARCv2: use unaligned access in SW
  ARCv2: LIB: MEMCPY: fixed and optimised routine
  ARC: boot log: print unaligned memory access details

 arch/arc/Kconfig                      |  9 +++++++
 arch/arc/Makefile                     |  6 +++++
 arch/arc/include/asm/irqflags-arcv2.h |  4 +++
 arch/arc/kernel/head.S                | 14 +++++++----
 arch/arc/kernel/intc-arcv2.c          |  2 +-
 arch/arc/kernel/setup.c               | 13 +++++++---
 arch/arc/lib/Makefile                 |  8 +++++-
 arch/arc/lib/memcpy-archs-unaligned.S | 46 +++++++++++++++++++++++++++++++++++
 arch/arc/lib/memcpy-archs.S           | 14 -----------
 9 files changed, 92 insertions(+), 24 deletions(-)
 create mode 100644 arch/arc/lib/memcpy-archs-unaligned.S

-- 
2.14.5

