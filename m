Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D69C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623B82148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696841;
	bh=0LMMU+Aaun9Ti49FqA+qQNUCAcyB5TMf8f1yva76TMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NTlVkZy9m/cldo1F5sbLRFA71e3LNIWnNGjZiTOKpNfmwc7Q0rI3zTx0Z6BTS682k
	 9LawvDCiICg6hEXNzDS3flRLJXMwCncMNe/vQAalff0ooSTOfqMsgYHI8hdPjar2ih
	 wfDsyLMAsW7zNyAfh8hhhkpSOvgkZLprqtPeqZb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbfA1ReA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:34:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730008AbfA1P4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:56:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 437842177E;
        Mon, 28 Jan 2019 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690966;
        bh=0LMMU+Aaun9Ti49FqA+qQNUCAcyB5TMf8f1yva76TMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LoVjpjOMuwtwR1xjzBGiy/J+ZYYJTJngQgw9ZKmfuK9Lnp41oxcc4UquP8uRmsjnA
         H4SNVLYEizCzq4rA6IAT2Lf1FsC3ddeKwhbhS5nlbLQ9uEEhK7N8b3ePISmxXRSuSc
         biz1myU3ctEJJETBOz9nijClV1jPEGFmd20pP/AY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 249/304] igb: Fix an issue that PME is not enabled during runtime suspend
Date:   Mon, 28 Jan 2019 10:42:46 -0500
Message-Id: <20190128154341.47195-249-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 1fb3a7a75e2efcc83ef21f2434069cddd6fae6f5 ]

I210 ethernet card doesn't wakeup when a cable gets plugged. It's
because its PME is not set.

Since commit 42eca2302146 ("PCI: Don't touch card regs after runtime
suspend D3"), if the PCI state is saved, pci_pm_runtime_suspend() stops
calling pci_finish_runtime_suspend(), which enables the PCI PME.

To fix the issue, let's not to save PCI states when it's runtime
suspend, to let the PCI subsystem enables PME.

Fixes: 42eca2302146 ("PCI: Don't touch card regs after runtime suspend D3")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 5df88ad8ac81..93f150784cfc 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8770,9 +8770,11 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 	rtnl_unlock();
 
 #ifdef CONFIG_PM
-	retval = pci_save_state(pdev);
-	if (retval)
-		return retval;
+	if (!runtime) {
+		retval = pci_save_state(pdev);
+		if (retval)
+			return retval;
+	}
 #endif
 
 	status = rd32(E1000_STATUS);
-- 
2.19.1

