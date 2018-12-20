Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45C7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02B5217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2nqPNuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbeLTRPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:15:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51890 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbeLTRPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:15:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so2844802wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YcSHRPw6/i76//xIDu+ZpB9k2P1PR6fI6Y23gHAzgP4=;
        b=M2nqPNuIeVPqIo2M5j2SsZJmDMt0cC/u4C1NfcRmPtaJac1LrEOV2vGqmhbwBq6X+S
         Q719vCIxgtWE02T9kqvoMjI7F5BOW1Y+cOH1EWVpF/AahaiobXX7PJTNuyAEjEhMUiMp
         EePYm4bEgOILVH2l/ZlugQcOE3jGhGv6u012aTRNKhu4K5nY2cDyxjYdLjFY9Pop26nW
         l2yluCyeonFaB+uT4rG55AFAuVYocG3wMQT5lwfr/kXCk3i4faxS5N9v3YbGrGp5wl9D
         9/uM7lvDuo7MM/YVRPgIG2dR2qPu98uk6hKQ60AngzdHzJ4rbHTa2oxfps3585Mm7IxH
         ea5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YcSHRPw6/i76//xIDu+ZpB9k2P1PR6fI6Y23gHAzgP4=;
        b=PcJWYZYpYlbducwLeXjymMJHAr+nxdTPFBWVhhTnuOKoFeToVO2oGK4/cuU+7tIX6F
         w8m0b4kOzRCbIyhql0y0vMipqp9gJSSvzkt1dvs0KYkH3TTS0LATAy6DfcWl8EdxqXA2
         zxzso1yeXel0yNQJOT+QIOvq4W4688wsGj+2XqYD1q8DEE+iqVwDKk80HCObN2J/YvZT
         27ksyENnzZQCPw39ainBE8b+H0SqEM72RVOaI+BxDGaQuNnhqKWGffWPaFRDb+vBsLOG
         tqnWTZxHrWLCx6+GHRTBeocZhYa3MtiH7F2qHcnOSR/0MU0qhVdu1IoKLiXBOiJ10FIp
         NcPQ==
X-Gm-Message-State: AA+aEWZ0gA3UQSltVlprUnykMmIn0IyD9juHHWv9JtTh9xfWTA6cVVzm
        7pexkug+33JWjyAZfPbhunw=
X-Google-Smtp-Source: AFSGD/WvjfA8zhzHuZmVUd8o+0Sd3C0Lm/jp/tBemm+ioxFq3LsN5jkhkho9X9HMzka55y+tZn0tgg==
X-Received: by 2002:a1c:934e:: with SMTP id v75mr12409913wmd.126.1545326101691;
        Thu, 20 Dec 2018 09:15:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 126sm6532751wmd.1.2018.12.20.09.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 09:15:01 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: fsl-dpaa2: fix SPDX identifiers in header files
Date:   Thu, 20 Dec 2018 18:14:50 +0100
Message-Id: <20181220171450.11616-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct comment style for SPDX identifiers in header files.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h | 2 +-
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h     | 2 +-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
index da744f2b0ee6..14b974defa3a 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2014-2016 Freescale Semiconductor Inc.
  * Copyright 2017-2018 NXP
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
index db43fa3782b8..25635259ce44 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2014-2016 Freescale Semiconductor Inc.
  * Copyright 2017-2018 NXP
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index 069c99bfba74..c48783680a05 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * DPAA2 Ethernet Switch declarations
  *
-- 
2.20.1

