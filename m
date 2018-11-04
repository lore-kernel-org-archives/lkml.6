Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FB2ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F982086D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRBTK5R8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F982086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbeKDXJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:09:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731464AbeKDXJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:09:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF7A02085A;
        Sun,  4 Nov 2018 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339641;
        bh=U0YRj7iJcZleKgA+EkxkNz+RZxGXXZBDiuy//4LrJa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRBTK5R89lMAe5N8RQCIHqr+0SxQYBTPn048S7JYaoKJxPCHITJ6i+O5hadGN5nnN
         b8MbmyMYRt5Qk6xb2ioGXhzCSBpqf0G70JRW8eiOcfKrzCrdFJSSvJo7ex13Mzf0FT
         yH9jidwTDt6lg8gvEbnGWJTH7ot6JiNnP/2QcxWM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sam Bobroff <sbobroff@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 04/21] powerpc/eeh: Fix possible null deref in eeh_dump_dev_log()
Date:   Sun,  4 Nov 2018 08:53:38 -0500
Message-Id: <20181104135355.88602-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135355.88602-1-sashal@kernel.org>
References: <20181104135355.88602-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Bobroff <sbobroff@linux.ibm.com>

[ Upstream commit f9bc28aedfb5bbd572d2d365f3095c1becd7209b ]

If an error occurs during an unplug operation, it's possible for
eeh_dump_dev_log() to be called when edev->pdn is null, which
currently leads to dereferencing a null pointer.

Handle this by skipping the error log for those devices.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/eeh.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index e5bfbf62827a..8336b9016ca9 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -169,6 +169,11 @@ static size_t eeh_dump_dev_log(struct eeh_dev *edev, char *buf, size_t len)
 	int n = 0, l = 0;
 	char buffer[128];
 
+	if (!pdn) {
+		pr_warn("EEH: Note: No error log for absent device.\n");
+		return 0;
+	}
+
 	n += scnprintf(buf+n, len-n, "%04x:%02x:%02x.%01x\n",
 		       edev->phb->global_number, pdn->busno,
 		       PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
-- 
2.17.1

