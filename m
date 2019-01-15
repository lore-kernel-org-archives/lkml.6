Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E33C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78D22085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjbyYxC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfAOIYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:24:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44098 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfAOIYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:24:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so1825600wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 00:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ceyhajqZIn+B4i5ABRJLHZESFW52Xvmly05+SruugB4=;
        b=RjbyYxC0kCZzFnZTazkybbWGaStFhx2vEhnAHrtymU54NUJFrVAQ0mQ+yXWyg1q83K
         LmTRapYpp3xjESe5I3dqvCzYBBTh0lK6IL5oVbD6v9UUm4olcUnVO9KGYKFCx1I4Mix7
         r07IQm8YeEBcBeaY3Nz6FYx5J3iH/yxkz17AN3hOubwIJUic0wdMQA1P3CU7MRO2DNr5
         GV6bjSBCTs8Hwqq4f4cDAHWltAxL2nnXnudKlMNgH0j5QdsJJxn9PkXh+IFwwvrfNRzQ
         FbgmacxL5l6aBhgijBLfMR9zsPPUIcdTkfjjl712+esXU7e+ZHVbPLvmJwoaJZbeFPoC
         sdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceyhajqZIn+B4i5ABRJLHZESFW52Xvmly05+SruugB4=;
        b=q75WbCiXv8ybYewgemj7GNR9qyK/LSC7thykyATI8Hp552LA85qSkKswTWFAgnRrok
         s0pdCw/Ti1xWmqJaQ8k7oIeTh8q9LPc9lvFpvBXsJE8UyR90xdtCLIeW2g4WjAqSv4ie
         BZTbgOVOlHKKIDXnt8pcrptGybsLa7DR4yqHTXTi+cDfv8SOAuu1SxT9lTJevub6VqjR
         nx4n8rac+WZNH0Mpn5yC/hVRA0SVnN/nBI9Ba8rn/wXJQghd0yn0e1nm3Z6B2qfNj1AA
         L2xF7xHMDnbFZ7G3q8GhGdved48Da1AC9gdh1/k4hj/gmdAOctSHbsvATqTA8fo3X4si
         aagg==
X-Gm-Message-State: AJcUukfb7iv249OlqeXcjyVAdLm5JVSbLW9cHhAAEerYl7c8OLz3qdjp
        JF/3VX4XUQArF7wWzgUlZSY=
X-Google-Smtp-Source: ALg8bN6VeGENkAorBN09CPEbdNcqL6fTgr0Q7H1Fteyea6kWjsV23KR2p36GbbPlcdUkh+rzX5WILQ==
X-Received: by 2002:a5d:6450:: with SMTP id d16mr2003472wrw.64.1547540656106;
        Tue, 15 Jan 2019 00:24:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id u10sm62556295wrr.33.2019.01.15.00.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 00:24:15 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8188eu: add spaces around operators in os_intfs.c
Date:   Tue, 15 Jan 2019 09:24:02 +0100
Message-Id: <20190115082402.8519-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115082402.8519-1-straube.linux@gmail.com>
References: <20190115082402.8519-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '+', '<<' and '*' to follow kernel coding style.
Reported by checkpatch.
---
 drivers/staging/rtl8188eu/os_dep/os_intfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index 6ed4a06a0796..dfba6b725790 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -267,11 +267,11 @@ u16 rtw_recv_select_queue(struct sk_buff *skb)
 	u32 priority;
 	u8 *pdata = skb->data;
 
-	memcpy(&eth_type, pdata+(ETH_ALEN<<1), 2);
+	memcpy(&eth_type, pdata + (ETH_ALEN << 1), 2);
 
 	switch (eth_type) {
 	case htons(ETH_P_IP):
-		piphdr = (struct iphdr *)(pdata+ETH_HLEN);
+		piphdr = (struct iphdr *)(pdata + ETH_HLEN);
 		dscp = piphdr->tos & 0xfc;
 		priority = dscp >> 5;
 		break;
@@ -323,7 +323,7 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 	padapter->pnetdev = pnetdev;
 	DBG_88E("register rtw_netdev_ops to netdev_ops\n");
 	pnetdev->netdev_ops = &rtw_netdev_ops;
-	pnetdev->watchdog_timeo = HZ*3; /* 3 second timeout */
+	pnetdev->watchdog_timeo = HZ * 3; /* 3 second timeout */
 	pnetdev->wireless_handlers = (struct iw_handler_def *)&rtw_handlers_def;
 
 	loadparam(padapter, pnetdev);
-- 
2.20.1

