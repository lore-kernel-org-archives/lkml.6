Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554CCECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E92D21534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXJTDcN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E92D21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388694AbeIUBDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36591 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388617AbeIUBD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so4830433pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=se2ngb5czU9sEE2MR3i6PgGpYjHvr4Xt9ePRt1rOif0=;
        b=NXJTDcN5ebVyQlFFv5G0Tf9cVLs4SmPg84ZTxuck0EW4c5RUEdZXPw9C5SNTJcquK9
         4KuN3wE984ejX5g2b/fkRVejX82GSdlLiu7zubCwyH4sOceixPCYQaIPe4ipBXhJnf5b
         DMldrEu6UGBnu/IGdnI4UkRWmqVVYdaLY8YNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=se2ngb5czU9sEE2MR3i6PgGpYjHvr4Xt9ePRt1rOif0=;
        b=Zo0/glb0zAabEHDAeaH/kQCKTbfRiqWcZqnYGM5fpo5JFLG5pj98EtJUDG8pqSiFZw
         JJVvWoqLCCMU32NFPUO69nFSqd+faFYVVLPt+1AXN+RnLu1o271eVgobhtZ7UMU/VCeO
         RoUufUR7GTcFw989eH9ZUJEImj7YoS5JXkevwRBIiFHCJwFgDY2aWs0Ii1tCqEKJln9x
         KDBpAWaUFygQgGoe3GJCJw+XEFCTZyTAsvXkLLSTR+N72mqO/aHFlcRyp2R4ywA+ajz1
         ++iEb/Byf6CcNoh4h+YoIxrflYYGciuGlz0z4MU/thhmiW+A8sliJLCVF2HXjoZZ/4Rv
         c73Q==
X-Gm-Message-State: APzg51ALc/QPbWE0GDuspxZv1Jj5s8A1UL00xxk8drRJumtoEEohGGyp
        t8/vVxyfX7VbKT23FamGVK/szw==
X-Google-Smtp-Source: ANB0VdYbDi6cB2DM6vlGAcJ3m+6VPUAo8192Bil7bALyc91G2PVO7GTBUYKJyNAOktZLPltKogWj/Q==
X-Received: by 2002:a63:df04:: with SMTP id u4-v6mr39015149pgg.434.1537471110752;
        Thu, 20 Sep 2018 12:18:30 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:29 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 06/44] coresight: Add helper to check if the endpoint is input
Date:   Thu, 20 Sep 2018 13:17:41 -0600
Message-Id: <1537471099-19781-7-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Add a helper to check if the given endpoint is input.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 2ecdd1432b5c..44903d35009f 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -45,6 +45,11 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
 			       endpoint, of_dev_node_match);
 }
 
+static inline bool of_coresight_ep_is_input(struct device_node *ep)
+{
+	return of_property_read_bool(ep, "slave-mode");
+}
+
 static void of_coresight_get_ports(const struct device_node *node,
 				   int *nr_inport, int *nr_outport)
 {
@@ -56,7 +61,7 @@ static void of_coresight_get_ports(const struct device_node *node,
 		if (!ep)
 			break;
 
-		if (of_property_read_bool(ep, "slave-mode"))
+		if (of_coresight_ep_is_input(ep))
 			in++;
 		else
 			out++;
@@ -213,7 +218,7 @@ of_get_coresight_platform_data(struct device *dev,
 		 * No need to deal with input ports, as processing the
 		 * output ports connected to them will process the details.
 		 */
-		if (of_find_property(ep, "slave-mode", NULL))
+		if (of_coresight_ep_is_input(ep))
 			continue;
 
 		ret = of_coresight_parse_endpoint(dev, ep, pdata, i);
-- 
2.7.4

