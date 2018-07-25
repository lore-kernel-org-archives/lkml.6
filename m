Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F77AC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F8320671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAJVWwgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F8320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbeGYXal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:30:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42574 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731422AbeGYXal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:30:41 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4-v6so16503edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EKuJdt1BuSxKrJHQc9106MH3cOl4WWqAFUj4SocrZUk=;
        b=YAJVWwgDPq3o3T3A6Vt03FIAEsbvlxGPKfzZM35UfqpEVko0gZDcrRyT6N5liAVB04
         icdBl7jA9fBHQ3zlZZ/ERdesM8+Xu/5Wb1Lhbwtov5cHQ19MWt0IsqCjbkn8fmuNEmyR
         nJ4kYoMXvdFEyquP857v+k1SZerytuD+FcuYIseM71Rkh5T9MdZvxnhxt7hSQqyf0n70
         sxs9Xo+SrxGZOahQsNLORXlNyx9V6qsDUVY1tyZUdCFnmFlkkeHfXN05IIBSEukvfzT0
         iUizM8Dxh0qyW3P7fMnEf9N8Hg/Ab2CT0ohx9SxIVWE7TEvYT95NEYTGuV+BI3cdagig
         fZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EKuJdt1BuSxKrJHQc9106MH3cOl4WWqAFUj4SocrZUk=;
        b=ixI/vbiKbuiM8fDNDLos8k5I7Pe4Fb3RHCeTD2NDhE9LTpv/hcfWby5fyWn+QjL8FM
         2yCU8xCCoDjChvaQdIDtduaNoanCKuMWqJctih/Q+3T/efG9joSHi0Zu9m2QczStBvVk
         FqNuVvj1qQSKSBSyg0FkmiHaoM6wjdXEMYZaQl3MUlrmY2vEu24z/lHnLGNNjXxRgBb9
         +QKymdd7dM6tyqmwmpGYufWxopGoN511qhBVcUs0goeVYvDjE0npnSCFip7yVHx2bT5V
         mkCkXfsGZ726lbVfgna7in/QU72KQJL+OnOOgPsgIGMdMi0N7kBk5DwH7tvMDOZShzmZ
         Nlog==
X-Gm-Message-State: AOUpUlEN1uGofs9pfPN4JyJHUCc6n8+udygST0OPONA/d8YMtxnHYSpr
        BDZnCBnLarBJngy3b0JHNS+1NeEM
X-Google-Smtp-Source: AAOMgpdLsrMOtmKKbz2G7Dr61gbqzGLa719yDpcZ769m96O565ekJ5C4Hykd0lpG3NK6eqqcJI4d6Q==
X-Received: by 2002:aa7:d385:: with SMTP id x5-v6mr25306935edq.104.1532557016760;
        Wed, 25 Jul 2018 15:16:56 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.113])
        by smtp.gmail.com with ESMTPSA id i63-v6sm6808814edi.16.2018.07.25.15.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:16:55 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/10] staging:rtl8192u: Remove unused CMPK_TX_SET_CONFIG_SIZE - Style
Date:   Wed, 25 Jul 2018 23:16:22 +0100
Message-Id: <20180725221630.28595-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725221630.28595-1-johnfwhitmore@gmail.com>
References: <20180725221630.28595-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused macro CMPK_TX_SET_CONFIG_SIZE. This is a coding style
change which should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index 3f366e8317e6..095664a086e1 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -3,7 +3,6 @@
 #define R819XUSB_CMDPKT_H
 /* Different command packet have dedicated message length and definition. */
 #define		CMPK_RX_TX_FB_SIZE		sizeof(struct cmpk_txfb_t)	/* 20 */
-#define		CMPK_TX_SET_CONFIG_SIZE		sizeof(cmpk_set_cfg_t)	/* 16 */
 #define		CMPK_BOTH_QUERY_CONFIG_SIZE	sizeof(cmpk_set_cfg_t)	/* 16 */
 #define		CMPK_RX_TX_STS_SIZE		sizeof(cmpk_tx_status_t)
 #define		CMPK_RX_DBG_MSG_SIZE		sizeof(cmpk_rx_dbginfo_t)
-- 
2.18.0

