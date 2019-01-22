Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F44C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9F320879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170627;
	bh=emveA2b0EWOTR34gvt+EiX2+vy7ONpGQepNxROGKDYc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SO3Iujh6b/DFT3wqbEBJCbCK23a4+GleJ3hPEP3b2Q7aEjCS5F/xumoTh4av+/Vyp
	 2iHwJdlJmLlAEPfgGaYCNL3d3WRnhnWWcztpm7EbzYuooc3xaprfwgfW/GEUf3h7bA
	 dYeyn8RBu8MxULve8U8/CdP/YosgBmnDqkPiYSW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfAVPXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:23:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbfAVPXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFCD4217F5;
        Tue, 22 Jan 2019 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170622;
        bh=emveA2b0EWOTR34gvt+EiX2+vy7ONpGQepNxROGKDYc=;
        h=From:To:Cc:Subject:Date:From;
        b=maLD7vJSvLjtxI4G8XZCv7i1/KwB0fe/Q1/gqGbS1Tzbv0tC0IkNxRGS/5G9bcjYo
         gJx2W2ivlU6zZ6Mv41R3Bbufc397fqI5wYJW+E+AZ3L6jweUnruFDl+ztBKIja0Ixt
         ERCujUqNBXKez+h7TxLqEyy7I3DKFFIyQ2wRICmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] kcov: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:45 +0100
Message-Id: <20190122152151.16139-46-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/kcov.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index c2277dbdbfb1..5b0bb281c1a0 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -444,10 +444,8 @@ static int __init kcov_init(void)
 	 * there is no need to protect it against removal races. The
 	 * use of debugfs_create_file_unsafe() is actually safe here.
 	 */
-	if (!debugfs_create_file_unsafe("kcov", 0600, NULL, NULL, &kcov_fops)) {
-		pr_err("failed to create kcov in debugfs\n");
-		return -ENOMEM;
-	}
+	debugfs_create_file_unsafe("kcov", 0600, NULL, NULL, &kcov_fops);
+
 	return 0;
 }
 
-- 
2.20.1

