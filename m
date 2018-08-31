Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875B5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34479205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0hdD9u6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34479205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeIABBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:01:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52700 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeIABBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:01:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id y139-v6so6299539wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HK5LT08ykmG5YwLnjISm/Y2crdQ/7wW+cXZ1BfyQFI8=;
        b=R0hdD9u6TBA26WHr0G785Fv+iiZjdlo4tQoCdlURoSmI8I5e5471pL1xQ4uATFT7SJ
         5MSUZgnlEmfDD8JaxBe81kzMO6iOYcQ2lxZ9Tw8Zezy02EbG7yEoIzRvNHyfdJwc6sfY
         73B8keRHLKkH4BSiCoIyvSyXImGjjjnfMXHnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HK5LT08ykmG5YwLnjISm/Y2crdQ/7wW+cXZ1BfyQFI8=;
        b=feRN2wkgrmRSzDw11Zi/VDbpzCiE9v9t0T7HJig9LH/daqf6eo2UsNP+nQEWT2akeU
         qynClNLC8ahNOuKU4/+s3dBlF4sA98C6ikFkrJLG6uSU9RIyCuSdyYJ7Dm6U5qrFMCDY
         49WpjDZR358p+Kzp13ui+CwahBCAdGFa7nafJh7OYXu3Jq2z5d1mXlb+Gj4xDzRPBWVi
         JDTE/z9hP31w133/CNDxlemXhZCjvnnLxEWNal+MDktg4Yeu6C2Rs79MI5mmP9P0BtxD
         S6gFETP8hFLCmrLY8gNTFS0rXf9tG7UHpIQAW23H965Wzll35zKE/HdsaXhk1zoND6mP
         SjjQ==
X-Gm-Message-State: APzg51CqcNR/9xtSAuLZ8yCa46WGKGFB2pWkSQ2YyOJ1owXH2x7uO3Z6
        4trdozDFzCyCmHSzzs5WAI7Abg==
X-Google-Smtp-Source: ANB0VdYoDCiDiofGxGikt2RZNgRDt3yxTWAlFjQjqwBKyMgvT5n0EusWgFqJole97bMaRUzoe5mw+g==
X-Received: by 2002:a1c:f001:: with SMTP id a1-v6mr6040620wmb.160.1535748751991;
        Fri, 31 Aug 2018 13:52:31 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u4-v6sm7659356wro.47.2018.08.31.13.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 13:52:31 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH 2/5] kdb: Simplify code to fetch characters from console
Date:   Fri, 31 Aug 2018 21:51:39 +0100
Message-Id: <20180831205142.23609-3-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831205142.23609-1-daniel.thompson@linaro.org>
References: <20180831205142.23609-1-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kdb_read_get_key() contains complex control flow that, on
close inspection, turns out to be unnecessary. In particular:

1. It is impossible to enter the branch conditioned on (escape_delay == 1)
   except when the loop enters with (escape_delay == 2) allowing us to
   combine the branches.

2. Most of the code conditioned on (escape_delay == 2) simply modifies
   local data and then breaks out of the loop causing the function to
   return escape_data[0].

3. Based on #2 there is not actually any need to ever explicitly set
   escape_delay to 2 because we it is much simpler to directly return
   escape_data[0] instead.

4. escape_data[0] is, for all but one exit path, known to be '\e'.

Simplify the code based on these observations.

There is a subtle (and harmless) change of behaviour resulting from this
simplification: instead of letting the escape timeout after ~1998
milliseconds we now timeout after ~2000 milliseconds

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index e54e1e185c47..0ba490728459 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -122,25 +122,18 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
 			touch_nmi_watchdog();
 			f = &kdb_poll_funcs[0];
 		}
-		if (escape_delay == 2) {
-			*ped = '\0';
-			ped = escape_data;
-			--escape_delay;
-		}
-		if (escape_delay == 1) {
-			key = *ped++;
-			if (!*ped)
-				--escape_delay;
-			break;
-		}
+
 		key = (*f)();
+
 		if (key == -1) {
 			if (escape_delay) {
 				udelay(ESCAPE_UDELAY);
-				--escape_delay;
+				if (--escape_delay == 0)
+					return '\e';
 			}
 			continue;
 		}
+
 		if (bufsize <= 2) {
 			if (key == '\r')
 				key = '\n';
@@ -148,28 +141,25 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
 			*buffer = '\0';
 			return -1;
 		}
+
 		if (escape_delay == 0 && key == '\e') {
 			escape_delay = ESCAPE_DELAY;
 			ped = escape_data;
 			f_escape = f;
 		}
 		if (escape_delay) {
-			*ped++ = key;
-			if (f_escape != f) {
-				escape_delay = 2;
-				continue;
-			}
+			if (f_escape != f)
+				return '\e';
 
+			*ped++ = key;
 			key = kdb_read_handle_escape(escape_data,
 						     ped - escape_data);
-			if (key > 0) {
-				escape_data[0] = key;
-				escape_data[1] = '\0';
-			}
-			if (key)
-				escape_delay = 2;
-			continue;
+			if (key < 0)
+				return '\e';
+			if (key == 0)
+				continue;
 		}
+
 		break;	/* A key to process */
 	}
 	return key;
-- 
2.17.1

