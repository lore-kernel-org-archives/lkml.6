Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E001C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA077206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2bkaT4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA077206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeKUCQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:16:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42913 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeKUCQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:16:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so1171648pfr.9;
        Tue, 20 Nov 2018 07:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kDTNf0YfFqmPIA1/Izli7zQXedYowG6g+6+gdNz3G1k=;
        b=I2bkaT4pycDlR63CnTw+LcgtoihDjkoAbDAoIEayFGe0O54ZGs+Za/i1NnV9unl2qc
         n1qEyz6zKhzq85Kx91XmNi9VTOr2yZsC0wySIZUThUoN02M9yaikcbTO+cVSbb6+1R+Y
         5TIHspzc2e2ldo8K2MrjorO05wOeABzID0Jocr1z2/wO1R1jTVg0wGAjOQ87YAq0Fwpr
         Q/M0AEJKHFlYsd9Z1G0UvNAL/r/Ml93uGUU0prr5wJ3U/mgYLMHBuYAm9kFdiF9QTXuH
         BEMP6fTLkePkwiGkanb09ZAKZonqHx2RIgqAwDu16GwDHIM0BCSHIZmly010D6b6B+4/
         Amng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kDTNf0YfFqmPIA1/Izli7zQXedYowG6g+6+gdNz3G1k=;
        b=XurAnBecO81pRp/QnitU35N3H7eTDQrv3t3lqqDGVNoSAUFOAtxLX2++FYxd9fRCsf
         SruGJqy+GGNi7T/mK53x3AjZFLpPDhVblfZkmKzC/XcOwwJzDdmxPclb/GktQu5FWLFu
         S+A5Ts8PWvHvofTC9Pw/jPaqx+QJ1+ND6Zv1HW+f81FF4Nf5pVJ7pHQgpmlwFsFkJCQb
         feYdKNHtSsFRfI46XcI0M7JRMO56kQxUQGTKH29hKZ6QMO9103RQiLw+H09DFGov5VNT
         q8mGoLpapFA4Z32/jA0HF1INzEfXaxtBaySo6EPgIgmiL83iIbue7IYFjjCfrdGh6JXH
         dW/Q==
X-Gm-Message-State: AA+aEWZP5HXxOcMkTb5AY5OrUkeaOqHMUVILUxa4suFtb6AEqaeVQNcE
        VAO7LZQp/XEQlmHqyVHsy5I=
X-Google-Smtp-Source: AFSGD/W7l3HuINN23UnBtDu7PDb2C7ptl8Dd/7Zh2XOvfEMIMse2rxGjIsCy3MvP8CoC0t7j0k/uuQ==
X-Received: by 2002:a63:2141:: with SMTP id s1mr2390804pgm.148.1542728781340;
        Tue, 20 Nov 2018 07:46:21 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id h17-v6sm61988023pfj.125.2018.11.20.07.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 07:46:20 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     lorenzo.pieralisi@arm.com, daniel.lezcano@linaro.org,
        rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] cpuidle: big.LITTLE: add of_node_put()
Date:   Tue, 20 Nov 2018 10:46:17 -0500
Message-Id: <20181120154617.20903-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_node_put() is missing.So we call the of_node_put() to release
the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Changes in v2
-update changelog
-do that right after its last use 
 to also cover error handling.
---
 drivers/cpuidle/cpuidle-big_little.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index db2ede565f1a..650f063ef809 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -174,8 +174,12 @@ static int __init bl_idle_init(void)
 	/*
 	 * Initialize the driver just for a compliant set of machines
 	 */
-	if (!of_match_node(compatible_machine_match, root))
+	if (!of_match_node(compatible_machine_match, root)){
+		of_node_put(root);
 		return -ENODEV;
+	}
+
+	of_node_put(root);
 
 	if (!mcpm_is_available())
 		return -EUNATCH;
-- 
2.17.0

