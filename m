Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B453ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2120120825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFUvTNHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2120120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeKHSjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:39:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54820 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeKHSjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:39:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so439515wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 01:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7C/wrspMfUQvsFMTcgDRLQWNrIa3gG/vxf/pbqlMaK8=;
        b=GFUvTNHosU9EGyVuBqbiVyi/VR8Q1jV/Q7erazAt4wlxRAbU/4G+zA8uahY1+BZmSF
         LA9GoVdAOQg+ysjc/Qx1d58HPqtMRA/Z/jA9HnVi2qRMb+oByD6bymWrzK2OzP4pG52g
         EpzWWHFiljYmWJ847nAWMLssfJo19wqjuMhWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7C/wrspMfUQvsFMTcgDRLQWNrIa3gG/vxf/pbqlMaK8=;
        b=Y8wb3Do6Iomj529ruvQ4kzVHg9PtrO6YtZOzA+yPwPkk+T3Yp2NoYG4Fb7BxvpVnD7
         mAxQBbUWMBFckuPDlXu/+CEwt4pPfOStxF9PiObsaPZdWyLK3izVYQ6O938D4S0S9vOY
         u3z8IrZG0iiyw2uOAMtVyQYZ54DuoCrD61S2kQ3/FT1pchp6RvVM1ZklDkS3b8AxrpIN
         mKDq+FtNt8hbIYVahGi70Ny5tdy6s0Hp5iOlt1DchGj93JbdXygdVtqTaIzArD1oGUdC
         hDmDcOIgifl5aPfFjkWIU6HPNIkh4UjGR0+abY94n5Bn2qA6LBctwNl29A+2ESi7VscF
         omPQ==
X-Gm-Message-State: AGRZ1gIr0n7NFcJ1NJ3N1HUpJdEfnbKEm4oh4CHDx3vs8cckpZ3qvBlv
        7dd2U1Y7uhQn4egGpuPjZIGw3g==
X-Google-Smtp-Source: AJdET5eo7NLKsq4nCro/TskDB1tEsDKTt/G/XujosQSzN7bJZQt7DssrB8rqYu0lQxZHrJtkrl0aRQ==
X-Received: by 2002:a1c:84:: with SMTP id 126-v6mr410351wma.96.1541667921577;
        Thu, 08 Nov 2018 01:05:21 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1094:149:440c:9368:8cda:a020])
        by smtp.gmail.com with ESMTPSA id l140-v6sm6974469wmb.24.2018.11.08.01.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 01:05:21 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 4/4] ARM: dts: stm32: enable hwspinlock on stm32mp157c-ed1
Date:   Thu,  8 Nov 2018 10:05:02 +0100
Message-Id: <20181108090502.14543-5-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181108090502.14543-1-benjamin.gaignard@st.com>
References: <20181108090502.14543-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Activate hwspinlock for stm32mp157c-ed1

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index f77bea49c079..158a337b3129 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -94,3 +94,7 @@
 	vdda1v1-supply = <&reg11>;
 	vdda1v8-supply = <&reg18>;
 };
+
+&hsem {
+	status = "okay";
+};
-- 
2.15.0

