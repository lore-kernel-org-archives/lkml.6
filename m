Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC56C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D17A21550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Vb9PPXfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D17A21550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389894AbeIUULr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:11:47 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45604 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeIUULr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:11:47 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7A9A21280;
        Fri, 21 Sep 2018 16:22:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1537539758;
        bh=QAprZUSH7SZi1Dr8b9tXbbaG6phFjqIDYQnRK8vWwPk=;
        h=From:To:Cc:Subject:Date:From;
        b=Vb9PPXfh+jdR1oghgeQp7nbmNxbhxnKIHNNVqdLg9rVQ2Kw2eg4ZzHhon0Y2NJ7oY
         En7QNecxrXnqE+kQ/6HkgNP+RUEDDUEJcPbeqrLgs9INjpjpngPX46ByWvv3mN86wT
         lM5dy4qpb/Z24q1DpISGTP9VJX55VGhRVWoWpnRE=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] kernel/bounds: Provide prototype for foo
Date:   Fri, 21 Sep 2018 15:22:33 +0100
Message-Id: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/bounds.c is recompiled on every build, and shows the following
warning when compiling with W=1:

  CC      kernel/bounds.s
linux/kernel/bounds.c:16:6: warning: no previous prototype for ‘foo’ [-Wmissing-prototypes]
 void foo(void)
      ^~~

Provide a prototype to satisfy the compiler.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: stable@vger.kernel.org

---
I compile all of my incremental builds with W=1, which allows me to know
instantly if I add a new compiler warning in code I generate.

This warning always comes up and seems trivial to clean up.
---
 kernel/bounds.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bounds.c b/kernel/bounds.c
index c373e887c066..60136d937800 100644
--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -13,6 +13,8 @@
 #include <linux/log2.h>
 #include <linux/spinlock_types.h>
 
+void foo(void);
+
 void foo(void)
 {
 	/* The enum constants to put into include/generated/bounds.h */
-- 
2.17.1

