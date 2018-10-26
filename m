Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDAEECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE172084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="H9BTetLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE172084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeJ0HJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:09:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34543 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbeJ0HJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:09:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id w19-v6so2584403eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJIDvZWQFuIBCXaIKbeoEcOs8MmNJNtvZlWs+1E5HfA=;
        b=H9BTetLft9V5V4ESyzKfGllytJ4z+khljpXpqr3kljXNQIDh3L6oiVRRmMXhe3h9In
         pefPH0hptoN7o1h8QWVPPcZcUOXRajMsSk5x2Kh4vPrG+LSjp9na/Ol4OlarqrT4fKRn
         OC+qHtaNanbRfIS7Sbsk59sT2s4FZ3/DLo67k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJIDvZWQFuIBCXaIKbeoEcOs8MmNJNtvZlWs+1E5HfA=;
        b=eYzPoxQ9FU1dDlbt4rT44E4+iiAwN0cxh+1EbtW9Po1RdRtUmE1WKMq2OzyJT3Sjvv
         yCZNquBKPgw0WApt2JXSZaNHMS6v8n6UdaGjb4BDNX/bjG7MFwhLs5h5bVhW/z62Pijj
         FB6016yDSScojNwhrHo3W8B140SGt2ADwp1PMlkgjohLLTO884r+iB2zQRFk7bT6fl0f
         xdRWXNKocjZXIcpMovmYQ3aQ6dwEeSkr3G8zhjCf3bv+oBdwrA2aFg8IU2pYdAXMirgi
         kPywL5fHwo+kkl4bdcsfvN/GHuNY2jgrkbR9k2VjqAbm7C9uGsFAWEvJt94/X1xcx0YW
         UPjA==
X-Gm-Message-State: AGRZ1gLiWDme4ivNjI7YgMoINP6wWezLLikdTXKg2lc8SmMpPnpWHfyS
        nJuVdd77PjL2GX93/5N8K77eBA==
X-Google-Smtp-Source: AJdET5dTfKTcrNnoqLrO9ZB3zSo9ipB/ad0ncZf4WtmC/RMPf8raH6Wm2W4HXQPnj1losgD4q65fgA==
X-Received: by 2002:a17:906:4c89:: with SMTP id q9-v6mr3594783eju.26.1540593062429;
        Fri, 26 Oct 2018 15:31:02 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id z7-v6sm2456843ejp.49.2018.10.26.15.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 15:31:01 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: hwmon: remove redundant cast
Date:   Sat, 27 Oct 2018 00:30:59 +0200
Message-Id: <20181026223059.17652-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct attribute::name which this local variable name is eventually
assigned to is "const char*", and so is the template parameter. We might
as well preserve the constness all the way through.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/hwmon/hwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 975c95169884..ea42c5ec40d9 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -267,7 +267,7 @@ static struct attribute *hwmon_genattr(struct device *dev,
 	struct device_attribute *dattr;
 	struct attribute *a;
 	umode_t mode;
-	char *name;
+	const char *name;
 	bool is_string = is_string_attr(type, attr);
 
 	/* The attribute is invisible if there is no template string */
@@ -289,7 +289,7 @@ static struct attribute *hwmon_genattr(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	if (type == hwmon_chip) {
-		name = (char *)template;
+		name = template;
 	} else {
 		scnprintf(hattr->name, sizeof(hattr->name), template,
 			  index + hwmon_attr_base(type));
-- 
2.19.1.6.gbde171bbf5

