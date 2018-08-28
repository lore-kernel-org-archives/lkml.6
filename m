Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1126DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEFF20851
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRHDlIgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEFF20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbeH1SQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:16:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42214 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbeH1SQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:16:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id f1-v6so1583769ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tIDOHwRKxCYxaDFqqH/tkWpkFutM4/6P5ONExsDModw=;
        b=gRHDlIgw/UL2aiHtKC8zHOGTa3c5PW+AggNOiUH4/CFBjvmuSvo3wH5Smp7FOeAY5F
         tbRQSyTaNHb3Svvgs99hQcVnktN2joNMFxh1o8DJzMvZIOwyUEDq2oNdgw3Pm+IXXF37
         I0/iEbngr1/FsFku7xLKT66iwsdoUK22UInqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tIDOHwRKxCYxaDFqqH/tkWpkFutM4/6P5ONExsDModw=;
        b=XKUHIK3RSf1SkPZ0Y0uEnGoDW7VZqK4A4UvUzRfZ8Ro60ZxA9nz4I51Qezlnb98nPi
         VRoCKOeyOGr4wdOKx0KSAtVxgIo/y5iE2zxpKlEYF0tEemVsYUlulqbDWRuZjP3sp0p8
         F9PlyEy42ahu63rB+r+AmW0tHtbwJ1EAulq7Wn9TTZbys49RUidQppbxrpsWE6sL4cOD
         58wEOgfRJeFtruvdqn3LDykpAakDUi6XZNKntqURz1XKTP8Z5etW+JZKMprnBdAxx1zb
         DyT4xtuX3ELzIVB1r929rMyB19P+ur9KZPvxPrAscJk6R8/iUXhuW5RmOE0zW2gEZqtx
         vpQg==
X-Gm-Message-State: APzg51D9tknCcn0IjH4h80MgbfyTm1RwdPaxXLTaEicb4HrVUFO12W02
        hNfOAHdKFOcytss14yPf6nKRKV7mDDc=
X-Google-Smtp-Source: ANB0VdYOduSlaB9j8au62yV/wHCyyB7JttltZw8IsIh9q67YiziWWqni9nn2b7rm1cMI/D1xJ3wzZA==
X-Received: by 2002:a2e:9ec9:: with SMTP id h9-v6mr1293583ljk.133.1535466265246;
        Tue, 28 Aug 2018 07:24:25 -0700 (PDT)
Received: from localhost ([195.238.92.132])
        by smtp.gmail.com with ESMTPSA id u4-v6sm246231ljh.36.2018.08.28.07.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 07:24:24 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Paul Sokolovsky <paul.sokolovsky@linaro.org>,
        Miklos Szeredi <mszeredi@suse.cz>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 1/2] codafs: Fix build using bare-metal toolchain
Date:   Tue, 28 Aug 2018 17:24:20 +0300
Message-Id: <20180828142421.15335-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828142421.15335-1-semen.protsenko@linaro.org>
References: <20180828142421.15335-1-semen.protsenko@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is self-contained project and can be built with bare-metal
toolchain. But bare-metal toolchain doesn't define u_quad_t type.
Because of this codafs build fails when building with bare-metal
toolchain. This patch fixes it by defining u_quad_t type in case when
non-Linux toolchain is used.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 include/uapi/linux/coda.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/coda.h b/include/uapi/linux/coda.h
index 695fade33c64..098a6c318b0a 100644
--- a/include/uapi/linux/coda.h
+++ b/include/uapi/linux/coda.h
@@ -96,6 +96,11 @@ typedef unsigned long long u_quad_t;
 #endif /* !KERNEL */
 #endif /* !DJGPP */
 
+/* Handle bare-metal toolchain case */
+#if defined(__KERNEL__) && !defined(__linux__) && !defined(_UQUAD_T_) && \
+!defined(__UQUAD_TYPE)
+typedef unsigned long long u_quad_t;
+#endif
 
 #if defined(__linux__)
 #include <linux/time.h>
-- 
2.18.0

