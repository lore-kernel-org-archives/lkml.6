Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5B7C04EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FA5224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bMOTlLlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FA5224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbeKMBRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:17:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42298 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbeKMBRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:17:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id u5-v6so4530208wrn.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 07:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pwFNzDGdYuDr+YfGKasy9ggIzxKeenAzUyRgSfpdLck=;
        b=bMOTlLlUdjW8+zVxtBC4SQROn/62ERv+IV8Fa7SMmr5d9ocapIy0Rhtod83dQhZ0HS
         dopOX5TGph5besCCo3rep8zjrZfrSKZZ7lTVn6GrX+fhLqndJILjvPOKTZZ+gWFc3M9S
         gfAKFbcTp8kaxcPNq92P+U7pdCX6UAdTzl564=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pwFNzDGdYuDr+YfGKasy9ggIzxKeenAzUyRgSfpdLck=;
        b=D2KluuNMOYzjuGPPekYY7vHOonlzE3FepJKZS7VUrzdDnxzI4Ubyt0dvf1fkhnYV3P
         lFM5dvWEc5abUBB7+yBCoeovfwx3f9qws1eKxyuOuieN0zBqHuq5TfTbyd4iIe1VA7TI
         Jt1CUHwH3BZc2AxejLzfLcNDrkNeyd5Qnhk/Jhdgr3A9HEDBEEfxN63rWtd2nvXWzZIl
         gCHwUI+sR9/1XHD9tD4rN6yR0KkRImg7RkZRPzLmC3tMkWfJAAjQ2rjpHCddL4S+UNw1
         7SU3WauKbU4ZwWaP2UKuAPFcpyc3/Q9xAqxA4IXZ8I9qNhhxcA/SwXHvUfNJ7UnNZsuc
         3IvQ==
X-Gm-Message-State: AGRZ1gILZwrI3FtChSXFMhbyiJlyAAJCEgsTEA44fRmlpHzvV+YIRfSr
        GeyC3i/AV1bQzzLUnX45ml+a7A==
X-Google-Smtp-Source: AJdET5dnUue+mZR4muT5SwCJD/ipSNzhGq7/I3kuDnIr1Z6+1Uv2dhTjHNzojjhvGefVKPyoczcAnA==
X-Received: by 2002:adf:ca03:: with SMTP id o3-v6mr1377834wrh.148.1542036238262;
        Mon, 12 Nov 2018 07:23:58 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:105e:a8d5:7c2c:2737:d373:11ee])
        by smtp.gmail.com with ESMTPSA id t82-v6sm11192849wme.30.2018.11.12.07.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 07:23:57 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 4/4] ARM: dts: stm32: enable hwspinlock on stm32mp157c-ed1
Date:   Mon, 12 Nov 2018 16:23:42 +0100
Message-Id: <20181112152342.6561-5-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181112152342.6561-1-benjamin.gaignard@st.com>
References: <20181112152342.6561-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

