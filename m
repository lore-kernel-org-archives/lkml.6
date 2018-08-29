Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7D9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAE62064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXfDnpHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAE62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbeH2U6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:58:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37722 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeH2U6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:58:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id j8-v6so4879454lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 10:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=crQrWW2IG8U9p4rb69T7T4R17Th6b6d/bEWWUKQF8Es=;
        b=aXfDnpHhYQliPMBRfWkndq1vB45gIoyiDq0jUJcpXjuGJKY09DHcH1M/QE+sLlNp4Z
         0H2QA5GnKyN5Qs7pGZefbgd4uWZnnkHyjzPECmXqcTDxWi7UHSBPA6RN3ThjwIhKuQfE
         s2DCOykpP+xxry8LdGTyHck2k+7jYEsz/4Iqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=crQrWW2IG8U9p4rb69T7T4R17Th6b6d/bEWWUKQF8Es=;
        b=pm1IAQ+vjbHKck7/jWcCVsQ1cvJccWPW++oEXv6+wYwAplK6zDd6OgHzk6DveyThal
         Y7x+XkcrFpTEAaoQ3FRedPSQjYwEVzUEFwl06aQd2EjiCR4LQqb1lThVLm9nuSFcKAg6
         NHzf0lMvvC9t9E2aoh5hCPDNVRTev2UFPYxoJboIMaxCL5orv6e9/L4MenEGlz8hPsIH
         osnya/sYKbUpHZAYk1Rt84fyX0LCfrjliaiDF3UedXF+K1FJHTZZZht9k9yIKL8U0mPa
         mW05zWY5fPUR9AFTqN1iem+M1+zCBMmuGMu78IWWO8j1gcPcE6FDzqbbjEkKDvTnqGRg
         lEPg==
X-Gm-Message-State: APzg51CHgH/yaAWP8M2FEl8LFfdcGPu48SXLdETjzJ/QuHBm0dq4wB/A
        IE3rxd29yqDlKGoTLUrN38cHbUDFcZU=
X-Google-Smtp-Source: ANB0VdahyGZFw95ZKTG3qrtCMxLX5ZUvuLD5R2v+qmydClCO4fCMxzPTX+GWI5Bo77PMqySUTD8TSA==
X-Received: by 2002:a19:b24e:: with SMTP id b75-v6mr4834796lff.138.1535562018934;
        Wed, 29 Aug 2018 10:00:18 -0700 (PDT)
Received: from localhost ([195.238.92.132])
        by smtp.gmail.com with ESMTPSA id p65-v6sm800220lja.44.2018.08.29.10.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 10:00:18 -0700 (PDT)
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 1/2] codafs: Fix build using bare-metal toolchain
Date:   Wed, 29 Aug 2018 20:00:14 +0300
Message-Id: <20180829170015.7729-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829170015.7729-1-semen.protsenko@linaro.org>
References: <20180829170015.7729-1-semen.protsenko@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is self-contained project and can be built with bare-metal
toolchain. But bare-metal toolchain doesn't define __linux__. Because of
this u_quad_t type is not defined when using bare-metal toolchain and
codafs build fails. This patch fixes it by defining u_quad_t type
unconditionally.

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
2.18.0

