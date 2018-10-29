Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0201C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F8F2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="emyJd7L7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F8F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbeJ2LvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:51:20 -0400
Received: from nag.0l.de ([207.154.252.120]:44354 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbeJ2LvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:51:20 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DpD/g3UI5Kv9UbOcVc0flth3o3CshcDIfNsb23byK7Q=;
        b=emyJd7L7Hs3GXU4RaESskw+HTduwUiLbVuR014/kDy7b0iYbaqzqdVn7ecdBvPY1EZruTM
        4MyhEApXdRdYw2HlZUXNMJWlWVA7vtmMInU8yD9qyQWCj7tXZE2BxEO1B5Yty4prTcpz+L
        WH6ewhh/qFD/vjCnaeFAKtnY1fvMuYZdb3OnKsST4K32OPmNF7PJ/R0Vt96W+eDQvgl2Qr
        nlJd6lJwHm8ptBLVZ3fIcyW+KsrSova0oiiG+DOwyyDMa5Aph1Y7cNmNyF+bCzrpOBbHrE
        c/ZMeJe8t1wfC1W6MK62CDXXPbWm5OKfBdgYWOcyeOZZecVb9PnxyasxHro5aQ==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH v2 06/12] w1: do not log errors about failed memory allocations
Date:   Mon, 29 Oct 2018 04:03:36 +0100
Message-Id: <5e95d5b8e6b65f4e865be1d1300ea07d5e96103c.1540782140.git.post@steffenvogel.de>
In-Reply-To: <cover.1540782140.git.post@steffenvogel.de>
References: <cover.1540782140.git.post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DpD/g3UI5Kv9UbOcVc0flth3o3CshcDIfNsb23byK7Q=;
        b=d6Yfj0FYjcxrZu+ttF2vwuCYQBj3FZw0wVZ9UDCqeZlnYBoT0KNWeZlWk09sSKPosiN7/B
        yLZE/gSGKnYxWG5qTy3pYS2j4vTO2nF+43o5VSiQdvsP0o8KFbOwzrvpEsQmKN06hPlShb
        NUXRLpmmIgTAx9oRWKoEEA6joaxFc/tC1yPGkvpPRVgDedvUiUihkyVB+9RvDg7vy6RcXu
        A3pA2//wEXWU0j1wRGYcNkgnJDuM6XWfUAFzB0RbFEOadkVIz9LNbDL5xjoBSCv18huPU+
        cZj4JZKlVU4879D9WXskftU8vhqEvRYwpgB6obayw6PqGmQJ0SH3TgaMWPXwxQ==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540782275; a=rsa-sha256;
        cv=none;
        b=OfAnD7Q0jAPWwgDNovKqWBMKT27Zjt4w7cWZyuYLEArQAIUmCPMOyj+/kTlbGVy4hJ2mMrutIRL0K6n8nA1PmpWZ83AgoSNbCvP73LiaQuPDv24K9AROa4i3MI3XQM9KLtpzJJKyN0C0PTducqNe6BnkK4kARbDhxiCVjJp/Qw9boJz4AyFBuxisJEnlJYI1P9y8f2mQQSe2oEZjhv8Dt85WyI64CzN5sSEWQ6py/q8vzwJMHGgyAgz94V23Qe8Ce449Ha2Kdx0vItgkNEN4EcwD2NjwpTbbglHCTC7bQlMD8nld7qvMgjuk0L6U1ZaV+hZ67QklAIJRaHpjldDniA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a warning raised by the checkpatch tool.

Signed-off-by: Steffen Vogel <post@steffenvogel.de>
---
 drivers/w1/w1.c     | 7 +------
 drivers/w1/w1_int.c | 6 +-----
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index a8ead2350521..cbfc3f7012de 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -757,13 +757,8 @@ int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
 	struct w1_netlink_msg msg;
 
 	sl = kzalloc(sizeof(struct w1_slave), GFP_KERNEL);
-	if (!sl) {
-		dev_err(&dev->dev,
-			 "%s: failed to allocate new slave device.\n",
-			 __func__);
+	if (!sl)
 		return -ENOMEM;
-	}
-
 
 	sl->owner = THIS_MODULE;
 	sl->master = dev;
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index efe03b9e23f5..a6c011e57c90 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -33,12 +33,8 @@ static struct w1_master *w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
 	 */
 	dev = kzalloc(sizeof(struct w1_master) +
 		sizeof(struct w1_bus_master), GFP_KERNEL);
-	if (!dev) {
-		pr_err("Failed to allocate %zd bytes for new w1 device.\n",
-			sizeof(struct w1_master));
+	if (!dev)
 		return NULL;
-	}
-
 
 	dev->bus_master = (struct w1_bus_master *)(dev + 1);
 
-- 
2.11.0

