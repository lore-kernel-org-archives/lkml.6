Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63D0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6786E2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQh2ltdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6786E2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeJAOXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:23:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39551 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbeJAOXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:23:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14-v6so12699391wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 00:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9kGGJIEenHcnisA1eMhu6dmnNh5loyWbzbjSC7WoTcM=;
        b=CQh2ltdBJzUvBDf5kwPmChIPkhSL/jbFc+xQ0bdlAXa/G4lOYbNcXFbBwE9PYyCb5e
         tS3IvSLAM93ZWl/x04X8SAbUy7BDcjGsFF8Ib3Q5oBUyP2OGIpLEzLF0FlinzH7jIzT1
         oGlz5PwGGNIGVb5ZO2GqNB0Q01gf68EYaWrQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9kGGJIEenHcnisA1eMhu6dmnNh5loyWbzbjSC7WoTcM=;
        b=UIYjMTIZ0tyRs3Uq4si+250HPSMXWoMzciQXBrln1XZbg1KIcO6z/y4VBVGTbyZqhx
         jg2jwKRIXQpxbZ3Cgh3oaup8S+lEAmNUpF7E0ohpOuQmGZwWnpYyXZUO7t1IWO9orDJz
         21SzRyVhN/O0OxPnERRvnDcMA7zHrM2RCo9w9dj//e3N5uViE4JMxxTNb6wjCX9wkyVv
         znvSV7PF3aBaSGAp/BjLLqs5kXWZ6tYOsM+EfBYCeSD//mgDfi/g5dZg8WmsBK7vs0hD
         cS2jJDxAGB2jvnKGN61ebf8NjpvLuVE7dMXBy+XBgyTE7y7yr336r31/snENtbd9i2nK
         HY/Q==
X-Gm-Message-State: ABuFfoi8guC/Rj856VQT1tKRktT4HXM7SW1qpB1reZnLEBU5lAw7VEHw
        qqh5/4kDLY3nYShA4lDERHxFCQ==
X-Google-Smtp-Source: ACcGV602d6k32+aggSjy1LLYkZ9NDliVh7UNjMBmXMPCah6WGM9KC2OKl9HkeXA+PAS9e88B1jLUkA==
X-Received: by 2002:adf:bb02:: with SMTP id r2-v6mr6177304wrg.24.1538380010865;
        Mon, 01 Oct 2018 00:46:50 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1144:47cb:69e8:4e2f:ed2d:bf00])
        by smtp.gmail.com with ESMTPSA id q15-v6sm9668395wrw.2.2018.10.01.00.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Oct 2018 00:46:50 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     gregkh@linuxfoundation.org, mchehab+samsung@kernel.org,
        akpm@linux-foundation.org, hans.verkuil@cisco.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] MAINTAINERS: fix reference to STI CEC driver
Date:   Mon,  1 Oct 2018 09:46:40 +0200
Message-Id: <20181001074640.16342-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STI CEC driver has move from staging directory to media/platform/sti/cec/

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b22e7fdfd2ea..8aa973410e2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13870,7 +13870,7 @@ F:	sound/soc/sti/
 STI CEC DRIVER
 M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
 S:	Maintained
-F:	drivers/staging/media/st-cec/
+F:	drivers/media/platform/sti/cec/
 F:	Documentation/devicetree/bindings/media/stih-cec.txt
 
 STK1160 USB VIDEO CAPTURE DRIVER
-- 
2.15.0

