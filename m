Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589D9C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D2320779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D2320779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeI2FPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:15:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39690 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeI2FPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:15:46 -0400
Received: by mail-oi1-f194.google.com with SMTP id y81-v6so6764484oia.6;
        Fri, 28 Sep 2018 15:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qJjaNrXr1jwNWUcqFYNoeheLOX/BIq6piV6Dc8qewnY=;
        b=oQzQ/zWwZNxi6Sl/veMDew/GBKPMXTGztQQCLDTYV/1h7xBukf9vTl5iVK9KbcvU8+
         SZANH4+M8ogvlpRAQjiQa2c/s1wfZR1C/u5QyfPz70eajhi+ozhy2BnzBkhR9FGZvTXX
         /aDdQg1hS1pmldz8oTzMQ4qgUOkVzCpGnotYb6fMOkwLDFmnz28xg4/Gj1KjZk52cUK3
         fk7FfjYW52R8O/MdwlHljHZCN1YXnxModTYnpFPyYz0vO0izcRKKeLESqV2X5qiv6r+Z
         PJl9RWSpUrjF//K1d/qqian7nSInmtPs6KoKbo1heFGXf8SymRGWycYpkG5UoSJ/8Yp0
         wUXA==
X-Gm-Message-State: ABuFfojIdYcDAQFF4lVIgX8Y9BaxL8kauPTFnKHarOXFlsmlfEojOjIr
        wZ2S0EWp2uyR+hiBrkVfN+f2LGrgvw==
X-Google-Smtp-Source: ACcGV62S/T/OeHDfWOwoqTgL2Zvwdw0qAKLwt/Uf3IUUTu+RpC7qS12Bw2d8UM4QWzUdbQaezf++4A==
X-Received: by 2002:aca:3546:: with SMTP id c67-v6mr382026oia.249.1538174989463;
        Fri, 28 Sep 2018 15:49:49 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n26-v6sm1972676oic.5.2018.09.28.15.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 15:49:48 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] i2c: Convert to using %pOFn instead of device_node.name
Date:   Fri, 28 Sep 2018 17:49:47 -0500
Message-Id: <20180928224947.19058-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
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
v2:
- Remove initialization of parent

 drivers/i2c/busses/i2c-powermac.c | 17 +++++++++--------
 drivers/i2c/muxes/i2c-mux-gpmux.c |  4 ++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index f2a2067525ef..f6f4ed8afc93 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -388,9 +388,8 @@ static void i2c_powermac_register_devices(struct i2c_adapter *adap,
 static int i2c_powermac_probe(struct platform_device *dev)
 {
 	struct pmac_i2c_bus *bus = dev_get_platdata(&dev->dev);
-	struct device_node *parent = NULL;
+	struct device_node *parent;
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

