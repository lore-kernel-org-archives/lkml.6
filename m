Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AECC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8AD208E6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8AD208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeH1Fmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:42:31 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39556 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeH1Fma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:30 -0400
Received: by mail-oi0-f68.google.com with SMTP id c190-v6so9265oig.6;
        Mon, 27 Aug 2018 18:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xulus8zSDvpYwpbHR5AcJKSXwBqS55HrQS4eGyYdJbc=;
        b=YNnSWrXIae6avmFAv39vUYtTMDIBa0c6JiKp6NAO853CodUBpVaJLz+wMuB4rI2d4P
         TZ0OfyJfuuy0uMiTBY7ttc4tqX3dchwGFkR/TdElmyqcKiOyatHlE/XpGDpTWUnGZo+J
         aqt44/RtnWrsG6ZqeKFAComwHjUJZsMd7bn8dRFAVvwpTbDf7PiXx3DkyV5HrPnH1wkV
         lFm2+C8OxVLPn4eX0mnTMYXmzQ2hxosHRizMQgLXY3HpwqG9gSvnkzEvyQE90NKBa+zt
         A3BPvZansTL+YR/NG08dN4z0TLeq7kA2vJ/FYOGQ2mAoZcy6ZhKHt+b9JbrKAeClZpSL
         zU7Q==
X-Gm-Message-State: APzg51DMxjof8ct/V7p3HiIxgjoEzaRY0Cas+C7znnR3mIu+Ar77pXLV
        t88AlsWlsq1UM1Cre9XAqsZdulQ=
X-Google-Smtp-Source: ANB0VdaCVmpju2mhVt8Y3JSfvdgNsTCOYTD4b+Aonr7WU+QQEv/EMpN++vrxZdWF2gRPF7Lv6X4vVg==
X-Received: by 2002:aca:3507:: with SMTP id c7-v6mr1198850oia.46.1535421194751;
        Mon, 27 Aug 2018 18:53:14 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:53:14 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] i2c: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:22 -0500
Message-Id: <20180828015252.28511-21-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/i2c/busses/i2c-powermac.c | 15 ++++++++-------
 drivers/i2c/muxes/i2c-mux-gpmux.c |  4 ++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index f2a2067525ef..b706fd136ca5 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -390,7 +390,6 @@ static int i2c_powermac_probe(struct platform_device *dev)
 	struct pmac_i2c_bus *bus = dev_get_platdata(&dev->dev);
 	struct device_node *parent = NULL;
 	struct i2c_adapter *adapter;
-	const char *basename;
 	int rc;
 
 	if (bus == NULL)
@@ -407,23 +406,25 @@ static int i2c_powermac_probe(struct platform_device *dev)
 		parent = of_get_parent(pmac_i2c_get_controller(bus));
 		if (parent == NULL)
 			return -EINVAL;
-		basename = parent->name;
+		snprintf(adapter->name, sizeof(adapter->name), "%pOFn %d", 
+			 parent,
+			 pmac_i2c_get_channel(bus));
+		of_node_put(parent);
 		break;
 	case pmac_i2c_bus_pmu:
-		basename = "pmu";
+		snprintf(adapter->name, sizeof(adapter->name), "pmu %d",
+			 pmac_i2c_get_channel(bus));
 		break;
 	case pmac_i2c_bus_smu:
 		/* This is not what we used to do but I'm fixing drivers at
 		 * the same time as this change
 		 */
-		basename = "smu";
+		snprintf(adapter->name, sizeof(adapter->name), "smu %d",
+			 pmac_i2c_get_channel(bus));
 		break;
 	default:
 		return -EINVAL;
 	}
-	snprintf(adapter->name, sizeof(adapter->name), "%s %d", basename,
-		 pmac_i2c_get_channel(bus));
-	of_node_put(parent);
 
 	platform_set_drvdata(dev, adapter);
 	adapter->algo = &i2c_powermac_algorithm;
diff --git a/drivers/i2c/muxes/i2c-mux-gpmux.c b/drivers/i2c/muxes/i2c-mux-gpmux.c
index 92cf5f48afe6..f60b670deff7 100644
--- a/drivers/i2c/muxes/i2c-mux-gpmux.c
+++ b/drivers/i2c/muxes/i2c-mux-gpmux.c
@@ -120,8 +120,8 @@ static int i2c_mux_probe(struct platform_device *pdev)
 
 		ret = of_property_read_u32(child, "reg", &chan);
 		if (ret < 0) {
-			dev_err(dev, "no reg property for node '%s'\n",
-				child->name);
+			dev_err(dev, "no reg property for node '%pOFn'\n",
+				child);
 			goto err_children;
 		}
 
-- 
2.17.1

