Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409F0ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D7920870
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9wL3Jau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D7920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbeJYWwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730432AbeJYWwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:17 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2773C2085B;
        Thu, 25 Oct 2018 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477160;
        bh=pZ0LopufCPj98I+pErMges8QBFY34MAjoIVHUQJw/kA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K9wL3JauaLQC3do4rNUnhd2JDd0ZYm+rZVcXLn5PKRvlhT6TIT+w+cM5M+rQYzR1/
         aGreJnqkRMYCR0VYvCeogHbwjUusNnmMmSX0HSYNZHo9LZFFoM4ppzw6R9IcKZUdSR
         gN9646Y4YHeIs7ZIM/+eclNP9gNAQTjtO3B8ZqOc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Felipe Balbi <balbi@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 15/98] usb: musb: Fix a few off-by-one lengths
Date:   Thu, 25 Oct 2018 10:17:30 -0400
Message-Id: <20181025141853.214051-15-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

[ Upstream commit e87c3f80ad0490d26ffe04754b7d094463b40f30 ]

!strncmp(buf, "force host", 9) is true if and only if buf starts with
"force hos". This was obviously not what was intended. The same error
exists for "force full-speed", "force high-speed" and "test
packet". Using strstarts avoids the error-prone hardcoding of the
prefix length.

For consistency, also change the other occurences of the !strncmp
idiom.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/musb_cppi41.c  |  4 ++--
 drivers/usb/musb/musb_debugfs.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index 2a535b70af21..3d69971156ea 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -629,9 +629,9 @@ static int cppi41_dma_controller_start(struct cppi41_dma_controller *controller)
 		ret = of_property_read_string_index(np, "dma-names", i, &str);
 		if (ret)
 			goto err;
-		if (!strncmp(str, "tx", 2))
+		if (strstarts(str, "tx"))
 			is_tx = 1;
-		else if (!strncmp(str, "rx", 2))
+		else if (strstarts(str, "rx"))
 			is_tx = 0;
 		else {
 			dev_err(dev, "Wrong dmatype %s\n", str);
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 4c216790e86b..05d1b203f0d0 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -194,30 +194,30 @@ static ssize_t musb_test_mode_write(struct file *file,
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
 
-	if (!strncmp(buf, "force host", 9))
+	if (strstarts(buf, "force host"))
 		test = MUSB_TEST_FORCE_HOST;
 
-	if (!strncmp(buf, "fifo access", 11))
+	if (strstarts(buf, "fifo access"))
 		test = MUSB_TEST_FIFO_ACCESS;
 
-	if (!strncmp(buf, "force full-speed", 15))
+	if (strstarts(buf, "force full-speed"))
 		test = MUSB_TEST_FORCE_FS;
 
-	if (!strncmp(buf, "force high-speed", 15))
+	if (strstarts(buf, "force high-speed"))
 		test = MUSB_TEST_FORCE_HS;
 
-	if (!strncmp(buf, "test packet", 10)) {
+	if (strstarts(buf, "test packet")) {
 		test = MUSB_TEST_PACKET;
 		musb_load_testpacket(musb);
 	}
 
-	if (!strncmp(buf, "test K", 6))
+	if (strstarts(buf, "test K"))
 		test = MUSB_TEST_K;
 
-	if (!strncmp(buf, "test J", 6))
+	if (strstarts(buf, "test J"))
 		test = MUSB_TEST_J;
 
-	if (!strncmp(buf, "test SE0 NAK", 12))
+	if (strstarts(buf, "test SE0 NAK"))
 		test = MUSB_TEST_SE0_NAK;
 
 	musb_writeb(musb->mregs, MUSB_TESTMODE, test);
-- 
2.17.1

