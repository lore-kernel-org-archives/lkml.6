Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F078FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA60820657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CsrEo/uJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfANNp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:45:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54327 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfANNp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:45:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so8962751wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 05:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eSHBro6jkuZgRF88rxThmvfL8PXduJEihRijUXbgQN4=;
        b=CsrEo/uJUfiY/yhKewL8SJyrD+mSyI9vQ5hR4ip+l8fH7imZ/n5u1l2mFgIgOJmIaT
         CLGzB1DFsfQ+LD0TWgG5KI9P+ixgpWiWaW8IldcliZ6LFPgAZayBd4QJpkewWd1XkU6B
         bCsrn+1AIUHxewPaSCiHqX+THm/66A3vjUQyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eSHBro6jkuZgRF88rxThmvfL8PXduJEihRijUXbgQN4=;
        b=Ak82VeaoKCmv+msqnZyWJqlCtmdb5o0UEJZ+K8Wc6izPdryhNHxmMCRAuZeIe9Ke0j
         MZJuoFE8DqZ7JSPDdTr+Guw9EYnOWSQcEvStaVFX0YvdkX8BUdch3ihKip5mBwwWdMYG
         Yh1zHqAYbdeDYm4XMrkXeu6bu7RCEyp/+/lMFrNgmJJTXvVjEIONOTSsN2msJaCRZ5XG
         S+0/CA0R7FZQSJav7e6sYjk+5D8M1y5A9pu1kpXVmTUA4rB8SU2El5k1mF0ZtNBRXF8j
         PRhEfqIDG8T3YFzTY2R0kSRdI7KM247RnZdML71VE3RCDdkUEOBxwN6jr/yaGQMLhQPa
         XIfg==
X-Gm-Message-State: AJcUuke3QGpDEJ8G8k7f6zZIA5R43j6w2RT0QFcPaJAVVjNgUABEG/ff
        AXsOwPKZpKDn9MioNtye1lHpIg==
X-Google-Smtp-Source: ALg8bN5Tu3CDY+htwXDCWVyW0b0gInxawViDsIS5SCsemKld1G35f3Y3cWCl0Wyrec0ZWCEf1dmfRA==
X-Received: by 2002:a1c:4108:: with SMTP id o8mr11573993wma.91.1547473555389;
        Mon, 14 Jan 2019 05:45:55 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id x10sm86766472wrn.29.2019.01.14.05.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 05:45:54 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] slimbus: core: match full device id
Date:   Mon, 14 Jan 2019 13:44:46 +0000
Message-Id: <20190114134449.15367-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
References: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match full slim device id instead of just product and manufacture code,
this will allow drivers to be much more specific to that device.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 55eda5863a6b..9e4f3b21ba8c 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -21,7 +21,9 @@ static const struct slim_device_id *slim_match(const struct slim_device_id *id,
 {
 	while (id->manf_id != 0 || id->prod_code != 0) {
 		if (id->manf_id == sbdev->e_addr.manf_id &&
-		    id->prod_code == sbdev->e_addr.prod_code)
+		    id->prod_code == sbdev->e_addr.prod_code &&
+		    id->dev_index == sbdev->e_addr.dev_index &&
+		    id->instance == sbdev->e_addr.instance)
 			return id;
 		id++;
 	}
-- 
2.20.1

