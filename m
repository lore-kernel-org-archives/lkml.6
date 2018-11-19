Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FAFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCF92148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jd6soyHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCF92148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406270AbeKTD1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:27:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405677AbeKTD1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:27:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9889A2146D;
        Mon, 19 Nov 2018 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647009;
        bh=m5alIWHPpCMpZyPESxfRB5rn398qt+Sx7IQhJ5WL9tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jd6soyHeFx5dzKSuJ/LyX6KHivjYfI5N/Z09jRwnpJDwpVCBf02+gLcw0f9MnC+qm
         /TBN3N5kpkrKiAyeJ9NdiIp4hvNLtnpxmZY+Pu8tg9izvn+8G+Kymnt5tTO7ldDxza
         oTpvVnTDl87kXXMZ/uT8LD1ECRenTJ+s4bSKtaW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 16/90] cpupower: Fix coredump on VMWare
Date:   Mon, 19 Nov 2018 17:28:58 +0100
Message-Id: <20181119162623.516060898@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/power/cpupower/utils/cpufreq-info.c |    2 ++
 tools/power/cpupower/utils/helpers/amd.c  |    5 +++++
 2 files changed, 7 insertions(+)

--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -200,6 +200,8 @@ static int get_boost_mode(unsigned int c
 		printf(_("    Boost States: %d\n"), b_states);
 		printf(_("    Total States: %d\n"), pstate_no);
 		for (i = 0; i < pstate_no; i++) {
+			if (!pstates[i])
+				continue;
 			if (i < b_states)
 				printf(_("    Pstate-Pb%d: %luMHz (boost state)"
 					 "\n"), i, pstates[i]);
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -103,6 +103,11 @@ int decode_pstates(unsigned int cpu, uns
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


