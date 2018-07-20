Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7F4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A9020833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn47Ltz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A9020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeGTEhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:37:01 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33403 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeGTEgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:11 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so4570044plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=khOxDhevnymFnYRKR9We1vfbyjly4X6615Z796xc6sM=;
        b=dn47Ltz/d8x4b1gzwefoWHIsn1crlG8hyMTd2mNbM/uO35qkvYAezGQh58+rYAH+BN
         hRvsBpcYiWLVQFnZbtctDFUy2eeFy7NXpFaL4cYH7K/+qvI3k3fkris0fsq3DAneFuCv
         NdfPkI6upl6LTRMNhlZrLDd1ohf+NpwdFQnFa/tm8DPVI3UYu+GPhw880zdz+jF+M1nK
         eRdrc3GNf4jhhsQP5h+RRmcVsgd3UTRzfesICywPkiB7VzWvachuHQYtToIOpVwEvxp1
         Z0wtHxvSq5jLBhf7dCKkDCr++De6Ihive4Q393w/QMV++utYw3YTHLS2AbzPoQjiZxp0
         QXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=khOxDhevnymFnYRKR9We1vfbyjly4X6615Z796xc6sM=;
        b=Uobm5MCm7Y+yxVFokrnOCvSm5pXW6cnGiyB9hAjZPWGUltXw55zB4ZDo9IWINQGWoE
         enErUEtqz6NtXxVlxiTa0IJA/N8QjfZxN5gKzFte82LYTB4VTN2IsKfovXDcb1Kn2fxi
         xmCszerA394UysxpBX6uMEFogCrbmPem6VrkTSy8MWnqLBPcklK71CVYEa0E8lkXoyE4
         Wj6WXJ8X0IwBF2d2xS3pggd0QlNh2gEp2laYcznAH/Uk83lH3QaAazOScOZ3wb6vdt9o
         VGNIu42azlga0kscnLFlP3xx7UCBmEzDHiEFcmNyNmLuZUhhMHNbKtHPb1cWji/BacSk
         ytJg==
X-Gm-Message-State: AOUpUlGeKSNm0U/kaH9HOitYRb2UlrjnMWxjCuaLdOh67TLRn2/u5WVw
        8LBba9u1aFYfsnIHmRFGv7o=
X-Google-Smtp-Source: AAOMgpfWOIxGf6WEqYlfLZipGpPCBbGnogfW4o/rMyUAZwQUb2CW9+S3p27A4TZZ0UulChrfh1vL6Q==
X-Received: by 2002:a17:902:b612:: with SMTP id b18-v6mr418970pls.131.1532058600876;
        Thu, 19 Jul 2018 20:50:00 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:50:00 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 12/20] staging: gasket: remove unnecessary parens in page table code
Date:   Thu, 19 Jul 2018 20:49:12 -0700
Message-Id: <20180720034920.77320-13-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_alloc_coherent_memory() extra parentheses in statement.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 617d602b8b447..9f8116112e0ac 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1639,7 +1639,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 	dma_addr_t handle;
 	void *mem;
 	int j;
-	unsigned int num_pages = (size + PAGE_SIZE - 1) / (PAGE_SIZE);
+	unsigned int num_pages = (size + PAGE_SIZE - 1) / PAGE_SIZE;
 	const struct gasket_driver_desc *driver_desc =
 		gasket_get_driver_desc(gasket_dev);
 
-- 
2.18.0.233.g985f88cf7e-goog

