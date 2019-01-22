Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0451C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A63217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548177809;
	bh=vRen3aAO8O13xjYc5whdXmQctDFM7soenZmQ2mhZvq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D/zAAemLRU5Ia5S6M4Uee3uaDB4KSLd3RUs/iYNoPwEKwc6k6uauxl2rRM/DNWToL
	 Refz6gfkd4o7HRmb7rqsVRa1R/K9u2LR9ZXO8OupuJCTdVsxSVUAf2IGKWtH5SBIW1
	 lOMy3six2gUUbI2jY83SKo6eGN+Tu/436e3bTOzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfAVRX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:23:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38666 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbfAVRXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:23:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so21349779lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 09:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rl2KJL7uDBCdwW+hXir8OykyApAvp/osF5eC6yaBp90=;
        b=bjjx2s79itSflK6PXZmT8RmmcEx/e6vS48Z+yiWeZHw3BJfYmwhmkeuajtK8ze4Q4t
         v/hl3ESsEvCLI/N1EBiBZ5cjWdB/xodFdU3pPkpZh4TG5KuzMYVvmFtTrd7+hX5t9L+L
         3oKfuEq9J5h7/ZgG8yVL07E3qTws+ttG+Ya0vj5TkyWaXdTGYCLB34SnJmR1e3hqPVz0
         56WeginGX2jJlw9QWNELAI8c7/I9JIOphW+goteBwL+Sgfgp8AIX1ZtO9XV/uWciAfXS
         C3oK65ur6AhvZCgeQeqtWfZcMoS9R4b6ot5c6MLuBMbazCaF/qSsn+xTd7K721jkJOqe
         UHRQ==
X-Gm-Message-State: AJcUukeXD3ki1VnuG7uwmjSjpW5DWPCBMa8qeT50qVARDlklYaDX3UuP
        7BEPZ1e8NqcwtbNxWoY7VX+WyAdU
X-Google-Smtp-Source: ALg8bN66zgGNu3uUE17dWebKlYkVD7NIgfmcEKy+1P2OiZIrKDwt1RsBf493rkzQg8tw1itaOjD6bw==
X-Received: by 2002:a2e:9e16:: with SMTP id e22-v6mr21033977ljk.4.1548177799686;
        Tue, 22 Jan 2019 09:23:19 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z6sm93863lfd.50.2019.01.22.09.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 09:23:18 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1glzla-0004gI-UU; Tue, 22 Jan 2019 18:23:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] gnss: sirf: force hibernate mode on probe
Date:   Tue, 22 Jan 2019 18:22:54 +0100
Message-Id: <20190122172255.17944-3-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122172255.17944-1-johan@kernel.org>
References: <20190122172255.17944-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to put the receiver in hibernate mode in case it is already
active during probe in order to avoid wasting power until first open or
suspend.

This can happen, for example, after a reset or non-clean shutdown, and
possibly also due to glitches during power-on.

Reported-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/sirf.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 8e3f6a776e02..f9a9d00dec98 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -320,6 +320,11 @@ static int sirf_probe(struct serdev_device *serdev)
 	}
 
 	if (data->wakeup) {
+		ret = gpiod_get_value_cansleep(data->wakeup);
+		if (ret < 0)
+			goto err_disable_vcc;
+		data->active = ret;
+
 		ret = gpiod_to_irq(data->wakeup);
 		if (ret < 0)
 			goto err_disable_vcc;
@@ -332,6 +337,18 @@ static int sirf_probe(struct serdev_device *serdev)
 			goto err_disable_vcc;
 	}
 
+	if (data->on_off) {
+		/* Force hibernate mode if already active. */
+		if (data->active) {
+			ret = sirf_set_active(data, false);
+			if (ret) {
+				dev_err(dev, "failed to set hibernate mode: %d\n",
+						ret);
+				goto err_free_irq;
+			}
+		}
+	}
+
 	if (IS_ENABLED(CONFIG_PM)) {
 		pm_runtime_set_suspended(dev);	/* clear runtime_error flag */
 		pm_runtime_enable(dev);
-- 
2.20.1

