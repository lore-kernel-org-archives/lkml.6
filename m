Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C3DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABAB2787D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nuJPLZWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABAB2787D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934850AbeF2IOD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:14:03 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37573 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934799AbeF2IN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:13:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id h20-v6so1934989pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OzgGn+Q4isfRNiycbtBKaigAmf6rTndiL1fQJSnnjt4=;
        b=nuJPLZWgMy5x/DllJ0f9bws6EJn7EuTd+YXMnVmC2T2b4rRmf9TRFtSkb8NpDXRsEP
         XkaJCY3S+a8UexVNdudRr5+d9iZ9SfwjTG4Lz6W9ZGHTTEjIgjTVcdNJ7aZi/n5rQr2C
         mIkdSZ0LjMrbOepYeph1BaT0zETYWtgV5Hmqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OzgGn+Q4isfRNiycbtBKaigAmf6rTndiL1fQJSnnjt4=;
        b=AeE+5cFajPNa5fzFSjpy2u51KL2REhT8oo5xnZsTq16ud7XW5i9u9jHyQn4ox6HQpU
         Nw5R+0XtckLOpMZMyUDZf7fNB6o0qmGK6WAULxLlihGJ0qG9SyhzZsy5qP5kcP5meerm
         KAeJgDk6a7msal3ZYS30/F1KEtSwVLGkrcpwXcD6DmA9OQB43WN9kpvijbtMsLgFZsxp
         SxkT0zCmN9yiZeNMR6hX5qdMs6Macs5vTNRqxo3eRvwFtWaJe2F4IxWIymisqk5THjJ7
         ASRUWCrR+C0hf8UCDEQ+cXxI5orMglsUlvOTfW/TjZ/2Hkg8rrBaeVLJhmMo/isNM6/R
         1voQ==
X-Gm-Message-State: APt69E0iiBM75WNyq5MAfXuhhgJcktBrzLsfHYQTx6krrFxbcRJXV3Ol
        YNEajy0alaWa1t/f88DyZcTFfqe3NJU=
X-Google-Smtp-Source: ADUXVKI4IIgRqhwccVLliC3PUz0EbFQJGPdvShoSOUhiYOP7cEV17WGQdu6uP/KT0lAgeaLU7R7jmw==
X-Received: by 2002:a63:107:: with SMTP id 7-v6mr11490038pgb.289.1530260039314;
        Fri, 29 Jun 2018 01:13:59 -0700 (PDT)
Received: from excession.tpe.corp.google.com ([2401:fa00:1:10:3987:9bf6:3352:7574])
        by smtp.gmail.com with ESMTPSA id p19-v6sm5494749pfd.75.2018.06.29.01.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 01:13:58 -0700 (PDT)
From:   Louis Collard <louiscollard@chromium.org>
To:     linux-integrity@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, apronin@chromium.org
Subject: [PATCH v2] tpm: Allow tpm_tis drivers to set hwrng quality.
Date:   Fri, 29 Jun 2018 16:13:55 +0800
Message-Id: <20180629081355.155317-1-louiscollard@chromium.org>
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

