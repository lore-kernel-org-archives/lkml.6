Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5884EC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133B421778
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133B421778
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbeHNA5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:57:12 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbeHNA5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:57:12 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lvg2y-1fxJFF21ro-017Szd; Tue, 14 Aug 2018 00:12:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bnxt_en: take coredump_record structure off stack
Date:   Tue, 14 Aug 2018 00:12:45 +0200
Message-Id: <20180813221256.299221-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:VvX4oWXNQxK+lgAbJzvFKYyTsBe1vACD+a7UvRrhGs1egl8Ni10
 DuQtLhIeRr3+HYMnblTnoqmeV/aA+bWjVNAgpdnIiKAjXHJjtZiZkr3OHizfXp8vG11Zfcf
 vWBZkrSYpMbpecv9SS4Jp89MH31ZksTXtXISmbTzfMLgAG1SfQZQSBWmUiZvt1GLhHuoNeY
 qI2pszyhB6j9WS4nWZ+mA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1ontqEbgg4g=:EK7nvBvezqr57PQnGqZ7q7
 hp4HJ1vjrGO89m57ZAKLxHnaCxr7sXjVjE66LiCfvfcFBl/XWQw8ev8BPw7L3KWcXMV26jiVn
 zXsaG7FydULDt4GyUDMA89RgsPo+QXKVuZmsSwCpGqA/f54mhqjLGMZzc0tdsJ8wo/k6MHnRq
 aPu803dd/+Y1WiZ5eh7BNTBLaI0zHnAsG/DoPYf1pN8rUk+6f/aiiz11aeqyorRsn6Y3pTjv6
 ewQQ4GdUj7Au0zDP8UN4mhNWiyz9v42wqegoKZHYtk7iSWV8wITdhEzpK5deqrKAoQTima9uY
 cnnutVcW+VyMxytNNe8+w9RQIiYnmn6HR6v2nS8sWfkmwvZfMUX1bViOlLnSCqlj4K94QU2PY
 o8QqCSvrryNlyHwMhx8/Rp3psUnTEFcF6/nrLBQtrt0EJEFYX6Ns3f01xfVhq+Ju8y/+tW9mP
 IhtkGR+9r45fX7RNfe0FupfUdX3LWxggwS2PhMSdE0ZHu9dJ0KkDCNcz3Yq5QDvQ/BQb8hojX
 ALTDEzQLeFTIDO9nHT4I/47zsUA6Yf/EbtLShhkGo4qrTYEQzn9cUbyeXyVWajhbHPLnM1jPh
 xvWClsBbTEz1/n2Xce9fjAK1PU82xhdfHdvimvRr8aDqcz5R6SkV9PH5FB+BGCj/Q7hgYyMhb
 x5qA+TbQ7lBi6MKaz7SnKTOGqP4INy1Cc5KOtK/8v2scEFUECeC46BX8Pp4gC0YVsdiw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bnxt_coredump_record structure is very long, causing a warning
about possible stack overflow on 32-bit architectures:

drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c: In function 'bnxt_get_coredump':
drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:2989:1: error: the frame size of 1188 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

I could not see any reason to operate on an on-stack copy of the
structure before copying it back into the caller-provided buffer, which
also simplifies the code here.

Fixes: 6c5657d085ae ("bnxt_en: Add support for ethtool get dump.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 539be1d1b67f..e52d7af3ab3e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2900,7 +2900,6 @@ static int bnxt_get_coredump(struct bnxt *bp, void *buf, u32 *dump_len)
 	struct coredump_segment_record *seg_record = NULL;
 	u32 offset = 0, seg_hdr_len, seg_record_len;
 	struct bnxt_coredump_segment_hdr seg_hdr;
-	struct bnxt_coredump_record coredump_rec;
 	struct bnxt_coredump coredump = {NULL};
 	time64_t start_time;
 	u16 start_utc;
@@ -2976,14 +2975,12 @@ static int bnxt_get_coredump(struct bnxt *bp, void *buf, u32 *dump_len)
 	}
 
 err:
-	if (buf) {
-		bnxt_fill_coredump_record(bp, &coredump_rec, start_time,
+	if (buf)
+		bnxt_fill_coredump_record(bp, buf + offset, start_time,
 					  start_utc, coredump.total_segs + 1,
 					  rc);
-		memcpy(buf + offset, &coredump_rec, sizeof(coredump_rec));
-	}
 	kfree(coredump.data);
-	*dump_len += sizeof(coredump_rec);
+	*dump_len += sizeof(struct bnxt_coredump_record);
 
 	return rc;
 }
-- 
2.18.0

