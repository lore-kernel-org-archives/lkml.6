Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6287CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D5920875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJb0I4qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D5920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967172AbeFSQNN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:13:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52667 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966916AbeFSQNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:13:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id p126-v6so1338803wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=orK3jueeD8iKHAfbK5diacUPArijIBIe08XpYi0WLvQ=;
        b=WJb0I4qguAGnG8ViBOzfU+r1pGCxGFPMypZWxGj8Zy1JE1ASQ6jYNxoscXsvLtKpd8
         hS66suuO7+lKL28ruoTr7NLUEjLW/Cl9DoO9ZhIiy284QAsmnzUjBEzYWVY8EIfpX0GD
         2cPeZ/EcLO1TQMjFoZIOJ2hdpT20XVYY7y0Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=orK3jueeD8iKHAfbK5diacUPArijIBIe08XpYi0WLvQ=;
        b=iIXY4GbyP2LgUgouDCDQcInu6YyNPjoUQA+rBnzKCl4OXjPo3orPXbSBXZXIRCNMMK
         44Pix3VKd35rV/NE6rhZlnbRa2KP7OIrYqlSOsfvLp+yvFzqwKXhujkgkRK3QmRXWysL
         PMn871586VxkvEtbRQDlagy4IEYfzZtyWMCqFH/bCvXdPztRXJJuTArbylsWnOn0lhtX
         nuFrXYZoevcdY5MugAjqqp2oC87QjbgEJ5xb6Nkuw99uOsw19IEONveah2JkYM6qZhsq
         wWcdhLaoo1P5/jOydl7+iL7C0zENmK3GAYmDZOyDo0rvfimZf39jR7lEDdh4s7TUAQZ8
         Ftwg==
X-Gm-Message-State: APt69E1q1k9Bu7+04e0SVNZ5BAoqxAz5WA+nGk2F+AZdHYpj51TuMCpi
        lQOOb6jtaW8StE5VZ4hGSQ1Ufg==
X-Google-Smtp-Source: ADUXVKJJrca/iXnzyscjhaZffEwMAAysjQ1yhUuHzl2BQ7apHN4Coo+xI5WUxVP/vidnfSDbAX6Asg==
X-Received: by 2002:a1c:4189:: with SMTP id o131-v6mr11655598wma.7.1529424787406;
        Tue, 19 Jun 2018 09:13:07 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r5-v6sm47248wrp.59.2018.06.19.09.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 09:13:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     robh+dt@kernel.org, kramasub@codeaurora.org, sdharia@quicinc.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 1/5] slimbus: core: add of_slim_device_get() helper
Date:   Tue, 19 Jun 2018 17:12:57 +0100
Message-Id: <20180619161301.4556-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180619161301.4556-1-srinivas.kandagatla@linaro.org>
References: <20180619161301.4556-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SLIMBus controllers like Qcom NGD(non ported device), controller
can request logical address once the remote side is powered, having a
helper function like this to explicitly enumerate the bus is helpful.
Also codec drivers which are taking to interface device would need
such a helper too.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c  | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/slimbus.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 7ddfc675b131..88248a4ecad9 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -356,6 +356,45 @@ struct slim_device *slim_get_device(struct slim_controller *ctrl,
 }
 EXPORT_SYMBOL_GPL(slim_get_device);
 
+static int of_slim_match_dev(struct device *dev, void *data)
+{
+	struct device_node *np = data;
+	struct slim_device *sbdev = to_slim_device(dev);
+
+	return (sbdev->dev.of_node == np);
+}
+
+static struct slim_device *of_find_slim_device(struct slim_controller *ctrl,
+					       struct device_node *np)
+{
+	struct slim_device *sbdev;
+	struct device *dev;
+
+	dev = device_find_child(ctrl->dev, np, of_slim_match_dev);
+	if (dev) {
+		sbdev = to_slim_device(dev);
+		return sbdev;
+	}
+
+	return NULL;
+}
+
+/**
+ * of_slim_get_device() - get handle to a device using dt node.
+ *
+ * @ctrl: Controller on which this device will be added/queried
+ * @np: node pointer to device
+ *
+ * Return: pointer to a device if it has already reported. Creates a new
+ * device and returns pointer to it if the device has not yet enumerated.
+ */
+struct slim_device *of_slim_get_device(struct slim_controller *ctrl,
+				       struct device_node *np)
+{
+	return of_find_slim_device(ctrl, np);
+}
+EXPORT_SYMBOL_GPL(of_slim_get_device);
+
 static int slim_device_alloc_laddr(struct slim_device *sbdev,
 				   bool report_present)
 {
diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
index c36cf121d2cd..efa36a852dc3 100644
--- a/include/linux/slimbus.h
+++ b/include/linux/slimbus.h
@@ -138,6 +138,8 @@ static inline void slim_set_devicedata(struct slim_device *dev, void *data)
 	dev_set_drvdata(&dev->dev, data);
 }
 
+struct slim_device *of_slim_get_device(struct slim_controller *ctrl,
+				       struct device_node *np);
 struct slim_device *slim_get_device(struct slim_controller *ctrl,
 				    struct slim_eaddr *e_addr);
 int slim_get_logical_addr(struct slim_device *sbdev);
-- 
2.16.2

