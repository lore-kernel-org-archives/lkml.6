Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB61C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D6A27BC2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MQN0n0cY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D6A27BC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934785AbeF2INV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:13:21 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35044 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934739AbeF2INR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:13:17 -0400
Received: by mail-pg0-f67.google.com with SMTP id i7-v6so3659312pgp.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OzgGn+Q4isfRNiycbtBKaigAmf6rTndiL1fQJSnnjt4=;
        b=MQN0n0cYBJrBiAfwmygEa8LMaowCTm8fdnpUdHO4d/aVjKxAHCFy06vKj37KPtmnJY
         FUnhMmVB5Bop7IWhhUF6QVTdQkZkpMxBAl8kFJgyGIU5uRTHsiQzVLqsGnzpOGQV7YW0
         H+k0it/rvZgOi+GmWfv7sKx6cfsw27/3BT0mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OzgGn+Q4isfRNiycbtBKaigAmf6rTndiL1fQJSnnjt4=;
        b=MBL1tHyjEuyC8IR8ccyoV2nk7g9amvYsLUSohCgTlUyvIJKxeEP1bJVZTY3o5lkKY3
         cF1nQ9aAK9pQfFArIILCcoACnKkyXPAglNpOyaLAqpeJFX1NvWt2Ml8dgO2JEyZmuJjl
         lttInIM+uYNhg9eTdAOMqhLJ+deqKuBnpYFVkzmL7TC4l7R8g3DiAavRrG4rGV9KsAQS
         k1rqJqQR9urORSLS6Wv9Wr4/aT0zDlXoQYkWT47RUCGQL/wPTN5CGVi7Mg9r+Pt+eMel
         g7CKzP61oqSHoza5KnwCDw5GY9my6ioaXxhmmhGawp6HiG7IGx8rhANmc3ml05sUCimn
         4JeA==
X-Gm-Message-State: APt69E1QbLAdi184m/eieR/3Tj87CH3STr/BX7t+BqtUjsrpxWr2MeMg
        FEYZSD0mmxxuNIV9p/b0AD1BxQ==
X-Google-Smtp-Source: AAOMgpcR8iip0WWnl+/LDgt9DfNzfBKeUGJC7WriRxuY96KCzwXSD1uEgYVQy9AWjWfE6lCTezmLdg==
X-Received: by 2002:a62:fe19:: with SMTP id z25-v6mr13190972pfh.167.1530259996608;
        Fri, 29 Jun 2018 01:13:16 -0700 (PDT)
Received: from excession.tpe.corp.google.com ([2401:fa00:1:10:3987:9bf6:3352:7574])
        by smtp.gmail.com with ESMTPSA id h13-v6sm12994488pgp.13.2018.06.29.01.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 01:13:15 -0700 (PDT)
From:   Louis Collard <louiscollard@chromium.org>
To:     linux-integrity@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, apronin@chromium.org
Subject: [PATCH v2] tpm: Allow tpm_tis drivers to set hwrng quality.
Date:   Fri, 29 Jun 2018 16:12:58 +0800
Message-Id: <20180629081258.155228-1-louiscollard@chromium.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds plumbing required for drivers based on tpm_tis to set hwrng quality.

Signed-off-by: Louis Collard <louiscollard@chromium.org>
---
Changes since v1:
- based on (hopefully!) correct git tree

 drivers/char/tpm/tpm_tis_core.c | 2 ++
 drivers/char/tpm/tpm_tis_core.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 8b46aaa9e049..d2345d9fd7b5 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -875,6 +875,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	chip->acpi_dev_handle = acpi_dev_handle;
 #endif
 
+	chip->hwrng.quality = priv->rng_quality;
+
 	/* Maximum timeouts */
 	chip->timeout_a = msecs_to_jiffies(TIS_TIMEOUT_A_MAX);
 	chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index f6e1dbe212a7..f48125f1e6e0 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -99,6 +99,7 @@ struct tpm_tis_data {
 	wait_queue_head_t int_queue;
 	wait_queue_head_t read_queue;
 	const struct tpm_tis_phy_ops *phy_ops;
+	unsigned short rng_quality;
 };
 
 struct tpm_tis_phy_ops {
-- 
2.13.5

