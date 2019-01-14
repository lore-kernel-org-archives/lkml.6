Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF648C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B57E2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvzHlEY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfANUTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:19:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33466 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfANUTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:19:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so430156wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rv54V/MaRh6BJmKONskW/ZwwHfsHOaSVCtiOirYlyio=;
        b=qvzHlEY8iB/9VFpainYGTbjpNEZ+JLtKN/5ALgzL362+vhwn7WJF19FdviXUAaw7x0
         otQzUvuLQNNXynFPgQxdIeKz3U5Ba5LlHZzIivpwFOvS90lGpBLxXZsy5FYiqkY+YdMx
         zBb56Tnex/lKIYlZI54rpSyqtxaWpLcGiR4Aan/TaOx3WE/wKh80w9HUuoaZ4J7YGxtN
         WmySJ8XBim/K4pwOQgUxSoLMke7iyWtuzARCoioolb6xmkYSBDZHd4hm5Q37RBXYBqel
         ZE56t4APgLnREdhc7A2xqglGMYFvNrHtznSUP11jajRsheqepcjF66huEJr++aRvPDgS
         /6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=rv54V/MaRh6BJmKONskW/ZwwHfsHOaSVCtiOirYlyio=;
        b=OorG8ba3T7cy2eRHhr7d3cRk1qryV1J8p+9/dxHJquOfNvkxhsM8LKBN6JkQPAV2bU
         56wtH44YimG/sfZf0yXO+LjjaodlPeaOTbtiOXqT8Ix8u1uxU6Su4uiGd9GOVq8yySFq
         0zrzxUbyB3c5jD8dmZCh1MSgsxZzQDX/rXesnivqHVOTUXhZ9F7AGybGwPzPwqZU+pgh
         UFWtFFCNIkapVM4cNOxAz2jwpQfxWPxH4TYnu0aBQnPqFjo9HcILSK8Yr4Dk3ip7TWKy
         uZJNpcnJ1oz+J7D9LrbTGaaI4t1Ylai49HLho/CviFaZRoF0xUolmVmUFNqEu9ltkycZ
         Io6A==
X-Gm-Message-State: AJcUukf9N+G8+uDnZLMufJpBQDdisVit6fNt4dZAeVtNNMhAYCUbKz0P
        fql2d0Epw6DGXQ/7VIFSa+I=
X-Google-Smtp-Source: ALg8bN6YD3JRVf51SEMkb4T3OD3gwuXyAV001b35lv798gxlJPrUskUABwHmkBfFLQRQ+N/iKHksQQ==
X-Received: by 2002:adf:97d1:: with SMTP id t17mr144042wrb.283.1547497162537;
        Mon, 14 Jan 2019 12:19:22 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id v16sm58738017wrs.75.2019.01.14.12.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:19:21 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id C3D5611422AD; Mon, 14 Jan 2019 21:19:20 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/siphash.c:: annotate implicit fall throughs
Date:   Mon, 14 Jan 2019 21:19:11 +0100
Message-Id: <20190114201911.13725-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1). Fix them up.

This commit remove the following warnings:

  lib/siphash.c:71:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/siphash.c:72:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/siphash.c:73:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/siphash.c:75:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/siphash.c:434:12: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 lib/siphash.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/siphash.c b/lib/siphash.c
index 3ae58b4edad6..b95624f5aa34 100644
--- a/lib/siphash.c
+++ b/lib/siphash.c
@@ -69,10 +69,14 @@ u64 __siphash_aligned(const void *data, size_t len, const siphash_key_t *key)
 #else
 	switch (left) {
 	case 7: b |= ((u64)end[6]) << 48;
+		/* fall through */
 	case 6: b |= ((u64)end[5]) << 40;
+		/* fall through */
 	case 5: b |= ((u64)end[4]) << 32;
+		/* fall through */
 	case 4: b |= le32_to_cpup(data); break;
 	case 3: b |= ((u64)end[2]) << 16;
+		/* fall through */
 	case 2: b |= le16_to_cpup(data); break;
 	case 1: b |= end[0];
 	}
@@ -432,6 +436,7 @@ u32 __hsiphash_aligned(const void *data, size_t len, const hsiphash_key_t *key)
 	}
 	switch (left) {
 	case 3: b |= ((u32)end[2]) << 16;
+		/* fall through */
 	case 2: b |= le16_to_cpup(data); break;
 	case 1: b |= end[0];
 	}
-- 
2.19.2

