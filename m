Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B27CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF4D20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xv+mo420"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfANNqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:46:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43592 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfANNqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:46:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so22903625wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 05:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O84mJPX8rC7OO4KioGFTyrv4Z9BLr8QwdnxN2Cr0+Iw=;
        b=Xv+mo420RQ7SowyXQw5AOCTKRj/czTkjlgmqK2fPHy5sIyzgCxajeFCQkYBrAPj+95
         +Fju2rw+nA/0cRLQlXuiFPULIZJGWcF/j3Qyi5ZPa66gsosd/FfNWpVg0zplq66CTSxK
         GbBvRVkhYOhLZXsP85cjaruzTkBMzLR5qQUkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O84mJPX8rC7OO4KioGFTyrv4Z9BLr8QwdnxN2Cr0+Iw=;
        b=KwyvCwe50vLtSO04Thwl0shAhH97J04auy8Wu+TFm6RjrkM/GBoX77mX9DerL9q9MD
         9v5g6KxACqXv7kjukTeJ4mARCxPrAn5KAVF77hd7e/dPjMS0Il5Bm2xeXfHXXfTBR3/Z
         HCimSPnIjEP00c7t0cGReWcHBl5NBtShptkE+SCWL15XZ26eitb8NWVkYMm916SCqcIt
         FzxJUnVwRtXI13GdbRKgXsKhH/MI2+nSqMuPuI12y0ff/PiDx/xWG6Q9apgIv8EooI4e
         lvN4FqHtaVpVko/YPyA0QRmZ16lEdQcTSjXRdTXNMZeo6WW6MIRn1S6zv6sNb9Ge+Pmc
         lW3A==
X-Gm-Message-State: AJcUuke4uwfdbu1+bh8rIBfWNgbex+qCveZLYppdDWKu448igirR8dsg
        js0PuZuf+4XWEXY1SbiMiZHsLg==
X-Google-Smtp-Source: ALg8bN4MnerjFJwS814W3kl5XW6Mk6zbxqo8XNvKLGKMxT8Im17NTWIRM5DDeHIDp88gfaCzPytGIg==
X-Received: by 2002:adf:b6a1:: with SMTP id j33mr24357526wre.55.1547473559036;
        Mon, 14 Jan 2019 05:45:59 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id x10sm86766472wrn.29.2019.01.14.05.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 05:45:58 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] slimbus: core: add missing spin_lock_init on txn_lock
Date:   Mon, 14 Jan 2019 13:44:49 +0000
Message-Id: <20190114134449.15367-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
References: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing spin lock intialization this also fixes the spinlock bad magic
warning.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 8ffdc9876223..b2f07d2043eb 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -274,6 +274,7 @@ int slim_register_controller(struct slim_controller *ctrl)
 	mutex_init(&ctrl->lock);
 	mutex_init(&ctrl->sched.m_reconf);
 	init_completion(&ctrl->sched.pause_comp);
+	spin_lock_init(&ctrl->txn_lock);
 
 	dev_dbg(ctrl->dev, "Bus [%s] registered:dev:%p\n",
 		ctrl->name, ctrl->dev);
-- 
2.20.1

