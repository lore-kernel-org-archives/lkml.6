Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4BFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FFC2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="T/EA5xPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfA2Ktz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:49:55 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:46396 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfA2Ktx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:49:53 -0500
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 579BC10C1493;
        Tue, 29 Jan 2019 02:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548758993; bh=w64iJvGv0yzHjpm3aGnApbOj/XSVxiTqqDo3AeNSwII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/EA5xPXWwaU+ME9vhv1a5ub61AO5Ik+T1iC3ke3MCaK/81QfJloBzPP6pXr54thz
         k3WE5BZN8hbndPGLVXnqrT9hsdr9u7kgIW8QwjOb71v9GpCnCqaUJC4gHXcrz4Myp1
         rwb09mp/p9JZry+7zocFAukVRLfD+15Datqe36cvSqCGbZi9TzSvSgETcUh8jhpBts
         Z1j8ZVTBwBSWTvcFuMMJyF9DYTfq7xV+32q1LHa41/0080mU9q0ZMmOhlrvXis4vWY
         7gV/APWo/Si3cgC/M6B6fUQaUhjua8TSnPlk+RuTNoCVqEv5wrzGmvFOHVof0kkogO
         K49mJoK1nycTA==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.46])
        by mailhost.synopsys.com (Postfix) with ESMTP id EE25EA0070;
        Tue, 29 Jan 2019 10:49:51 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH 4/5] ARCv2: use unaligned access in SW
Date:   Tue, 29 Jan 2019 13:49:41 +0300
Message-Id: <20190129104942.31705-5-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190129104942.31705-1-Eugeniy.Paltsev@synopsys.com>
References: <20190129104942.31705-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select HAVE_EFFICIENT_UNALIGNED_ACCESS and allow GCC to generate
unaligned data if we enable enable unaligned access in HW.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig  | 1 +
 arch/arc/Makefile | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 37c8aeefa3a5..a1d976c612a6 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -390,6 +390,7 @@ if ISA_ARCV2
 config ARC_USE_UNALIGNED_MEM_ACCESS
 	bool "Handle unaligned access in HW and use it"
 	default y
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	help
 	  The ARC HS architecture supports unaligned memory access
 	  which is disabled by default. Enable unaligned access in
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index df00578c279d..e2b991f75bc5 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -28,6 +28,12 @@ cflags-$(CONFIG_ARC_HAS_SWAPE)		+= -mswape
 
 ifdef CONFIG_ISA_ARCV2
 
+ifdef CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS
+cflags-y				+= -munaligned-access
+else
+cflags-y				+= -mno-unaligned-access
+endif
+
 ifndef CONFIG_ARC_HAS_LL64
 cflags-y				+= -mno-ll64
 endif
-- 
2.14.5

