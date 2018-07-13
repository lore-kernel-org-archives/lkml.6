Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384DAECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6A2208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="ayh6ECaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6A2208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbeGMJDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:03:02 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42013 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbeGMJDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:03:01 -0400
Received: by mail-pl0-f68.google.com with SMTP id f4-v6so7725640plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KN9SV33FLnLJMA92S3MlUtZGomr1Mwe/OGsIBK+qvvw=;
        b=ayh6ECaZD7T1Cs9NjZRarJSfbIqpJKx6fgbjSxVnnGqZar5tJVNTVhmyUlmjZgW1eo
         qF7NfExZHvzGvSTex782yYVRyeeJf6WCzxqSlJe8nJRreJsAecVPb4GvflyKYNtm22Ji
         N+OryVfVx6HwZ9ofQQ4aqnh0fqMgEDcDsO5q/fRF/Lt7nFUvYlsHd6bO1ssaJJwOJV1Z
         kV7za70n5Mg1h7S0yCnZWFDSD9yN/gyGwUQtJ4MhgETv1wD4Q2C3HAfe6woY7GX0RXQk
         GNLk62EhvYQIZJp7lV0eygRkX24DczSxd5pOxWwuU7UGOWoNylV0Ylnq92RF3qYJzH6M
         nUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KN9SV33FLnLJMA92S3MlUtZGomr1Mwe/OGsIBK+qvvw=;
        b=USYYK1hPOGNPdcI21jhL5UlH/uAvZoM5aCfCHOfnnyE7dzYnmM4oYqwuExGH5TfCSA
         rOpRSFqqQZ3PgRsQHQYY2cYovyVx5sXOBl6Cn5REkGSRBIJ8jZ3z1BBkKurhwluSm+Un
         GdbhNoi9B6JPS/6r+NlT16FlRNH5UTH6CUliVWikuEtKsPSRnqL7AgHI+AX58+ktEYQZ
         lcFdsnHRkUG37BrZ3qk9/mXrwiE8UEF/GYFug5/sSLjk22r0hPG0eNOLsMQKWRGonaWg
         /ncqjyKfAcGwzvdDlCxlA0bBYuFMjthsa3rjw3j4d9Ux3TCST/Ahl69b1nnqxcOoFuWK
         G7vg==
X-Gm-Message-State: AOUpUlHCI9YfbWauY1YKJwmzaWMve6wPH62cGCs/bdn1EYSUgKtN17Pi
        jBzhYGljNkd8qM3dP1xSEOeqOw==
X-Google-Smtp-Source: AAOMgpcJlWpdORsFYv25t/N9PVpWHskYJA1WeO98q/3PV3A2Vi6S/VtKIwka/ctfQe5PsNUeklk1wg==
X-Received: by 2002:a17:902:8207:: with SMTP id x7-v6mr5419201pln.57.1531471761147;
        Fri, 13 Jul 2018 01:49:21 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id d18-v6sm569357pgo.74.2018.07.13.01.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 01:49:19 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 03/10] lightnvm: pblk: enable line minor version detection
Date:   Fri, 13 Jul 2018 10:48:38 +0200
Message-Id: <20180713084845.19511-4-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
References: <20180713084845.19511-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When recovering a line, an extra check was added when debugging was
active, such that minor version where also checked. Unfortunately,
this used the ifdef NVM_DEBUG, which is not correct.

Instead use the proper DEBUG def, and now that it compiles, also fix
the variable.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Fixes: d0ab0b1ab991f ("lightnvm: pblk: check data lines version on recovery")
Reviewed-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-recovery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 3a5069183859..d83466b3821b 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -742,9 +742,10 @@ static int pblk_recov_check_line_version(struct pblk *pblk,
 		return 1;
 	}
 
-#ifdef NVM_DEBUG
+#ifdef CONFIG_NVM_PBLK_DEBUG
 	if (header->version_minor > EMETA_VERSION_MINOR)
-		pr_info("pblk: newer line minor version found: %d\n", line_v);
+		pr_info("pblk: newer line minor version found: %d\n",
+				header->version_minor);
 #endif
 
 	return 0;
-- 
2.11.0

