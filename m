Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1792BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68AC2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS7kgrUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfAXSGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:06:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37466 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfAXSGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:06:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so4060585wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 10:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h10FJU/LDKIiygA4ZR/kepjWUNDP2RdpzJ7y01UnlpM=;
        b=CS7kgrUHY4rmjQNIS2zazMNxwB/8WmpADn724tbFQ8wxv3RAVbINlyVXewjEKCGFNR
         99k2Qywh5xZv7cTP+XO1a86WGjFm/yp9nIkLnem+rkTP64xKrVx2VYScOWf7mIR3RNb6
         dSubqsY06Jl8WsTKQpM0cvhbroO8/cBMXkeLvN3qap4BVdmOHMRehb/WSgAQmgCBjVKa
         EpVgIU0w+dkf3ICQ7/IlnTkzxKWPlxhkm/5RablWVBudm0l975mWcoAeWhR8HbHSk4VC
         QxAg8NaoeJqF6T/scCmTk26qmZez8ZZP96FnGyFKxYGKOBDc4zrOp71MX73SirUEHFRn
         m/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=h10FJU/LDKIiygA4ZR/kepjWUNDP2RdpzJ7y01UnlpM=;
        b=lI65P/XaOwUCSKTEAHLBZwC+TWyUjfYqOjLDOZvO4epY0gpSmEXqbRPVnhib32bHVi
         KhDqKcza7M/iqNxtOhgE4xp6cvu3zqD8Op52uMtCs3bm/vHfF45z2VLEw9xFUAD8VrB0
         ZJpiSkFF8umlJH4WrFlawQ/kP9ArYcqBzXt/n40p+XV6G7hmPSITRdWIXchwh8xxNOaZ
         vO4LIUHIFh6YUSF8oYbDHYmFl9eqs9381IdSpVXYufCYUcx7HFQjhG83ageYDllnuomT
         J0vUEiymJLDI1FyLCJm8bufItMDnHHauXhhHctBmJskXh4sM6BJga7bosLxPBg75VGRL
         HeRQ==
X-Gm-Message-State: AJcUukceqnZlV2v7yijU66+aUhfQTmjGWJDD4//ITyJfHBujuHJ01k4L
        J+kbAbes182tYpi4BOvLK3M=
X-Google-Smtp-Source: ALg8bN6MBUARb5An6fav7kpfx1zpshf52hX3zwluDRLTRw9JJRUdgiRHQ97SuzvpE9tT8Uu23qn6Mg==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr3582126wmb.98.1548353201537;
        Thu, 24 Jan 2019 10:06:41 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id m15sm86331564wrr.95.2019.01.24.10.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 10:06:40 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 3A6B71143573; Thu, 24 Jan 2019 19:06:39 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Dimitris Papastamos <dp@opensource.wolfsonmicro.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regmap: Remove attribute packed from struct 'regcache_rbtree_node'
Date:   Thu, 24 Jan 2019 19:06:24 +0100
Message-Id: <20190124180624.20557-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On one hand commit 28644c809f44 ("regmap: Add the rbtree cache support")
added 'regcache_rbtree_node' as packed structure, while on the other hand
commit e977145aeaad ("[RBTREE] Add explicit alignment to sizeof(long)
for struct rb_node.") declared struct 'rb_node' as aligned.

Solve the ambiguity of placing aligned structure in a packed one by
removing the packed attribute from struct. This seems to be the behavior
of gcc anyway.

This removes the following warning (W=1):

  drivers/base/regmap/regcache-rbtree.c:36:1: warning: alignment 1 of 'struct regcache_rbtree_node' is less than 4 [-Wpacked-not-aligned]

Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/base/regmap/regcache-rbtree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index 2e8f0144f9ab..9cbb4b0cd01b 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -33,7 +33,7 @@ struct regcache_rbtree_node {
 	unsigned int blklen;
 	/* the actual rbtree node holding this block */
 	struct rb_node node;
-} __attribute__ ((packed));
+};
 
 struct regcache_rbtree_ctx {
 	struct rb_root root;
-- 
2.19.2

