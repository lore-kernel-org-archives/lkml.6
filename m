Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C39BECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45B720854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45B720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbeGTNQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:16:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36730 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731669AbeGTNQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:16:37 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9BBC9BCF;
        Fri, 20 Jul 2018 12:28:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Lamparter <chunkeey@googlemail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 15/66] crypto: crypto4xx - remove bad list_del
Date:   Fri, 20 Jul 2018 14:13:32 +0200
Message-Id: <20180720121408.144204977@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
References: <20180720121407.228772286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Lamparter <chunkeey@googlemail.com>

commit a728a196d253530f17da5c86dc7dfbe58c5f7094 upstream.

alg entries are only added to the list, after the registration
was successful. If the registration failed, it was never added
to the list in the first place.

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/amcc/crypto4xx_core.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -1034,12 +1034,10 @@ int crypto4xx_register_alg(struct crypto
 			break;
 		}
 
-		if (rc) {
-			list_del(&alg->entry);
+		if (rc)
 			kfree(alg);
-		} else {
+		else
 			list_add_tail(&alg->entry, &sec_dev->alg_list);
-		}
 	}
 
 	return 0;


