Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3784AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03852086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03852086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbeKQIUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:20:00 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35273 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQIT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:19:59 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so8577977oif.2;
        Fri, 16 Nov 2018 14:05:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OMxzw3OgABjWMwDVIjzC61nzPa4oBfyhrfhlaiDptyc=;
        b=RWiRTOsf6br8+ZrK6xGmbSZB95mTF35kNmNSY11Rdu6HhwPbCIUMCw+2dUkkykkBgY
         Iq+YhsslkZXOYcnkq52GxS8DDweevrI3P/XuSSrTDUgtnXotVhK9p0CoW9PtNsrrFF49
         XjQ+KzvW7KowCghbGMyHv7c8sA+HHorbVQPUXaALMo2NZO3RVhTT9XpK0v35Hj2t/you
         QLY08tIAmFttsRmoRhh0Mi7PeatIrnFG82gU5Z26O1a51cR6IUe8S3A5WMeCUcRQ3QHi
         0vYElkvbg5gaTAwJHesY7Up7hMJfGz4LNVR5bBbOuzzbZUc59BkneW1myavRf7ZIGkLK
         NUcQ==
X-Gm-Message-State: AGRZ1gLB/f1da5LiBKHtnJDWrI7aZJFGgTdDkTPpfDHIfi06EgZNjapY
        sNC/MhNPVe/t40cWDdlSdA==
X-Google-Smtp-Source: AJdET5daRqqbI8n8z3T30QfMM073cqCIkgqMHjura3g8JAgKzyx6p04giaJtUwD8CmVbrn0sZhyeug==
X-Received: by 2002:aca:54c4:: with SMTP id i187mr1738904oib.238.1542405950123;
        Fri, 16 Nov 2018 14:05:50 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.googlemail.com with ESMTPSA id w5sm2316587oif.48.2018.11.16.14.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:05:49 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Chas Williams <3chas3@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: [PATCH] atm: Convert to using %pOFn instead of device_node.name
Date:   Fri, 16 Nov 2018 16:05:37 -0600
Message-Id: <20181116220540.17222-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Chas Williams <3chas3@gmail.com>
Cc: linux-atm-general@lists.sourceforge.net
Cc: netdev@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/atm/fore200e.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index f55ffde877b5..14053e01a2cc 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -754,8 +754,8 @@ static int fore200e_sba_proc_read(struct fore200e *fore200e, char *page)
 
 	regs = of_get_property(op->dev.of_node, "reg", NULL);
 
-	return sprintf(page, "   SBUS slot/device:\t\t%d/'%s'\n",
-		       (regs ? regs->which_io : 0), op->dev.of_node->name);
+	return sprintf(page, "   SBUS slot/device:\t\t%d/'%pOFn'\n",
+		       (regs ? regs->which_io : 0), op->dev.of_node);
 }
 
 static const struct fore200e_bus fore200e_sbus_ops = {
-- 
2.19.1

