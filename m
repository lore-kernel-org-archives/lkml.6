Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE77C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEA121773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897211;
	bh=ZD3YX5Xrdn4rBzy1JQznJG4BraxFklYWRjYpp/UP7MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U2oSNSYTTMdNEFsQncs7iBsiAk4Amxmo8/lnl2m5tDnJmuT+EatJ/p9EJNwUvNtxz
	 EYOXYFCs9CGTldEskZFPEhHQ52kGCe/KH23IZOywTcfHBi+IizmAtLxpKA93SZTW3u
	 veF7ypfN3E44RzPo9XozonrSXXFJupvWEMCFkkIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389945AbfBKPAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389930AbfBKPAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:00:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6040921773;
        Mon, 11 Feb 2019 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897205;
        bh=ZD3YX5Xrdn4rBzy1JQznJG4BraxFklYWRjYpp/UP7MA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zpH2KlWq6jSdpOJCTWM9spec9WEExuaTZGO+Ch0UpwKSYDoZs/jS80flXZEw2qppW
         WN7l2+R7a2SQdejrglMufYmq70go9oMfcbRYbCsAqyXOJEfSNUkFEwemhtUjtrsgDw
         0yn8rlLWTNBbJjBzNOD45es16Gk0G85rHVtHJo58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 126/205] igb: Fix an issue that PME is not enabled during runtime suspend
Date:   Mon, 11 Feb 2019 15:18:44 +0100
Message-Id: <20190211141836.714264710@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 1c027f9d9af5..8892ea5cbb01 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7950,9 +7950,11 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
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



