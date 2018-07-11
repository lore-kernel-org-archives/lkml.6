Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56EDC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D02C208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D02C208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbeGKMet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:34:49 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56370 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732995AbeGKMet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:34:49 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M9j7n-1fnMrk1oIJ-00Cymj; Wed, 11 Jul 2018 14:30:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        John Hurley <john.hurley@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>, oss-drivers@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [RESEND] nfp: avoid using getnstimeofday64()
Date:   Wed, 11 Jul 2018 14:29:53 +0200
Message-Id: <20180711123003.453442-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180711123003.453442-1-arnd@arndb.de>
References: <20180711123003.453442-1-arnd@arndb.de>
X-Provags-ID: V03:K1:gF3CG1bMAMzEzNZP4a+fJhMwv4Xn5C33s+MzBiNGTKSmj4BEhBs
 +rQWiF4o6N8JcYdZ8TwqljIMEdEdN/alKQo+GhwM/YWfFawA0NfiYBAgW24YAJq0Pp97Xi1
 coi4OtO35JgFmMXUn2J8FuKUm4PIrw1C6IW7CqkKeNO/l4D6O60xH1K4TMUa1kcZwNJQYLC
 t2g62qJxMsb9svXqhk2LA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J3C33a3p81Q=:CUIEsHvDd9YQ44EG9GmFOb
 FqnXDLLoSQl2z/K4bsnLtRlJ93J8gRZQGR10668n7lnlc77vSl7M44rNTXpVdZQ8LZXkaf5Rk
 0efmjK2mKQYkKbMgJ5xgK9WnAF88/ct09YNIrVYo/5gM0RVka8FWz7RJI4tRRiq21qcl5yInh
 gcq88EhghFeapBRWRCHEsTyQN3uLVUcgWoEKxMkuRK5I4bjSMdYrbo0wahpcCfwR9LV4LPdfD
 /T1+BhEAECMv5LYxxrBw4kmi/zUExjcvf3MUAQ/mHp7wCOkwPboqjJouaQBhECgKcsIMGGS3i
 z/7M1TxaBYoeVIPD7S/T+18khgay/mg7XzgiKonujcYJq66dmR5v+Mkbrbx/luKwkoa+sqHxk
 ew2q9PKFUVX7QAztmUaLlFlg80eT3vRYqYnKVgmOSQ4HrKay44AemGzz6JtFwrGv/N44KFmTh
 eetH3fF3Ro5eXxjs1ZiysDDhx2Gz24ceAoyaqzdd5U2YaD1jh00nRfdknsxlBc+8wEwWIrNU7
 eFT6n5ML9luaZHbBgko9uKOsyvopYEoR8kWJW/7Jvyjwn0B6vbvi3dczT/glwrff3vM0Ystz2
 Wk81xdyy52gdpFklrcGShN2BzzM+EHsG/p/QeL7vc+5QRW4GQsp0IiUCDq+wpx0Pek61p4IQN
 sipCopIWz2Dcu3qjPGDebaJBiXKWji72ucpz5cSdA5oisfcPbdq8VoGW34iBI7auHyVo=
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

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
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

