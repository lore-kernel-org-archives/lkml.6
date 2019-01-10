Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36D3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B144E208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NfNgkqZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfAJVCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:02:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35736 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfAJVCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:02:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so5722712plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 13:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZARu9UCi4xrMPRpppS+IIjC4rdBSvF8crSbkUbDMBGM=;
        b=NfNgkqZTGUxn46lQER81Mq1UQHA72OCGNNz5hnDZBJbYMlnIyz7CtV4KaVzM/1vcB5
         +m+A6BTufpNNHilXz20IIhs7D4oXx+ooZI/TczlEOGWI12Ic9O1WXbI5qSP2Jgqvz6tp
         V65G3RYXn4rz8YyBUNVy89mGqoBx3h61ewy3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZARu9UCi4xrMPRpppS+IIjC4rdBSvF8crSbkUbDMBGM=;
        b=E8oFtJEXcx6bQkA69D9vd5u7d1mf92jWNPYmyRUNLGezI4jjjKjtiosCMyb81wZPuW
         0oZ/1hVrTwF6RY7C04oSj8naCUhe9AZGy8Pk6SN7Rza93UJ9V+o6fTPxFCCM+UULD4ez
         SzdLMEcKGTMGRSHNO5NYJumI1nyMM27z/YpPd5x3JJKCfZNhF/Af4tsLKOBUmg9qnUXI
         G4XN+hi1HFnHLfLglTrDqcmk1oABKERoZ3VHgoXfnlj8fnsks1iL6HuwKaMNr+I5/Nia
         e1xqlDeDd6pKUvaqj/vtNz+fCkA+/VHnvM4+OFpCPAjny9RFwL9uT1pIDA82k/ilYtyw
         542A==
X-Gm-Message-State: AJcUukf9t3dKbnK/gz2NHJpO7EnRZv/aoc22NtMXx3eUNO/FLh/Nnsjv
        +uB675+1nVv+YeFAyGX3hxSJZA==
X-Google-Smtp-Source: ALg8bN7MjSTeHxw61KTjWdGf7mpgBzaotL5D3QrlKVm2E0Hr2TqwVk9U6Hrur6JKxPJ/IVCUdzdn/A==
X-Received: by 2002:a17:902:981:: with SMTP id 1mr11539368pln.142.1547154174479;
        Thu, 10 Jan 2019 13:02:54 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s37sm95562617pgm.19.2019.01.10.13.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 13:02:53 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/2] spi: spi-geni-qcom: Don't initialize completion for normal message
Date:   Thu, 10 Jan 2019 13:02:52 -0800
Message-Id: <20190110210253.23219-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only use this completion when we're doing something that isn't a
message transfer. For example, changing CS or aborting/canceling a
command. All of those situations properly reinitialize the completion
before sending the GENI the special command to change CS or cancel, etc.
Given that, let's remove the initialization here.

Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Dilip Kota <dkota@codeaurora.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index fdb7cb88fb56..c3e9464027d4 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -233,7 +233,6 @@ static int spi_geni_prepare_message(struct spi_master *spi,
 	struct geni_se *se = &mas->se;
 
 	geni_se_select_mode(se, GENI_SE_FIFO);
-	reinit_completion(&mas->xfer_done);
 	ret = setup_fifo_params(spi_msg->spi, spi);
 	if (ret)
 		dev_err(mas->dev, "Couldn't select mode %d\n", ret);
-- 
Sent by a computer through tubes

