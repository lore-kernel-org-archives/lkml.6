Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4092DECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 18:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14A3208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 18:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfvCp0Bv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14A3208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeGOSsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 14:48:37 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38977 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeGOSsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 14:48:37 -0400
Received: by mail-pf0-f193.google.com with SMTP id j8-v6so551907pff.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B1u5sUnJYATnmbKCsneAweKzVis/lrzp79JF/HZKXQw=;
        b=CfvCp0Bv0FwnM83QtO666H1h/E3B1L50CjCkyLTMqxpY169nmS2kqwH+raMC+X7XHp
         jWdlCxY0Fl25NRUPyyCNDFaQRPN4NgWaJxL5S4zrVBXFRGOm08AchfnN0WDfEx1f4EtN
         uJoGHUH5Krv83Q6SbrltJQ2KdAFBprqSga3DKbF/bzimv7koRb7DkAAV8uk0xthPRT2O
         Ef1qGZbDMVKsPgaaSZN9rsvfP1L7pscafgzS8wKSuBo3t3Wqss4XiPGJVxbO+qBVXCN9
         XDjoQiA/dQ3vM22Qm438jvDVAbBa11pF04a95aqMHq7ePpr86Vwr5TsIHHfvaZe7XAL7
         6GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B1u5sUnJYATnmbKCsneAweKzVis/lrzp79JF/HZKXQw=;
        b=A9wjWrIJxdbSS+lzQqJCFMY1dCMWGmqOBJ6qAs89/dWUAj4gy35B/osxKAslA6U3gN
         NGQ6r+rtsLLNqum9F8bKm+x7flSnVxvMh3EDlVHSYVeGX0Ua/KPM2D+3nIVS4+A5BrwS
         dA6GxfcBv1vLMzslO+nqwNdLBWIilWEDDIzXWae0MKjuSf6D8HChz4ED0zR2TM2yrVls
         QinyXKYe9AOpqZtjDxUSEa3qu+Vp7kbhRrDd2+W/jerCd7oNa4heW2/p8TXO7v4UTra9
         tX36Ok6XuWz82ehm6zehPELuo5HV2N3+Ie+97xRGAuf5/Wt9Da7M/27GfQZR3MT+jpOi
         UzLA==
X-Gm-Message-State: AOUpUlHGgT/yedhdYkTGjZeANq+f8rB+pzJd+Zzl5THmFKwMM9A2XmrE
        7tyiLiRQkRRJPVJjiQhN7JY=
X-Google-Smtp-Source: AAOMgpdNKRdCjgFQ8v8lD9y3YzvdVoWsvvUuwcE99HP4/iZ8tZK/bvMQmFxLSL1hTR5gri9hP0RE2Q==
X-Received: by 2002:a63:c902:: with SMTP id o2-v6mr12997925pgg.118.1531679091923;
        Sun, 15 Jul 2018 11:24:51 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id r19-v6sm27680426pgo.68.2018.07.15.11.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 11:24:51 -0700 (PDT)
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
Subject: [PATCH resend] staging: gasket: don't release coherent mappings
Date:   Sun, 15 Jul 2018 11:24:41 -0700
Message-Id: <20180715182441.187653-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

coherent address mappings aren't backed by a struct page, don't need to
be released, and don't count as an active page in the page table
bookkeeping.

Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index dcd52e141f95..e71baa11c8de 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1233,7 +1233,7 @@ static void gasket_perform_unmapping(
 				dma_unmap_page(pg_tbl->device, ptes[i].dma_addr,
 					       PAGE_SIZE, DMA_FROM_DEVICE);
 			}
-			if (gasket_release_page(ptes[i].page))
+			if (ptes[i].page && gasket_release_page(ptes[i].page))
 				--pg_tbl->num_active_pages;
 		}
 		ptes[i].status = PTE_FREE;
-- 
2.18.0.203.gfac676dfb9-goog

Resending, extracted from the previous stack of patches that needs
other cleanups.
