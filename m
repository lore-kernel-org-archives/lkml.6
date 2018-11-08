Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F164ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F982146D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYEpn7fW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F982146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbeKIHeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:34:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbeKIHep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:45 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58EFC2089A;
        Thu,  8 Nov 2018 21:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714237;
        bh=L4ybJl7+ZCbUU4ALFI6VW+OrS58fUCHqtputtQUEbkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYEpn7fWfMIKY2PPmheAz/jcimt2Ipc3DyC0uxPxXL9sO3m6JqJl8Y9s5W75acYU6
         WBeMXsy6k4iaIrezYDX/9o4PuPouPeu8QeHHcQev4mDBUFOqeviy7XsBeyZ9/WQ5MM
         gL1/HW9+S0YurLRgsi25t6P4Xx4sq9gDSJLGb8x0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 121/144] igb: fix NULL derefs due to skipped SR-IOV enabling
Date:   Thu,  8 Nov 2018 13:51:32 -0800
Message-Id: <20181108215106.799908533@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
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

[ Upstream commit be06998f96ecb93938ad2cce46c4289bf7cf45bc ]

The combined effect of commits 6423fc3416 ("igb: do not re-init SR-IOV
during probe") and ceee3450b3 ("igb: make sure SR-IOV init uses the
right number of queues") causes VFs no longer getting set up, leading
to NULL pointer dereferences due to the adapter's ->vf_data being NULL
while ->vfs_allocated_count is non-zero. The first commit not only
neglected the side effect of igb_sriov_reinit() that the second commit
tried to account for, but also that of setting IGB_FLAG_HAS_MSIX,
without which igb_enable_sriov() is effectively a no-op. Calling
igb_{,re}set_interrupt_capability() as done here seems to address this,
but I'm not sure whether this is better than sinply reverting the other
two commits.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 84049078c4f0..b73c896ed184 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2866,6 +2866,13 @@ static void igb_probe_vfs(struct igb_adapter *adapter)
 	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211))
 		return;
 
+	/* Of the below we really only want the effect of getting
+	 * IGB_FLAG_HAS_MSIX set (if available), without which
+	 * igb_enable_sriov() has no effect.
+	 */
+	igb_set_interrupt_capability(adapter, true);
+	igb_reset_interrupt_capability(adapter);
+
 	pci_sriov_set_totalvfs(pdev, 7);
 	igb_enable_sriov(pdev, max_vfs);
 
-- 
2.17.1



