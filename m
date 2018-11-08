Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67375ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDAC20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQwciXhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDAC20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbeKIHmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728544AbeKIHmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:19 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B72882086C;
        Thu,  8 Nov 2018 22:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714688;
        bh=6Wru0SEdY49dINhG2O65+1GZ/Np6nLUBUmpPPtyXZqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQwciXhCuMcnose+FO3n5hScbmHijLKUrFx1MhzGI5YZbp4JwKpGrrxFI4326j6M2
         jPa7qKcr+bHdgdfYuRvOwib+GhlSNpMw2CZTMD2fXATkYXMsstVuyYlOz0fvU74Nxe
         pzVKnzfzL3oOhBKV0zh86yAu6jr9LdfSCKq836OE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20S=C3=BCnkenberg?= 
        <christian.suenkenberg@student.kit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 066/171] x86/cpu/cyrix: Add alternative Device ID of Geode GX1 SoC
Date:   Thu,  8 Nov 2018 13:50:36 -0800
Message-Id: <20181108215132.344839494@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



