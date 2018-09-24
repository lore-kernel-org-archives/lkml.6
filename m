Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6395ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6FD2148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6FD2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbeIXSbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:31:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57558 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732800AbeIXSbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:31:02 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A54B91018;
        Mon, 24 Sep 2018 12:29:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vakul Garg <vakul.garg@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 007/235] net/tls: Set count of SG entries if sk_alloc_sg returns -ENOSPC
Date:   Mon, 24 Sep 2018 13:49:53 +0200
Message-Id: <20180924113105.027790477@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Vakul Garg <vakul.garg@nxp.com>

[ Upstream commit 52ea992cfac357b73180d5c051dca43bc8d20c2a ]

tls_sw_sendmsg() allocates plaintext and encrypted SG entries using
function sk_alloc_sg(). In case the number of SG entries hit
MAX_SKB_FRAGS, sk_alloc_sg() returns -ENOSPC and sets the variable for
current SG index to '0'. This leads to calling of function
tls_push_record() with 'sg_encrypted_num_elem = 0' and later causes
kernel crash. To fix this, set the number of SG elements to the number
of elements in plaintext/encrypted SG arrays in case sk_alloc_sg()
returns -ENOSPC.

Fixes: 3c4d7559159b ("tls: kernel TLS support")
Signed-off-by: Vakul Garg <vakul.garg@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -149,6 +149,9 @@ static int alloc_encrypted_sg(struct soc
 			 &ctx->sg_encrypted_num_elem,
 			 &ctx->sg_encrypted_size, 0);
 
+	if (rc == -ENOSPC)
+		ctx->sg_encrypted_num_elem = ARRAY_SIZE(ctx->sg_encrypted_data);
+
 	return rc;
 }
 
@@ -162,6 +165,9 @@ static int alloc_plaintext_sg(struct soc
 			 &ctx->sg_plaintext_num_elem, &ctx->sg_plaintext_size,
 			 tls_ctx->pending_open_record_frags);
 
+	if (rc == -ENOSPC)
+		ctx->sg_plaintext_num_elem = ARRAY_SIZE(ctx->sg_plaintext_data);
+
 	return rc;
 }
 


