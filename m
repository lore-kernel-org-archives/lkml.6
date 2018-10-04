Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBDBC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEA82098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c08M7pIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEA82098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeJDHFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:05:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39959 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeJDHFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:05:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id s5-v6so2446578pfj.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZWduqTwgwfDOeaimfj42x9KLb8S33udAqWz+FCqhHPI=;
        b=c08M7pIYGsdlWg/bsb5YM6DuU7bpR4psBC/6eivru0ecvIjESBZJBMpsibhDZr4+2q
         gzJPNqWi6q1trMfwzEbw9I4AtuuUCCMoX7AiDnrQhU0FLpanOxxFQi7rGyAwzLYEYtMt
         b1Mwmvyik2CR52CvKucFkP1swOE9JCH8Bb0k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZWduqTwgwfDOeaimfj42x9KLb8S33udAqWz+FCqhHPI=;
        b=QdYc5ojvWJrDT6HZdLot2RZot78dXm7NXgLnPqB4NTg9HpoJCf6D8KZrZcLpvZsgo1
         vBwDqvxdVFNsTYC0dz5hB2mRKWICJqNeb9Y4ySTaob6e+YIUw6bsPbvjjUfJj2i8cYmY
         YCkrk3Repqi7ylYyZuLXc6yFueobjQ6+/oHIyNo+ajFgWGqyogYMat0Y3EvchsMgbCru
         xocEcVZDKI8rBdaLoEA184tpUmgEglbDGvd5js+qR8+g0/y/K/WHXDSJ2L2DWNMe4YM9
         Fy9Vdg/TpTdERgsplfxV5s7dcYhaxiy6x3TX5upt0+N3XD8jFgAnu1I5dYBt7UQ61qtW
         hWIw==
X-Gm-Message-State: ABuFfoiVeWUR8HYh0ByFsk7P0/2LebPSXIdRPq3H1Jwp/IvKbHUkr3C0
        vlep7M5fWFwV/39kmdeJVscW1A==
X-Google-Smtp-Source: ACcGV60Ewj5cp/mqZg2GRKq9uUotjhOdrB+SndlJSo/g0YolMS2bnXLLuSEAbq56Z5AycWmn7IE3aQ==
X-Received: by 2002:a62:2845:: with SMTP id o66-v6mr4028595pfo.17.1538612091007;
        Wed, 03 Oct 2018 17:14:51 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b81-v6sm6497051pfm.96.2018.10.03.17.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 17:14:50 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 1/2] dt-bindings: iio: vadc: Update example to include unit address for node 'usb-id-nopull'
Date:   Wed,  3 Oct 2018 17:14:31 -0700
Message-Id: <20181004001432.21218-2-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181004001432.21218-1-mka@chromium.org>
References: <20181004001432.21218-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node has a reg property, therefore its name should include a unit
address.

Also change the name from 'usb_id_nopull' to 'usb-id-nopull' to follow
DT conventions.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v4:
- patch added to the series
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
index d0c188e5c922..ff7aa5038ba6 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
@@ -112,7 +112,7 @@ Example:
 		io-channel-ranges;
 
 		/* Channel node */
-		usb_id_nopull {
+		usb-id-nopull@VADC_LR_MUX10_USB_ID {
 			reg = <VADC_LR_MUX10_USB_ID>;
 			qcom,decimation = <512>;
 			qcom,ratiometric;
-- 
2.19.0.605.g01d371f741-goog

