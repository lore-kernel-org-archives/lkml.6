Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3F5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2015320872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnbS0vnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2015320872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390476AbeKLI4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:56:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390367AbeKLIWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:12 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 817B5224E3;
        Sun, 11 Nov 2018 22:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975535;
        bh=VR14KrgA/pXoj1lndDLRAWU/IGWB3L9nw/htZMPuC5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rnbS0vnbo0SU05N2hUIHd5mgb/tqVzZysrH8gWoqugAy4LJqbKWDsMjMUzz4YKfnD
         i0kfuKkl50rNzsqzATJKBcJzz763gZJic+Z3IJrV5j4XRGm1oC+zKG29oTQ/9blu4L
         l/mvEs/ZYo7ew2wacp76j0I7KraqdpG4jLSJs+Zw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 051/222] cpupower: Fix coredump on VMWare
Date:   Sun, 11 Nov 2018 14:22:28 -0800
Message-Id: <20181111221652.663159594@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -202,6 +202,8 @@ static int get_boost_mode(unsigned int c
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
@@ -119,6 +119,11 @@ int decode_pstates(unsigned int cpu, uns
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


