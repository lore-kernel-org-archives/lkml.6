Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B848C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B242084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B242084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeH1Tpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:45:36 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45313 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeH1TpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:45:13 -0400
Received: by mail-oi0-f68.google.com with SMTP id t68-v6so3675776oie.12;
        Tue, 28 Aug 2018 08:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T+l961YCM6AdnrRoLX9dDKYctXA+LHBCEcRJLbcGhSU=;
        b=n3yWlcRERckvfQj4ERatcNR7EfGXhr8eUG5w5h7DulWPBIlz0ApS/NtvMR/u0JdPRm
         jbKOOTOrOz2q0oJ+AL7fSTjefnwstAFJ+TupjMhh5n0iRUgqyjis7iVCBD6BU0Jar7Hw
         BiY9QaBkERRujBqBtDlrNpQggolIhwd9QbuhHNOgAhZl86sH+nYcxOW0hQihCuZZOX7C
         8N79wKm9T2JbgN46tNBjwkkyxtLTLcVS+kSxqw7yDtVyAeNi8rLziOxAxJuJGxXoQ+ZW
         bpjPXyx/XYdo9rGTPPE5oOXlMKFkcxMTP/rKXFl2mIhNbMtQEhCJp7CwUdggvFHkwdJf
         0pGQ==
X-Gm-Message-State: APzg51DyAnAJEJWpJ60hIMfQxYSxXibB0HxboHzZQsruombx/LSFGa7R
        K24F4rCoY2Krl+s3v84NPg==
X-Google-Smtp-Source: ANB0VdY6MVVqVATf5Al6HO6AbhHRZYBUcMnVxoD8QF5FDwmadsFN1PrLWd0+16xpWAOa+3Psk3fCKg==
X-Received: by 2002:aca:4d56:: with SMTP id a83-v6mr1563136oib.205.1535471576633;
        Tue, 28 Aug 2018 08:52:56 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id o68-v6sm2902294oik.56.2018.08.28.08.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 08:52:55 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] of/unittest: remove use of node name pointer in overlay high level test
Date:   Tue, 28 Aug 2018 10:52:51 -0500
Message-Id: <20180828155254.10709-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828155254.10709-1-robh@kernel.org>
References: <20180828155254.10709-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing the node name pointer, it needs to be
removed from of_unittest_overlay_high_level. However, it's not really
correct to use the node name without the unit-address and we should use
the full node name. This most easily done by iterating over the child
nodes with for_each_child_of_node() which is what of_get_child_by_name()
does internally. While at it, we might as well convert the outer loop to
use for_each_child_of_node() too instead of open coding it.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/unittest.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 722537e14848..69a522e48970 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2347,10 +2347,12 @@ static __init void of_unittest_overlay_high_level(void)
 		}
 	}
 
-	for (np = overlay_base_root->child; np; np = np->sibling) {
-		if (of_get_child_by_name(of_root, np->name)) {
-			unittest(0, "illegal node name in overlay_base %s",
-				np->name);
+	for_each_child_of_node(overlay_base_root, np) {
+		struct device_node *base_child;
+		for_each_child_of_node(of_root, base_child) {
+			if (!strcmp(np->full_name, base_child->full_name))
+				unittest(0, "illegal node name in overlay_base %pOFn",
+					np);
 			return;
 		}
 	}
-- 
2.17.1

