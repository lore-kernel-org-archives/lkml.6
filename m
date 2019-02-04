Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA8FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C14214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276705;
	bh=cDFCvIr+4D/RJaEWyka6wNAPK0vQZ5JjrZt5qSTL4Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b5g2e2VTUrIwtIiSe91V6pA0hvTDWrAU1aWsF81EmCR8fgyBzfeJ3ca7Q2EJFRJ5N
	 o+pdKYHkD6Ev7us7TuzikCZ8nnVu2N8lMQJwkupcMGXjv4XgiuVy12sFWpO6hDQdcH
	 2yrul5ZU3fqsMQPs/qg3NvMIXXUnvqxi54naQCxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfBDKiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:38:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbfBDKiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:38:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F022070C;
        Mon,  4 Feb 2019 10:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276700;
        bh=cDFCvIr+4D/RJaEWyka6wNAPK0vQZ5JjrZt5qSTL4Bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKRL/ALf3qbEaQAcxgFREcw1wK8/9lqreONbBujP0OopQDEstRWYe8X7YDdJK+1ZU
         4dfQZ88WRExX9l//Cr3o+Pg/BQu5Ymc2Y5F23Myq301rIA1UY7FpdrGIByZ2twz/GL
         9ZFGKfk6Hrg/2yIozTGc9/QRVGzKV0iKoeCUF9/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <gnault@redhat.com>,
        Jacob Wen <jian.w.wen@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 18/31] l2tp: copy 4 more bytes to linear part if necessary
Date:   Mon,  4 Feb 2019 11:36:33 +0100
Message-Id: <20190204103601.630270047@linuxfoundation.org>
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

From: Jacob Wen <jian.w.wen@oracle.com>

[ Upstream commit 91c524708de6207f59dd3512518d8a1c7b434ee3 ]

The size of L2TPv2 header with all optional fields is 14 bytes.
l2tp_udp_recv_core only moves 10 bytes to the linear part of a
skb. This may lead to l2tp_recv_common read data outside of a skb.

This patch make sure that there is at least 14 bytes in the linear
part of a skb to meet the maximum need of l2tp_udp_recv_core and
l2tp_recv_common. The minimum size of both PPP HDLC-like frame and
Ethernet frame is larger than 14 bytes, so we are safe to do so.

Also remove L2TP_HDR_SIZE_NOSEQ, it is unused now.

Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>
Acked-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_core.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -83,8 +83,7 @@
 #define L2TP_SLFLAG_S	   0x40000000
 #define L2TP_SL_SEQ_MASK   0x00ffffff
 
-#define L2TP_HDR_SIZE_SEQ		10
-#define L2TP_HDR_SIZE_NOSEQ		6
+#define L2TP_HDR_SIZE_MAX		14
 
 /* Default trace flags */
 #define L2TP_DEFAULT_DEBUG_FLAGS	0
@@ -856,7 +855,7 @@ static int l2tp_udp_recv_core(struct l2t
 	__skb_pull(skb, sizeof(struct udphdr));
 
 	/* Short packet? */
-	if (!pskb_may_pull(skb, L2TP_HDR_SIZE_SEQ)) {
+	if (!pskb_may_pull(skb, L2TP_HDR_SIZE_MAX)) {
 		l2tp_info(tunnel, L2TP_MSG_DATA,
 			  "%s: recv short packet (len=%d)\n",
 			  tunnel->name, skb->len);


