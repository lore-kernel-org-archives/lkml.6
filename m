Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0E1C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 10:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575F720693
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 10:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="v3Pfky/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575F720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754330AbeFQKeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 06:34:21 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:44294 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753976AbeFQKeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 06:34:19 -0400
Received: from trochilidae.lan (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 955935C019E;
        Sun, 17 Jun 2018 12:34:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529231657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=TKu9k3pkXk/ER6SiHJYzujn4jQk3e1WECqrw3PwNOsM=;
        b=v3Pfky/w1IxwLR6DUZjKow5qFISLwS21Fp4Gz1YHF/+KZnmLdIU5y7TxXdvBuyl+jz7jwc
        uUEJlwzJqCvQfD61WHfrerRXEC+GtG6cm5iQ5BLL9+H8dfgOh9I0AQlOWfkhK+G0S7VrNf
        uSDhAMVxm2xnbPHY2yhasO7mJxK7du4=
From:   Stefan Agner <stefan@agner.ch>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Stefan Agner <stefan@agner.ch>,
        Tobias Regnery <tobias.regnery@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] brcm80211: fix wrap around in conversion from constant to s16
Date:   Sun, 17 Jun 2018 12:33:50 +0200
Message-Id: <20180617103407.27819-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.1
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[14];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last value in the log_table wraps around to a negative value
since s16 has a value range of -32768 to 32767. This is not what
the table intends to represent. Use the closest positive value
32767.

This fixes a warning seen with clang:
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c:216:2: warning:
      implicit conversion from 'int' to 's16' (aka 'short') changes
value from 32768
      to -32768 [-Wconstant-conversion]
        32768
        ^~~~~
1 warning generated.

Fixes: 4c0bfeaae9f9 ("brcmsmac: fix array out-of-bounds access in qm_log10")
Cc: Tobias Regnery <tobias.regnery@gmail.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 .../net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c
index b9672da24a9d..b24bc57ca91b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c
@@ -213,7 +213,7 @@ static const s16 log_table[] = {
 	30498,
 	31267,
 	32024,
-	32768
+	32767
 };
 
 #define LOG_TABLE_SIZE 32       /* log_table size */
-- 
2.17.1

