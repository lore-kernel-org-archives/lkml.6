Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64258C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCE1214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qttEOSB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCE1214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeLCKQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:16:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52129 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLCKQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:16:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so5135683wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hgaDQkDoibMUUGBXHBCGeXaaQAL52VCnVF1GrXldIPA=;
        b=qttEOSB6GTEdB2OuW1Pefb35HbJoo1ypye9EEESvp0KQdEXeck7X/4G+NzF6sEtQ42
         lCBi/SoHtLsgVKHmFmKTaf6ZNA7Tx3aLcmdqT7PYckms5U03hBMQM/ZXfVTy5ViRecPf
         /hhgkKie+Sv+Tv+9WkcSPMJN22IFiBeiJDQ4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hgaDQkDoibMUUGBXHBCGeXaaQAL52VCnVF1GrXldIPA=;
        b=Yw3yA5Ur+rS+ZSQgklcAm7lja4odLLAx6R5MHuvmuaYKAOJBXRe8UABclwDh9cMiHk
         gZKggi6kG29k9/ovdTE7Rrg4/VhbUVe/V/BRH88cPKFrPElnOYOMB3QHTr43FLZq150t
         A40bV+2ZERTeax3efJ0sMku8RaeKWq9Sd542nZ1z5JtnrWAU36bPr1agdbh5+wwwNnKF
         f6gKK0SN9O1w4gzk1nwQ7lCIEe3dHPTBZt78iAf+O6VqjujxTZyaTouiPaH1aq5ki2H9
         snX/BhiOXrHPUoyS1j7MFXvl7K0KVkNIqfhRtQM1r/i537F2ou2z7s3yNNNZOzL7thT3
         BhrQ==
X-Gm-Message-State: AA+aEWZz0Sg5tqWwITNtDHJ8BpkB0FuboUHjUhoUKqzjbg5X4AfTvTZq
        NNj7EHDVGoEbXKPgdc8kel8ajg==
X-Google-Smtp-Source: AFSGD/Xwlld3xeI/VFBtGMFL3KEijSd8n3gf8wwOqT+DCZYgY8B5vXaZDaW2545VwtZiaF1uGzx6sg==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr8051912wmf.117.1543832160747;
        Mon, 03 Dec 2018 02:16:00 -0800 (PST)
Received: from localhost.localdomain (conf.hotelmediterraneo.com. [2.228.78.71])
        by smtp.gmail.com with ESMTPSA id f192sm5832158wmd.12.2018.12.03.02.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:16:00 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 5/9] dt-bindings: input: touchscreen: goodix: Document vcc-supply property
Date:   Mon,  3 Dec 2018 15:45:43 +0530
Message-Id: <20181203101547.16835-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181203101547.16835-1-jagan@amarulasolutions.com>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vcc-supply property is need for some Goodix CTP controller like GT5663
where 3.3V external pull-up regulator connected via controller VCC pin.

So, document the same as optional property.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index f7e95c52f3c7..604766e347ce 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -23,6 +23,7 @@ Optional properties:
  - touchscreen-inverted-y  : Y axis is inverted (boolean)
  - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
                              (swapping is done after inverting the axis)
+ - vcc-supply		: 3v3 regulator phandle for controller VCC pin
 
 Example:
 
-- 
2.18.0.321.gffc6fa0e3

