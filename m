Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86D6C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720DF2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR3y9R36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720DF2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbeJQBJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbeJQBJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:09:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E30A620866;
        Tue, 16 Oct 2018 17:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710274;
        bh=wGMHYSDeXtPkMu6h2YjIFffs5vtI7Qvd5e3BruvoEHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BR3y9R36ew/WlAesNq1Ot9qS2JHQWejaMBT56B6JhYbM2BF1CzFwT2M9/6iqteASH
         LJ7w8wgCzj+0SU60J/QJe8g5V7p4irJZuuDWiKiZoBH/wRxsN7Nnm5hhNo2jLpefmK
         aw4se5kWmFwwwqvfD1AXbfX+fHyfZSATLOEeiySQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 024/109] tipc: fix flow control accounting for implicit connect
Date:   Tue, 16 Oct 2018 19:04:52 +0200
Message-Id: <20181016170526.408957515@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
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

From: Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>

[ Upstream commit 92ef12b32feab8f277b69e9fb89ede2796777f4d ]

In the case of implicit connect message with data > 1K, the flow
control accounting is incorrect. At this state, the socket does not
know the peer nodes capability and falls back to legacy flow control
by return 1, however the receiver of this message will perform the
new block accounting. This leads to a slack and eventually traffic
disturbance.

In this commit, we perform tipc_node_get_capabilities() at implicit
connect and perform accounting based on the peer's capability.

Signed-off-by: Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/socket.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1063,8 +1063,10 @@ static int __tipc_sendstream(struct sock
 	/* Handle implicit connection setup */
 	if (unlikely(dest)) {
 		rc = __tipc_sendmsg(sock, m, dlen);
-		if (dlen && (dlen == rc))
+		if (dlen && dlen == rc) {
+			tsk->peer_caps = tipc_node_get_capabilities(net, dnode);
 			tsk->snt_unacked = tsk_inc(tsk, dlen + msg_hdr_sz(hdr));
+		}
 		return rc;
 	}
 


