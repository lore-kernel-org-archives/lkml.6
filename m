Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E8CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C0020657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECO3CHK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C0020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeJaFWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:22:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40388 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeJaFWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:22:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so12688237lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 13:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1BOhPRBeyyTugmq02tnr63je4AqDPCmKKAU4utoq3Js=;
        b=ECO3CHK4osbr1hJAnV5m8Ut57BFiZ83GOPSTcralvCEYPY1zLc1VH7laadGKEFA6zC
         JWzrJdjx5vIIwI1hjFgGa9EoK8nKyERX6u9TFrBI8P1NjA34ZmJ4g2skTiuzppM5pBK7
         ndjdyaoXhCs5EJwIYwIrzeVVp9OOHj7Dp92uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1BOhPRBeyyTugmq02tnr63je4AqDPCmKKAU4utoq3Js=;
        b=Idi9fuHejlX5btynlKHtvymtKdy2sdCecWRk3Zui+wsv1VLuu9HV9Eck4ifTM2Gdh7
         VwCc/Ftlc0+iaP78YhiG65MNPyA8uH//ZRe2esGvkvgQ5suA8k2FY4z3npDULQ9sZfs8
         f1fFIZD6lXTjwks9mo8CK5BFRElhKnq9fryJ3rUPVVrx5Zj7UlwfILl3Sni9N0LFj0yN
         sIESwfkZzs9m0bRfWsWD880kHRy/e2YqUcoDPWmSG7qWxhIKmNqd/V79iDXI33PxobSN
         n8VVf1xuS2t4tMF9wYPvfxzSavBYJMNgSP/ZjStt9XxyUhmlsKfALciz293zJl/mIj2h
         w6lA==
X-Gm-Message-State: AGRZ1gKeJ5rahJ3CdRwhRFsvCu2jiS84QIcfpbHNS8HKjBw90BfiKFdQ
        rLuYGInC+0Nu/7z0oAvBtlG0eQ==
X-Google-Smtp-Source: AJdET5fnMJULJGRooeRjDHudDs7rWPHdnfkS8B7AuGScHoNXJBxujtup+7EswROhM+Iu7Y2oedNPrA==
X-Received: by 2002:a2e:1241:: with SMTP id t62-v6mr110414lje.81.1540931234956;
        Tue, 30 Oct 2018 13:27:14 -0700 (PDT)
Received: from localhost ([195.238.92.132])
        by smtp.gmail.com with ESMTPSA id z17-v6sm427925lfd.14.2018.10.30.13.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 13:27:14 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Praneeth Bajjuri <praneeth@ti.com>
Subject: [PATCH v2] codafs: Fix build using bare-metal toolchain
Date:   Tue, 30 Oct 2018 22:27:13 +0200
Message-Id: <20181030202713.26203-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is self-contained project and can be built with bare-metal
toolchain. But bare-metal toolchain doesn't define __linux__. Because of
this u_quad_t type is not defined when using bare-metal toolchain and
codafs build fails. This patch fixes it by defining u_quad_t type
unconditionally.

Cc: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 include/linux/coda.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/coda.h b/include/linux/coda.h
index d30209b9cef8..0ca0c83fdb1c 100644
--- a/include/linux/coda.h
+++ b/include/linux/coda.h
@@ -58,8 +58,7 @@ Mellon the rights to redistribute these changes without encumbrance.
 #ifndef _CODA_HEADER_
 #define _CODA_HEADER_
 
-#if defined(__linux__)
 typedef unsigned long long u_quad_t;
-#endif
+
 #include <uapi/linux/coda.h>
 #endif 
-- 
2.19.1

