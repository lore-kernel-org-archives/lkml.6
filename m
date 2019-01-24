Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9DBC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC87121872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV/jzKWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfAXUIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:08:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33205 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAXUIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:08:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so3159186pgu.0;
        Thu, 24 Jan 2019 12:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k2UNI+y5cpAGw1jlqd4+C7gsDdBuWa6hZAk4Nv/vaK4=;
        b=EV/jzKWsdRDcQLxTLksGoetxIEDdJxS+66UugLyOIKNmACMoigZP4fEstWeK5gE6dc
         VV9q2bWAQLDo8E0sxQRwa//k2Y4oc3GMpyZEFu5h/WzCD1+AXqdnQXJHwySUskZ+HvfZ
         8bcYylcLB34isrlwDDYtecOJ2zm8lL47KSPNH+Xe51b1U7BZUx/mGVAF4/3cOP6Ap1un
         g7Dh7PF9hXVhMcG0ekDT2hVpWeSEXci957Tls51Mik+7queWXSuTRmGAEZntIUjnUoQ7
         T3AL9SaLJZj3hYIIFtVrqkYjRGWzurxHX0xpv7hOcAYB2QlNNr8CLCKXBWp3Vw62DMpc
         slXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k2UNI+y5cpAGw1jlqd4+C7gsDdBuWa6hZAk4Nv/vaK4=;
        b=rUBn4VJZBA1Ae8Hhzr1G4jXA9Y02NLDYQ8RazcINUuB6GIjcm0Q1lpr2JgFv3t6kLo
         3imdl2LzIngJFoIez6sRzpRTBv951DtfdzLVbOKso96OesLSQxp7z4wBs7o6uIQFPM2N
         XSssjaoGdIGjjKEdpzl9tEUz/yzxvc2YZGbbXVOXuwRBTdqeSQCVGLmEtyId3URvr7Hv
         lgqFF5L4Mcuxrwy6H27BQeRNSoQctaKd+XQU2bLbojY0wRqbMVqWEwE0KAbcuWFD8Q69
         c8QuClZVZjebr4y/AmXFASy1SKHLdCJlMZwSWept0/t+CabGxl3ubdxugBtF/nyMRRPq
         aUHA==
X-Gm-Message-State: AJcUukcD8c2ZEdjdNHPgqVdbeTNEmBtfpwJb8sqmKnKzUOq5e/HAhXn3
        FqcdC3DnLtkVsqT7INUFxnFNTsFD
X-Google-Smtp-Source: ALg8bN7JCr/4Wy/68XUom9P7Zs/71bnIhPg3yuQBeZYzf8zDgFAdRawGDlWHXLDq/ewYrMFJ5ROr9w==
X-Received: by 2002:a63:c141:: with SMTP id p1mr7262280pgi.424.1548360527564;
        Thu, 24 Jan 2019 12:08:47 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id y71sm41434831pfi.123.2019.01.24.12.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 12:08:46 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     vivien.didelot@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE)
Subject: [PATCH] of: Make of_node_name_eq() case insensitive
Date:   Thu, 24 Jan 2019 12:08:25 -0800
Message-Id: <20190124200825.2611-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since c32569e358ad ("regulator: Use of_node_name_eq for node name
comparisons") Vivien reported the mc13892-regulator complaining about
not being able to find regulators.

This is because prior to that commit we used of_node_cmp() to compare
the regulator array passed from mc13892_regulators down to
mc13xxx_parse_regulators_dt() and they are all defined in uppercase
letters by the MC13892_*_DEFINE* macros, whereas they are defined as
lowercase in the DTS.

Fix this by use strncasecmp() since that makes sure the comparison is
case insensitive like what of_node_cmp() did.

Reported-by: Vivien Didelot <vivien.didelot@gmail.com>
Fixes: c32569e358ad ("regulator: Use of_node_name_eq for node name comparisons")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/of/base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 5226e898476e..ff47c86277cb 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -66,7 +66,8 @@ bool of_node_name_eq(const struct device_node *np, const char *name)
 	node_name = kbasename(np->full_name);
 	len = strchrnul(node_name, '@') - node_name;
 
-	return (strlen(name) == len) && (strncmp(node_name, name, len) == 0);
+	return (strlen(name) == len) &&
+		(strncasecmp(node_name, name, len) == 0);
 }
 EXPORT_SYMBOL(of_node_name_eq);
 
-- 
2.17.1

