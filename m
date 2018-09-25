Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC0AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A372B20684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=sehro.org header.i=@sehro.org header.b="XgsKuO4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A372B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sehro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbeIZFwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:52:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:47064 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeIZFwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:52:07 -0400
Received: by mail-io1-f67.google.com with SMTP id y12-v6so21844104ioj.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sehro.org; s=dotorg;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRIm7xHZutOkojX3O5uUewGtJg7PmDDNqsPJg9tEUb0=;
        b=XgsKuO4jDOeATAmWsLivTw5bZWB83QsiFsKOnxveJYVDeKUR/KhvolAJSgx5yg5TAD
         qHY6EXP6HSOym9MCc7yGGhTOIuEhC34nLRS0mrSNFktkTKnXSrBBHfiix0QWmq8YlB5K
         slClXX4fEXWGohvdS7JbiT/qTlMcLr8LNgYIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRIm7xHZutOkojX3O5uUewGtJg7PmDDNqsPJg9tEUb0=;
        b=kRiq8QDm+d7gECB807umFQLVGQXhw4yy4oeTNQ6ZyGTIIh/sIjWrsfS3VcY4efFRdS
         fciaVIwMWegtQJ1HCnh10wr5KPZfvNd59JcwNU2q0ElO9JV/UVoEyajQ9jdsaEx8g05f
         uxa9JnHgE2LRpfOI3fmBQtj7LYGFPsMhUIgz9OGIQ4ca0bBuNV0CSG3gncNwrsdwbVVh
         tqZZRMj9nQ9KD/9UeIDFrXgAVDU1ViwB5MyblSvSWnsRnzb0wBYRUE7HfyGLnDkZlxPe
         UfmxgP5Gfz7julzQbChSJ1tCm7WTuiSwvIyufQEIng19yLqXtTJihmsagewzvK6eh/cm
         BVKg==
X-Gm-Message-State: ABuFfoh8Ad9kMKrrrTbbmM7BJv+G5ycU3Bx16A0SgaV/m9jktTlqkSIp
        rHszMpos9TVcZYOZ9+8WVGcVpQ==
X-Google-Smtp-Source: ACcGV61zbNTRiVwhlS/+2ldrjJaM5yeR52SRPpM9GPhC8FST954lS6BZOiQbAheqYyngw6neMX4vhg==
X-Received: by 2002:a6b:8f93:: with SMTP id r141-v6mr2667950iod.118.1537918928008;
        Tue, 25 Sep 2018 16:42:08 -0700 (PDT)
Received: from goro.horizons.sehro.org ([2601:280:4400:56c:731e:1a85:7df8:2d5b])
        by smtp.gmail.com with ESMTPSA id n194-v6sm1832400itg.14.2018.09.25.16.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 16:42:06 -0700 (PDT)
From:   Sehro Rautenkranz <sehro@sehro.org>
To:     sehro@sehro.org
Cc:     Lidza Louina <lidza.louina@gmail.com>,
        Mark Hounschell <markh@compro.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: dgnc: Fix Kconfig help header and text
Date:   Tue, 25 Sep 2018 17:41:59 -0600
Message-Id: <20180925234159.22547-1-sehro@sehro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <59f16a7e-4221-73e0-cf6e-3461717be318@infradead.org>
References: <59f16a7e-4221-73e0-cf6e-3461717be318@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace Kconfig help header and text to match other modules. Issue found
by checkpatch.

Spacing adjusted to match Documentation/process/coding-style.rst. Issue
reported by rdunlap@infradead.org.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sehro Rautenkranz <sehro@sehro.org>
---
 drivers/staging/dgnc/Kconfig | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/dgnc/Kconfig b/drivers/staging/dgnc/Kconfig
index 032c2a795238..9f4f52c9c27d 100644
--- a/drivers/staging/dgnc/Kconfig
+++ b/drivers/staging/dgnc/Kconfig
@@ -1,6 +1,10 @@
 config DGNC
-       tristate "Digi Neo and Classic PCI Products"
-       default n
-       depends on TTY && PCI
-       ---help---
-       Driver for the Digi International Neo and Classic PCI based product line.
+	tristate "Digi Neo and Classic PCI Products"
+	default n
+	depends on TTY && PCI
+	help
+	  Say Y here to enable support for the Digi International Neo and
+	  Classic PCI based product line.
+
+	  To compile this driver as a module, say M here: the module will be
+	  called dgnc
-- 
2.19.0

