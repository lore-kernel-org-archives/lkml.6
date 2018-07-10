Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69240C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBAD2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBAD2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933436AbeGJAq7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:46:59 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40048 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933423AbeGJAq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:46:28 -0400
Received: by mail-qt0-f196.google.com with SMTP id h4-v6so16997378qtj.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 17:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tWiyJeGvC5zdp0sRApZQtqvGHxQUko6rZedkHxbyDtU=;
        b=HXzsImAvyIAifYWrWG/bmuUz4SJ3PzmvzXvlU5Jy7o+2sFCG9qfzx/3n8bhPiYimJJ
         Y+bOvfNn33L7T/vwt7K8c0dJvT+IN6z7RrmsQQRGRdwTfo2tOFjsFo8A2NORxtlckRyy
         YnEAzIVWOIxO1JyrHDPh/9Nimk1OSnJQ0YntW27XV2xo1nqcGqWyxmM0sbZvLWHFprlw
         BGAnXKBFV88zyxCLTmRJmt0yKw5Jnf62BqQdSlsnb/qLdYd7bJ9QTLCc/Y5sQjiLkAyj
         XT8PXfNsHmlJYkpPEt044CvYaLxdjDvs1y9IkpQe7PLONqhPFzXk80Jch8HltFwZFm/d
         SNvw==
X-Gm-Message-State: APt69E0cWhZgPzZogoH+QIxD6MrL5xuF0YPI5VEER71JIMjuatPZPG+u
        pOOTeqSAFi6vd6ncoYd6qI37sA==
X-Google-Smtp-Source: AAOMgpdZ5iID0peRzm7lqvJvb02pQkLpCP/bGfHAcqzNb45e2VJiVs5oNubwOBtAjdFwubYV3N8F0A==
X-Received: by 2002:ac8:709:: with SMTP id g9-v6mr21415585qth.110.1531183588250;
        Mon, 09 Jul 2018 17:46:28 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::1941])
        by smtp.gmail.com with ESMTPSA id l36-v6sm1816792qtk.12.2018.07.09.17.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 17:46:27 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCHv2 7/7] Kbuild: Use HOST*FLAGS options from the command line
Date:   Mon,  9 Jul 2018 17:46:02 -0700
Message-Id: <20180710004602.21599-8-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710004602.21599-1-labbott@redhat.com>
References: <20180710004602.21599-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Now that we have the rename in place, reuse the HOST*FLAGS options as
something that can be set from the command line and included with the
rest of the flags.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Use the correct name for HOSTLDLIBS, update documentation.
---
 Documentation/kbuild/kbuild.txt | 16 ++++++++++++++++
 Makefile                        |  9 +++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/kbuild/kbuild.txt b/Documentation/kbuild/kbuild.txt
index 6c9c69ec3986..9847a5974826 100644
--- a/Documentation/kbuild/kbuild.txt
+++ b/Documentation/kbuild/kbuild.txt
@@ -238,3 +238,19 @@ KBUILD_VMLINUX_LIBS
 All .a "lib" files for vmlinux.
 KBUILD_VMLINUX_INIT, KBUILD_VMLINUX_MAIN, and KBUILD_VMLINUX_LIBS together
 specify all the object files used to link vmlinux.
+
+HOSTCFLAGS
+--------------------------------------------------
+Additional flags to be passed to $(HOSTCC) when building host programs.
+
+HOSTLDFLAGS
+--------------------------------------------------
+Additional flags to be passed to $(HOSTLD) when building host programs.
+
+HOSTCXXFLAGS
+--------------------------------------------------
+Additional flags to be passed to $(HOSTCXX) when building host programs.
+
+HOSTLDLIBS
+--------------------------------------------------
+Additional libraries to link against when building host programs.
diff --git a/Makefile b/Makefile
index 96e34381d9ee..c2ee1d4c12c9 100644
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
+KBUILD_HOSTLDLIBS := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
 
 # Make variables (CC, etc...)
 AS		= $(CROSS_COMPILE)as
-- 
2.17.1

