Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB24ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C059F21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C059F21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeJSU0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:26:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37988 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeJSU0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:26:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id a13-v6so37220761wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 05:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Oy3EdcsKa921bauMTdkdlc8KG+Gne7gsHnChldkrCS0=;
        b=RidsJkzDY/P9wiIGmqfs4qsw1prUnO4CZhSpGKxc102qvb+7aXo2ZE+tOP6VQdcIzk
         GAoUBjgaR5qm1S5BrMvyS1b7C1Shxzvk2n9H90FdVLUnx7yN6KnuRPlnz8g4h/e4WH27
         cpZz37q1sb7gFykWmWPaehd0KTeFufz6rG0Tb/hQrmnaqFK4GmRyuRk+VZ+JBHxSqjUz
         9duC4LF8+6r8Q0ehgd97DOxW3R11mNRWJuMkrawy0MLTzH6t2CJEDwglDVMaVVyYjJdc
         7djHjmjT6zRxqKcCGzRnXyi2oLrnQsOCjYHfYe2u6AkT6DeW/QOH74cxKRhmjewtdCH0
         lH6g==
X-Gm-Message-State: ABuFfojk9y46FIoX1ext4ZYdggVmWoN3/0xeF1Ms0ptZd88PHKOPhAFj
        rY494ZNaG5t95kR9xyYzxxWr6Q==
X-Google-Smtp-Source: ACcGV63Q2WNpklcdTTebLgqFJd4fZ4Fxil/zKeUwoZ+vaD3MJ4/FIiPZbARPK5D+O06p84shW32F1w==
X-Received: by 2002:adf:84e6:: with SMTP id 93-v6mr35672038wrg.144.1539951656957;
        Fri, 19 Oct 2018 05:20:56 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id s10-v6sm1858283wmf.15.2018.10.19.05.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 05:20:56 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 3/5] statx: add STATX_ATTRIBUTES flag
Date:   Fri, 19 Oct 2018 14:20:47 +0200
Message-Id: <20181019122049.27121-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181019122049.27121-1-mszeredi@redhat.com>
References: <20181019122049.27121-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FUSE will want to know if stx_attributes is interesting or not, because
there's a non-zero cost of retreiving it.

This just a "want" flag, since stx_attributes_mask already indicates
whether we "got" stx_attributes or not.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
---
 include/uapi/linux/stat.h       | 1 +
 samples/statx/test-statx.c      | 2 +-
 tools/include/uapi/linux/stat.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index ed456ac0f90d..7d3cce078652 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -148,6 +148,7 @@ struct statx {
 #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
+#define STATX_ATTRIBUTES	0x00001000U	/* Want stx_attributes */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
diff --git a/samples/statx/test-statx.c b/samples/statx/test-statx.c
index e354048dea3c..deef9a68ff68 100644
--- a/samples/statx/test-statx.c
+++ b/samples/statx/test-statx.c
@@ -211,7 +211,7 @@ int main(int argc, char **argv)
 	struct statx stx;
 	int ret, raw = 0, atflag = AT_SYMLINK_NOFOLLOW;
 
-	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME;
+	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME | STATX_ATTRIBUTES;
 
 	for (argv++; *argv; argv++) {
 		if (strcmp(*argv, "-F") == 0) {
diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
index ed456ac0f90d..60cd0a3f52e7 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -148,6 +148,7 @@ struct statx {
 #define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
+#define STATX_ATTRIBUTES	0x00001000U	/* Want/got stx_attributes */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
-- 
2.14.3

