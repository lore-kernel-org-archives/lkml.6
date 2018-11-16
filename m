Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF518C04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7992086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7992086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbeKQIZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:25:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36803 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQIZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:25:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so22736842otk.3;
        Fri, 16 Nov 2018 14:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dm96ml3cZNVLC3eH890iFCugyIdMvaya0M2JyB3z1mo=;
        b=Lm405YJIthW+XPQ4HpRVW6Xq0JwvCzF3IppLeUHg504qc++u1c//QqW/6rpKE5N6oo
         X0KSU79Rya2BH2zgfULtr9wYh+pss5x1WrY4O3nfUqcBLLqRAW2t6xUMswMXYhzF2+IJ
         zvhp02earaz6R201TIUhPZBqXR650Tkhqfewj7a4y42IyHnD9sUvBy4F5UOwnxvvgY5q
         tTJJ5efce1R6Ir5p64AuGro9LPrlwPzz0iONtlmeClfQHMzLPbk36qL44nN/IFeoT9bg
         gR4+mU7z96MdtMUpq/uXv5vGR98VkO/qP9Lcu7J7qp8vPQoiY3tn9qgMcemGzVG0zcVC
         pg9w==
X-Gm-Message-State: AGRZ1gLY1OOjnYT2b7MbEqJVC+7l0IV68Nq3x0EmwKyG8Cpn3uDcxVVK
        YxutkdplrjAfIUbQVdOqug==
X-Google-Smtp-Source: AJdET5dNN4gUHZyvBz+rVWnFbgEJaLp+TdTbHCd2q7CntIQ2dQJVLTZbWNJVnIJDXpLglNVm2oJPDQ==
X-Received: by 2002:a9d:2c94:: with SMTP id p20mr7089642otb.92.1542406269333;
        Fri, 16 Nov 2018 14:11:09 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.googlemail.com with ESMTPSA id p204-v6sm12142631oib.25.2018.11.16.14.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:11:08 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Rework btext_find_display to use of_stdout and device_type helpers
Date:   Fri, 16 Nov 2018 16:10:59 -0600
Message-Id: <20181116221104.23024-3-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove directly accessing device_node.type pointer and use the accessors
instead. This will eventually allow removing the type pointer.

In the process, the of_stdout pointer can be used instead of finding the
stdout node again.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/kernel/btext.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index b4241ed1456e..488b0875ed66 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -232,20 +232,12 @@ static int btext_initialize(struct device_node *np)
 
 int __init btext_find_display(int allow_nonstdout)
 {
-	const char *name;
-	struct device_node *np = NULL; 
+	struct device_node *np = of_stdout; 
 	int rc = -ENODEV;
 
-	name = of_get_property(of_chosen, "linux,stdout-path", NULL);
-	if (name != NULL) {
-		np = of_find_node_by_path(name);
-		if (np != NULL) {
-			if (strcmp(np->type, "display") != 0) {
-				printk("boot stdout isn't a display !\n");
-				of_node_put(np);
-				np = NULL;
-			}
-		}
+	if (!of_node_is_type(np, "display")) {
+		printk("boot stdout isn't a display !\n");
+		np = NULL;
 	}
 	if (np)
 		rc = btext_initialize(np);
-- 
2.19.1

