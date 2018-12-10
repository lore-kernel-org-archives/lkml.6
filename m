Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F57C65BB3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A6620870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RtODiqXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A6620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeLJLxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:53:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39927 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbeLJLxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:53:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so10869190wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 03:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oKwkzMOWRQEWFTLUklhPX6+c5oXA7cimHYq8AEDDkxU=;
        b=RtODiqXUztsCylKr84fXQveBZmLrwdH33lyx6NYjXRPPW87KzwTSDUG+9HL1+BfYbg
         nv9abK6HfEuDCL/k46RuMBswxJhvoJbuPy7l7XJByxGo8lFRhpdd67Tck1f3Z0Xg7I2y
         s8nfDbSFnDNP+JVdETweX8HcgcYPOstKCqQdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oKwkzMOWRQEWFTLUklhPX6+c5oXA7cimHYq8AEDDkxU=;
        b=EAyzbqsFKJvpyM4Xxkqzs9pEg50y4rVUJkNf9EpQgonCkWfRYz7UaL6M/mf6FNFWjQ
         vBFCpUERyZ6wZNF0p+fdYGdO3J6YqrldltStlFHm7YnQtMQuqzRa8L1bcyplZGXvrrDf
         BTDzyRwbYJlVDfWDIUGujuBU049NN8PlhsWm1urw6v31yGJqkz70e7pa7s0PDhKiWWJw
         oAc9LcFllKdzZJHRi8hj3kW1cni9sxWemfq346OaDAzmJj9gKWJ2vf4NmoPvMiCwFFQF
         x2dy4uMXpArNOg2tF4YbpFvYenUG7TfP5wD8oYqIBuhyI0Dt71JbLMFVFjBWOBowq50K
         tXBg==
X-Gm-Message-State: AA+aEWZZm7mwZTZKyqbMyAcCrE/VnXG2q5kdUOOl1CSfSV/6riawxsW8
        MpWXJje8smHfCpNPEOJs1GIj7Q==
X-Google-Smtp-Source: AFSGD/Xz8I6cN84X/FEMHiu6k8Bhi+MoIp1XLoYeowMvi97hhE28IVAlVvNqDdfr3ch1F+AqiR0zfA==
X-Received: by 2002:a1c:7f0c:: with SMTP id a12mr6650138wmd.89.1544442811948;
        Mon, 10 Dec 2018 03:53:31 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b16sm7869243wrm.41.2018.12.10.03.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 03:53:31 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 2/6] media: sun6i: Add A64 compatible support
Date:   Mon, 10 Dec 2018 17:22:42 +0530
Message-Id: <20181210115246.8188-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210115246.8188-1-jagan@amarulasolutions.com>
References: <20181210115246.8188-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 CSI has single channel time-multiplexed BT.656
CMOS sensor interface like H3 but work by lowering clock than
default mod clock.

So use separate compatibe to support it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index ee882b66a5ea..bbe45e893722 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -892,6 +892,7 @@ static int sun6i_csi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sun6i_csi_of_match[] = {
+	{ .compatible = "allwinner,sun50i-a64-csi", },
 	{ .compatible = "allwinner,sun6i-a31-csi", },
 	{ .compatible = "allwinner,sun8i-h3-csi", },
 	{ .compatible = "allwinner,sun8i-v3s-csi", },
-- 
2.18.0.321.gffc6fa0e3

