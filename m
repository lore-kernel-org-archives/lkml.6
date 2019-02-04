Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD967C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7176C2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="HZyHigHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfBDVUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:20:46 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41707 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfBDVUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:20:46 -0500
Received: by mail-ed1-f68.google.com with SMTP id a20so1196514edc.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 13:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WUBvaPcTV6KNM8UlnXALkUd1vDtcksn79ypMTaYmG6E=;
        b=HZyHigHq2OPj6weRKqw8NTn15CHbxq2PhwDPOnbziQjbM7JDGu7Y2ub30gl0xkaxKR
         p+/ujUAicfIEiNTCzSDQ8K0LB3xsI7Sxl5+7lLc2jFxHSVC2EHy+f3a2/WDAydbpDAd6
         iSEXbn06atLqqgQVmX6CcEeMAgZEmZt0A/zGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WUBvaPcTV6KNM8UlnXALkUd1vDtcksn79ypMTaYmG6E=;
        b=g6hjNIEmHu6/Fxdye9sCQufRWHroJX1Z1B8+cx+hX9/4l8E1GJyK/eWJJqx6hNE5eF
         3cUQ2TzXKVie7Lfafh8+GiQQZuNEJVZEVcCGYADe5zuWgdTk7FVyIGElkSguXHQeBhrh
         3+JMSrOHDnY6olxF2cvVrMkaALcYFG+R/6Ms5LSOmAYZR+xH9tO7Ckos2YI6corGiimM
         M8Nx4rZoXNpBThlVhfv8EqTd2ZYb7lyXRpU+j4tTfUC64nS1wGeyZV/bfvExOihKhUks
         Sp8HmMimdwVoQePlC6MCz8mBAuE8lKrJnbBmQiZqnI7GhknLoCS3NMlAsl0L9f/BqjU1
         F8ng==
X-Gm-Message-State: AHQUAubuKuv/Oj3WBRxym4q0VGWInC+AaQ61zjtI1TrTHI2+KMMBsLT0
        AmMROD3bUccZYa63yRsVjX8TNg==
X-Google-Smtp-Source: AHgI3IZXgKfRTAz82ViCmTpid3xiY0+8DbOnhL3O3gzyQ5Jsh2OSKSGC+4YSz6L0+oXPRtKo328F+A==
X-Received: by 2002:a50:d311:: with SMTP id g17mr1048484edh.187.1549315244515;
        Mon, 04 Feb 2019 13:20:44 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-68.cgn.fibianet.dk. [5.186.119.68])
        by smtp.gmail.com with ESMTPSA id e14sm4625745edb.79.2019.02.04.13.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 13:20:44 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xfs: allow disabling xfs tracepoints via Kconfig
Date:   Mon,  4 Feb 2019 22:20:35 +0100
Message-Id: <20190204212035.9919-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/tracepoints.h allows individual subsystems to disable their
tracepoints. Add such a knob for xfs. Disabling XFS_TRACEPOINTS
reduces the resident size of xfs.ko by about a third, or ~350 KiB.

$ size /tmp/xfs/{a,b}/xfs.ko
   text    data     bss     dec     hex filename
 671726    4129     632  676487   a5287 /tmp/xfs/a/xfs.ko
 893192  166737     632 1060561  102ed1 /tmp/xfs/b/xfs.ko

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/xfs/Kconfig     | 9 +++++++++
 fs/xfs/xfs_trace.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
index 457ac9f97377..d099e6d9f6c5 100644
--- a/fs/xfs/Kconfig
+++ b/fs/xfs/Kconfig
@@ -141,3 +141,12 @@ config XFS_ASSERT_FATAL
 	  result in warnings.
 
 	  This behavior can be modified at runtime via sysfs.
+
+config XFS_TRACEPOINTS
+	bool "XFS tracepoints"
+	default y
+	depends on XFS_FS && TRACEPOINTS
+	help
+	  Say Y here to build XFS with tracepoints.
+
+	  You can say N here to reduce the size of the kernel image.
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 6fcc893dfc91..5fb3d5c0483e 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -6,6 +6,10 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM xfs
 
+#ifndef CONFIG_XFS_TRACEPOINTS
+#define NOTRACE
+#endif
+
 #if !defined(_TRACE_XFS_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_XFS_H
 
-- 
2.20.1

