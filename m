Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A777C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED56421906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3UYMNbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389108AbeLUH25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:28:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34806 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732558AbeLUH2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:28:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so2121700pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6vSSSEdtBWJbFYHG/SzU1RcinihqOnESUQ8p2WZbatI=;
        b=g3UYMNbgccF4Bebii7lJoyHDuEx2pOQ4pl5L4cETAn2m3SFKVRIqKmNqnx3Z31UCRV
         PUNyA4jO1P9CozsBoZJy1neHwnTVdeSjFqpp3Y5UmkLbW/QGNj74dE1uSItvkWbU4jie
         5joLb4Uc3wZoQs/oZT9mDLGDylMVpnQOdDlTyFtBYFQ+p/ukaLtpSsmTCGCb2IMHbUvy
         /bnFmFRgXR3nJ1KFV3kp2L/LyU899zVA9Qyo2mmZrpwk+IaBgJaDbzdFXaO0GOCGcTqX
         BMsDh/tsTJ3fa99Xj2HxjILBSQuJ3DkNOdSjLZls8y0/FsFOhrud+Y2puEfo5x169yPP
         3xhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6vSSSEdtBWJbFYHG/SzU1RcinihqOnESUQ8p2WZbatI=;
        b=D/amRTaWd1nuSv84GZETBsKlFTY54yL3r7g8YcDQRB0//+hfUffEfYtQghxsoxMkhU
         Icta90RsUVrBheBvZ2G6rG3ZNELMAiaTzhv81A3+nlxaDordChGGnB7RfpB5RHkNYLSb
         bMXM4KYPkY10jVNQdY0J7bV1srVr982YDAJTywwVPwckYoLVursNJFbg54BgyaTe/ELO
         7FeEV4Fg09FFA7GWpBeqa38KX4B0puCmnyBQPhTsxK/1XSgxKSqSPIVrbZt/YKp6L/0v
         WuRDKkfW5xc8nZe1WDBEWMqVjQ3iquc/BTo/kjwT1YKW53HwuBDF4EVjmFo8uLBWcMX8
         onuw==
X-Gm-Message-State: AJcUukc/4PeoIQD/BO21tT7EWU6HtYBbaXVkO60nirw5ofVn4Xy4y1d9
        g//ByvN1Oo79OQL+QxJU8zMEynvb
X-Google-Smtp-Source: ALg8bN5wn+yMg5AhTwOrCITMdrdcgDMMqlu6YO9ayK04AwkxBTpqNjMAcf51QoiDZIOgsaL8phKDYQ==
X-Received: by 2002:a63:5b48:: with SMTP id l8mr1377974pgm.80.1545377333823;
        Thu, 20 Dec 2018 23:28:53 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id f20sm27688275pfn.177.2018.12.20.23.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:53 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Kyle McMartin <kyle@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/5] ihex: Check if zero-length record is at the end of the blob
Date:   Thu, 20 Dec 2018 23:28:38 -0800
Message-Id: <20181221072841.30199-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072841.30199-1-andrew.smirnov@gmail.com>
References: <20181221072841.30199-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When verifying the validity of IHEX file we need to make sure that
zero-length record we found is located at the end of the file. Not
doing that could result in an invalid file with a bogus zero-length in
the middle short-circuiting the check and being reported as valid.

Cc: Chris Healy <cphealy@gmail.com>
Cc: Kyle McMartin <kyle@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 include/linux/ihex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ihex.h b/include/linux/ihex.h
index 9c701521176b..9130f307a420 100644
--- a/include/linux/ihex.h
+++ b/include/linux/ihex.h
@@ -49,7 +49,7 @@ static inline int ihex_validate_fw(const struct firmware *fw)
 
 	for (; rec <= end; rec = __ihex_next_binrec(rec)) {
 		/* Zero length marks end of records */
-		if (!be16_to_cpu(rec->len))
+		if (rec == end && !be16_to_cpu(rec->len))
 			return 0;
 	}
 	return -EINVAL;
-- 
2.19.1

