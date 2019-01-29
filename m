Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EABC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1302820881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ea6cZEGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfA2Ktr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:49:47 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:43316 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfA2Ktr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:49:47 -0500
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id A4F1D24E138A;
        Tue, 29 Jan 2019 02:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548758986; bh=sqQs3SMsxeIaSjIFJgSE1Ypkg5s2c0rBW33OlLbqjMw=;
        h=From:To:Cc:Subject:Date:From;
        b=Ea6cZEGx/19LCJzZ7c82/U2UpbyiuSC8Fwl0pVVkDV3J2HkWwgMpdSUmK+HPhttjs
         EQV+35wFAHuXSBMJArxJV5R5K/933f9819bYAT2/dreCtdVCX+y+FHGI5qfwRjGKjY
         06aMqEDCB+Bpff2OCCa9aXJYnJm89UawBIXKM1ENQecpsjUAkgCaYUQecYO283EES7
         KyPBc0Be5/7ZXTmCQ7gSjRAL8E/8s3/DojrjYq4p6XvRR6/rznPiwhA1JYF/Iij9km
         9WKeoJ/nWdAgIU7hSzZYKqluL+NS4Kuc7INS/HoFEOZtDpN4bp5ySjXZwIT5hc6e6C
         hBcdxYWFUvvSA==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.46])
        by mailhost.synopsys.com (Postfix) with ESMTP id 46C2DA00AA;
        Tue, 29 Jan 2019 10:49:44 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH 0/5] introduce unaligned access under a Kconfig option
Date:   Tue, 29 Jan 2019 13:49:37 +0300
Message-Id: <20190129104942.31705-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today we enable unaligned access unconditionally on ARCv2.
Lets move it under Kconfig option and use it actively in SW if it is
enabled.

While I'm at it fix and optimise ARCv2 memcpy implementaion.

Eugeniy Paltsev (5):
  ARCv2: lib: memcpy: fix doing prefetchw outside of buffer
  ARCv2: introduce unaligned access under a Kconfig option
  ARCv2: Enable unaligned access in early ASM code
  ARCv2: use unaligned access in SW
  ARCv2: LIB: MEMCPY: fixed and optimised routine

 arch/arc/Kconfig                      | 13 ++++++++++
 arch/arc/Makefile                     |  6 +++++
 arch/arc/include/asm/irqflags-arcv2.h |  4 +++
 arch/arc/kernel/head.S                | 14 +++++++++++
 arch/arc/kernel/intc-arcv2.c          |  2 +-
 arch/arc/lib/Makefile                 |  5 +++-
 arch/arc/lib/memcpy-archs-unaligned.S | 46 +++++++++++++++++++++++++++++++++++
 arch/arc/lib/memcpy-archs.S           | 14 -----------
 8 files changed, 88 insertions(+), 16 deletions(-)
 create mode 100644 arch/arc/lib/memcpy-archs-unaligned.S

-- 
2.14.5

