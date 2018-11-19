Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699E1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329F521508
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIsnTDyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329F521508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403819AbeKTDRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:17:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403895AbeKTDRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:17:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FC5E20851;
        Mon, 19 Nov 2018 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646399;
        bh=Aed5ni97lIGp6DbPg4NP2N3u21556Lm0nJaVxEKQTtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FIsnTDyCunus21PZ3Juwz3Lilfqlsp7MiK4kj+EKKj7Ly6BbjmbRo/g8s9TKfTMaL
         IzFph9FGQNCok2sLDJDqsR7jry9r2+kKdCotNLy9NLDE3+L5BNpChzUiCgYVSJ3H07
         5Xt5QkMniAgiE+TaJiCHQSCGDiP6/MMAgb71UDK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 26/83] parisc: Align os_hpmc_size on word boundary
Date:   Mon, 19 Nov 2018 17:28:52 +0100
Message-Id: <20181119162617.639669614@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
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

[ Upstream commit 0ed9d3de5f8f97e6efd5ca0e3377cab5f0451ead ]

The os_hpmc_size variable sometimes wasn't aligned at word boundary and thus
triggered the unaligned fault handler at startup.
Fix it by aligning it properly.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v4.14+
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/hpmc.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/parisc/kernel/hpmc.S b/arch/parisc/kernel/hpmc.S
index 0fbd0a0e1cda..38d461aec46d 100644
--- a/arch/parisc/kernel/hpmc.S
+++ b/arch/parisc/kernel/hpmc.S
@@ -304,6 +304,7 @@ ENDPROC_CFI(os_hpmc)
 
 
 	__INITRODATA
+	.align 4
 	.export os_hpmc_size
 os_hpmc_size:
 	.word .os_hpmc_end-.os_hpmc
-- 
2.17.1



