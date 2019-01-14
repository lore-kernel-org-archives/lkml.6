Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14595C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94862064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQeO6nfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfANUV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:21:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42498 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfANUV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:21:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so369111wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeuM7QQA5Gxu6SkBFFLlqSjRQ6G2P+DWauTXJpVJV1w=;
        b=mQeO6nfGVl8RtKai4UIw+SvgF316Gs1QGCUr5nCPCbzGhRtX/RWaVER8/6lNnJfcka
         NJrKAC3qV6IBrN5dC4piPlzR2iAwVabacGUAU0Mop9XCAjYiD1sFdXq3zMUr+9v8RQWf
         xaumPgvF94dkABOzZ7d0ydXDvaZRWq9iKhn8EpXdoEauH8KQQVGXYRH7LFdEHlyV9jZb
         INFveEfs1OrNregNn3AzQSikf6BXQv0sh5sQVyh5Jad3JB9UUqdCr14Qrs4VxFKH9cYN
         b8rOmp3+Z3dmq0IY9fN/AHW3pasXObNnLF/FAXrVUwNnI5N6ArjrlmKLBzWeKK7DwRNy
         /VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xeuM7QQA5Gxu6SkBFFLlqSjRQ6G2P+DWauTXJpVJV1w=;
        b=SPk4MKuI2mT98w+LF6qVz3Or/WCD36XRVRlldxbtJlOrYknJPjFZa5AEMD/3Qh0fiD
         fr3qnJOAZ+klQXDFvH2aBDPZ0IWvCh+PLtwJCRYcaGeqEwJPno1sSmdxSC9WfnYMsD4H
         Db5/9TVbLaaWYS7kgIe6/kwO5+Y2oo86Ig/KEsDaTdwx+OMGhb2vKTo4uxPPHq9WyMi6
         e22XB6rHuN/QTTGvA3wyrmsW0hu4kkdzGuB+xKzfazD5uw96xHr+I+g+HSihorVPwy+y
         I9iIlfWhj9Sn+//07F6vitAEtJ1hbeVam3RilGwPhWpF41UZFnkn2VhrdnbIse4w9rl8
         Csbg==
X-Gm-Message-State: AJcUukcFwCOLFcQDPeADgYj5axk4HaqK/AuFQmlds9XIoWXP4xEC2MPv
        na4QPq87LWqUuQuaNarJscqsgmBv
X-Google-Smtp-Source: ALg8bN6dVeTGG1N61t+Q4sZADeMQQEgSjAjdEHiPG+pxCQ9BIpP2Bxr3G2+VQc6OqW7Mf1IjhTOjHQ==
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr192711wrx.146.1547497315993;
        Mon, 14 Jan 2019 12:21:55 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id p139sm57427802wmd.31.2019.01.14.12.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:21:54 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 85B3C11422AD; Mon, 14 Jan 2019 21:21:53 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/cmdline.c:: annotate implicit fall throughs
Date:   Mon, 14 Jan 2019 21:21:42 +0100
Message-Id: <20190114202143.14130-1-malat@debian.org>
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

  lib/cmdline.c:137:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/cmdline.c:140:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/cmdline.c:143:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/cmdline.c:146:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
  lib/cmdline.c:149:7: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 lib/cmdline.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 171c19b6888e..dc59d6216318 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -135,18 +135,23 @@ unsigned long long memparse(const char *ptr, char **retptr)
 	case 'E':
 	case 'e':
 		ret <<= 10;
+		/* fall through */
 	case 'P':
 	case 'p':
 		ret <<= 10;
+		/* fall through */
 	case 'T':
 	case 't':
 		ret <<= 10;
+		/* fall through */
 	case 'G':
 	case 'g':
 		ret <<= 10;
+		/* fall through */
 	case 'M':
 	case 'm':
 		ret <<= 10;
+		/* fall through */
 	case 'K':
 	case 'k':
 		ret <<= 10;
-- 
2.19.2

