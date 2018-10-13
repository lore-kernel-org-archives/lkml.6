Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B13C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 11:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0652064E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 11:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0652064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbeJMTdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 15:33:40 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.47]:15047 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbeJMTdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 15:33:40 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id C68683A166
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 06:56:48 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BIXIgTg0CFxNhBIXIgnqm3; Sat, 13 Oct 2018 06:56:48 -0500
X-Authority-Reason: nr=8
Received: from lputeaux-656-1-34-183.w80-15.abo.wanadoo.fr ([80.15.51.183]:44260 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gBIXI-0006mH-5g; Sat, 13 Oct 2018 06:56:48 -0500
Date:   Sat, 13 Oct 2018 13:56:46 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] skbuff: Mark expected switch fall-throughs
Message-ID: <20181013115646.GA3516@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 80.15.51.183
X-Source-L: No
X-Exim-ID: 1gBIXI-0006mH-5g
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lputeaux-656-1-34-183.w80-15.abo.wanadoo.fr (embeddedor) [80.15.51.183]:44260
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 include/linux/skbuff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 119d092..92ec346 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3505,13 +3505,19 @@ static inline bool __skb_metadata_differs(const struct sk_buff *skb_a,
 #define __it(x, op) (x -= sizeof(u##op))
 #define __it_diff(a, b, op) (*(u##op *)__it(a, op)) ^ (*(u##op *)__it(b, op))
 	case 32: diffs |= __it_diff(a, b, 64);
+		/* fall through */
 	case 24: diffs |= __it_diff(a, b, 64);
+		/* fall through */
 	case 16: diffs |= __it_diff(a, b, 64);
+		/* fall through */
 	case  8: diffs |= __it_diff(a, b, 64);
 		break;
 	case 28: diffs |= __it_diff(a, b, 64);
+		/* fall through */
 	case 20: diffs |= __it_diff(a, b, 64);
+		/* fall through */
 	case 12: diffs |= __it_diff(a, b, 64);
+		/* fall through */
 	case  4: diffs |= __it_diff(a, b, 32);
 		break;
 	}
-- 
2.7.4

