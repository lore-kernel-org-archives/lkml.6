Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A27C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213632168B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ss8H5pce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213632168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbeHIO63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:58:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38485 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731189AbeHIO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:58:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so2793245pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sAJYfB7jNZkf4AcG1guaAuxl2U8HLNfaRN6C5i+mEB0=;
        b=Ss8H5pcerWFK5si4ToA9s7qHqAGD/RE97Mt1Wk4W+GvRcsNTKCUn0jdD0awEKgM8/+
         ie9LhbJ4cCEF7KIEt1o98gfYTML2AUlOzYoXk6eBeTOQncND9MLgUBDIZK/vuhbZ3L8R
         cB3ttsk9yKkUsoRL7+2BKIaNeTmqyWcMtIi38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sAJYfB7jNZkf4AcG1guaAuxl2U8HLNfaRN6C5i+mEB0=;
        b=JZLFFmqhFnu/YLL8kbzRjY2ljM9YPtNYknnRTrCnKHfDpmTR8HIukSB50mj8gQUQGb
         /dzfp939hGf66Jg/ZSE3sasptNv3IZwNY5awFdmsrBFPCJ0yfgaPVdVlBh8Ybz/X9lyf
         jG/NNChl+1bO+ED7DrcMsOo3Io3MCd85imNXL0mMuSlJjq2powEYDXFCUWaoEptwRRj+
         sqA+hRq15ZmVexkGbMmeVwLb4hNwi5/636C/QhisSltCv9HOXYtir++mYg5YLfPxbsqa
         Tr++TJ6xmAw72dnLDiDRl91l9fUfvDSYceE6pZxFPASdcKd1yHWdKhS07glyvqdogpqj
         ZRdA==
X-Gm-Message-State: AOUpUlFkAICHl/Ngpd+Q10OdjygW3tNtzWUb6Ht55j9XzsBHgFfRlfqV
        dJYgN2yuvoY1SfH3YAT2I6jQ45kDzKQ=
X-Google-Smtp-Source: AA+uWPzOAktDB7iTvMGyLirkA0uZOj3hPQHRnAuskry1koC7iu2jqqZfoUZ2KLwduc3SycqUuX0MuQ==
X-Received: by 2002:a62:21cc:: with SMTP id o73-v6mr2228004pfj.21.1533818021023;
        Thu, 09 Aug 2018 05:33:41 -0700 (PDT)
Received: from localhost ([45.113.251.134])
        by smtp.gmail.com with ESMTPSA id 22-v6sm12853108pfl.126.2018.08.09.05.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:33:40 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1 10/10] MAINTAINERS: Add entry for Qualcomm TSENS thermal drivers
Date:   Thu,  9 Aug 2018 18:02:42 +0530
Message-Id: <106a459af3882745e78cb9b774dcfda08a96a6dd.1533815718.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create an entry for the TSENS drivers and mark them as maintained

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68b4ff8ed205..ca6183d6d545 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11862,6 +11862,13 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/iommu/qcom_iommu.c
 
+QUALCOMM TSENS THERMAL DRIVER
+M:	Amit Kucheria <amit.kucheria@linaro.org>
+L:	linux-pm@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/thermal/qcom/
+
 QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
 M:	Stanimir Varbanov <stanimir.varbanov@linaro.org>
 L:	linux-media@vger.kernel.org
-- 
2.17.1

