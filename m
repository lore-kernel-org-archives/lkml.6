Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54949C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115B820779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115B820779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeICVLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:11:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbeICVLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:11:42 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 95D8BCF4;
        Mon,  3 Sep 2018 16:50:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "yujuan.qi" <yujuan.qi@mediatek.com>,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 02/56] Cipso: cipso_v4_optptr enter infinite loop
Date:   Mon,  3 Sep 2018 18:48:52 +0200
Message-Id: <20180903164924.190991076@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: yujuan.qi <yujuan.qi@mediatek.com>

commit 40413955ee265a5e42f710940ec78f5450d49149 upstream.

in for(),if((optlen > 0) && (optptr[1] == 0)), enter infinite loop.

Test: receive a packet which the ip length > 20 and the first byte of ip option is 0, produce this issue

Signed-off-by: yujuan.qi <yujuan.qi@mediatek.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/cipso_ipv4.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1591,9 +1591,17 @@ unsigned char *cipso_v4_optptr(const str
 	int taglen;
 
 	for (optlen = iph->ihl*4 - sizeof(struct iphdr); optlen > 0; ) {
-		if (optptr[0] == IPOPT_CIPSO)
+		switch (optptr[0]) {
+		case IPOPT_CIPSO:
 			return optptr;
-		taglen = optptr[1];
+		case IPOPT_END:
+			return NULL;
+		case IPOPT_NOOP:
+			taglen = 1;
+			break;
+		default:
+			taglen = optptr[1];
+		}
 		optlen -= taglen;
 		optptr += taglen;
 	}


