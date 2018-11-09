Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4081FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0870520827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="R9i1wcyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0870520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeKJIxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:53:49 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42968 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbeKJIxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:53:48 -0500
Received: by mail-lf1-f68.google.com with SMTP id q6-v6so2485854lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jx5HlPIIomYlBzDt54Qe47ifSCPQEK4uNdx5H+CvDwg=;
        b=R9i1wcyVx/iFL4uWDnG2Z8tQVPf6cbh7rTNjZ+kqgfo7nsTnT43n04TfGhL+EOo8d/
         Zsy4kxL+HbdgXEfEnUaqQz9IstZHRGjoWT6qhJJjABUMqZggeQ69CrGKIOU3Jv5BKpq6
         NJT3MCZ16PdvvrFBHJP9AFC7Zu4RcoE8OMZzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jx5HlPIIomYlBzDt54Qe47ifSCPQEK4uNdx5H+CvDwg=;
        b=pKwyXb0W1mmfDypsTzahA9hZjY9An9sU8vxT1M6c1NLb35mwU6T6GqWoZHEJJE+bN2
         r8+8AXExh24ZrexzHlSKbqv8hwMQ6pxI/0v1mRkxej/vRHoAzpRbKVjv5pBXIsBF/hkN
         0Dx03nqygy0aXok3EVpM/NtpBfuql9F0fcu5vhQNhhZRlWfPZKFxQopbd16qVUrwqbI6
         I/e1/+KEiD+aYuOA1a9G11Dv9SuAKwKcYUhDOwJiLA1emCLVr3z/OzVwB/iiBAGGDJTK
         GFY+9mwfnCnsG+SU0vpHg4/vv4mYCINY0PvG6EuuHmPEG3xFlWe7HEinDwMJCQx6WBqi
         elbw==
X-Gm-Message-State: AGRZ1gLmoyw1Ezv2xKBI/m3Z0Cdjl/6WMiwvHseaUwOqWjUqohT19InQ
        GNf2wJtDLoj7i+p4aK4QAzCkwQ==
X-Google-Smtp-Source: AJdET5f6lWd5P+B9dhIG1HRbPVrutADq2XIsYsXmtEd8dxC0NkC+CM0zb2PafIonO98v36sD0FKDvg==
X-Received: by 2002:a19:280f:: with SMTP id o15mr6315309lfo.0.1541805062205;
        Fri, 09 Nov 2018 15:11:02 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:01 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 02/23] linux/device.h: use unique identifier for each struct _ddebug
Date:   Sat, 10 Nov 2018 00:10:00 +0100
Message-Id: <20181109231021.11658-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181109231021.11658-1-linux@rasmusvillemoes.dk>
References: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
 <20181109231021.11658-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes on x86-64 later in this series require that all struct _ddebug
descriptors in a translation unit uses distinct identifiers. Realize
that for dev_dbg_ratelimited by generating such an identifier via
__UNIQUE_ID and pass that to an extra level of macros.

No functional change.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/device.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 061cd83ac64c..6e0909db6dda 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1532,7 +1532,7 @@ do {									\
 	dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
 #if defined(CONFIG_DYNAMIC_DEBUG)
 /* descriptor check is first to prevent flooding with "callbacks suppressed" */
-#define dev_dbg_ratelimited(dev, fmt, ...)				\
+#define _dev_dbg_ratelimited(descriptor, dev, fmt, ...)			\
 do {									\
 	static DEFINE_RATELIMIT_STATE(_rs,				\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
@@ -1543,6 +1543,8 @@ do {									\
 		__dynamic_dev_dbg(&descriptor, dev, dev_fmt(fmt),	\
 				  ##__VA_ARGS__);			\
 } while (0)
+#define dev_dbg_ratelimited(dev, fmt, ...)				\
+	_dev_dbg_ratelimited(__UNIQUE_ID(ddebug), dev, fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define dev_dbg_ratelimited(dev, fmt, ...)				\
 do {									\
-- 
2.19.1.6.gbde171bbf5

