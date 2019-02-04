Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE1EC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F912207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278726;
	bh=MpX35K9TE3jfSMOcdU4nPJk0EYnKKQR9hwhQEzmqtbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pQxuLObNXajcGwL3TCMAJjfgtqoeVAt645PHLgzmILFiK1A5Oe3aD9nMwwaV1JXJS
	 d187Q8AN3hyCeGPXNIcrmh9tKSbdrhCHqTJgHFj7eG2jHDhBK3lyVX26Ol/zkJyDwN
	 NIUnfE3Q4AWrUvlDgQUUnUOijRtvVuHpU+tj3FNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfBDKig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:38:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:35516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729392AbfBDKie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:38:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBDFC2070C;
        Mon,  4 Feb 2019 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276712;
        bh=MpX35K9TE3jfSMOcdU4nPJk0EYnKKQR9hwhQEzmqtbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZeNZghGB4Nof4pVUVEfqu3lDNvzAIKepuXepl5sfziNDJbg/fNWDvOMYGbrKQ4PNg
         25jPF3162nuKhOAvnMGQf9dsT6sdJrVWmx/+0Xc8EDCVnBGoqVqmkkUfAbB8eT6gYy
         QK3/czpcBr9PHmjAWc3lknDvkjfFxY/RPk+Q/Sds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <g.nault@alphalink.fr>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 22/31] l2tp: remove l2specific_len dependency in l2tp_core
Date:   Mon,  4 Feb 2019 11:36:37 +0100
Message-Id: <20190204103602.498190257@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103557.903263774@linuxfoundation.org>
References: <20190204103557.903263774@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

commit 62e7b6a57c7b9bf3c6fd99418eeec05b08a85c38 upstream.

Remove l2specific_len dependency while building l2tpv3 header or
parsing the received frame since default L2-Specific Sublayer is
always four bytes long and we don't need to rely on a user supplied
value.
Moreover in l2tp netlink code there are no sanity checks to
enforce the relation between l2specific_len and l2specific_type,
so sending a malformed netlink message is possible to set
l2specific_type to L2TP_L2SPECTYPE_DEFAULT (or even
L2TP_L2SPECTYPE_NONE) and set l2specific_len to a value greater than
4 leaking memory on the wire and sending corrupted frames.

Reviewed-by: Guillaume Nault <g.nault@alphalink.fr>
Tested-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/l2tp/l2tp_core.c |   34 ++++++++++++++++------------------
 net/l2tp/l2tp_core.h |   11 +++++++++++
 2 files changed, 27 insertions(+), 18 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -700,11 +700,9 @@ void l2tp_recv_common(struct l2tp_sessio
 				 "%s: recv data ns=%u, session nr=%u\n",
 				 session->name, ns, session->nr);
 		}
+		ptr += 4;
 	}
 
-	/* Advance past L2-specific header, if present */
-	ptr += session->l2specific_len;
-
 	if (L2TP_SKB_CB(skb)->has_seq) {
 		/* Received a packet with sequence numbers. If we're the LNS,
 		 * check if we sre sending sequence numbers and if not,
@@ -1026,21 +1024,20 @@ static int l2tp_build_l2tpv3_header(stru
 		memcpy(bufp, &session->cookie[0], session->cookie_len);
 		bufp += session->cookie_len;
 	}
-	if (session->l2specific_len) {
-		if (session->l2specific_type == L2TP_L2SPECTYPE_DEFAULT) {
-			u32 l2h = 0;
-			if (session->send_seq) {
-				l2h = 0x40000000 | session->ns;
-				session->ns++;
-				session->ns &= 0xffffff;
-				l2tp_dbg(session, L2TP_MSG_SEQ,
-					 "%s: updated ns to %u\n",
-					 session->name, session->ns);
-			}
+	if (session->l2specific_type == L2TP_L2SPECTYPE_DEFAULT) {
+		u32 l2h = 0;
 
-			*((__be32 *) bufp) = htonl(l2h);
+		if (session->send_seq) {
+			l2h = 0x40000000 | session->ns;
+			session->ns++;
+			session->ns &= 0xffffff;
+			l2tp_dbg(session, L2TP_MSG_SEQ,
+				 "%s: updated ns to %u\n",
+				 session->name, session->ns);
 		}
-		bufp += session->l2specific_len;
+
+		*((__be32 *)bufp) = htonl(l2h);
+		bufp += 4;
 	}
 	if (session->offset)
 		bufp += session->offset;
@@ -1722,7 +1719,7 @@ int l2tp_session_delete(struct l2tp_sess
 EXPORT_SYMBOL_GPL(l2tp_session_delete);
 
 /* We come here whenever a session's send_seq, cookie_len or
- * l2specific_len parameters are set.
+ * l2specific_type parameters are set.
  */
 void l2tp_session_set_header_len(struct l2tp_session *session, int version)
 {
@@ -1731,7 +1728,8 @@ void l2tp_session_set_header_len(struct
 		if (session->send_seq)
 			session->hdr_len += 4;
 	} else {
-		session->hdr_len = 4 + session->cookie_len + session->l2specific_len + session->offset;
+		session->hdr_len = 4 + session->cookie_len + session->offset;
+		session->hdr_len += l2tp_get_l2specific_len(session);
 		if (session->tunnel->encap == L2TP_ENCAPTYPE_UDP)
 			session->hdr_len += 4;
 	}
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -312,6 +312,17 @@ do {									\
 #define l2tp_session_dec_refcount(s) l2tp_session_dec_refcount_1(s)
 #endif
 
+static inline int l2tp_get_l2specific_len(struct l2tp_session *session)
+{
+	switch (session->l2specific_type) {
+	case L2TP_L2SPECTYPE_DEFAULT:
+		return 4;
+	case L2TP_L2SPECTYPE_NONE:
+	default:
+		return 0;
+	}
+}
+
 #define l2tp_printk(ptr, type, func, fmt, ...)				\
 do {									\
 	if (((ptr)->debug) & (type))					\


