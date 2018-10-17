Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BACECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5824A21479
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVpKLd9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5824A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeJRDXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:23:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43945 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeJRDXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:23:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so30969121wrt.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jqjlq7mZDerPRopuOpz2ST/dUsC5C43Ae0k8tEaHxas=;
        b=WVpKLd9opJWWrBExvYR/Ah4pvuPR29lQ3A4oaXnUdHlGtAKS2qTWHy6O7MCIhvSU1z
         fLdbqYa+BTpJvI5qYHUAXFinmqoBNwz5jERurXWsyqIMbFQebLU7XRvVCwywksVU1N8U
         NTftiJf6utYTcHqE6I9ae8lrVGMwIoNT5NDBUk9XXkjGaEMzOmpo3RbeMYuQukVbCLsY
         NcbwWI3iRTqDSCqpqyey/4PT3Nm1HWlzMqP9XXNVZm0k3BNngQS/pTtyjm+Srcl9Ai85
         GbZRCsU0R1IaDTozkRBwksfBMpSNu6BjvdgG9k7xlErerAzgafu9LwVUGELesDHYE045
         JOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jqjlq7mZDerPRopuOpz2ST/dUsC5C43Ae0k8tEaHxas=;
        b=bbp7b9Ic+M6iWuClJshD9RTWOYstWYIQi4jq455YHhLs3aq3LkVyWMl9Utvo6+rk0Y
         Qmt9oBY0dqTYnr1sU9XeLtN+zJswTmI/WYxn/5GyFTdz0cOOpUCMIKIg4cuXbpslz6qG
         deCLy0rZtUeDSqFDxSDM9Svunz/tMpacct5/8ZfpsreUiE8CSHLZLu2pyazgoG61zYY3
         XvcH9AdnGPkDNZGeAAneOxkENyQrH74tPc09ATelLHgQRJEIrFnqWJHln0AcmwgT/40d
         lXcSVne6G4UiYmWXzcy/660knmNpNq4vz+Gv50JnqSpQxZdVM6uEekoUTljNMOVlVkgF
         EHew==
X-Gm-Message-State: ABuFfoimKGZp5x2HOW9S4wL/22lVOgkQIkMYcu5YoQryezFkO+YilAxP
        vw88kEpGfDQ7Jp5bI7OeFFQ=
X-Google-Smtp-Source: ACcGV612E9OUbPufP0Ft4lULmNOCb4sLe2L7KWXwfQVwTNdX0kwbYmVfmMyaUuhOQvlTQZxzWHc9rQ==
X-Received: by 2002:a5d:620b:: with SMTP id y11-v6mr24939393wru.105.1539804364985;
        Wed, 17 Oct 2018 12:26:04 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id t66-v6sm1678872wmt.5.2018.10.17.12.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 12:26:04 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id A140111439C3; Wed, 17 Oct 2018 21:26:02 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Add missing include <asm/stacktrace.h>
Date:   Wed, 17 Oct 2018 21:25:58 +0200
Message-Id: <20181017192558.8039-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 88b0fe175735 ("powerpc: Add show_user_instructions()") the
function show_user_instructions was added.

This commit adds an include of header file <asm/stacktrace.h> to provide
the missing function prototype. Silence the following gcc warning
(treated as error with W=1):

  arch/powerpc/kernel/process.c:1302:6: error: no previous prototype for ‘show_user_instructions’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index bb6ac471a784..1c64491e9702 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -65,6 +65,7 @@
 #include <asm/livepatch.h>
 #include <asm/cpu_has_feature.h>
 #include <asm/asm-prototypes.h>
+#include <asm/stacktrace.h>
 
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
-- 
2.11.0

