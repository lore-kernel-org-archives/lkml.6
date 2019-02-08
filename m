Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A566C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0ACB217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H58r5Ove"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfBHPmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:42:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50727 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfBHPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:42:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id z5so3888211wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 07:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/BsdiLgEQYED0q/Vc9+obN0erQdEH4dBLTgeo1fZTiQ=;
        b=H58r5OveFpNzVjc20ohoDib/Yy5P9Dn5q2HwJjY/qRcpT+gmG6RNQpwPjru2E2g2Mm
         rGSwq46ieI6xHT55p2sQmRvWbGRoBSUQwptZSEF6Dl49uhTcwPjS27AvS7HZGjt/sRN+
         yR59OVDzYjk3WiVMeKlwuRQ24s+pXIn6fMI8d3AiriYrXHu0zDlsDN3g6xv9wX0jfIcp
         UdcOpAGl22nasZebCzCABPBokGMabh/XQJRkXtIQF/1gwrGMupW3i8e2tLHGc6ghqCBW
         BptFFf03jggdghb/hKPvQPt7/pt370++zoZXV1QfdQIkbi8gJ/QwEezt5epjigbnS4K6
         ISkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/BsdiLgEQYED0q/Vc9+obN0erQdEH4dBLTgeo1fZTiQ=;
        b=SaLHZCI3zsC9S3QXgC+2sbk4xtpCnNKNcHirJpJpiFcys1/nep757ug8igmKlDwHOn
         khTSmFf3N2mFWWlRvZ//S9lzdISiQ8Oi9B2Jj2tcHXwMhV0rPoqaZSLiTVfJtSn3JXKk
         yXPLGxtg5+Gk94VLuadL5ZlejZbLea3OuIXbxQT3EXo1hey6rl/dOzKl7WRG2kR9+Vbe
         cGtlHaGTGBsDaJac/4E00x4siSqq2X1x6Eny5Gmig7EZ+Zityg3XM2q1wPW/s1WZq0Da
         0egSlQdSPDIn2xQrIUHUDs6PCddrk27eQL+xypA9YCjL/fGaDexeK1IFhrm9EPSUQA/V
         vcew==
X-Gm-Message-State: AHQUAub8Gqeo7SrmvbKX5AkBx1F6jovtPc2FHjhGvpFaxnoadVgRVFpl
        wtcz/JurAFDw66vGaMvqlMSLVZ2SvHUkDA==
X-Google-Smtp-Source: AHgI3IZOo5e1Yj8Qbkp2SbvMDcpvN+Sc4xiDUAPe/kr14/qwI/FK3UfmaLBRVbEpIIZ6j+Uq26IGNw==
X-Received: by 2002:a05:600c:211a:: with SMTP id u26mr7702668wml.142.1549640568210;
        Fri, 08 Feb 2019 07:42:48 -0800 (PST)
Received: from localhost.localdomain (static-qvn-qvu-167076.business.bouyguestelecom.com. [89.81.167.76])
        by smtp.gmail.com with ESMTPSA id g10sm4291016wrq.81.2019.02.08.07.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Feb 2019 07:42:47 -0800 (PST)
From:   Jerome Forissier <jerome.forissier@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH] tee: optee: update optee_msg.h and optee_smc.h to dual license
Date:   Fri,  8 Feb 2019 16:42:06 +0100
Message-Id: <1549640526-10935-1-git-send-email-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The files optee_msg.h and optee_smc.h (under drivers/tee/optee) contain
information originating from the OP-TEE OS project [1] [2], where the
licensing terms are BSD 2-Clause. Therefore, apply a dual license to
those files.

[1] https://github.com/OP-TEE/optee_os/blob/master/core/include/optee_msg.h
[2] https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/include/sm/optee_smc.h

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/tee/optee/optee_msg.h | 26 ++------------------------
 drivers/tee/optee/optee_smc.h | 26 ++------------------------
 2 files changed, 4 insertions(+), 48 deletions(-)

diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
index 3050490..795bc19 100644
--- a/drivers/tee/optee/optee_msg.h
+++ b/drivers/tee/optee/optee_msg.h
@@ -1,28 +1,6 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
 /*
- * Copyright (c) 2015-2016, Linaro Limited
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *
- * 1. Redistributions of source code must retain the above copyright notice,
- * this list of conditions and the following disclaimer.
- *
- * 2. Redistributions in binary form must reproduce the above copyright notice,
- * this list of conditions and the following disclaimer in the documentation
- * and/or other materials provided with the distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2015-2019, Linaro Limited
  */
 #ifndef _OPTEE_MSG_H
 #define _OPTEE_MSG_H
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index bbf0cf0..c72122d 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -1,28 +1,6 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
 /*
- * Copyright (c) 2015-2016, Linaro Limited
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *
- * 1. Redistributions of source code must retain the above copyright notice,
- * this list of conditions and the following disclaimer.
- *
- * 2. Redistributions in binary form must reproduce the above copyright notice,
- * this list of conditions and the following disclaimer in the documentation
- * and/or other materials provided with the distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2015-2019, Linaro Limited
  */
 #ifndef OPTEE_SMC_H
 #define OPTEE_SMC_H
-- 
2.7.4

