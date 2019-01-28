Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02485C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0672082C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="MZTxwm8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390646AbfA1QjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:39:03 -0500
Received: from mout02.posteo.de ([185.67.36.66]:44741 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731715AbfA1QjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:39:01 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 0FCF72400E6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 17:39:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548693540; bh=iyeTN5mKCT3iqw+oUHvuS1uw+yMQPaK5HUCUnjeTz5g=;
        h=From:To:Cc:Subject:Date:From;
        b=MZTxwm8C+ujV8b6jg0AuHVJaLiE0fn1btvtUmO4YQrPPPfqbiXxLYLmCGvfSpYNlV
         +MN0revK/5NDAtib+bKv9gy85PViQJX/tOcGhaHAx0fkbNQusVAJookgkovwtTGhpo
         oWB8X37JF7ThhFXLqWs7cWpDppHPr0Vve2cg9YCSCmcUEyEMsqn1gVMJ4/O6PDI4fd
         KbHA7P0YO/rCiqTf9PE4LeRKdIrJNkxs3SRq9UVduas1P1S1pT92ngyKOHcJZjXZTx
         lvvmHj4oVlD/JpfjfxYSkBZOTfXkLXThhLb6U3gQNjptGUPBVat+IoQYMsA4Ox8Mp0
         ZYkO5y9IBsEJw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43pFh30HMhz9rxV;
        Mon, 28 Jan 2019 17:38:58 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-kernel@vger.kernel.org,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH] tty: increase the default flip buffer limit to 2*640K
Date:   Mon, 28 Jan 2019 17:38:43 +0100
Message-Id: <20190128163843.688-1-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

The default value for this was 64K. We increase this by a factor of
10 to 640K to prevent data loss when using fast serial interfaces.

Since this value is only a maximum limit for allocation and isn't used
by default, this change has minimal effect on systems with slow interfaces.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

Is there any reason for this _limit_ to be as small as 64K?

thanks,

                          martin



 drivers/tty/tty_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 77070c2d1240..ec145a59f199 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -26,7 +26,7 @@
  * Byte threshold to limit memory consumption for flip buffers.
  * The actual memory limit is > 2x this amount.
  */
-#define TTYB_DEFAULT_MEM_LIMIT	65536
+#define TTYB_DEFAULT_MEM_LIMIT	(640 * 1024UL)
 
 /*
  * We default to dicing tty buffer allocations to this many characters
-- 
2.20.1

