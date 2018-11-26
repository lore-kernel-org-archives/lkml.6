Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C195C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D838C21104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4dpQve9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D838C21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeKZVvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:51:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeKZVvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:51:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8582520817;
        Mon, 26 Nov 2018 10:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229847;
        bh=7RDZ7wZrqward5svIi5Y0dq4CoIUqw2BblXtW662upk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4dpQve9nBiqrHnrBu3b11FzVqaFHiGW9hi1Y46eLhRh1xMahwg0EHg1ttuK3GPm+
         9EBoYBZdK/a0TATJ0kcZ1ViZSWTSOUHN7LcEo7ubLzZ/9ukzBuA5A/zXdP8OnwKC+0
         6zjOhfcTPS/hJ57PH4/PtbyHSh8pHYFu9DWUy/1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 23/46] qed: Fix memory/entry leak in qed_init_sp_request()
Date:   Mon, 26 Nov 2018 11:51:12 +0100
Message-Id: <20181126105048.385111013@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 39477551df940ddb1339203817de04f5caaacf7a ]

Free the allocated SPQ entry or return the acquired SPQ entry to the free
list in error flows.

Signed-off-by: Denis Bolotin <denis.bolotin@cavium.com>
Signed-off-by: Michal Kalderon <michal.kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/qlogic/qed/qed_sp_commands.c    | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c b/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
index 2888eb0628f8..ac69ff3f7c5c 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
@@ -56,7 +56,7 @@ int qed_sp_init_request(struct qed_hwfn *p_hwfn,
 
 	case QED_SPQ_MODE_BLOCK:
 		if (!p_data->p_comp_data)
-			return -EINVAL;
+			goto err;
 
 		p_ent->comp_cb.cookie = p_data->p_comp_data->cookie;
 		break;
@@ -71,7 +71,7 @@ int qed_sp_init_request(struct qed_hwfn *p_hwfn,
 	default:
 		DP_NOTICE(p_hwfn, "Unknown SPQE completion mode %d\n",
 			  p_ent->comp_mode);
-		return -EINVAL;
+		goto err;
 	}
 
 	DP_VERBOSE(p_hwfn, QED_MSG_SPQ,
@@ -85,6 +85,18 @@ int qed_sp_init_request(struct qed_hwfn *p_hwfn,
 	memset(&p_ent->ramrod, 0, sizeof(p_ent->ramrod));
 
 	return 0;
+
+err:
+	/* qed_spq_get_entry() can either get an entry from the free_pool,
+	 * or, if no entries are left, allocate a new entry and add it to
+	 * the unlimited_pending list.
+	 */
+	if (p_ent->queue == &p_hwfn->p_spq->unlimited_pending)
+		kfree(p_ent);
+	else
+		qed_spq_return_entry(p_hwfn, p_ent);
+
+	return -EINVAL;
 }
 
 static enum tunnel_clss qed_tunn_get_clss_type(u8 type)
-- 
2.17.1



