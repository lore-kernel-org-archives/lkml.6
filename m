Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0694ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A6720664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIhW+h1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A6720664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbeKAILR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731528AbeKAILQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 204A72086D;
        Wed, 31 Oct 2018 23:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027464;
        bh=sdJTLqneArckJrsha/NkmWi8JqNGP/245CsmPQhwvdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TIhW+h1lIvdi9YSpcT4/pnQaK8qbKZ++BaqWcGmCZLZ9q71Lw/Ht+ht0vbAuTDhbF
         H923mJvKpXdczmv+VLUkCCp0iCTxhjiFB9u9gu1A9G9TBB3BLeLuz3kDq9soqm9Mfy
         l04D/TwcmGhETIJNdmSZlYUhyiQFt60J/IYdHVYo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 11/48] cpupower: Fix coredump on VMWare
Date:   Wed, 31 Oct 2018 19:10:17 -0400
Message-Id: <20181031231054.29333-11-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prarit Bhargava <prarit@redhat.com>

[ Upstream commit f69ffc5d3db8f1f03fd6d1df5930f9a1fbd787b6 ]

cpupower crashes on VMWare guests.  The guests have the AMD PStateDef MSR
(0xC0010064 + state number) set to zero.  As a result fid and did are zero
and the crash occurs because of a divide by zero (cof = fid/did).  This
can be prevented by checking the enable bit in the PStateDef MSR before
calculating cof.  By doing this the value of pstate[i] remains zero and
the value can be tested before displaying the active Pstates.

Check the enable bit in the PstateDef register for all supported families
and only print out enabled Pstates.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Stafford Horne <shorne@gmail.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/cpupower/utils/cpufreq-info.c | 2 ++
 tools/power/cpupower/utils/helpers/amd.c  | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 590d12a25f6e..8d7580e4b299 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -202,6 +202,8 @@ static int get_boost_mode(unsigned int cpu)
 		printf(_("    Boost States: %d\n"), b_states);
 		printf(_("    Total States: %d\n"), pstate_no);
 		for (i = 0; i < pstate_no; i++) {
+			if (!pstates[i])
+				continue;
 			if (i < b_states)
 				printf(_("    Pstate-Pb%d: %luMHz (boost state)"
 					 "\n"), i, pstates[i]);
diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 6437ef39aeea..82adfb33d7a5 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -103,6 +103,11 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
 		}
 		if (read_msr(cpu, MSR_AMD_PSTATE + i, &pstate.val))
 			return -1;
+		if ((cpu_family == 0x17) && (!pstate.fam17h_bits.en))
+			continue;
+		else if (!pstate.bits.en)
+			continue;
+
 		pstates[i] = get_cof(cpu_family, pstate);
 	}
 	*no = i;
-- 
2.17.1

