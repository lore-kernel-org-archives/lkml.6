Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0272EECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3BB21524
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="AtIUFWMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3BB21524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbeITDow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:44:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35888 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbeITDov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:44:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so6182819edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1+Ka/P4c2+y8Ly0gb+ADjCRFrYMCj6rIF/AA6q0Fsk4=;
        b=AtIUFWMskQGGzGvFZtqzGmwLGQftIHBI8cgR6ObNIuzNeo3cnm5pbpHrPL2YODVM6i
         /sIpYDejYcFw4n0ijaDM+rrCQotTk2s6Bh59ywpNEI12Er+LkcIEwRu39EhdEATC9ErI
         aA9xO3jq/mQ6IQc3NAmLebEiCb6ryQeUBV6L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1+Ka/P4c2+y8Ly0gb+ADjCRFrYMCj6rIF/AA6q0Fsk4=;
        b=hBnGAVKkyxcSzSimEHwNYOQVwyayzW2PDoA2tL8t5N5KDAGwU7wuM9I6GLM+hoIsGi
         /7tDdBJkw6VFD+k8pZRLTdJADkGRew3PvGLkrZk2ORH0lRT3s+EpdA3xGDLkycXma2si
         er6idaUfFxMgTjV9eI1Wy4b0F3V/nXXhG6CMFX3XgP7F/SFzOTI5i7Qij3xLJyNBEAsK
         rmYJ5N/hwUCKZ6DR7fuT9LUdn7uovaduTYbb0HMjlanudwvskp0IpdiAT1vit4GsWiHH
         Y+lR0TM7jM4KGZ7iXbGIUbHNtP2Id+HVSVXFEfBqBxAmnm+JV1JbHyNIJyuhV3xzgj81
         1guA==
X-Gm-Message-State: APzg51ArK+RM5SpeayK5gvu4P028mKEEesNR7F+lsHGwp9dTwuZWlx2r
        85UzauXuUsT88njEDQ12tDI3Rg==
X-Google-Smtp-Source: ANB0VdZwawvweR7zKHP3uBFygRLqmuKgzXMkqYj+//KVOmKsV5Ow+KHv2M1L3Ap/o4barAKUuHfo+Q==
X-Received: by 2002:a50:ec03:: with SMTP id g3-v6mr61148353edr.96.1537394693658;
        Wed, 19 Sep 2018 15:04:53 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:04:53 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/22] linux/device.h: use unique identifier for each struct _ddebug
Date:   Thu, 20 Sep 2018 00:04:24 +0200
Message-Id: <20180919220444.23190-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes on x86-64 later in this series require that all struct _ddebug
descriptors in a translation unit uses distinct identifiers. Realize
that for dev_dbg_ratelimited by generating such an identifier via
__UNIQUE_ID and pass that to an extra level of macros.

No functional change.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/device.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 0d8ed2adfc73..81108db013e4 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1497,7 +1497,7 @@ do {									\
 	dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
 #if defined(CONFIG_DYNAMIC_DEBUG)
 /* descriptor check is first to prevent flooding with "callbacks suppressed" */
-#define dev_dbg_ratelimited(dev, fmt, ...)				\
+#define _dev_dbg_ratelimited(descriptor, dev, fmt, ...)			\
 do {									\
 	static DEFINE_RATELIMIT_STATE(_rs,				\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
@@ -1508,6 +1508,8 @@ do {									\
 		__dynamic_dev_dbg(&descriptor, dev, dev_fmt(fmt),	\
 				  ##__VA_ARGS__);			\
 } while (0)
+#define dev_dbg_ratelimited(dev, fmt, ...)				\
+	_dev_dbg_ratelimited(__UNIQUE_ID(ddebug), dev, fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define dev_dbg_ratelimited(dev, fmt, ...)				\
 do {									\
-- 
2.16.4

