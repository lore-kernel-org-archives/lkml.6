Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552912173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498577;
	bh=qJ5g3ajEs7rKJOO1RFukkXSMqvQvVvQOyyBL29n3N2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EGV+s9pks2TJF7SgkWAzOywnaj7sxuEAyiiPp9Mj1ztvBxEyyb8N5nO5xRppyC+UO
	 IfbpR+xaI0qoc4q+kaYmQk/aV1EfV6kNNWBLmsCQR4E1NvWdQ/DWU0Yxa60uxIZwsw
	 H0D8kildUbOWvJMvy/7v03dKgJsRtI0Ko1d3Xdqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbfBROCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:02:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389486AbfBROCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:02:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D624C2070D;
        Mon, 18 Feb 2019 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498572;
        bh=qJ5g3ajEs7rKJOO1RFukkXSMqvQvVvQOyyBL29n3N2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkjkQoxEgDlaMNEyX36cGxmD2jpNR/OWVwINLirXjRSVUeX69EySng9AW6GSGp7l/
         DhohypEIVVday21sBp+WCxRlhwJnm1Q4KuuybmSdWv7lzus1bdRGekMzytoAfdhI3V
         aT4R+K8046rFwd151mhvyBGQO5U+gPBWG93EXl88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 052/143] igb: Fix an issue that PME is not enabled during runtime suspend
Date:   Mon, 18 Feb 2019 14:43:00 +0100
Message-Id: <20190218133531.025408179@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index 02b23f6277fb..c1796aa2dde5 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7339,9 +7339,11 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
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



