Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E00C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423C121723
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eMgAMk5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423C121723
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbeHOBZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:25:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35019 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbeHOBZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:25:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10-v6so9749710pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 15:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDSDC8Nea085diqbKG+0UCh2FToyzV6QGtwZCp0qnEk=;
        b=eMgAMk5MOaCVYJCLTfg2zokNtxKrlG6cREo2LoyBmAFu3pCXZMe7Q1WZTNvMxj/XoR
         KQegSS+I8THjfJtiqN6rK2UErlXBsL6ytafSvN9MHG2ZZbKm2+FUJ38ClOIfa5IRwXLD
         YU6yTTiAy92QFsKTuP2BF7u+A7djcix9UO/GwripW6uofuMgtD7LRVBaaP6ActcbKWEA
         elN4eEo1Ue+/SKgQ8B5qSCQi0fw9N2o4BJCTCH/UnrBefowY8ul4yzoqzVetX4laDF7s
         YtDBilg0MYGnYa5nC5FNtcCEzLXi6cu9OatmaR9mKidA+q5UeG+K2gutTQX1kZjElSUl
         CV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDSDC8Nea085diqbKG+0UCh2FToyzV6QGtwZCp0qnEk=;
        b=WdZZp1nlSQtVj3OsNUGlq3yyTm45qvHffzBAocZpGdQAqlrTQPeIx6C2ySNveObWgs
         fc1Lp/Szg1NpRfXfmpwLc7tD8efr6LH8B0kX6Li9r/lJ8qnoxl6E4ZZtEbbjmIXV0DM5
         YwZNwlo5mHorzgCr8YHslsh/0YOK/Xlmq6Fnp4xrZmmT4RJgpWYZVP+tv+JL4KGMgWOA
         AZXN4T7joxI+CfLTGa81OmrzlNZZ0F2uZzJnGpz+jvRSF3ssfWl6TUCLZamS1Vdb1CvI
         sMGJP7Hy90F0akepUv4srWKzNHRKP1ktHBshshFH6RffzVatTezrFehHzMasLlx1zeAc
         LBug==
X-Gm-Message-State: AOUpUlGCP+6wgcKB0uPQtkXlGg4L9hZl8WApZ6TzzZEZ7mci0zluN2XU
        5Kly9hheCHzkbUIPfJbNFldvEA==
X-Google-Smtp-Source: AA+uWPxp97rEWkK0uMGoGMBJGbZdbzPFtL6G9Dr1dkcNld9bVdNRn/urY88YRqcJDOi2hbj8yHA8uA==
X-Received: by 2002:a62:4898:: with SMTP id q24-v6mr24873113pfi.58.1534286177484;
        Tue, 14 Aug 2018 15:36:17 -0700 (PDT)
Received: from surenb0.mtv.corp.google.com ([2620:0:1000:1612:45b2:1550:405f:3ba1])
        by smtp.gmail.com with ESMTPSA id b21-v6sm60621039pfe.148.2018.08.14.15.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 15:36:16 -0700 (PDT)
From:   Suren Baghdasaryan <surenb@google.com>
Cc:     security@kernel.org, dan.carpenter@oracle.com, kdeus@google.com,
        surenb@google.com, Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] NFC: Fix the number of pipes
Date:   Tue, 14 Aug 2018 15:35:19 -0700
Message-Id: <20180814223519.13610-1-surenb@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to ETSI TS 102 622 specification chapter 4.4 pipe identifier
is 7 bits long which allows for 128 unique pipe IDs. Because
NFC_HCI_MAX_PIPES is used as the number of pipes supported and not
as the max pipe ID, its value should be 128 instead of 127.

nfc_hci_recv_from_llc extracts pipe ID from packet header using
NFC_HCI_FRAGMENT(0x7F) mask which allows for pipe ID value of 127.
Same happens when NCI_HCP_MSG_GET_PIPE() is being used. With
pipes array having only 127 elements and pipe ID of 127 the OOB memory
access will result.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/net/nfc/hci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/nfc/hci.h b/include/net/nfc/hci.h
index 316694dafa5b..008f466d1da7 100644
--- a/include/net/nfc/hci.h
+++ b/include/net/nfc/hci.h
@@ -87,7 +87,7 @@ struct nfc_hci_pipe {
  * According to specification 102 622 chapter 4.4 Pipes,
  * the pipe identifier is 7 bits long.
  */
-#define NFC_HCI_MAX_PIPES		127
+#define NFC_HCI_MAX_PIPES		128
 struct nfc_hci_init_data {
 	u8 gate_count;
 	struct nfc_hci_gate gates[NFC_HCI_MAX_CUSTOM_GATES];
-- 
2.18.0.865.gffc8e1a3cd6-goog

