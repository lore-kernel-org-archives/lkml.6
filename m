Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4982DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA2220864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA2220864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933496AbeFRPVD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:21:03 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55187 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeFRPVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:21:01 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lup4D-1gCTyO1tjd-0104PC; Mon, 18 Jun 2018 17:20:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Simon Horman <simon.horman@netronome.com>,
        John Hurley <john.hurley@netronome.com>,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>, oss-drivers@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] nfp: avoid using getnstimeofday64()
Date:   Mon, 18 Jun 2018 17:20:17 +0200
Message-Id: <20180618152051.1510142-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:UiQT+MNRfCF33W85M08QghYMG35BP+29OnqhlH3qLGGwjGUSxE+
 8UNfoZBin7m1dLHNBstbYBUPD8+FxsnPnn5CmdHhPuVS24mHSoqo3QBiSIMYYNWFxK1xz7y
 Nb8Y4tWJM8350q73ULtpR0HpguUczXAqC2EPsicg3owzhgiqGAvH8lcDlLnsHEcqOahGQa3
 YA4x3zClSEwIwQw2KjszA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5u4lt1EdB/o=:ZD2XYXjEMxXcpQnByPCIkC
 41KwWj78hmrRiI8CEVLaAxa5oJF8mIjMPWjf7Wj7M6UlcbKZ1gcLKTPV/jOEF553pGs3+g+SV
 sLd3M59f2rFMLpDHJ8ByfBFiPU9MoZYqnv9/wMhG+5FzR4tuQb9QvuQ7t76Gq63BJg/ZmlUpd
 j31Hwzu/1sLoD7dmNiEfemBF0MkYowRS9CZ8ssq2IC1o5Q91Jw4HXZaGB0Xye2elHL1wsA/Lk
 Ry4vwxAfIqJsuE1NfJLYzWFySHf3MDml9iE7ScE82n7sILaNO1STMpZC0pQi+G5qhPDSbk05q
 /r61q+3/XkTbSp9MpauslFP6gRj4UPwl90Lnk7H+pzoIAIKf0iWiYjgzNxQb6BOio77v9Pn9W
 RalG5xebMurP+/HHoe4TzVp8NLmZESbEJ6e3FBWQSEcdk8f8VPyRur8Jz+5o5lqlCVFeKPIrf
 NSiGdbDaTQ/tM/x2gETvZzoGWYmHIC1UXbV2qpGbgu/4ZKyXRRk/STwIjbtrZ73iPWM37Icss
 NwWFSUqTAkPDYcD1uyTnvpEj7EN6rwekvyGCqV/9qnUfPq8a+FalcGvhTrn6SQI/cxfdl+tJs
 It84oJDYc19Db3ZZKpg2GUzpwpfcaUXJT2rp1EUiSEFyMDcQPuNQSGj6DAk/seVRpGX3C7VbA
 Qt7jZd+Z5nRcAFUQKXAacT8264uT0/3SrtFoxUuqbbHr/vA5YkFkSq7tws4SZcXLLfDY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getnstimeofday64 is deprecated in favor of the ktime_get() family of
functions. The direct replacement would be ktime_get_real_ts64(),
but I'm picking the basic ktime_get() instead:

- using a ktime_t simplifies the code compared to timespec64
- using monotonic time instead of real time avoids issues caused
  by a concurrent settimeofday() or during a leap second adjustment.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/netronome/nfp/flower/main.h     |  2 +-
 drivers/net/ethernet/netronome/nfp/flower/metadata.c | 12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/main.h b/drivers/net/ethernet/netronome/nfp/flower/main.h
index bbe5764d26cb..ef2114d13387 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/main.h
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.h
@@ -73,7 +73,7 @@ struct nfp_app;
 
 struct nfp_fl_mask_id {
 	struct circ_buf mask_id_free_list;
-	struct timespec64 *last_used;
+	ktime_t *last_used;
 	u8 init_unallocated;
 };
 
diff --git a/drivers/net/ethernet/netronome/nfp/flower/metadata.c b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
index 93fb809f50d1..c098730544b7 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/metadata.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
@@ -158,7 +158,6 @@ static int nfp_release_mask_id(struct nfp_app *app, u8 mask_id)
 {
 	struct nfp_flower_priv *priv = app->priv;
 	struct circ_buf *ring;
-	struct timespec64 now;
 
 	ring = &priv->mask_ids.mask_id_free_list;
 	/* Checking if buffer is full. */
@@ -169,8 +168,7 @@ static int nfp_release_mask_id(struct nfp_app *app, u8 mask_id)
 	ring->head = (ring->head + NFP_FLOWER_MASK_ELEMENT_RS) %
 		     (NFP_FLOWER_MASK_ENTRY_RS * NFP_FLOWER_MASK_ELEMENT_RS);
 
-	getnstimeofday64(&now);
-	priv->mask_ids.last_used[mask_id] = now;
+	priv->mask_ids.last_used[mask_id] = ktime_get();
 
 	return 0;
 }
@@ -178,7 +176,7 @@ static int nfp_release_mask_id(struct nfp_app *app, u8 mask_id)
 static int nfp_mask_alloc(struct nfp_app *app, u8 *mask_id)
 {
 	struct nfp_flower_priv *priv = app->priv;
-	struct timespec64 delta, now;
+	ktime_t reuse_timeout;
 	struct circ_buf *ring;
 	u8 temp_id, freed_id;
 
@@ -198,10 +196,10 @@ static int nfp_mask_alloc(struct nfp_app *app, u8 *mask_id)
 	memcpy(&temp_id, &ring->buf[ring->tail], NFP_FLOWER_MASK_ELEMENT_RS);
 	*mask_id = temp_id;
 
-	getnstimeofday64(&now);
-	delta = timespec64_sub(now, priv->mask_ids.last_used[*mask_id]);
+	reuse_timeout = ktime_add_ns(priv->mask_ids.last_used[*mask_id],
+				     NFP_FL_MASK_REUSE_TIME_NS);
 
-	if (timespec64_to_ns(&delta) < NFP_FL_MASK_REUSE_TIME_NS)
+	if (ktime_before(ktime_get(), reuse_timeout))
 		goto err_not_found;
 
 	memcpy(&ring->buf[ring->tail], &freed_id, NFP_FLOWER_MASK_ELEMENT_RS);
-- 
2.9.0

