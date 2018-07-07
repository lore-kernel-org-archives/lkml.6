Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22C2C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 19:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C0E21475
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 19:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1kMzhkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C0E21475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754322AbeGGTXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 15:23:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37913 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754124AbeGGTXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 15:23:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so11376390ljc.5;
        Sat, 07 Jul 2018 12:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=i8wVfeGCsxXErXhahEPIR0fR2GJ0F5F1rFwG6+xw49c=;
        b=J1kMzhkSUisuhXpH4tgPVgZ7Iu6vPk3F7apkc0pDW/YCdVFLNixI1XVgoWDKLNplbU
         6AliDv4OjT2TVqmztGq5Agm1Lsw6FtPkl88FfFPUUbsi1BKGhFvZb/6yZVfsYzXbYJDK
         LZUgdvnGTnMaJvYgmy0N8Cp1V7bsze5Ei/nlMBo6fWkH8EAQags0YIDKPsis+ahm4rvz
         8W1W+k49UtxCZw+QquqkGN/mKF790YNg39EB9R6OHGiqaOwD4NuAbY1HXYvckV7Otntt
         MEHRQ/Jf1jwv37u2QI9265hDvDqMLOxlcXD53xGtvX+vIBcagST4Zk/LOUPUCL6pvNpN
         1DZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i8wVfeGCsxXErXhahEPIR0fR2GJ0F5F1rFwG6+xw49c=;
        b=kM0TVPoXpDBXgvJVFoY0TFCaq9og1A5VRBMZxQezQm/YYH8SvmfYEqkLtaI+E+tPGT
         4CIykWFaAfqSXKmQzunxB4HCYiW4J2UVgbNLX0C9DythPSYFnlf8b6oEd4mG3YPbob+S
         K8buSFilM1bXggurHIMjA4VNH5H4mrSC49rzJJuZV3TeypZIVCMip6FK7D1a+9x5GOLV
         6N3WYbNkZ1Jl+nc+DippaXWxHz+xa2Qh27T30ClM6mW8WTfXaxi/rm1NBVFeXU4aaogP
         uMGH4JxrlmgGVsA1vvpfQkwBxbNhyWMvrENF6yWRqtCZ65EDCYIWPN5h4MrwNyZS4QwB
         2uQg==
X-Gm-Message-State: APt69E3h4TmwZ1vV2H8LCDIx7IcySk5DY98YMbo+r7FVpr4y1EPITdAz
        uchjOS5K4Edx63r5j9Q3Jnc=
X-Google-Smtp-Source: AAOMgpeEaJ/RRP9b7wtq1bhRf9gvBmNNgtNTkiZTnotuDXyn5mXeGZ0RF+f8UnJJriFfdcaJal4qkA==
X-Received: by 2002:a2e:5012:: with SMTP id e18-v6mr9550895ljb.22.1530991409147;
        Sat, 07 Jul 2018 12:23:29 -0700 (PDT)
Received: from radek-K75VJ.NAT.warszawa.vectranet.pl (093105176145.dynamic-ra-01.vectranet.pl. [93.105.176.145])
        by smtp.googlemail.com with ESMTPSA id q16-v6sm3074176lfi.68.2018.07.07.12.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 12:23:28 -0700 (PDT)
From:   humbabek <humbabek@gmail.com>
Cc:     humbabek <humbabek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Maloney <maloney@google.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] move smp_rmb() after load of status
Date:   Sat,  7 Jul 2018 21:23:17 +0200
Message-Id: <20180707192319.24771-1-humbabek@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: humbabek <humbabek@gmail.com>
---
 net/packet/af_packet.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 57634bc3da74..91830ef07c48 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -394,25 +394,30 @@ static void __packet_set_status(struct packet_sock *po, void *frame, int status)
 static int __packet_get_status(struct packet_sock *po, void *frame)
 {
 	union tpacket_uhdr h;
-
-	smp_rmb();
+	int status;
 
 	h.raw = frame;
 	switch (po->tp_version) {
 	case TPACKET_V1:
 		flush_dcache_page(pgv_to_page(&h.h1->tp_status));
-		return h.h1->tp_status;
+		status = h.h1->tp_status;
+		break;
 	case TPACKET_V2:
 		flush_dcache_page(pgv_to_page(&h.h2->tp_status));
-		return h.h2->tp_status;
+		status = h.h2->tp_status;
+		break;
 	case TPACKET_V3:
 		flush_dcache_page(pgv_to_page(&h.h3->tp_status));
-		return h.h3->tp_status;
+		status = h.h3->tp_status;
+		break;
 	default:
 		WARN(1, "TPACKET version not supported.\n");
 		BUG();
-		return 0;
+		status = 0;
+		break;
 	}
+	smp_rmb();
+	return status;
 }
 
 static __u32 tpacket_get_timestamp(struct sk_buff *skb, struct timespec *ts,
-- 
2.17.1

