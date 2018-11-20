Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40275C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D9C20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdWpPtjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D9C20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbeKTX3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:29:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42980 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729135AbeKTX3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:29:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so871970pga.9;
        Tue, 20 Nov 2018 05:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GcRCnaIVg7iubppgtRBY4JCdVqjTZM56c9fJrbK1/do=;
        b=BdWpPtjDpLdNck2TfS3K47z/uC9QbltjPZX+dfMZ2rSQSnBGjX+HAt8FkM8DoWzGQI
         Vv6NpFJdgk9UQ4TQ7r3l66blPH4rgxcaZfxY8jBB9vsmr534/MoZ9uI+PbL0fOn9UUrJ
         LVMjCVZy4oRwyVwVhIaO5K9awRobuVRsPrGiZfFWdwoE7iuZAT057LY6xrUwNPKW4uh6
         MFTLJHZOgFiz1OJVNuq2kpDldUkgWi+CgzGAqOWR5rtLh3PsduDIrqANMLMb+TsUjk4h
         mLokOpVpIvaxdAk2U0oZfNMa7LgB1pwLHd8ltJuChyW1NJ1pbE2qbIlWMz3q03r7BWWw
         6NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GcRCnaIVg7iubppgtRBY4JCdVqjTZM56c9fJrbK1/do=;
        b=b4Gz2gQ1srH0AaL8UGYOyUcyjWMXtRAaaoNK24hgM5Bc3yfBiR9h+v10L3slnLcHIJ
         MY1YCZG2shxhNyWhhf6XfafZ5XooOyoAiGwqPVZ1W7opaj407kRwuRrgXBnr2ojpbCXH
         N3/NsKMX6AD3z/0PGm5+Cv7fDNHb1hNNV1N4F6UtFZiWw5CDAPEeHxDGpe8f1FHsuL9M
         IRkDZ1o5Ke/YAA18ehrr8oszoyOaA//cejNmgwuVIgULpdZP6zMR0Ac715cxqZKV6Ax0
         U/bnFPh44gCETSMKs9AWzilU4EiOp0q3ODhcPBWsQBRWvIJe+hdbIUWGV8cq2q2ig+xG
         xB7w==
X-Gm-Message-State: AA+aEWYwxvNb8AWr5DUUceRBoGjrgW659n6COMLkYGDm8NlsSIFk4MGO
        z+D/TlNJb/TAhAV+H4MwpFQ=
X-Google-Smtp-Source: AFSGD/Xbr5NTHi/3SHW+HT9CiPgkFiRmN4K1dsNBRp82laC3x1Kajgg8ipJ2YfFV8DUp+ymm1MrUzw==
X-Received: by 2002:a63:1204:: with SMTP id h4mr1805966pgl.51.1542718816413;
        Tue, 20 Nov 2018 05:00:16 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b202sm34199287pfb.88.2018.11.20.05.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 05:00:16 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        lorenzo.pieralisi@arm.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpuidle: big.LITTLE: add of_node_put()
Date:   Tue, 20 Nov 2018 08:00:12 -0500
Message-Id: <20181120130012.19471-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpuidle/cpuidle-big_little.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index db2ede565f1a..a3b8bc09bac8 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -174,8 +174,10 @@ static int __init bl_idle_init(void)
 	/*
 	 * Initialize the driver just for a compliant set of machines
 	 */
-	if (!of_match_node(compatible_machine_match, root))
-		return -ENODEV;
+	if (!of_match_node(compatible_machine_match, root)){
+		ret = -ENODEV;
+		goto out_release_node;
+	}
 
 	if (!mcpm_is_available())
 		return -EUNATCH;
@@ -222,6 +224,8 @@ static int __init bl_idle_init(void)
 	kfree(bl_idle_big_driver.cpumask);
 out_uninit_little:
 	kfree(bl_idle_little_driver.cpumask);
+out_release_node:
+	of_node_put(root);
 
 	return ret;
 }
-- 
2.17.0

