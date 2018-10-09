Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B648AC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8E420835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="NP0NSSbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8E420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJISgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:36:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37947 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeJISgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:36:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id c1-v6so1319566ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2SEi+p7mmP740+ZUFGEVFjrP8Zm4MxuBcs8jm2kUR4=;
        b=NP0NSSbPezXalr3bWXk/XN9Jfvhp3kScQd49m4rFKCTrodQ0JntpjkUqUWmKgBj58p
         5T9pUnY1s+b6WpziT5ATs5RriPMTS3RFCLtNg++g+Wta+X1Ew+I2GcqEFbA5/nwisEns
         zMTUNAkbKu9JCh7iw3p5wUK87wXs3llnnqyNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2SEi+p7mmP740+ZUFGEVFjrP8Zm4MxuBcs8jm2kUR4=;
        b=smUY6mrx2DfPVAm1mt6yuto5bR3ob15HKxYYRazSc0bc1Fd9KicD7+PfOIdGuSZPMp
         z+BK71lPL6kQkK4jt3ses7ltluI7wPoGo10chbc0CH/FRufKJ+g2aT1nuf0ebINtgNm4
         SrGr8+FJmnF6RSnbjo3qWnEUeiCaBaB8ghhk2McgS92gDh3zH3AK4t5BRe2hVhHOAqlD
         C/FKVLsvV3QEKpAo9SqZOdkrCEXwLYnsWj071mJ25a8oshYFYQvpNmOaJClZBmil0Wtu
         jgw3ynT25Qw9dUjcPkx36nSjxuN0s4XKI2FLwD0QBbmHv3XgTeG991F056oNlLaGKDzN
         IHHQ==
X-Gm-Message-State: ABuFfohqIykuf6r+pCF5uWXEDJOlPCSOaxeksZjYMLxjq2/w1coWvqSr
        6n6UkPvFWMYOxj27rTRxOWeN6kBzb1o=
X-Google-Smtp-Source: ACcGV615QFyUghS7285emI8Uxlle2xTovTOCri5NJVtAKhMzOm5PtgBP4dbPfejt6tHm2fzBi0Y8BQ==
X-Received: by 2002:a50:8807:: with SMTP id b7-v6mr34130191edb.182.1539084021794;
        Tue, 09 Oct 2018 04:20:21 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:21 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 02/23] linux/device.h: use unique identifier for each struct _ddebug
Date:   Tue,  9 Oct 2018 13:19:52 +0200
Message-Id: <20181009112013.14238-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.4.g721af0fda3
In-Reply-To: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20181009112013.14238-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes on x86-64 later in this series require that all struct _ddebug
descriptors in a translation unit uses distinct identifiers. Realize
that for dev_dbg_ratelimited by generating such an identifier via
__UNIQUE_ID and pass that to an extra level of macros.

No functional change.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/device.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 0d8ed2adfc73..81108db013e4 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1497,7 +1497,7 @@ do {									\
 	dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
 #if defined(CONFIG_DYNAMIC_DEBUG)
 /* descriptor check is first to prevent flooding with "callbacks suppressed" */
-#define dev_dbg_ratelimited(dev, fmt, ...)				\
+#define _dev_dbg_ratelimited(descriptor, dev, fmt, ...)			\
 do {									\
 	static DEFINE_RATELIMIT_STATE(_rs,				\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
@@ -1508,6 +1508,8 @@ do {									\
 		__dynamic_dev_dbg(&descriptor, dev, dev_fmt(fmt),	\
 				  ##__VA_ARGS__);			\
 } while (0)
+#define dev_dbg_ratelimited(dev, fmt, ...)				\
+	_dev_dbg_ratelimited(__UNIQUE_ID(ddebug), dev, fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define dev_dbg_ratelimited(dev, fmt, ...)				\
 do {									\
-- 
2.19.1.3.g1d92a00e68

