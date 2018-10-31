Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531BFECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE2B2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4qYsPHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE2B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeKAIxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:53:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727679AbeKAIGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64E2720823;
        Wed, 31 Oct 2018 23:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027163;
        bh=/VR6lIXXafUpjR7JKWNbP5Sg9DM1QgMytnddXxMsHMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X4qYsPHhPeAsvNtakMEgpvjgnh86yxb1fAs+WjkqALUtuPtnQVGFqz+aMb6fA4Eiy
         TkReq18VtpTksSoPCfUv3t0yDLf46uWa+BRhDYEyT/67aVgLTStK1TBikENNLIqQOJ
         2gsvpNpNBD+LGk4YV99XVQGWnUroKLPboPhEjZ4k=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 022/146] cpupower: Fix coredump on VMWare
Date:   Wed, 31 Oct 2018 19:03:37 -0400
Message-Id: <20181031230541.28822-22-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
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
index df43cd45d810..ccd08dd00996 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -200,6 +200,8 @@ static int get_boost_mode(unsigned int cpu)
 		printf(_("    Boost States: %d\n"), b_states);
 		printf(_("    Total States: %d\n"), pstate_no);
 		for (i = 0; i < pstate_no; i++) {
+			if (!pstates[i])
+				continue;
 			if (i < b_states)
 				printf(_("    Pstate-Pb%d: %luMHz (boost state)"
 					 "\n"), i, pstates[i]);
diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index bb41cdd0df6b..58d23997424d 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -119,6 +119,11 @@ int decode_pstates(unsigned int cpu, unsigned int cpu_family,
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

