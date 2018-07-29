Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8F5C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A8F20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiQPggjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A8F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbeG2Whh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:37:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43669 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731466AbeG2Whh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:37:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so10585551wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=++t0u7nIq4z5gcK4uzdbg9UIz3urn9Qn37qAku0EuuE=;
        b=uiQPggjfw+pf8I6ipL3c70jDOjudil2DWY6tVrXbpWA1SqU7mtr/Tzze4rzHW/UgHO
         xxcXmGICvDIrrQ4b46NShcmN40H4VSsDryCo6n8k5Ch6DzWHJ7L1obdDb5lviU2v+mRn
         06stP688zaGW+bshBhjvPgUukxaiN9wyR8lUHA17kyeyiF+9Go8rPOz8urvhismwP0y2
         ntpVN+Ai0/eBAN7qbKUhSd2+zj4oiGMgDouw2w02dPtwMONMZ+fgqodYAy/svNlAdZaz
         qT0hnGQIyjzLXuZytXJl7JRPazVdVMi6E0Bh302NBMTz4ETHRd2n/qKrhG3iNHJt6Gb/
         pH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=++t0u7nIq4z5gcK4uzdbg9UIz3urn9Qn37qAku0EuuE=;
        b=CeP51Kof0d83L+FgQOvRpqwuxqs8zlCLwMBnsHpmAfsoRAtZbLIpKWPmviTE+u9I/b
         0x8sscdUnVkfnPGT48tbwPHcGjpRpHpyWDYnro59vOjOLUjhGjet4b3aDK94M3ZCOV3o
         dLg8vyc8EbodOtPftjxtp/QbZfZHB8ODCRKcAsC3+L0fP2ky9V+rmsDvejo4owJSaWV3
         1b8P+Ar/DXc1IDZEP50Cq8DeYUkN16E5pJ7UgxoapMi+KHd5bXMfgJpLkYIEAVwYVqmx
         gjx8d7eZPHM1pT+Po8yIdKUAQWbuXxqWEGRfTGILkT1QwfWnPtatkMHEhmo2DIke1Izl
         eC/g==
X-Gm-Message-State: AOUpUlFr+hEextHRmgqO9aKHisY5BBWdg7ij9kB0jR56s8p8xcknpAXW
        iZu6KLvODlxe1tUz15x0Gi9/eQb8tds=
X-Google-Smtp-Source: AAOMgpeRGC7YQqSRR1upZWZ3ZX7ycnIL0VYHW3EhK2YRTIGGPIrToxYWxXfR9w/QHF7qB5aloQAYEA==
X-Received: by 2002:a5d:4f82:: with SMTP id d2-v6mr14636295wru.261.1532898346465;
        Sun, 29 Jul 2018 14:05:46 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id l19-v6sm10476876wmc.3.2018.07.29.14.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:05:45 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 02/15] staging:rtl8192u: Remove unused CMPK_TX_SET_CONFIG_SIZE - Style
Date:   Sun, 29 Jul 2018 22:05:14 +0100
Message-Id: <20180729210534.10617-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210534.10617-1-johnfwhitmore@gmail.com>
References: <20180729210534.10617-1-johnfwhitmore@gmail.com>
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
index 756e08bd341a..fab982668b44 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -3,7 +3,6 @@
 #define R819XUSB_CMDPKT_H
 /* Different command packet have dedicated message length and definition. */
 #define		CMPK_RX_TX_FB_SIZE		sizeof(struct cmd_pkt_tx_feedback)	/* 20 */
-#define		CMPK_TX_SET_CONFIG_SIZE		sizeof(cmpk_set_cfg_t)	/* 16 */
 #define		CMPK_BOTH_QUERY_CONFIG_SIZE	sizeof(cmpk_set_cfg_t)	/* 16 */
 #define		CMPK_RX_TX_STS_SIZE		sizeof(cmpk_tx_status_t)
 #define		CMPK_RX_DBG_MSG_SIZE		sizeof(cmpk_rx_dbginfo_t)
-- 
2.18.0

