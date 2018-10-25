Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5201C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796BB2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OyfS1itP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796BB2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJZG4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:56:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40595 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbeJZG4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:56:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id o14-v6so4674261pgv.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 15:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUTLNC4m4w91CHTqoAgeiiy9cnTlYaHM5XFwx8a4RBM=;
        b=OyfS1itPdAb8tmXpSb098aUZD56GNFIBqXG/ykzMRbu8TjOESundVkDzzPFN+VIDRA
         9hcZj4/sfohG2TviQp1JB4QNJCO/29PmUfcp5bQAl9pM0cmMzkcwECRTCG8gtFp9tGIP
         1adNJ4iyfnhPumaMH0mFdGqIsOhWGei6hsJvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUTLNC4m4w91CHTqoAgeiiy9cnTlYaHM5XFwx8a4RBM=;
        b=rpKkB5Q+StpnbVM1925Aq76nkn0g85cMXPoQtoB4wJsoIhUkmi7/CIWs9upyVDdRbf
         /gi2letguY/vNJrEUZTuGDO2oODMT9T82MisT9xhfJokQONF1+ZQ0AwAjpt7Iom0Bjtu
         CIe40IDEPDXEB9CtiffwHMjBWFhgTnP0emw5FY+qa09gXhIRUQNqnsbcolN+cmuUnGPL
         10KJ0SBWFZilC3hAwpPRd9X2/XTP2sxhTy4229L94zC8kCxr8k8qjY6u8Bq2FVWE46I8
         S/XtwhXlyr8VJYVJdE38PsaXgOUdaBvVeiBVHHgzRNZu4cPavJTLpU0Pt3Klddl439s2
         cIHg==
X-Gm-Message-State: AGRZ1gICGqhldD8Fe1p9BftRrv80JT+HilIj8SQL92VfJRPfMuGG46Lz
        AuousNTyB3HzvPs9N2NuNJO8ug==
X-Google-Smtp-Source: AJdET5eAmWwOpqlvNaQuJlA6+B/OvhGVojTC6uUiER7tFKGjFhb9dCQMXm7X69CgldH8dSmkRY+ruQ==
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr871280pgb.357.1540506130519;
        Thu, 25 Oct 2018 15:22:10 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id x73-v6sm19813778pfk.139.2018.10.25.15.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 15:22:09 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] drm/panel: simple: Add "no-hpd" delay for Innolux TV123WAM
Date:   Thu, 25 Oct 2018 15:21:31 -0700
Message-Id: <20181025222134.174583-3-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181025222134.174583-1-dianders@chromium.org>
References: <20181025222134.174583-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the HPD signal isn't hooked up to this panel we need a 200 ms
delay.  In the datasheet this is shown as the maximum time that HPD
will take to be asserted after power is given to the panel.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Use "hpd_absent_delay" property instead of a bool + prepare delay

 drivers/gpu/drm/panel/panel-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 687fd087b9fc..88592f9a0018 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1396,6 +1396,7 @@ static const struct panel_desc innolux_tv123wam = {
 		.height = 173,
 	},
 	.delay = {
+		.hpd_absent_delay = 200,
 		.unprepare = 500,
 	},
 };
-- 
2.19.1.568.g152ad8e336-goog

