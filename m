Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5ECC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DB420835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN/zsm1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DB420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJLD0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:26:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34755 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbeJLD0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:26:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id w19-v6so9422210eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 12:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PWeKfeGq210b8efVytF3ftt9TiarLtTSAKzyY6Mqcf4=;
        b=YN/zsm1YshIJa3+RJpVkfm5m2PRWzTQYD//AFtKOvT7uVfvjklPvS2GCGLZXhil6MJ
         Qm9onbozc32jtK8pih3BFQELDy6P/ns238kXkAmKu/abMAKLPa9h8MwOt95pSF3/kRZp
         fTCzZ4YLuh3EukMS35BjBDdBFKbs0dusaNroWERBjfFEkzPovMShYPtzHzLjdzrYA/mM
         CRzpQEoS0gEM3C+KGuLxkhLq0cVCovFOdmVM2b7R42//BdpcbtaLR0Wn0aVy/ra5La1l
         czAATpcuNSwIrUILVJNPIkG6cjOemDCotADCmbfVLFbGjhiHr1sgqvlcjk51pGTAl10j
         pGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PWeKfeGq210b8efVytF3ftt9TiarLtTSAKzyY6Mqcf4=;
        b=uX419s6of7RZCyD1XKJ/03BfhCFJPf2V7hTg45vsRS1xVugpc+TLziMKnHDHk4pz1C
         jCwyVtH/0ZondJGKD/f5UkKJnyzG9hQ3LFQbOETJZ7u63rWDJD0TJWHphbn3qyGKNyLY
         27Jd2COnglhaMpB+een3/z0/nanQyPQOlJ1QWoKQ3ex21Q3GsBGfr1+h4H2ouxHB7Hmu
         Wk8YGxA7wLClf1lzEz1TTp0AbfitbxRi4OGr2/GDs/bZBidvcUmV2hw6t7mt76JA5wgE
         nrgKtKQRF7J/xFt11OAvw/c6mjFFu11mRnaigPfUe36sh6bbsOV7AKV/p21xeYQDMWJt
         tKdQ==
X-Gm-Message-State: ABuFfoierqy0bLU34muvGMIGyJAsJe1fCso0zgSxbaZI+xrkjX+osacq
        bqO/agnPLzvitl0qZF+Ho6M=
X-Google-Smtp-Source: ACcGV60JbVuvW6yibav1QqIewVEfEYV+gSvNpZO7K5hVGlZhszebwmtksEhl3E6n187g4OnHcGZ8aA==
X-Received: by 2002:a17:906:90f:: with SMTP id i15-v6mr3895159ejd.225.1539287849994;
        Thu, 11 Oct 2018 12:57:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id k22-v6sm919408eja.23.2018.10.11.12.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 12:57:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/8] staging: rtl8188eu: cleanup block comments
Date:   Thu, 11 Oct 2018 21:57:09 +0200
Message-Id: <20181011195712.1472-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011195712.1472-1-straube.linux@gmail.com>
References: <20181011195712.1472-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup block comments to clear 'please, no space before tabs'
and 'line over 80 characters' checkpatch warnings.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 9413cd21e201..55ce9e67d1c7 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -250,10 +250,12 @@ static void update_attrib_vcs_info(struct adapter *padapter, struct xmit_frame *
 	else /* no frag */
 		sz = pattrib->last_txcmdsz;
 
-	/*  (1) RTS_Threshold is compared to the MPDU, not MSDU. */
-	/*  (2) If there are more than one frag in  this MSDU, only the first frag uses protection frame. */
-	/* 		Other fragments are protected by previous fragment. */
-	/* 		So we only need to check the length of first fragment. */
+	/* (1) RTS_Threshold is compared to the MPDU, not MSDU.
+	 * (2) If there are more than one frag in this MSDU,
+	 *     only the first frag uses protection frame.
+	 * Other fragments are protected by previous fragment.
+	 * So we only need to check the length of first fragment.
+	 */
 	if (pmlmeext->cur_wireless_mode < WIRELESS_11_24N  || padapter->registrypriv.wifi_spec) {
 		if (sz > padapter->registrypriv.rts_thresh) {
 			pattrib->vcs_mode = RTS_CTS;
@@ -373,8 +375,10 @@ static void set_qos(struct sk_buff *skb, struct pkt_attrib *pattrib)
 		skb_copy_bits(skb, ETH_HLEN, &ip_hdr, sizeof(ip_hdr));
 		pattrib->priority = ip_hdr.tos >> 5;
 	} else if (pattrib->ether_type == ETH_P_PAE) {
-		/*  "When priority processing of data frames is supported, */
-		/*  a STA's SME should send EAPOL-Key frames at the highest priority." */
+		/* When priority processing of data frames is supported,
+		 * a STA's SME should send EAPOL-Key frames at the highest
+		 * priority.
+		 */
 		pattrib->priority = 7;
 	} else {
 		pattrib->priority = 0;
@@ -420,8 +424,10 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	pattrib->pktlen = pkt->len - ETH_HLEN;
 
 	if (pattrib->ether_type == ETH_P_IP) {
-		/*  The following is for DHCP and ARP packet, we use cck1M to tx these packets and let LPS awake some time */
-		/*  to prevent DHCP protocol fail */
+		/* The following is for DHCP and ARP packet, we use
+		 * cck1M to tx these packets and let LPS awake some
+		 * time to prevent DHCP protocol fail.
+		 */
 		u8 tmp[24];
 
 		skb_copy_bits(pkt, ETH_HLEN, tmp, 24);
-- 
2.19.1

