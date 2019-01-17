Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4044C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA5C20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgBcml+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfAQXNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:13:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43894 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfAQXNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:13:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so5554064pfk.10;
        Thu, 17 Jan 2019 15:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gcyZFYzthWvUh835ouhNUXpH1BltMZgtBoPQJUbra1s=;
        b=UgBcml+cxMvLHTDdbVV7cdD+lVMBMyVM8c/euYJQuoQU65V7edUO5pkkl9JlCr7tIX
         TD43iW8FhoXhJdLEdyzi9obzsUzKOD6uNGnEdQwzeJQayO4imVTVaB1j9Bqz2qb+z0ZZ
         fJ+SJiGV5s/SE7TCtfcOvh72NDawrHJrD3h4IOOdWJc2KWOBk5EuJaTRh08tAsx2CvT1
         skXjabob4Eik5Of+YbGUZNov7pvZnvyt+fk10RG6x0eibbBi6aB//QkOG6rPTJXr2pJ/
         qKAqG6EAz3PmhQcgsLcSlvTme4dXqOrljyqGoy/nB+X4BIhRptmgMCpK9w9Or/fnOEh3
         Ueyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gcyZFYzthWvUh835ouhNUXpH1BltMZgtBoPQJUbra1s=;
        b=Jktc4lBdSpkxinUTSpHF+ujhA5Glc5dYJTYQr0vEn535DJjWwbpkJ2NxFNQdovVwSd
         Ceo4Qyy5R4fOxX5mUxGzFrBrFKN9j2BymRwGYg/Od5frgYSWdBS0VRzw4THfyWPpEHsv
         NXkWo9FORSFAKroe8GRX5X1bUquCn0TwnIFBAIjz5jqohaRknR8f9sE5tKy7CsSapBuy
         XIzTu3opn8SDWpAPeSx5R7f7gflZN8BPI2+teTG5ElljVqy6DafbxIGU7FrMqc3gdIbN
         TBU985sd1pXC6I8v4UrX445ytKnWPofFe8v0jyF/lhVJ4zx/zaFsU8u2htdR52iRLLE8
         TJlQ==
X-Gm-Message-State: AJcUukdnD5tbl80TF5SKaqHtAfVw1bDw9qLrB8pSVc49FRte47we1Car
        gjt0UZMmkemOtg9NXtzqggg=
X-Google-Smtp-Source: ALg8bN7HCS4UTxA66p6zpEGt0AnNC0YYxZTd8aMr17WY7W8TytEydYMJxL15u5Z0+9nJELS6vXFcyA==
X-Received: by 2002:a63:dd15:: with SMTP id t21mr14659065pgg.347.1547766787792;
        Thu, 17 Jan 2019 15:13:07 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id b27sm4125145pfh.113.2019.01.17.15.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 15:13:07 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: hwmon: ina3221: Add ti,single-shot property
Date:   Thu, 17 Jan 2019 15:12:52 -0800
Message-Id: <20190117231253.8828-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190117231253.8828-1-nicoleotsuka@gmail.com>
References: <20190117231253.8828-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, ina3221, as a hardware monitor, continuously measures
the inputs and generates corresponding data. However, for battery
powered devices, this mode might be power consuming.

This patch adds a "ti,single-shot" property to allow changing the
default continuous mode to single-shot operating mode.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changelog
v2->v3:
 * Added "Reviewed-by" from Rob
v1->v2:
 * N/A

 Documentation/devicetree/bindings/hwmon/ina3221.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
index a7b25caa2b8e..fa63b6171407 100644
--- a/Documentation/devicetree/bindings/hwmon/ina3221.txt
+++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
@@ -6,6 +6,16 @@ Texas Instruments INA3221 Device Tree Bindings
   - reg: I2C address
 
   Optional properties:
+  - ti,single-shot: This chip has two power modes: single-shot (chip takes one
+                    measurement and then shuts itself down) and continuous (
+                    chip takes continuous measurements). The continuous mode is
+                    more reliable and suitable for hardware monitor type device,
+                    but the single-shot mode is more power-friendly and useful
+                    for battery-powered device which cares power consumptions
+                    while still needs some measurements occasionally.
+                    If this property is present, the single-shot mode will be
+                    used, instead of the default continuous one for monitoring.
+
   = The node contains optional child nodes for three channels =
   = Each child node describes the information of input source =
 
-- 
2.17.1

