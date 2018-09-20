Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201D4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBF92146E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q3d4jR9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBF92146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbeITGr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:47:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33883 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeITGr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:47:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so3522820pfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4gENh/nkq+ueFJoDK0c//PUWWGpu695MthiwUIVw76Y=;
        b=Q3d4jR9+e+pVKVuaj23vfbqsNT+6kLIzhjeapgPaIQbNAh30Ukjmx5XUgDDV6TWik2
         3hHXTXWagfMDM8hmgL1OaKdKd4IvuMINC9JHCG5R/UB41rt1NBKdk9Skb+0No1PoqTr8
         xflkIxrq1E/rKaGTUC66zu6DP+nEKyy8wK2No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4gENh/nkq+ueFJoDK0c//PUWWGpu695MthiwUIVw76Y=;
        b=CB53Tc1VcgHbxWfzZ8wMD7oR7T4m9Ths7bXBPfxi7T5lXRsjPcRDBoNS72IhnYrOtd
         9FrBs1kv68NkQNoecTnjssIcsEDaPBThnK7GjJoBtENdjoH+9ITjuZkNas6EphmcHRl+
         DxgDwB2NX+NEFDBrSxQBU6detV3H7KorI6I6x9HUdugnVjt5lOiCK5ADSJSueLNNYm+b
         JNpiNZ+jiJFRG+iSZktglDrOgZjwYi6GTlVWIBhVjxUyDuj1X56aEPc5qGGvYk97Ueiq
         FSmANY8T1Oq+jVqrc+aC7BR/OUcbjOnrxc+MzHag8fop5pu5QFNDQN9l6kuOChEftSSN
         yR9Q==
X-Gm-Message-State: APzg51CKNqwsG9rrJqOF8X6wbhpetkkdHjxicTUNe8cAEHI8du7Bfo2x
        ey2MUhFPe2xTrVSvjtT2pHEaSg==
X-Google-Smtp-Source: ANB0VdaxKVRIwA7eFbdtjYRpdF4mWK+dHN3SplJBTGWNRjlsAY/+NIp1ouGB/yBipzl9ZizEZChBOA==
X-Received: by 2002:a63:1b07:: with SMTP id b7-v6mr34693465pgb.444.1537405642383;
        Wed, 19 Sep 2018 18:07:22 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d132-v6sm33454688pgc.93.2018.09.19.18.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 18:07:21 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH] firmware: Always initialize the fw_priv list object
Date:   Wed, 19 Sep 2018 18:09:38 -0700
Message-Id: <20180920010938.10315-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When freeing the fw_priv the item is taken off the list. This causes an
oops in the FW_OPT_NOCACHE case as the list object is not initialized.

Make sure to initialize the list object regardless of this flag.

Fixes: 422b3db2a503 ("firmware: Fix security issue with request_firmware_into_buf()")
Cc: stable@vger.kernel.org
Cc: Rishabh Bhatnagar <rishabhb@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/base/firmware_loader/main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index b3c0498ee433..8e9213b36e31 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -226,8 +226,11 @@ static int alloc_lookup_fw_priv(const char *fw_name,
 	}
 
 	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size);
-	if (tmp && !(opt_flags & FW_OPT_NOCACHE))
-		list_add(&tmp->list, &fwc->head);
+	if (tmp) {
+		INIT_LIST_HEAD(&tmp->list);
+		if (!(opt_flags & FW_OPT_NOCACHE))
+			list_add(&tmp->list, &fwc->head);
+	}
 	spin_unlock(&fwc->lock);
 
 	*fw_priv = tmp;
-- 
2.18.0

