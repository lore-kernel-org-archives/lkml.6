Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2843DC04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B9F2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B9F2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbeKQIUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:20:07 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37047 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQIUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:20:07 -0500
Received: by mail-oi1-f194.google.com with SMTP id y23so11771535oia.4;
        Fri, 16 Nov 2018 14:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ix8cP0wCHZeC/8dXIYOuLIsYXZGQ5ByO8TLiKaNRW6A=;
        b=F9jeuVVMR2GAzVHVOTrj1eKT3eYDjzgnBDjasl3+sA8ESqRggt8USYme4vOWfQqt+t
         4GYMRhMFcMPb5EYIQRWb02aethDpFYYO+iqT5l6E9fZU9zzVnkzUkHgeUDWlxMUUUb2v
         dLbnq/MIX/Q3wc5Rhp4DlxZ+kmsa8y/jDwc9Ab882NZrfHF9RZsD+Hei/rk2ZIiOK1PU
         +itxNMEWGUDaSEpMobgvtjoK6qCEzmVJZwywFQeVbIg26r+9sIEupyAGWARJcqhMNhu7
         wgHFHXRoGN9gQPU9tIHTOJpa1tTbcljW8gZZMnhymPhtqW1LQ2fFzQoFf8iKnNoW9IOn
         MtOw==
X-Gm-Message-State: AGRZ1gKuKIplTJdxNpaT6KYmIPC+QzTNoIMLnbkPFgFHsBwDyb5Fn3/3
        iGRw8/n4dyhnPqRxsPcC+hfspwFs2A==
X-Google-Smtp-Source: AJdET5dWAlyw9dQNJ01NmZEVcGJb1ngmkYFLUKKBDVDguZVokV56SJD0WI0696LJyEdJzyun0JaKcg==
X-Received: by 2002:aca:4202:: with SMTP id p2-v6mr1888048oia.41.1542405957801;
        Fri, 16 Nov 2018 14:05:57 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.googlemail.com with ESMTPSA id w5sm2316587oif.48.2018.11.16.14.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:05:57 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] macintosh: windfarm: Another convert to using %pOFn instead of device_node.name
Date:   Fri, 16 Nov 2018 16:05:39 -0600
Message-Id: <20181116220540.17222-3-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116220540.17222-1-robh@kernel.org>
References: <20181116220540.17222-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Convert the open coded iterating thru child nodes to
for_each_child_of_node() while we're here.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/macintosh/windfarm_fcu_controls.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/windfarm_fcu_controls.c b/drivers/macintosh/windfarm_fcu_controls.c
index fab7a21e9577..2b3ca628a650 100644
--- a/drivers/macintosh/windfarm_fcu_controls.c
+++ b/drivers/macintosh/windfarm_fcu_controls.c
@@ -425,18 +425,18 @@ static void wf_fcu_lookup_fans(struct wf_fcu_priv *pv)
 		{ "CPU B 2",		"cpu-fan-b-1",		},
 		{ "CPU B 3",		"cpu-fan-c-1",		},
 	};
-	struct device_node *np = NULL, *fcu = pv->i2c->dev.of_node;
+	struct device_node *np, *fcu = pv->i2c->dev.of_node;
 	int i;
 
 	DBG("Looking up FCU controls in device-tree...\n");
 
-	while ((np = of_get_next_child(fcu, np)) != NULL) {
+	for_each_child_of_node(fcu, np) {
 		int id, type = -1;
 		const char *loc;
 		const char *name;
 		const u32 *reg;
 
-		DBG(" control: %s, type: %s\n", np->name, np->type);
+		DBG(" control: %pOFn, type: %s\n", np, of_node_get_device_type(np));
 
 		/* Detect control type */
 		if (!strcmp(np->type, "fan-rpm-control") ||
-- 
2.19.1

