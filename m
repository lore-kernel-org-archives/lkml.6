Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B619C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D222063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217373;
	bh=IjYOufkOZQ2dmoMVmsoME0VGE4sQ+KMfETplgj6j8tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T9NamfwJu/SdHxMu+ju5j8Tjl8lUEt71NTz6IdETxjGIjGfZFMN/4IrgoWFWngtQL
	 6NAlssGz09JIO6lhtkoBTRYT/tbf8ODAWPpcFdTZ7sZSUggvWwsKbTUJO89d84fc0p
	 HF2OUbDiOQyRzh9XbmAiFe8JaTkLDlP/l8+2KQMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390317AbfAKOgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:36:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390298AbfAKOgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DCB82063F;
        Fri, 11 Jan 2019 14:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217367;
        bh=IjYOufkOZQ2dmoMVmsoME0VGE4sQ+KMfETplgj6j8tI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZXhVNe6RVrzg3qhRhdpSk+euf2J1x9dtP0iOZ4w7FhHot2YkCSOFy1vKqhxtvmKLf
         HL5wPbr9EZNy4zqxBf+0jRvf6KHMrqg3X+5H9z7a8+aBqOF0EhF4UcLtpLQV6FvTTd
         JoJj2KrnGlqlK8yw7Hlw4gUfQPe3osbRAv1hwXEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 036/148] bnx2x: Clear fip MAC when fcoe offload support is disabled
Date:   Fri, 11 Jan 2019 15:13:34 +0100
Message-Id: <20190111131115.743988654@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

[ Upstream commit bbf666c1af916ed74795493c564df6fad462cc80 ]

On some customer setups it was observed that shmem contains a non-zero fip
MAC for 57711 which would lead to enabling of SW FCoE.
Add a software workaround to clear the bad fip mac address if no FCoE
connections are supported.

Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index fcc2328bb0d9..b05c1d0f829b 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -11740,8 +11740,10 @@ static void bnx2x_get_fcoe_info(struct bnx2x *bp)
 	 * If maximum allowed number of connections is zero -
 	 * disable the feature.
 	 */
-	if (!bp->cnic_eth_dev.max_fcoe_conn)
+	if (!bp->cnic_eth_dev.max_fcoe_conn) {
 		bp->flags |= NO_FCOE_FLAG;
+		eth_zero_addr(bp->fip_mac);
+	}
 }
 
 static void bnx2x_get_cnic_info(struct bnx2x *bp)
-- 
2.19.1



