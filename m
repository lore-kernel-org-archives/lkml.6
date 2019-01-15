Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E1AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1551620645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYwdVHRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbfAOQ7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:59:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39401 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbfAOQjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:39:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id y8so3876553wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 08:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MSpKPEBgQGCyZ/IwTCezcZ1oE23TqpU3XsTXbisJI3I=;
        b=QYwdVHRwuxnTOMI1iVQPPgANUzbTIE2C+3pQ4TcTv/NrTrbZX3HmJVotPYrlheqzCi
         fP/qrC7TJcu4EtyVVBCkghoWQskhyj8AfB+S8qigUXwrfQu1sJLLQCPSAeZHCPV+6Ngj
         XQmD7+Lj5XPsekW4yQDQXAWFv0Zf/FhZFbKtmKraG5UzKAimiQ6ecVSwkjpUYYEq7bZb
         igd1atdCxG4qYqQKFI7AhrkoRO0YMvjCs+L71NqMU2U0rKa6LA4kLZ3zVa0NaiflcJLb
         5+1wWWRTe2k2tyXTJvbQl1j66TTaiwJ7ld/xkJecqgWgRlmKZR4p56oDv1p0qfaBhr/I
         2aMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MSpKPEBgQGCyZ/IwTCezcZ1oE23TqpU3XsTXbisJI3I=;
        b=PQwAHNuSV4HyTorLH27GoKCLYCWwmMiMz4Zxg9xj7lJLWskKUQLHEJMtHIW3SVubsg
         pwBSliAtfXL+ktqUSPiY1s2wKAcZiaq+BQa278ZiBHnwaaKUCuyrt8LQ1fe2Nz3OFB3A
         I4vh+BseWyDtp5Ycc0QhDhR1d0+nrrI6NGCjbEOID0lt7mFF4uhHSG3Yqrio4kEtcmcj
         a/Vi0nT2v+JAC2HZpDiQc5B/DKorZP5PnjpWCNrsYSwOHs3T/+CmICyfaroAnaTt+59d
         c4h0iCxcicTQ+A3S1q6RKGxWNEsSoxgO2iGLrLFaC6tjf6X3xjfrxacEv5cUlwIpvcS8
         xFVw==
X-Gm-Message-State: AJcUukfF/jvVva/GXbbDEhMHPabGba2lqn6OeBBirlN0wWtQDmJVUyXS
        +gKliH0XpAmOG+sGmor+4TE=
X-Google-Smtp-Source: ALg8bN5fBkjLf07kKhl8gl2x0ihDu00y/Qd65pGVItpKjIUFAn7JwgDHDS4HyuDdHm/pKEHyAvwLZQ==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr4198542wmc.116.1547570341586;
        Tue, 15 Jan 2019 08:39:01 -0800 (PST)
Received: from localhost.localdomain (ip1f12f8bc.dynamic.kabel-deutschland.de. [31.18.248.188])
        by smtp.gmail.com with ESMTPSA id c65sm32973558wma.24.2019.01.15.08.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 08:39:00 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/2] staging: rtl8188eu: cleanup declarations in os_intfs.c
Date:   Tue, 15 Jan 2019 17:36:39 +0100
Message-Id: <20190115163640.2598-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces and/or remove extra spaces in declarations.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2
added missing Signed-off-by

 drivers/staging/rtl8188eu/os_dep/os_intfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index 6681383579ee..6ed4a06a0796 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -137,7 +137,7 @@ static int netdev_close(struct net_device *pnetdev);
 
 static void loadparam(struct adapter *padapter, struct net_device *pnetdev)
 {
-	struct registry_priv  *registry_par = &padapter->registrypriv;
+	struct registry_priv *registry_par = &padapter->registrypriv;
 
 	GlobalDebugLevel = rtw_debug;
 
@@ -248,7 +248,7 @@ static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
 			    struct net_device *sb_dev,
 			    select_queue_fallback_t fallback)
 {
-	struct adapter	*padapter = rtw_netdev_priv(dev);
+	struct adapter *padapter = rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	skb->priority = rtw_classify8021d(skb);
@@ -263,7 +263,7 @@ u16 rtw_recv_select_queue(struct sk_buff *skb)
 {
 	struct iphdr *piphdr;
 	unsigned int dscp;
-	__be16	eth_type;
+	__be16 eth_type;
 	u32 priority;
 	u8 *pdata = skb->data;
 
@@ -286,7 +286,7 @@ static const struct net_device_ops rtw_netdev_ops = {
 	.ndo_open = netdev_open,
 	.ndo_stop = netdev_close,
 	.ndo_start_xmit = rtw_xmit_entry,
-	.ndo_select_queue	= rtw_select_queue,
+	.ndo_select_queue = rtw_select_queue,
 	.ndo_set_mac_address = rtw_net_set_mac_address,
 	.ndo_get_stats = rtw_net_get_stats,
 	.ndo_do_ioctl = rtw_ioctl,
@@ -361,7 +361,7 @@ void rtw_stop_drv_threads(struct adapter *padapter)
 static u8 rtw_init_default_value(struct adapter *padapter)
 {
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
-	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
@@ -431,7 +431,7 @@ u8 rtw_reset_drv_sw(struct adapter *padapter)
 
 u8 rtw_init_drv_sw(struct adapter *padapter)
 {
-	u8	ret8 = _SUCCESS;
+	u8 ret8 = _SUCCESS;
 
 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_init_drv_sw\n"));
 
-- 
2.20.1

