Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23047C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A2A2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543386;
	bh=keKs+SyApmyGjQ5DBj312YtHoKemssNFw+zq/2f5dWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RK3Y1u1Bxyg8RnAHI8bEqorzCZBfKxUT5gCTXKM49ax01ay2fNIosvVTVCyQmAUQa
	 6m3SD/kl2fSjHBD9zBiCGnb3q1kU4lQ5akdgcWvCZTAW8MGH+n3i4KdKzTaTGCtWK6
	 2ogqctPs/WVdbQ+VWKb5rTq+9qpqcIPX7rET7YKw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A2A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeLKPtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:49:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729102AbeLKPtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:49:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C23572145D;
        Tue, 11 Dec 2018 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543383;
        bh=keKs+SyApmyGjQ5DBj312YtHoKemssNFw+zq/2f5dWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o2mEvReA2vrd5f/bmWnjIWxmdjTpu72cWF2GU0D7DNM4kEeHjssj+dx2urgshacla
         1W7aqgXl3HkPENc2mZ0PUYlDjpiARNtPwuNZLBhQOkkewK5Ya6lZIQ5UpGswyTJ3Jb
         Z5OK6S5Rr7r1f6e/ywD5TyIr+4uMB1vrOAggS0WE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 09/51] qed: Fix PTT leak in qed_drain()
Date:   Tue, 11 Dec 2018 16:41:17 +0100
Message-Id: <20181211151613.502537866@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9aaa4e8ba12972d674caeefbc5f88d83235dd697 ]

Release PTT before entering error flow.

Signed-off-by: Denis Bolotin <denis.bolotin@cavium.com>
Signed-off-by: Michal Kalderon <michal.kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 1ed13a165e58..a769196628d9 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1395,9 +1395,9 @@ static int qed_drain(struct qed_dev *cdev)
 			return -EBUSY;
 		}
 		rc = qed_mcp_drain(hwfn, ptt);
+		qed_ptt_release(hwfn, ptt);
 		if (rc)
 			return rc;
-		qed_ptt_release(hwfn, ptt);
 	}
 
 	return 0;
-- 
2.19.1



