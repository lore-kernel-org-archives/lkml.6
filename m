Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE16C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0044022531
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0044022531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933028AbeGGBHp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:07:45 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:38014 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932879AbeGGBHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:07:40 -0400
Received: by mail-qk0-f180.google.com with SMTP id y4-v6so7215671qka.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 18:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JQCQFdHkWrtzdKOqm08g04PbP6dAJqUU1btZr0uBYiQ=;
        b=uTPPBwAtMj6MXpbRRQ/vEJPTe3ZoRt5Q89DYoFYdnWBhuRXABmlGj5r7PYzWJif4qN
         mutIIS+qY59arQqPMeuXRaMZfYQ4PSkDbl3vHR+sp8KAhc1FPhqc/NkqqHxdEf1x/R11
         /trcQbdhu+eHJy8wc6Rj9RK3WlpT5/7nezHbojGGklZCWIpbSwX4dNPtxucPwzhykQUD
         lWrrppVvSuaXEk3IDhs2XBSFXXLeBoflKxYWQMbY1zWLQg3kT8ODmQW3UKdziSfMEngw
         A35r5sPfYTctu6Y46mSi5cIGqwwcu6VE9yArSaPkM1tP/hXY8PVvBJVNPAFCZSl/+hnO
         eaMQ==
X-Gm-Message-State: APt69E0giytnm3uY6qhLXDR7Jx3e2o44eQD5UlINY87Akq3KfuZuYiP2
        E12ybRlkNdCyvskdqAQC7iF1ig==
X-Google-Smtp-Source: AAOMgpcd4X+TMNkkC5Uu21Sm7GD2hlUAtKaImct7sPpgsc1+Hp59rTmGGHG0wU9mPVsYYjset2QOGQ==
X-Received: by 2002:a37:d942:: with SMTP id u63-v6mr11243079qki.165.1530925660262;
        Fri, 06 Jul 2018 18:07:40 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id b3-v6sm3359698qtg.20.2018.07.06.18.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 18:07:39 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: [PATCH 7/7] Kbuild: Use HOST*FLAGS options from the command line
Date:   Fri,  6 Jul 2018 18:07:09 -0700
Message-Id: <20180707010709.16648-8-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707010709.16648-1-labbott@redhat.com>
References: <20180707010709.16648-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the rename in place, reuse the HOST*FLAGS options as
something that can be set from the command line and included with the
rest of the flags.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index d925af1fb11b..77c74b3cf30b 100644
--- a/Makefile
+++ b/Makefile
@@ -360,10 +360,11 @@ HOST_LFS_LIBS := $(shell getconf LFS_LIBS)
 HOSTCC       = gcc
 HOSTCXX      = g++
 KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
-		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS)
-KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS)
-KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS)
-KBUILD_HOSTLDLIBS := $(HOST_LFS_LIBS)
+		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS) \
+		$(HOSTCFLAGS)
+KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
+KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
+KBUILD_HOSTLDLIBS := $(HOST_LFS_LIBS) $(HOST_LOADLIBES)
 
 # Make variables (CC, etc...)
 AS		= $(CROSS_COMPILE)as
-- 
2.17.1

