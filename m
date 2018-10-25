Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B443C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C852085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+cA465r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C852085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbeJYWsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbeJYWsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:15 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1515C20848;
        Thu, 25 Oct 2018 14:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476918;
        bh=1QkFq/0vNibjmWLQAgQWd9NNEStAGbUXgxor7W9y5SE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V+cA465r62ghtQzCsnYeSQLCnVoovkiPL/zPeVJNoeged7kj4uLUzAOnPWM85q8MC
         J0cF51k5JvwLP2XWssJ7vLyutx81Lo68VZy0IPnTnEAUlOpz4O2LneS15T7bq35Vo8
         2VWg/bubjpbicNS/OWLllaJmOvc7diFmC+zVSPmA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20S=C3=BCnkenberg?= 
        <christian.suenkenberg@student.kit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 36/98] x86/cpu/cyrix: Add alternative Device ID of Geode GX1 SoC
Date:   Thu, 25 Oct 2018 10:13:21 -0400
Message-Id: <20181025141423.213774-36-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Sünkenberg <christian.suenkenberg@student.kit.edu>

[ Upstream commit ae1d557d8f30cb097b4d1f2ab04fa294588ee1cf ]

A SoC variant of Geode GX1, notably NSC branded SC1100, seems to
report an inverted Device ID in its DIR0 configuration register,
specifically 0xb instead of the expected 0x4.

Catch this presumably quirky version so it's properly recognized
as GX1 and has its cache switched to write-back mode, which provides
a significant performance boost in most workloads.

SC1100's datasheet "Geode™ SC1100 Information Appliance On a Chip",
states in section 1.1.7.1 "Device ID" that device identification
values are specified in SC1100's device errata. These, however,
seem to not have been publicly released.

Wading through a number of boot logs and /proc/cpuinfo dumps found on
pastebin and blogs, this patch should mostly be relevant for a number
of now admittedly aging Soekris NET4801 and PC Engines WRAP devices,
the latter being the platform this issue was discovered on.
Performance impact was verified using "openssl speed", with
write-back caching scaling throughput between -3% and +41%.

Signed-off-by: Christian Sünkenberg <christian.suenkenberg@student.kit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1496596719.26725.14.camel@student.kit.edu
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/cyrix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index 455d8ada9b9a..d39cfb2c6b63 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -253,6 +253,7 @@ static void init_cyrix(struct cpuinfo_x86 *c)
 		break;
 
 	case 4: /* MediaGX/GXm or Geode GXM/GXLV/GX1 */
+	case 11: /* GX1 with inverted Device ID */
 #ifdef CONFIG_PCI
 	{
 		u32 vendor, device;
-- 
2.17.1

