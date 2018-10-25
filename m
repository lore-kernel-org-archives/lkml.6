Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D43ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEDF20883
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG2yuPnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEDF20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbeJYWvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730073AbeJYWvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:51:21 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C65D120883;
        Thu, 25 Oct 2018 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477104;
        bh=TTu9CKE3X+mr0f2zsXA4nZ81h/zSVjyY2F2y5gHLN58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LG2yuPnT/9vIHnW4oMJ3gBP8kM/nvFu+uaSgMDwW2IJhnDM2xppZzy7965vsH95Tj
         cvHeMG0JR+7yH98qESGSgRZ9NadWAxTzaC+WPJFw5Z3E8S1bEjaAgvwdp7sPs+4tgP
         2lkuJ34wMKFq2shXhZ7RaQj/J1DufYIAM6T2eNX4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 50/65] sparc64: Fix exception handling in UltraSPARC-III memcpy.
Date:   Thu, 25 Oct 2018 10:16:50 -0400
Message-Id: <20181025141705.213937-50-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit 0ede1c401332173ab0693121dc6cde04a4dbf131 ]

Mikael Pettersson reported that some test programs in the strace-4.18
testsuite cause an OOPS.

After some debugging it turns out that garbage values are returned
when an exception occurs, causing the fixup memset() to be run with
bogus arguments.

The problem is that two of the exception handler stubs write the
successfully copied length into the wrong register.

Fixes: ee841d0aff64 ("sparc64: Convert U3copy_{from,to}_user to accurate exception reporting.")
Reported-by: Mikael Pettersson <mikpelinux@gmail.com>
Tested-by: Mikael Pettersson <mikpelinux@gmail.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/lib/U3memcpy.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
index 54f98706b03b..5a8cb37f0a3b 100644
--- a/arch/sparc/lib/U3memcpy.S
+++ b/arch/sparc/lib/U3memcpy.S
@@ -145,13 +145,13 @@ ENDPROC(U3_retl_o2_plus_GS_plus_0x08)
 ENTRY(U3_retl_o2_and_7_plus_GS)
 	and	%o2, 7, %o2
 	retl
-	 add	%o2, GLOBAL_SPARE, %o2
+	 add	%o2, GLOBAL_SPARE, %o0
 ENDPROC(U3_retl_o2_and_7_plus_GS)
 ENTRY(U3_retl_o2_and_7_plus_GS_plus_8)
 	add	GLOBAL_SPARE, 8, GLOBAL_SPARE
 	and	%o2, 7, %o2
 	retl
-	 add	%o2, GLOBAL_SPARE, %o2
+	 add	%o2, GLOBAL_SPARE, %o0
 ENDPROC(U3_retl_o2_and_7_plus_GS_plus_8)
 #endif
 
-- 
2.17.1

