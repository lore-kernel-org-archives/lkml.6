Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6406CC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 11:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB092098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 11:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB092098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeJMTZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 15:25:41 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.65]:22625 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbeJMTZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 15:25:40 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 2F022A909
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 06:48:51 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BIPbgGBBRPvAdBIPbg4wFz; Sat, 13 Oct 2018 06:48:51 -0500
X-Authority-Reason: nr=8
Received: from lputeaux-656-1-34-183.w80-15.abo.wanadoo.fr ([80.15.51.183]:44230 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gBIPZ-0003G9-VH; Sat, 13 Oct 2018 06:48:50 -0500
Date:   Sat, 13 Oct 2018 13:48:47 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] signal: Mark expected switch fall-throughs
Message-ID: <20181013114847.GA3160@embeddedor.com>
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
X-Exim-ID: 1gBIPZ-0003G9-VH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lputeaux-656-1-34-183.w80-15.abo.wanadoo.fr (embeddedor) [80.15.51.183]:44230
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
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
 include/linux/signal.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 200ed96..f428e86 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -129,9 +129,11 @@ static inline void name(sigset_t *r, const sigset_t *a, const sigset_t *b) \
 		b3 = b->sig[3]; b2 = b->sig[2];				\
 		r->sig[3] = op(a3, b3);					\
 		r->sig[2] = op(a2, b2);					\
+		/* fall through */					\
 	case 2:								\
 		a1 = a->sig[1]; b1 = b->sig[1];				\
 		r->sig[1] = op(a1, b1);					\
+		/* fall through */					\
 	case 1:								\
 		a0 = a->sig[0]; b0 = b->sig[0];				\
 		r->sig[0] = op(a0, b0);					\
@@ -161,7 +163,9 @@ static inline void name(sigset_t *set)					\
 	switch (_NSIG_WORDS) {						\
 	case 4:	set->sig[3] = op(set->sig[3]);				\
 		set->sig[2] = op(set->sig[2]);				\
+		/* fall through */					\
 	case 2:	set->sig[1] = op(set->sig[1]);				\
+		/* fall through */					\
 	case 1:	set->sig[0] = op(set->sig[0]);				\
 		    break;						\
 	default:							\
@@ -182,6 +186,7 @@ static inline void sigemptyset(sigset_t *set)
 		memset(set, 0, sizeof(sigset_t));
 		break;
 	case 2: set->sig[1] = 0;
+		/* fall through */
 	case 1:	set->sig[0] = 0;
 		break;
 	}
@@ -194,6 +199,7 @@ static inline void sigfillset(sigset_t *set)
 		memset(set, -1, sizeof(sigset_t));
 		break;
 	case 2: set->sig[1] = -1;
+		/* fall through */
 	case 1:	set->sig[0] = -1;
 		break;
 	}
-- 
2.7.4

