Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9EDC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB1120811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeoyj+8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB1120811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbeLKD5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 22:57:46 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38952 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbeLKD5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 22:57:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so6279872pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 19:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=I3Et1lRyku9kNfBv9LJ10cT2UUplmBJDt4g4A+wa0tA=;
        b=jeoyj+8g0bmoqrzicRP/IyUc9ZYien3uQIFc+zUauKWSx8TQeq7GwVPRHlTE7h4Njl
         PN+3B4HS15kDwGHRR4Gv/dCV9rtvneZM4jkgUYDOXBDjPZLEaV6mH+n+VRvOteETbnaA
         zHZbqCdiDo+AE9rR8GUDPFZ8CscjGUmHtjVOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I3Et1lRyku9kNfBv9LJ10cT2UUplmBJDt4g4A+wa0tA=;
        b=FhpIHIoZFDFTiBdVsucY27v9aFbo3nXT/dhEluUAx38nZmjdb4EBnHPP9DLpgdfoKc
         Kz4QHxtn28q6PPVGy5T3pr1iLWiR1Kd/JimJX49OHY8j9IlaUGyiagTlwIPEjBzZ80Il
         T1SKwag9R94inJvRpWSJcarYbVMTACns0zlojV87Zg7Ud+bAuqOMl70kPWJeh3VGOt43
         0+t4fISzmd9NV9U5P8crWeCpXJjKyK3qX8VcCg7PmtXrzSFmsRXAt+9LAdBu46L/MaZk
         Wg1w7mJOxA4BZK6ojTvFSvT4MaWPXCfH3lUaYIINvtdX1zc7TiKAuoWDJjXmFhgDZymh
         YEFg==
X-Gm-Message-State: AA+aEWYQHFYTA237raTRd2ThGwQmUhbKo5hoXK2JzFVOXeqmBB8JaycL
        UrDPvfztenMd0/D1MxHASiZm
X-Google-Smtp-Source: AFSGD/X7rpQwE46xNICZte+mamiQKkNt/rfViHq5q44L4D1Qo0shrM5Vc/FHbZ+/SEVnKgO+/W1L3Q==
X-Received: by 2002:a17:902:24a2:: with SMTP id w31mr14352262pla.216.1544500665015;
        Mon, 10 Dec 2018 19:57:45 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6305:a575:8874:2a8a:cc58:a5ef])
        by smtp.gmail.com with ESMTPSA id n22sm22454944pfh.166.2018.12.10.19.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 19:57:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com
Cc:     linux-unisoc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        afaerber@suse.de, orson.zhai@unisoc.com, geng.ren@unisoc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] Add linux-unisoc mailing list to Spreadtrum SoC support
Date:   Tue, 11 Dec 2018 09:27:25 +0530
Message-Id: <20181211035725.5084-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Spreadtrum is now merged into Unisoc Communications, let's use the
newly created linux-unisoc mailing list for all discussions around the
Spreadtrum SoCs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6682420421c1..d1f768fd4f49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2108,6 +2108,7 @@ ARM/SPREADTRUM SoC SUPPORT
 M:	Orson Zhai <orsonzhai@gmail.com>
 M:	Baolin Wang <baolin.wang@linaro.org>
 M:	Chunyan Zhang <zhang.lyra@gmail.com>
+L:	linux-unisoc@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/sprd
 N:	sprd
-- 
2.17.1

