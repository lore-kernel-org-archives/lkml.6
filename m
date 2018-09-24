Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1F6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4541C21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4541C21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbeIXS3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:29:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbeIXS3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:29:54 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8E7B81018;
        Mon, 24 Sep 2018 12:27:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 025/235] nfp: dont fail probe on pci_sriov_set_totalvfs() errors
Date:   Mon, 24 Sep 2018 13:50:11 +0200
Message-Id: <20180924113107.241756604@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 5b0ced17edc5710d4e946392d0f2934a9e07b37f ]

On machines with buggy ACPI tables or when SR-IOV is already enabled
we may not be able to set the SR-IOV VF limit in sysfs, it's not fatal
because the limit is imposed by the driver anyway.  Only the sysfs
'sriov_totalvfs' attribute will be too high.  Print an error to inform
user about the failure but allow probe to continue.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -236,16 +236,20 @@ static int nfp_pcie_sriov_read_nfd_limit
 	int err;
 
 	pf->limit_vfs = nfp_rtsym_read_le(pf->rtbl, "nfd_vf_cfg_max_vfs", &err);
-	if (!err)
-		return pci_sriov_set_totalvfs(pf->pdev, pf->limit_vfs);
+	if (err) {
+		/* For backwards compatibility if symbol not found allow all */
+		pf->limit_vfs = ~0;
+		if (err == -ENOENT)
+			return 0;
 
-	pf->limit_vfs = ~0;
-	/* Allow any setting for backwards compatibility if symbol not found */
-	if (err == -ENOENT)
-		return 0;
+		nfp_warn(pf->cpp, "Warning: VF limit read failed: %d\n", err);
+		return err;
+	}
 
-	nfp_warn(pf->cpp, "Warning: VF limit read failed: %d\n", err);
-	return err;
+	err = pci_sriov_set_totalvfs(pf->pdev, pf->limit_vfs);
+	if (err)
+		nfp_warn(pf->cpp, "Failed to set VF count in sysfs: %d\n", err);
+	return 0;
 }
 
 static int nfp_pcie_sriov_enable(struct pci_dev *pdev, int num_vfs)


