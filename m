Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEEEC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3BC208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APOCU1Kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3BC208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754440AbeGIGMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:12:35 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35365 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeGIGMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:12:33 -0400
Received: by mail-pf0-f194.google.com with SMTP id q7-v6so11776884pff.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 23:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aiibfnC4GH9w1XX+kBgJ0nkh9FOCGL7MJ6CqvrBaz/k=;
        b=APOCU1KbxaIdjWVBGOycHinTYjSF1mdH5HXkH7u72yKY3pEM+d1+kbz/dCFe7XUdRq
         iY1z20m/IA+OWWCFS7r/LvR+SGCI1STquRbdpI1KTGq2RdLyOf9vKFUR/HEBy/rRj3dZ
         znwtwS45CB5VLu1i2rOzKpUon/FLOjf9OWP7AnnXEnvfDibVvgKKvoyG2LxfLClUs5QP
         kwhBmQpCZCH0qyMTm4/fvgtdmWZh7EUR1o58xOC92TYL2gQTIeqZdlsCEAzYkthHQSlh
         AX6RN6icwa8T7BvzO7MMvBN7ebyyvBUZOn71ZYxmcW5/6+pfJx1uiSfV8vnyIrD59vks
         QFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aiibfnC4GH9w1XX+kBgJ0nkh9FOCGL7MJ6CqvrBaz/k=;
        b=qgsN0M6MQuWFVRROqjP4j7uq/OPpWIcmTsY0fSGHFu6Yix3rpCpVcK2HTRoA6X+vjc
         0NmKFnXz0LsYoKf4mchYWZr2XVOKQfWvbopKB3jsM0Rax7gQUadi2kghcgsDkz1S6oMQ
         NO29FRjASuqN5L6YGPixUWV5AoRf+qcLSTuBDCAF/P6e+0u9CoeQOdYuXX1dUtNMCqbM
         by770VIw7ycwcX3hud9CkQejTWJOWZdy3PbF0z5JI2vQTXkR2o+xmmyZzyT9/cdyuLNV
         55XDDT/tlCKG0TahyKRo/8satuHEgI/3tiyeJrJe6/bqnyA9z+g4yF3OwyB5EMxYiFEk
         2O/A==
X-Gm-Message-State: APt69E3c1tu7dPSX1UOrCbbJN9dyJ616PDrVzK2GQcisS9PxBP6QJXAf
        nGmNkoKo7/uF8AKqr7IT9yA=
X-Google-Smtp-Source: AAOMgpeLcLU+ELuSqssLifGznzyPqgEDAfTjn4AiGlnvJpCLQwLCn20oo1oXfLQFBd9Aen64vw4Neg==
X-Received: by 2002:a63:1f20:: with SMTP id f32-v6mr17055064pgf.84.1531116753054;
        Sun, 08 Jul 2018 23:12:33 -0700 (PDT)
Received: from localhost.localdomain ([27.62.45.92])
        by smtp.gmail.com with ESMTPSA id m15-v6sm20292784pfj.171.2018.07.08.23.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Jul 2018 23:12:32 -0700 (PDT)
From:   Janani Sankara Babu <jananis37@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     keescook@chromium.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Janani Sankara Babu <jananis37@gmail.com>
Subject: [PATCH] Staging:fwserial Move LINUX_VENDOR_ID to firewire.h
Date:   Mon,  9 Jul 2018 11:52:30 -0400
Message-Id: <1531151550-4918-1-git-send-email-jananis37@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses the same unregistered vendor id that the
firewire core does (0xd00d1e). Hence it is exposed as a
define in firewire.h.

Signed-off-by:Janani Sankara Babu <jananis37@gmail.com>
---
 drivers/staging/fwserial/fwserial.c | 1 -
 include/linux/firewire.h            | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index e8bfe55..f2966f2 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -21,0 +21,0 @@

 #define be32_to_u64(hi, lo)  ((u64)be32_to_cpu(hi) << 32 | be32_to_cpu(lo))

-#define LINUX_VENDOR_ID   0xd00d1eU  /* same id used in card root directory   */
 #define FWSERIAL_VERSION  0x00e81cU  /* must be unique within LINUX_VENDOR_ID */

 /* configurable options */
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index aec8f30..62cdff1 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -66,2 +66,2 @@
 #define CSR_MODEL		0x17
 #define CSR_DIRECTORY_ID	0x20

+#define LINUX_VENDOR_ID   0xd00d1eU  /* same id used in card root directory   */
+
 struct fw_csr_iterator {
 	const u32 *p;
 	const u32 *end;
--
1.9.1
