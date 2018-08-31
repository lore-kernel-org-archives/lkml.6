Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25BDC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A841205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKvzXTQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A841205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeIABBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:01:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34273 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeIABBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:01:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id j25-v6so4199095wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=60/OBHwJ0Jhy0mtbYMzYiVyHmch8QP1Vwd6y9Ee0VNU=;
        b=cKvzXTQefoDzyp7THWxaYvcMxDN+AOPUggGDqy0lqEAM/YoaH0rheUt5vzyebXnEct
         BMs4+GceVKVjK/QO60yQt2aDWcKs5PG8tTGNmO0HysL7gpPTb6Fr/PJR7qyVmY1Z3si8
         Nz9Na229P/uzgnhezmt2dsCkJCCqsArvYtl5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=60/OBHwJ0Jhy0mtbYMzYiVyHmch8QP1Vwd6y9Ee0VNU=;
        b=Qt9w3ACVTNtkBk+Bc5WKCXeiIkQiYbkvmHfVzvLBeBhUCb9M5v7uGwS+TAccg5cfPn
         7DO6r9e9PcbkUlM/mjxvU/jdN2T+EiIMtz9NOn9J5G5RBEeoaZeWDBBCJuELO8b8Fa+u
         cYn4qf/HV7sFREBbIzY09Je8EuOMUykkceLYzbTozoivflQkarOCDDasG92kWHopM24I
         nmLv7jH9Wm4NymqEPzyKPiun6GYF1ktzMRmaBEkAlu5U5fvlE8lHDUq2Lz48Sfi+HeRB
         A7MddwpIS5KI5qOZXy0EtinHxuvFl/bfQrYNHPdjwmgU6/igtqbwP6ALSVRITXHHlnnn
         Ra4g==
X-Gm-Message-State: APzg51Dcnfvzs0EJeeDA+2NsEiLNzw3IJOjcEcjMdBmOXCBK6OxzqVYw
        VC6/BdExEmduu3hjKHlA6sETmJlkLuM=
X-Google-Smtp-Source: ANB0VdaNyFdZW0UM9YzaFkjjdNKLuCwn8IBFdRFE+E/39Zn/RFWF71mbEve7rlgIBPnS55O8Z5zcUw==
X-Received: by 2002:a1c:ee15:: with SMTP id m21-v6mr1335367wmh.112.1535748754811;
        Fri, 31 Aug 2018 13:52:34 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u4-v6sm7659356wro.47.2018.08.31.13.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 13:52:33 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH 4/5] kdb: Improve handling of characters from different input sources
Date:   Fri, 31 Aug 2018 21:51:41 +0100
Message-Id: <20180831205142.23609-5-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831205142.23609-1-daniel.thompson@linaro.org>
References: <20180831205142.23609-1-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if an escape timer is interrupted by a character from a
different input source then the new character is discarded and the
function returns '\e' (which will be discarded by the level above).
It is hard to see why this would ever be the desired behaviour.
Fix this to return the new character rather then the '\e'.

This is a bigger refactor that might be expected because the new
character needs to go through escape sequence detection.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index f735d859f28b..8f2470016250 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -122,8 +122,8 @@ static int kdb_getchar(void)
 {
 #define ESCAPE_UDELAY 1000
 #define ESCAPE_DELAY (2*1000000/ESCAPE_UDELAY) /* 2 seconds worth of udelays */
-	char escape_data[5];	/* longest vt100 escape sequence is 4 bytes */
-	char *ped = escape_data;
+	char buf[4];	/* longest vt100 escape sequence is 4 bytes */
+	char *pbuf = buf;
 	int escape_delay = 0;
 	get_char_func *f, *f_escape = NULL;
 	int key;
@@ -145,27 +145,22 @@ static int kdb_getchar(void)
 			continue;
 		}
 
-		if (escape_delay == 0 && key == '\e') {
-			escape_delay = ESCAPE_DELAY;
-			ped = escape_data;
+		/* Reset state on first character from an input source */
+		if (f_escape != f) {
 			f_escape = f;
-		}
-		if (escape_delay) {
-			if (f_escape != f)
-				return '\e';
-
-			*ped++ = key;
-			key = kdb_read_handle_escape(escape_data,
-						     ped - escape_data);
-			if (key < 0)
-				return '\e';
-			if (key == 0)
-				continue;
+			pbuf = buf;
+			escape_delay = ESCAPE_DELAY;
 		}
 
-		break;	/* A key to process */
+		*pbuf++ = key;
+		key = kdb_read_handle_escape(buf, pbuf - buf);
+		if (key < 0) /* no escape sequence; return first character */
+			return buf[0];
+		if (key > 0)
+			return key;
 	}
-	return key;
+
+	unreachable();
 }
 
 /*
-- 
2.17.1

