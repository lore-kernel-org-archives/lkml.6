Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2A0C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8482082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8482082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJCDmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:42:51 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:33181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeJCDmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:42:50 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MtO06-1fsNtC0qjO-00ut0i; Tue, 02 Oct 2018 22:57:24 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MtO06-1fsNtC0qjO-00ut0i; Tue, 02 Oct 2018 22:57:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: caam/qi2 - avoid double export
Date:   Tue,  2 Oct 2018 22:56:19 +0200
Message-Id: <20181002205720.2255567-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:PvxzUDD4cvBR3xNIRfwiIYy7g6ReIrwKzR6Ph7nOpDkc+QIrtTL
 qj6PEqIL5K9upnbL1KjmOh0q5ygqwBo8639Np2CUTlrlFAH7uOnLKRjLQBzhSwebjCnTTrR
 53hJzUU/Z5KRv4ifwBNFB2kD0iQ+fy/8ZnvE293PaRnxlKr8V96PrTaLNO34l2O2RnqLGV0
 LBNabjGplVAzwQwxUaXVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m4t4M12xlno=:bFOog5m5UcNpizBcpmlCDY
 ZYcgllY7Guq/JNAAjP20CY2Bg5mtizE775Dz/PP117B/vUXmoFsfX6qwN/bbs4O3U5LIBesP+
 pCv6TqmvxaSuFtv7CzFRXYU7Hlt+nq9RFEZxw2U5BV6XLR5xcPe2a39AXVoTYKeUqr/WGQMgd
 RckQt/BakHxxj9HgYdauO0UfaLsrduBoxhnbfXJuEAIytx42IaTa9R1n22UojHQnz4HxVb992
 79Nqh5hJ5BntQoRD5hgfRBNytTvusKqlAAWfHgUepe5kD1GjfQDqzKgWSJj67ELFPmFAYYiFO
 xTAM3+TEQZPmKkCfrwzD+letCgyYymha/AbeY+9I5t9uk8Qkd6bVY5tjZhg+JXxcVOxk7XOH8
 YtZ23UBJgZeCBnA3Ac7X7YIYBlfunFxazpdvMCnYArPvYV1J88TpZy/XIOBu3o8QB5bSm6/Nq
 g1SRYd5zg8+zS/mDeIoq6NBT95JvnJD6V5tNrA9/6Zu0G/OGTY2n9ve6s1vxznNOW9sS8Rspk
 6KmNbJ0agDC7rqJ/oULvEYpmNw6fce8BZPhoQRKdYzq4CYRS8oqH/3AE627Bz2jWPrUuthRX9
 oL0CgGtgfCYAktTeRxqEs69tYp1DrV68mBcL+uq5Sh4TmE2ywJOuIwXlh2FjLq0IhqNYUU329
 T1fGgu2VaSZO2e9Ho4y1gPcpowhM5JP4jiEhhGgi6sVw3ZJhCVIn01N+g1776K0X09OE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the caam ctrl file and dpaa2_caam export a couple of flags. They
use an #ifdef check to make sure that each flag is only built once,
but this fails if they are both loadable modules:

WARNING: drivers/crypto/caam/dpaa2_caam: 'caam_little_end' exported twice. Previous export was in drivers/crypto/caam/caam.ko
WARNING: drivers/crypto/caam/dpaa2_caam: 'caam_imx' exported twice. Previous export was in drivers/crypto/caam/caam.ko

Change the #ifdef to an IS_ENABLED() check in order to make it work in
all configurations. It may be better to redesign this aspect of the
two drivers in a cleaner way.

Fixes: 8d818c105501 ("crypto: caam/qi2 - add DPAA2-CAAM driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/caam/caamalg_qi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 2f569d0231f9..7d8ac0222fa3 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -25,7 +25,7 @@
 #define CAAM_MAX_KEY_SIZE	(AES_MAX_KEY_SIZE + CTR_RFC3686_NONCE_SIZE + \
 				 SHA512_DIGEST_SIZE * 2)
 
-#ifndef CONFIG_CRYPTO_DEV_FSL_CAAM
+#if !IS_ENABLED(CONFIG_CRYPTO_DEV_FSL_CAAM)
 bool caam_little_end;
 EXPORT_SYMBOL(caam_little_end);
 bool caam_imx;
-- 
2.18.0

