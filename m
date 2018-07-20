Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD71FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC1220833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pP2D9PFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC1220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeGTEhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:37:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36896 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeGTEgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so5614986pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EMNJOZEZ0arrq76rwhD4xAsOEZbOlCLN3fwdfDJ6izM=;
        b=pP2D9PFFCuX60XLRMcs4fh8AYcpmWYs6ryJYE06R8crl6sTKZDK75tbasX3wL2PLcQ
         luCRHN4x78ftSbFVX5A4wpr9BMio/0r/JiIIE7oqwkmnHWuVYiLZY7mc6BSPSCuv9DRs
         1J0GMoMpeHvBjd12kGbmESiuvx50kKclIFoGmz1pcVn1z/8xwTOKjKIPScKk8eanZBrZ
         Fu3Ogx+Pguh+1jWW8H4pqmaQRxRmahMuNueu1aBBSrfiwFnLuuA+i9eFYo7FGzZhW+x1
         pn8i1oQzlhaXa1zMffZOhmaExwSl+2T7n86HqI9QQhVw5J98ANVFcteqyokHd2mbaNBj
         YZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EMNJOZEZ0arrq76rwhD4xAsOEZbOlCLN3fwdfDJ6izM=;
        b=COvCQT9G5um3xPeH2AUtP69cb8p/zQDas0dTuHS1Cjnbt/jgGBqx9/Ko55JvXhf4WU
         O7JfdhZQ/NqHapF3Szqhy+R1vgD4F69M9daLZWPRsYIzRLsmBwWLqe3MjTdhehpu6xRw
         rQFGCURPAVK6S93EhFW/ROmNzbOmny6CBDIXT1/BxOOgiTmpY8dkNgrDT5wQpBZ5a/NJ
         gI+hTO8rf5alHWztT21hGMLSVMt9PFW3j2z8U4k+YtmJi9Dy/iahNXmSlHpbcsJtO291
         BMMjWrOxOjAvfoZrHydnKUtwE/Ff95B5A0rA3kkdWN/0+e/kTZcMkiCfxUSOnyXO1Aa4
         9iWA==
X-Gm-Message-State: AOUpUlHQjXAgEmdmX674tIJpR9mA4PGgnmMgV9lLjYUlgk+6TmktPTLz
        WTIbIf3CIF6ynX12ojMv0Z8=
X-Google-Smtp-Source: AAOMgpd/C8yzXZGhRwIAuXo0tsOX5SEHHXR6kaPY7OVZD6fyzULovVKKnuKrcYL8JE+KrsmUJ+ojtA==
X-Received: by 2002:a62:930c:: with SMTP id b12-v6mr434994pfe.193.1532058592321;
        Thu, 19 Jul 2018 20:49:52 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:49:51 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 03/20] staging: gasket: remove code for no physical device
Date:   Thu, 19 Jul 2018 20:49:03 -0700
Message-Id: <20180720034920.77320-4-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_enable_dev code for enabling a gasket device with no physical PCI
device registered shouldn't be necessary.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index f327c9d7f90a3..18cc8e3283b39 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -898,7 +898,6 @@ static int gasket_enable_dev(
 {
 	int tbl_idx;
 	int ret;
-	struct device *ddev;
 	const struct gasket_driver_desc *driver_desc =
 		internal_desc->driver_desc;
 
@@ -919,21 +918,12 @@ static int gasket_enable_dev(
 	for (tbl_idx = 0; tbl_idx < driver_desc->num_page_tables; tbl_idx++) {
 		gasket_log_debug(
 			gasket_dev, "Initializing page table %d.", tbl_idx);
-		if (gasket_dev->pci_dev) {
-			ddev = &gasket_dev->pci_dev->dev;
-		} else {
-			gasket_log_error(
-				gasket_dev,
-				"%s with no physical device!!", __func__);
-			WARN_ON(1);
-			ddev = NULL;
-		}
 		ret = gasket_page_table_init(
 			&gasket_dev->page_table[tbl_idx],
 			&gasket_dev->bar_data[
 				driver_desc->page_table_bar_index],
 			&driver_desc->page_table_configs[tbl_idx],
-			ddev, gasket_dev->pci_dev, true);
+			&gasket_dev->pci_dev->dev, gasket_dev->pci_dev, true);
 		if (ret) {
 			gasket_log_error(
 				gasket_dev,
-- 
2.18.0.233.g985f88cf7e-goog

