Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6C3C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E741D21104
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543833;
	bh=JHZxGQwmPlpm16FKlCP0I85nykj9rlC2kTIgc6DVTzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kX1b6HQBIBPXeXltU9IruFSRhshvNA02Ib66kdzykvHb9Fa3NZf48dQhqhOICJHPZ
	 n1D0FRfbEbYE3jK2RhtqUMGQL+Un6lNNadjnqyQTACRqhGQ49AjruA6fcTacdFtp5H
	 YDdZStuJ6dB7YTOt1HMixfL3cDe95HhBIxfEBxdE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E741D21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbeLKP5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:57:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730742AbeLKP5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61813205C9;
        Tue, 11 Dec 2018 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543826;
        bh=JHZxGQwmPlpm16FKlCP0I85nykj9rlC2kTIgc6DVTzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zh/tNQB5NFca5NZvGBS5FVjhuoB0UV0fpdXsKQeCdDUx9dLTc7mHOssd4BjuXiLW/
         eji+MVHJWnzRfs3Fznt6xmuy1v76X3MiNz8MdDFd5rFdY36uuAMqHzUb+CFqqEmS9u
         WHk/NXbGUbFbeZkC9DzYDzU2UIPrmaVomH+8qz28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 044/118] qed: Fix bitmap_weight() check
Date:   Tue, 11 Dec 2018 16:41:03 +0100
Message-Id: <20181211151646.019580157@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 276d43f0ae963312c0cd0e2b9a85fd11ac65dfcc ]

Fix the condition which verifies that only one flag is set. The API
bitmap_weight() should receive size in bits instead of bytes.

Fixes: b5a9ee7cf3be ("qed: Revise QM cofiguration")
Signed-off-by: Denis Bolotin <denis.bolotin@cavium.com>
Signed-off-by: Michal Kalderon <michal.kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 9d2d18c32162..d2ead4eb1b9a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -478,8 +478,11 @@ static u16 *qed_init_qm_get_idx_from_flags(struct qed_hwfn *p_hwfn,
 	struct qed_qm_info *qm_info = &p_hwfn->qm_info;
 
 	/* Can't have multiple flags set here */
-	if (bitmap_weight((unsigned long *)&pq_flags, sizeof(pq_flags)) > 1)
+	if (bitmap_weight((unsigned long *)&pq_flags,
+			  sizeof(pq_flags) * BITS_PER_BYTE) > 1) {
+		DP_ERR(p_hwfn, "requested multiple pq flags 0x%x\n", pq_flags);
 		goto err;
+	}
 
 	switch (pq_flags) {
 	case PQ_FLAGS_RLS:
-- 
2.19.1



