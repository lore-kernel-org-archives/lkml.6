Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6641C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D0D2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQhPttEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfBSXyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:54:35 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:38853 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfBSXyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:54:35 -0500
Received: by mail-qk1-f201.google.com with SMTP id x63so1126350qka.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=48uoaBkr5Fhc7UlZ8wN/irXAr/m44zxpQNOys3T/n9c=;
        b=vQhPttEr/V+we7WUTgebhvd9qs/GKVCEiWDXMDUDATEj9NFF5IlmzXX+/cUZCyZy+m
         HinE3xUtvhkocPkgJ2vs8/p7EAbjW/OifHt0RlrkZPxNZ7UImATgPuyeKD9x6TKXDc5E
         QBg5sjloI9JGurGoVjd9mt34KLsWdv0i9Jw9vsQJNyhKiNlkqd5lih8oQiwAhkx6Mh0L
         9lgk/ABo+eULqq84Z9zCJBg2FXei3M2OEpsHxAZk/qxgZ0tC+KZgKtiDnFMu8fSoLRgA
         mlba8E3UzUCTfvgG7engcJdvJqr0/8PKEo7Z5Zn/GkjMqAmRRnq6WiaCUTR/ox7gZoVD
         mHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=48uoaBkr5Fhc7UlZ8wN/irXAr/m44zxpQNOys3T/n9c=;
        b=aBXzsyiO3q0cm5r06yDML1141/+TsD0xIILWPTGWs18SIU10qCl1+6e9l76Ygt5NrH
         KoH2+N4g5DyzMD+VMlFM6Ny6ka6J9tWnzbv3s2K48QoQMBAZZbXMe62+U+h/i1QeIgBv
         V0coi391BXYKmcHeVDYLRLTosm6CTdU4+4a0a1YBcHAYe0HEutdaUNK/7Fo8MAQzVEXg
         KgaeMNwb3TK47wgHAn9gH7jGP2W4GMVYCzFKrjx3e8fPTgJ/FMwgja5nZvXhLYDvHGIj
         waF8iN7/5OF1Nporxsdf3XbyGSGev8lC+y5WeotXeS370ij66rQAhkXAl96u2Ix9yR8Z
         0/IA==
X-Gm-Message-State: AHQUAuZccUUbij3nRLIJwXwYX1SqKvmWbQKGA1i5aQiiR6da8knU9qBX
        9hBCLqGWOo7oclmh3YL9NDodwjLKH2HRsTGFVf2wpg==
X-Google-Smtp-Source: AHgI3IbFmMMiCdRLSyrDQs/0Y6Xj0UiXXLL2TnDpdz/cFRsD6CH1Xeegee4edVNdJYVfuyrPdd20ZJsoYGR4Q2leAEQUZg==
X-Received: by 2002:a37:d186:: with SMTP id o6mr18154572qkl.19.1550620474204;
 Tue, 19 Feb 2019 15:54:34 -0800 (PST)
Date:   Tue, 19 Feb 2019 15:54:22 -0800
Message-Id: <20190219235422.256847-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v3] of: unittest: unflatten device tree on UML when testing
From:   Brendan Higgins <brendanhiggins@google.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com, mcgrof@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UML supports enabling OF, and is useful for running the device tree
tests, so add support for unflattening device tree blobs so we can
actually use it.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/of/unittest.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 84427384654d5..98f0dfc91c2a3 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2514,6 +2514,10 @@ static int __init of_unittest(void)
 	int res;
 
 	/* adding data for unittest */
+
+	if (IS_ENABLED(CONFIG_UML))
+		unittest_unflatten_overlay_base();
+
 	res = unittest_data_add();
 	if (res)
 		return res;
-- 
2.21.0.rc0.258.g878e2cd30e-goog

