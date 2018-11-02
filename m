Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2778C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A0F20847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmE+NQOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A0F20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbeKCDui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbeKCDuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:50:37 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F132084A;
        Fri,  2 Nov 2018 18:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184145;
        bh=9x1Tq2k+wKfP/VnhYqv7+K37ERtkRKem4BJA+8e6/e4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmE+NQOQtC3+WMVLMubPkz4NjIbgGyAJ9lcuwMUCKnEQbc6ZmS4yqn6M3eFAiPtTf
         JdRq2GudYpg6K1AX8ielPjit3ULUWHTBYBgIhLaEGbpx0IkGf0g/c3A+qwzAdjwW6p
         HGEGU9QmjYNV8F1qfilMruR1X/VWBqTZybE5gLWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 093/150] rds: RDS (tcp) hangs on sendto() to unresponding address
Date:   Fri,  2 Nov 2018 19:34:15 +0100
Message-Id: <20181102182909.932793629@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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



