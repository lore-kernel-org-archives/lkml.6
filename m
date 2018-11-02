Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DFAC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EB42082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBMJuObs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EB42082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbeKCEAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:00:50 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28AF62082D;
        Fri,  2 Nov 2018 18:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184754;
        bh=poFQksICuesrgEHSO37cSi86x+rgU6/QAnV8S+u/qlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBMJuObsnMuZo/eU9ykPtKKdkVsYffd20LZ2DhLqtia2FQhmJmG8EHohnAuNhmbyR
         RKwxhp0/+8bU3un/lOjAoAP6SGYBWTADwYVnG4pxauOIN2HoEF9vE4BCicm6AplLsP
         UVKwUmHf0YLGtY8yV6OwRbNs9Z6ChxfiMuLGeZ60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 070/143] l2tp: remove configurable payload offset
Date:   Fri,  2 Nov 2018 19:34:15 +0100
Message-Id: <20181102182902.921090563@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
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

[ Upstream commit 900631ee6a2651dc4fbaecb8ef9fa5f1e3378853 ]

If L2TP_ATTR_OFFSET is set to a non-zero value in L2TPv3 tunnels, it
results in L2TPv3 packets being transmitted which might not be
compliant with the L2TPv3 RFC. This patch has l2tp ignore the offset
setting and send all packets with no offset.

In more detail:

L2TPv2 supports a variable offset from the L2TPv2 header to the
payload. The offset value is indicated by an optional field in the
L2TP header.  Our L2TP implementation already detects the presence of
the optional offset and skips that many bytes when handling data
received packets. All transmitted packets are always transmitted with
no offset.

L2TPv3 has no optional offset field in the L2TPv3 packet
header. Instead, L2TPv3 defines optional fields in a "Layer-2 Specific
Sublayer". At the time when the original L2TP code was written, there
was talk at IETF of offset being implemented in a new Layer-2 Specific
Sublayer. A L2TP_ATTR_OFFSET netlink attribute was added so that this
offset could be configured and the intention was to allow it to be
also used to set the tx offset for L2TPv2. However, no L2TPv3 offset
was ever specified and the L2TP_ATTR_OFFSET parameter was forgotten
about.

Setting L2TP_ATTR_OFFSET results in L2TPv3 packets being transmitted
with the specified number of bytes padding between L2TPv3 header and
payload. This is not compliant with L2TPv3 RFC3931. This change
removes the configurable offset altogether while retaining
L2TP_ATTR_OFFSET for backwards compatibility. Any L2TP_ATTR_OFFSET
value is ignored.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_core.c    | 14 ++++----------
 net/l2tp/l2tp_core.h    |  3 ---
 net/l2tp/l2tp_debugfs.c |  4 ++--
 net/l2tp/l2tp_netlink.c |  3 ---
 4 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 5c87f1d3e525..33ea389ee015 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -808,10 +808,8 @@ void l2tp_recv_common(struct l2tp_session *session, struct sk_buff *skb,
 		}
 	}
 
-	/* Session data offset is handled differently for L2TPv2 and
-	 * L2TPv3. For L2TPv2, there is an optional 16-bit value in
-	 * the header. For L2TPv3, the offset is negotiated using AVPs
-	 * in the session setup control protocol.
+	/* Session data offset is defined only for L2TPv2 and is
+	 * indicated by an optional 16-bit value in the header.
 	 */
 	if (tunnel->version == L2TP_HDR_VER_2) {
 		/* If offset bit set, skip it. */
@@ -819,8 +817,7 @@ void l2tp_recv_common(struct l2tp_session *session, struct sk_buff *skb,
 			offset = ntohs(*(__be16 *)ptr);
 			ptr += 2 + offset;
 		}
-	} else
-		ptr += session->offset;
+	}
 
 	offset = ptr - optr;
 	if (!pskb_may_pull(skb, offset))
@@ -1104,8 +1101,6 @@ static int l2tp_build_l2tpv3_header(struct l2tp_session *session, void *buf)
 		}
 		bufp += session->l2specific_len;
 	}
-	if (session->offset)
-		bufp += session->offset;
 
 	return bufp - optr;
 }
@@ -1779,7 +1774,7 @@ void l2tp_session_set_header_len(struct l2tp_session *session, int version)
 		if (session->send_seq)
 			session->hdr_len += 4;
 	} else {
-		session->hdr_len = 4 + session->cookie_len + session->l2specific_len + session->offset;
+		session->hdr_len = 4 + session->cookie_len + session->l2specific_len;
 		if (session->tunnel->encap == L2TP_ENCAPTYPE_UDP)
 			session->hdr_len += 4;
 	}
@@ -1830,7 +1825,6 @@ struct l2tp_session *l2tp_session_create(int priv_size, struct l2tp_tunnel *tunn
 			session->recv_seq = cfg->recv_seq;
 			session->lns_mode = cfg->lns_mode;
 			session->reorder_timeout = cfg->reorder_timeout;
-			session->offset = cfg->offset;
 			session->l2specific_type = cfg->l2specific_type;
 			session->l2specific_len = cfg->l2specific_len;
 			session->cookie_len = cfg->cookie_len;
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index 9e2f1fda1b03..0a58c0754526 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -59,7 +59,6 @@ struct l2tp_session_cfg {
 	int			debug;		/* bitmask of debug message
 						 * categories */
 	u16			vlan_id;	/* VLAN pseudowire only */
-	u16			offset;		/* offset to payload */
 	u16			l2specific_len;	/* Layer 2 specific length */
 	u16			l2specific_type; /* Layer 2 specific type */
 	u8			cookie[8];	/* optional cookie */
@@ -86,8 +85,6 @@ struct l2tp_session {
 	int			cookie_len;
 	u8			peer_cookie[8];
 	int			peer_cookie_len;
-	u16			offset;		/* offset from end of L2TP header
-						   to beginning of data */
 	u16			l2specific_len;
 	u16			l2specific_type;
 	u16			hdr_len;
diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
index 53bae54c4d6e..534cad03b9e9 100644
--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -180,8 +180,8 @@ static void l2tp_dfs_seq_session_show(struct seq_file *m, void *v)
 		   session->lns_mode ? "LNS" : "LAC",
 		   session->debug,
 		   jiffies_to_msecs(session->reorder_timeout));
-	seq_printf(m, "   offset %hu l2specific %hu/%hu\n",
-		   session->offset, session->l2specific_type, session->l2specific_len);
+	seq_printf(m, "   offset 0 l2specific %hu/%hu\n",
+		   session->l2specific_type, session->l2specific_len);
 	if (session->cookie_len) {
 		seq_printf(m, "   cookie %02x%02x%02x%02x",
 			   session->cookie[0], session->cookie[1],
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index c28223d8092b..001797ce4084 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -549,9 +549,6 @@ static int l2tp_nl_cmd_session_create(struct sk_buff *skb, struct genl_info *inf
 	}
 
 	if (tunnel->version > 2) {
-		if (info->attrs[L2TP_ATTR_OFFSET])
-			cfg.offset = nla_get_u16(info->attrs[L2TP_ATTR_OFFSET]);
-
 		if (info->attrs[L2TP_ATTR_DATA_SEQ])
 			cfg.data_seq = nla_get_u8(info->attrs[L2TP_ATTR_DATA_SEQ]);
 
-- 
2.17.1



