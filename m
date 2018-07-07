Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB423C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0D022531
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0D022531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932701AbeGGBHd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:07:33 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39645 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754164AbeGGBH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:07:29 -0400
Received: by mail-qt0-f195.google.com with SMTP id q12-v6so11399460qtp.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 18:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VY/IhgIqxGkrQSyydj6bne3tZx4/JPRqdhis0pn0AqQ=;
        b=GFbzQdHbPSE1iUNKz70DbuQ7ZjdRLd6i/EvaE3UZP8QthI3iy0VTwK/3G1c2AEebHJ
         WHFXl6sRCQB+oRT+UH1svMXLASHsQSFSzhkuT2ZeAN6frE5G8nlf1UPw6gjjwVvWAB/W
         fHeYqI3VlST+3q+CZ8nVsCBDEJ66HAUR21LmvgQRGgRJI8Q115+mkv9CeXFaDvW0goxu
         F1+Own2qlVv18WkAx2Lcf3wOQokLTNDDKHLEGquITygKJqcELrmuzBMSiIGYlvMhMbtL
         qxHHxQg3eNVwjW9jpoyvVeWJaKwdICm4Uo3KA9zWYACtKVlYIet+SglQoG5HpFq3LEC1
         TO8w==
X-Gm-Message-State: APt69E1uEtVHMLwigChGhTjH+z3oE8b5Bh/H0J/0VmRLMRwnFHHPEjt8
        1SyYwYTTYRrcbvyXswrxy5jQew==
X-Google-Smtp-Source: AAOMgpfYB3XTLR+AaPgxavhf59J+jRgFdX+nZ/2rxPkal+obnXelgtO8p0R5/198KslKVybp182z7Q==
X-Received: by 2002:ac8:33c2:: with SMTP id d2-v6mr11084985qtb.323.1530925648480;
        Fri, 06 Jul 2018 18:07:28 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id b3-v6sm3359698qtg.20.2018.07.06.18.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 18:07:27 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: [PATCH 2/7] tools: build: Use HOSTLDFLAGS with fixdep
Date:   Fri,  6 Jul 2018 18:07:04 -0700
Message-Id: <20180707010709.16648-3-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707010709.16648-1-labbott@redhat.com>
References: <20180707010709.16648-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The final link of fixdep uses LDFLAGS but not the existing HOSTLDFLAGS.
Fix this.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
This was another one where I couldn't tell of the use of LDFLAGS was a
typo or intentional, hence keeping both.
---
 tools/build/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/Makefile b/tools/build/Makefile
index 5eb4b5ad79cb..cd0fd2cd165b 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -43,7 +43,7 @@ $(OUTPUT)fixdep-in.o: FORCE
 	$(Q)$(MAKE) $(build)=fixdep
 
 $(OUTPUT)fixdep: $(OUTPUT)fixdep-in.o
-	$(QUIET_LINK)$(HOSTCC) $(LDFLAGS) -o $@ $<
+	$(QUIET_LINK)$(HOSTCC) $(HOSTLDFLAGS) $(LDFLAGS) -o $@ $<
 
 FORCE:
 
-- 
2.17.1

