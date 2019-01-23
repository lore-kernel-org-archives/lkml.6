Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DC0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5D02183F
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfAWMzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:55:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37874 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfAWMzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:55:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so1849406wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 04:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSxnX/Lfd6gY76ahY1VU8wnsHqE/+G4E8WN5R2sa4SQ=;
        b=KEYuJf8h3yuBnizsfs1b+RtkFdc2cagM27NqWbZU53F4X84RgLXtHAdFUzbRE7SyFd
         CfXKTVIwX2tc4HLvdQMvKbTNELjL32PJSnAH/lEtxm5cDZhrN/fFPs0IMwWB0IKPqMIg
         E28zYyeLadTQMM+/fF6gpNrb3MYGUc0oeAy0T1pT4L6tKa6hZD1sheJqddHwJiwyEQ3F
         g8HnVmLPkZOHUrISb2eSRwGVva9w4h6FjTVrBweYk7kUaQ8Jz/PVFycz44DKwbqAuUjF
         8dO17/5u8TLPHXdbMc84psso+YoTkcBi0TY5tJITK+jmcYUq1qc5/kwGZg3qVy7GwwLi
         84Ng==
X-Gm-Message-State: AJcUuke+OBFOxUugem/U1moylNppZzpuqcpJLfQCTb5se6qsPlekh5ab
        Y7fQdVX2jqIBIIoVy/w0RsV9fw==
X-Google-Smtp-Source: ALg8bN50IX7t2OlgKJpCWlr5gDWnvdTJsyV9F2bbbUAwAm5frinDho6iWZ5M5DRanbDbMs/U60PxBA==
X-Received: by 2002:a7b:c757:: with SMTP id w23mr2508967wmk.59.1548248115783;
        Wed, 23 Jan 2019 04:55:15 -0800 (PST)
Received: from labbott-redhat.redhat.com (ovpn-brq.redhat.com. [213.175.37.11])
        by smtp.gmail.com with ESMTPSA id x15sm130679211wrs.27.2019.01.23.04.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 04:55:15 -0800 (PST)
From:   Laura Abbott <labbott@redhat.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Laura Abbott <labbott@redhat.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] s390/jump_label: Correct asm contraint
Date:   Wed, 23 Jan 2019 13:55:13 +0100
Message-Id: <20190123125513.20210-1-labbott@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a build failure with gcc9:

 ./arch/s390/include/asm/jump_label.h: Assembler messages:
 ./arch/s390/include/asm/jump_label.h:23: Error: bad expression
 ./arch/s390/include/asm/jump_label.h:23: Error: junk at end of line, first unrecognized character is `r'
 make[1]: *** [scripts/Makefile.build:277: init/main.o] Error 1

According to the toolchain people, the actual issue is the use of
"X" constraint which is too permissive. Switch to using "i" instead.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1668703
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/s390/include/asm/jump_label.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index e2d3e6c43395..41dabfd8518d 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -22,7 +22,7 @@ static inline bool arch_static_branch(struct static_key *key, bool branch)
 			  ".long	0b-.,%l[label]-.\n"
 			  ".quad	%0-.\n"
 			  ".popsection\n"
-			  : : "X" (&((char *)key)[branch]) : : label);
+			  : : "i" (&((char *)key)[branch]) : : label);
 	return false;
 label:
 	return true;
@@ -36,7 +36,7 @@ static inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 			  ".long	0b-.,%l[label]-.\n"
 			  ".quad	%0-.\n"
 			  ".popsection\n"
-			  : : "X" (&((char *)key)[branch]) : : label);
+			  : : "i" (&((char *)key)[branch]) : : label);
 	return false;
 label:
 	return true;
-- 
2.20.1

