Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02352C6786F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8FE2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="IiC9Q7n2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8FE2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbeJ2L7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:59:10 -0400
Received: from nag.0l.de ([207.154.252.120]:44780 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729142AbeJ2L7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:59:09 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6glTwueM4PIsm5OYbYqQZmJn/3byjTc0jizbD4daxk=;
        b=IiC9Q7n2OqzAvd+X+s2dKyw3fgHuxguFflTMfPbl91Uey3ZxVs0RL2TeYdjhdzpPYErTGM
        NS+UZBqufu+m/sq4pgz0HIrW6p+XECI8aRITxHLO5+iwLK1dKRi0Qz3lki0Qcs4gGAXrwk
        MfNxRvHkbP886wHwKqbps8yp8NQMJuPwzjSRUAG3owW26/1++ehh1jI9iQDA4uCE7vRiKn
        2uttt7EE1QIzgOPJItVvELJStbVtuOCLAM1QoNvPD7eZphMjTNEJJy5uK7CGWjxYn55bC+
        FHgAfzsWsrpowtjc2lrH4ZhiTF9RZvoFg48pS/brGiWWzaUQmOv2Ab4loHyVSQ==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH v2 10/12] w1: use pointers instead of types to determine size of allocs
Date:   Mon, 29 Oct 2018 04:03:40 +0100
Message-Id: <8d0079ed2b260a00bcaa906729325a4e8de66486.1540782140.git.post@steffenvogel.de>
In-Reply-To: <cover.1540782140.git.post@steffenvogel.de>
References: <cover.1540782140.git.post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6glTwueM4PIsm5OYbYqQZmJn/3byjTc0jizbD4daxk=;
        b=FdvlrSGUi7dBcVh3SYwEojHNhNNx+UQmgHC+pfypbn2CDs89ogQdHokLJfgR2saecwaFRD
        kZYl3oNpEul5/CPA1x2b2pPT2r6paoCHUTyLJFktHNF670GF7b6hAtnARM/QQq88gk5/5l
        nXWDSbGQA1jzO+5b3C3E1Mz95i0wv4F51P8WLMhWd4BLqV8yjUuDgNAGqeaOxEQ/ukcapa
        Oi1jYbHPs0sxWPFfyZPqjmbAxwLR8Qi3Ex5/1tGFaY5rdRiOHstLmhLQAlkyQ8YY79UdlG
        WXfzj/sTUzvfgrvGPHzvejIl7bZolAGJ6u2cmj7FSZl40xYxF/q0sG/NRt43pQ==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540782276; a=rsa-sha256;
        cv=none;
        b=qrvUhhKZ0NISIWdQVbEDtzXBZhthg0aOuM+q7DQRIdETHtViFSyusnYL2bn1IYDrUtjBG/uHUfzBY+x2eJbJsThLjZIsMVhfCshzoJRC9iTtEkoCSKSnGwx++i7uLogZzQRq579BTCYrkPrVPCyg1/l4x6HVIYkevEyxzrYICSJ++dNT63Ig1pEroxGpj5QxAOlkLplN8VDJSbu+Do9CvZZxWJMPwyCrnw2Hf0Z9uhxWbQI3cyw401FSDNWybtIHHr4rK6k0BilLCGFtER5ModLUp/IxHHpzL3vnPTWi9GCHwZDfdZve/kiqauUl3ipFuhV7frCSLr7ALv+xsiSsDw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get size of allocation based on pointer not type.

Signed-off-by: Steffen Vogel <post@steffenvogel.de>
---
 drivers/w1/w1.c     | 2 +-
 drivers/w1/w1_int.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 4cbe1849fbfc..87094d99ccbe 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -756,7 +756,7 @@ int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
 	int err;
 	struct w1_netlink_msg msg;
 
-	sl = kzalloc(sizeof(struct w1_slave), GFP_KERNEL);
+	sl = kzalloc(sizeof(*sl), GFP_KERNEL);
 	if (!sl)
 		return -ENOMEM;
 
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index a5230c0d49e3..2bf7631ac24f 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -31,7 +31,7 @@ static struct w1_master *w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
 	/*
 	 * We are in process context(kernel thread), so can sleep.
 	 */
-	dev = kzalloc(sizeof(struct w1_master) +
+	dev = kzalloc(sizeof(*dev) +
 		sizeof(struct w1_bus_master), GFP_KERNEL);
 	if (!dev)
 		return NULL;
-- 
2.11.0

