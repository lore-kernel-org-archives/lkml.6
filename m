Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E8DC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C17A20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNBT+0mS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C17A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbeKIIXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:23:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728228AbeKIHcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:04 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 590102086C;
        Thu,  8 Nov 2018 21:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714077;
        bh=ngtSPVv4wihM632/oiCRNAl3GTIjBcH0y6rYTRW1oh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HNBT+0mSrr1I1ocheDop77hkwEp5rKAgYiVyXqNnuaMBUdWVPoZKJD1eFoi13we5c
         VObOdIANrrLU27k0xtwA/DQOmhgqKOzy2Ww3afCB2RddT7cH6AfaPDPFZd3bUy6wNY
         Y7LbSZ0o5WK0n4SvWZZhKpMu2lbLrYbAPfRgOCQM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Felipe Balbi <balbi@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 045/144] usb: musb: Fix a few off-by-one lengths
Date:   Thu,  8 Nov 2018 13:50:16 -0800
Message-Id: <20181108215058.118086395@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



