Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7975DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4142146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0Pb33+OY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4142146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbeK3B1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:27:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731108AbeK3B1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:27:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A522133F;
        Thu, 29 Nov 2018 14:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501309;
        bh=q9RVMTGQbCTryLC2a9rGXFZzYcOMmjmT+1m6pghCVew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Pb33+OYAMpgDidbaeQx53MThG1ytjBWOFtsEYb7VQChujHksCCjnAeLWph77xbLY
         10P6YqoAjvTquLHuhV54y96dx4qJisNFocbZgka71HhZWwK/2KbeAVijahNjc+jKFg
         LI2jezs3AvwJNN5hnV7Q5t7W55tfIZPHkopepEgQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 38/92] powerpc/numa: Suppress "VPHN is not supported" messages
Date:   Thu, 29 Nov 2018 15:12:07 +0100
Message-Id: <20181129140109.348451913@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
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

[ Upstream commit 437ccdc8ce629470babdda1a7086e2f477048cbd ]

When VPHN function is not supported and during cpu hotplug event,
kernel prints message 'VPHN function not supported. Disabling
polling...'. Currently it prints on every hotplug event, it floods
dmesg when a KVM guest tries to hotplug huge number of vcpus, let's
just print once and suppress further kernel prints.

Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 6cff96e0d77b..0ef83c274019 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1289,7 +1289,7 @@ static long vphn_get_associativity(unsigned long cpu,
 
 	switch (rc) {
 	case H_FUNCTION:
-		printk(KERN_INFO
+		printk_once(KERN_INFO
 			"VPHN is not supported. Disabling polling...\n");
 		stop_topology_update();
 		break;
-- 
2.17.1



