Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A506ECDE48
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B99F20853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+5Hrj6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B99F20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbeJVSiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbeJVSiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:38:03 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7601E2087D;
        Mon, 22 Oct 2018 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203608;
        bh=/MkjsjLve/+jDxDd5DHiw7PWzvvVX+gi9JLaqARn1oQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+5Hrj6HXAuKjZHVeCi6/l3DyqGbngE1nYnHbkAcZkD2YEoiOzO1+mmcd90tfYSVM
         V5bFaCmwRG/KndsjsW8tNuhTXcfDi/t0ltDsfMBhsibanVH6+B2h/y6CIiiVvqZk2A
         qCmUwdcumKV7S/c+RHHh9o4hAjlwfmKamLThpV0s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 21/27] rds: RDS (tcp) hangs on sendto() to unresponding address
Date:   Mon, 22 Oct 2018 06:19:18 -0400
Message-Id: <20181022101924.40531-21-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022101924.40531-1-sashal@kernel.org>
References: <20181022101924.40531-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ka-Cheong Poon <ka-cheong.poon@oracle.com>

[ Upstream commit 9a4890bd6d6325a1c88564a20ab310b2d56f6094 ]

In rds_send_mprds_hash(), if the calculated hash value is non-zero and
the MPRDS connections are not yet up, it will wait.  But it should not
wait if the send is non-blocking.  In this case, it should just use the
base c_path for sending the message.

Signed-off-by: Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rds/send.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/rds/send.c b/net/rds/send.c
index 59f17a2335f4..0e54ca0f4e9e 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1006,7 +1006,8 @@ static int rds_cmsg_send(struct rds_sock *rs, struct rds_message *rm,
 	return ret;
 }
 
-static int rds_send_mprds_hash(struct rds_sock *rs, struct rds_connection *conn)
+static int rds_send_mprds_hash(struct rds_sock *rs,
+			       struct rds_connection *conn, int nonblock)
 {
 	int hash;
 
@@ -1022,10 +1023,16 @@ static int rds_send_mprds_hash(struct rds_sock *rs, struct rds_connection *conn)
 		 * used.  But if we are interrupted, we have to use the zero
 		 * c_path in case the connection ends up being non-MP capable.
 		 */
-		if (conn->c_npaths == 0)
+		if (conn->c_npaths == 0) {
+			/* Cannot wait for the connection be made, so just use
+			 * the base c_path.
+			 */
+			if (nonblock)
+				return 0;
 			if (wait_event_interruptible(conn->c_hs_waitq,
 						     conn->c_npaths != 0))
 				hash = 0;
+		}
 		if (conn->c_npaths == 1)
 			hash = 0;
 	}
@@ -1170,7 +1177,7 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 	}
 
 	if (conn->c_trans->t_mp_capable)
-		cpath = &conn->c_path[rds_send_mprds_hash(rs, conn)];
+		cpath = &conn->c_path[rds_send_mprds_hash(rs, conn, nonblock)];
 	else
 		cpath = &conn->c_path[0];
 
-- 
2.17.1

