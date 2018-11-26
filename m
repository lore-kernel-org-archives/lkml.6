Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BCFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB5B21104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfKnwIK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB5B21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbeKZVzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbeKZVzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:55:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18C3A2089F;
        Mon, 26 Nov 2018 11:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230088;
        bh=QVPM2doaAJypFhIXLBVFL3jV4kii6lrSB+eiYuqovJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZfKnwIK0z1MGuJi0X1OUlvz1YcNBQGxiui0VYNSnQK4I/5tf8sQdJUKjgYfOW5Mau
         kvUa04cxTfRDJgmHhMo1yc4I7Wz7w3bvFwkIuB1Qf+4IIcRyKFut2MwBf9480cns05
         lt1477PuNZMoAcDIKgZBEX1Z20HttC5LX+XpDTb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sagiv Ozeri <sagiv.ozeri@cavium.com>,
        Denis Bolotin <denis.bolotin@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 38/62] qed: Fix potential memory corruption
Date:   Mon, 26 Nov 2018 11:51:19 +0100
Message-Id: <20181126105053.767763142@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit fa5c448d98f0df660bfcad3dd5facc027ef84cd3 ]

A stuck ramrod should be deleted from the completion_pending list,
otherwise it will be added again in the future and corrupt the list.

Return error value to inform that ramrod is stuck and should be deleted.

Signed-off-by: Sagiv Ozeri <sagiv.ozeri@cavium.com>
Signed-off-by: Denis Bolotin <denis.bolotin@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_spq.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_spq.c b/drivers/net/ethernet/qlogic/qed/qed_spq.c
index 0313e9c46979..467755b6dd0b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_spq.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_spq.c
@@ -144,6 +144,7 @@ static int qed_spq_block(struct qed_hwfn *p_hwfn,
 
 	DP_INFO(p_hwfn, "Ramrod is stuck, requesting MCP drain\n");
 	rc = qed_mcp_drain(p_hwfn, p_ptt);
+	qed_ptt_release(p_hwfn, p_ptt);
 	if (rc) {
 		DP_NOTICE(p_hwfn, "MCP drain failed\n");
 		goto err;
@@ -152,18 +153,15 @@ static int qed_spq_block(struct qed_hwfn *p_hwfn,
 	/* Retry after drain */
 	rc = __qed_spq_block(p_hwfn, p_ent, p_fw_ret, true);
 	if (!rc)
-		goto out;
+		return 0;
 
 	comp_done = (struct qed_spq_comp_done *)p_ent->comp_cb.cookie;
-	if (comp_done->done == 1)
+	if (comp_done->done == 1) {
 		if (p_fw_ret)
 			*p_fw_ret = comp_done->fw_return_code;
-out:
-	qed_ptt_release(p_hwfn, p_ptt);
-	return 0;
-
+		return 0;
+	}
 err:
-	qed_ptt_release(p_hwfn, p_ptt);
 	DP_NOTICE(p_hwfn,
 		  "Ramrod is stuck [CID %08x cmd %02x protocol %02x echo %04x]\n",
 		  le32_to_cpu(p_ent->elem.hdr.cid),
-- 
2.17.1



