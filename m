Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42681C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2792081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544393;
	bh=2FHduYeVoT2nO9GLw8ujAMf2ZzEE/71ovSwwS/jNHUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m9gUJwp8UdSDuUtK/i6dR7srpDxq+ZlSzfwMUow6FMHQXKzsoLEPaGitztZMtNe/H
	 CzWjqg7JB4+feaUPFETQz01yCVr+qFb8pGX36a4aIhYCUU8nwcLnKmfhCHn9FNprTF
	 UYOpH3cLWH77ctWj52gYg7yDXiIT9MvFE4H6qPO4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2792081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbeLKQGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:06:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730105AbeLKPy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:54:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A89D2146D;
        Tue, 11 Dec 2018 15:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543668;
        bh=2FHduYeVoT2nO9GLw8ujAMf2ZzEE/71ovSwwS/jNHUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGBvFG2VbSc86dnTSABZg5pTBibHOHxarbEn8w5+FQFbbthP72b4dge1/rEy7DotO
         WDhdekKL84pXa72ZmKqPHm3Fx/RddrgmNAQlL7O4/HeLluUna7uNJGtOnd8iJlmeu7
         KS7K8QNPxY7DWJHoHfVj0hJ6fURjS8pVkYqBfP9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 018/118] qed: Fix PTT leak in qed_drain()
Date:   Tue, 11 Dec 2018 16:40:37 +0100
Message-Id: <20181211151644.966103989@linuxfoundation.org>
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
index 2094d86a7a08..cf3b0e3dc350 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1634,9 +1634,9 @@ static int qed_drain(struct qed_dev *cdev)
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



