Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F37DECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD90320844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uB5Y/XTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD90320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbeKIHmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728790AbeKIHmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:53 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D242086C;
        Thu,  8 Nov 2018 22:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714723;
        bh=00+MDZ9jHGNi6bQa62t4FvT4PrabYMsRTEB3oa6Rcfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uB5Y/XTaYLYzKSeBtXWXeQVULMOMzKhoCTBExTqq6eu+1Vysct1l42tNuBXDG3X3N
         qkMQ+5Bml58hqUYcZrmOS6tf4yo1fFRIh0ZaoJQ+JGXcjsjzu71plNwznap/0a4BDi
         waZw6m6vb6QxRQpDOKnHMdWn/BpKEaa+we0slNmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dag Moxnes <dag.moxnes@oracle.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 085/171] rds: ib: Fix missing call to rds_ib_dev_put in rds_ib_setup_qp
Date:   Thu,  8 Nov 2018 13:50:55 -0800
Message-Id: <20181108215133.629531738@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
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

[ Upstream commit 91a825290ca4eae88603bc811bf74a45f94a3f46 ]

The function rds_ib_setup_qp is calling rds_ib_get_client_data and
should correspondingly call rds_ib_dev_put. This call was lost in
the non-error path with the introduction of error handling done in
commit 3b12f73a5c29 ("rds: ib: add error handle")

Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rds/ib_cm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index 169156cfd4c8..96e61eab19bc 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -505,7 +505,7 @@ static int rds_ib_setup_qp(struct rds_connection *conn)
 	rdsdebug("conn %p pd %p cq %p %p\n", conn, ic->i_pd,
 		 ic->i_send_cq, ic->i_recv_cq);
 
-	return ret;
+	goto out;
 
 sends_out:
 	vfree(ic->i_sends);
@@ -530,6 +530,7 @@ send_cq_out:
 		ic->i_send_cq = NULL;
 rds_ibdev_out:
 	rds_ib_remove_conn(rds_ibdev, conn);
+out:
 	rds_ib_dev_put(rds_ibdev);
 
 	return ret;
-- 
2.17.1



