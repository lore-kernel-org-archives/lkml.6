Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC0CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59596217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfAYUtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:49:07 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.191]:22929 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbfAYUtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:49:07 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 26D68400C95E4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 14:49:06 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id n8PSgkYhT4FKpn8PSg8jvb; Fri, 25 Jan 2019 14:49:06 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=43900 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gn8P9-002hny-DM; Fri, 25 Jan 2019 14:49:05 -0600
Date:   Fri, 25 Jan 2019 14:48:46 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] ASN.1: mark expected switch fall-throughs
Message-ID: <20190125204846.GA4106@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gn8P9-002hny-DM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:43900
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

lib/asn1_decoder.c:386:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
lib/asn1_decoder.c:449:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 lib/asn1_decoder.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/asn1_decoder.c b/lib/asn1_decoder.c
index dc14beae2c9a..8f3d207d2b00 100644
--- a/lib/asn1_decoder.c
+++ b/lib/asn1_decoder.c
@@ -385,6 +385,8 @@ int asn1_ber_decoder(const struct asn1_decoder *decoder,
 	case ASN1_OP_END_SET_ACT:
 		if (unlikely(!(flags & FLAG_MATCHED)))
 			goto tag_mismatch;
+		/* fall through */
+
 	case ASN1_OP_END_SEQ:
 	case ASN1_OP_END_SET_OF:
 	case ASN1_OP_END_SEQ_OF:
@@ -450,6 +452,8 @@ int asn1_ber_decoder(const struct asn1_decoder *decoder,
 			pc += asn1_op_lengths[op];
 			goto next_op;
 		}
+		/* fall through */
+
 	case ASN1_OP_ACT:
 		ret = actions[machine[pc + 1]](context, hdr, tag, data + tdp, len);
 		if (ret < 0)
-- 
2.20.1

