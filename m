Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AA6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B3620837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B3620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeH3W4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:56:04 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39707 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbeH3W4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:56:04 -0400
Received: by mail-oi0-f67.google.com with SMTP id c190-v6so17307341oig.6;
        Thu, 30 Aug 2018 11:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1Kkp6VXQTWLNRTjIurqTu/b/ONg3G/htDfEkWKGxZmA=;
        b=kcEkKvgZ6LtOXBVkNq5jPo4vWo6u4busglTh5u4PEpC0FeiwLmG+fXT95rwKgVblNG
         q7buBAOWWbroeGglP3asVuANRnEB1LfbQ/z7He41Lbh3KNSHhEh0MEjcvNO4Fy9wLJqJ
         ApgIS68RMVN/F46q37T4y5hFG6UX8X3004cMSJdWgFVDcUQK7QQl9me700e7kajmH5HS
         0BGuvBC+LdMqheGZnQgjsUU51cqoL1fYtMmClUw0Agw/xJbcdqHCeVi/QLmQz846FUja
         binbgAYTBTUCeQW9hMNH06nzgqMnFT/4lq4G4e/y8SO+5qbmkOivJ+wmMzKTxMvSQKlI
         xTkg==
X-Gm-Message-State: APzg51BS634GtJ3AJgFVY53WhJ6pRQD2s5IiW/OYzYkOjfCNQ7QxWHVh
        xyrxeZMF1Zj4Ft5h3pYFrUEqo2I=
X-Google-Smtp-Source: ANB0Vda/5G6n+4pp72Labmz1+WZ8KiQ/Di7M6BEviFnygYUrZJdTEiiZ1gOjNuhrR7xirDEwO5Gg2w==
X-Received: by 2002:aca:d9c5:: with SMTP id q188-v6mr3966425oig.239.1535655150823;
        Thu, 30 Aug 2018 11:52:30 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j125-v6sm5587426oih.53.2018.08.30.11.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:52:30 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] of: Add device_type access helper functions
Date:   Thu, 30 Aug 2018 13:52:29 -0500
Message-Id: <20180830185229.20393-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove direct access to device_node.type, add
of_node_is_type() and of_node_get_device_type() helpers to check and
retrieve the device type.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 include/linux/of.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index a40f63a36afa..506beca9588d 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -980,6 +980,18 @@ static inline struct device_node *of_find_matching_node(
 	return of_find_matching_node_and_match(from, matches, NULL);
 }
 
+static inline const char *of_node_get_device_type(const struct device_node *np)
+{
+	return of_get_property(np, "type", NULL);
+}
+
+static inline bool of_node_is_type(const struct device_node *np, const char *type)
+{
+	const char *match = of_node_get_device_type(np);
+
+	return np && match && type && !of_prop_cmp(match, type);
+}
+
 /**
  * of_property_count_u8_elems - Count the number of u8 elements in a property
  *
-- 
2.17.1

