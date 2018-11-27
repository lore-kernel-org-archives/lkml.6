Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88699C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482262086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ng+sxjj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482262086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbeK1EON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:14:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36648 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbeK1EON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:14:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so3461011plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bLNvaoCCH05m2PTISfDtvUr4vGDUjtejnoxkkoIzmc0=;
        b=ng+sxjj4CQQC1GuUmoqJ0IWsj/psYeBJZ/1nK+/txS9PJQiwNaKIPPg79o/UfCFzwE
         QplL9x850zKlDLaxk/yXGOYGjGjBoAN2BncSTbXrYDtkvONXmUs8GYMCdIJ4yIwgKio9
         zkYBOmFKX2tsShaazLVFKRPhz2j/Avc4wOwW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bLNvaoCCH05m2PTISfDtvUr4vGDUjtejnoxkkoIzmc0=;
        b=a0HEmaUxuF8INbYXfEVPkvZigDTlGY/0v8StP2h1XQFoHwI4lCVxvbjQVKU8upkhgQ
         IvGn6sFJN12cIeySXAXanrGVZTqY6alJd8SdwsUpsdV2o8niNKOgItXgseO1GNP28Fuv
         k2Y3JkdWlRXA3HfBgrWWR+LYv2d8hmQWNs9jPDbnjnAGsEPN7iGBuw6wCe3LxpDHBZkh
         j1StehxTSJK9UcDlLDEgKJ67yAwRLhAR1f92NBht+1uuxVlm3qyIlimj76oiW9opuAHZ
         XAIeAFWhj+bpdEGDmuBDhiGgzU+QGsWPOsURLiISNUhwOtvArDjpZH1isFCbxepDjVut
         X/fA==
X-Gm-Message-State: AA+aEWYdzQHlqWK6m0oaro1HKxacypA3mlzuIpgJDmL6MgyBWGEU67tl
        I6kc/UK1Dt2jU+lyTcOlBEcAjg==
X-Google-Smtp-Source: AFSGD/VZK6/U5QKx0atWvx9RKBXjp3HYdW26581F2mH3o5vMKH63LK8+TNvrqSj/cF/w0QYtvv294Q==
X-Received: by 2002:a17:902:3383:: with SMTP id b3mr32687445plc.170.1543338939186;
        Tue, 27 Nov 2018 09:15:39 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z8sm5153904pgz.53.2018.11.27.09.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 09:15:38 -0800 (PST)
Date:   Tue, 27 Nov 2018 09:15:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lkdtm: Do not depend on BLOCK and clean up headers
Message-ID: <20181127171537.GA5300@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the transition to kprobes, symbols are resolved at runtime. This
means there is no need to have all the Kconfig and header logic to
avoid build failures. This also paves the way to having arbitrary test
locations.

Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/core.c | 9 ---------
 lib/Kconfig.debug         | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 2837dc77478e..5d41c2230d2e 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -37,16 +37,9 @@
 #include <linux/kprobes.h>
 #include <linux/list.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/hrtimer.h>
 #include <linux/slab.h>
-#include <scsi/scsi_cmnd.h>
 #include <linux/debugfs.h>
 
-#ifdef CONFIG_IDE
-#include <linux/ide.h>
-#endif
-
 #define DEFAULT_COUNT 10
 
 static int lkdtm_debugfs_open(struct inode *inode, struct file *file);
@@ -102,9 +95,7 @@ static struct crashpoint crashpoints[] = {
 	CRASHPOINT("MEM_SWAPOUT",	 "shrink_inactive_list"),
 	CRASHPOINT("TIMERADD",		 "hrtimer_start"),
 	CRASHPOINT("SCSI_DISPATCH_CMD",	 "scsi_dispatch_cmd"),
-# ifdef CONFIG_IDE
 	CRASHPOINT("IDE_CORE_CP",	 "generic_ide_ioctl"),
-# endif
 #endif
 };
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af29b8224fd..0dd65b4b2ad2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1685,7 +1685,6 @@ if RUNTIME_TESTING_MENU
 config LKDTM
 	tristate "Linux Kernel Dump Test Tool Module"
 	depends on DEBUG_FS
-	depends on BLOCK
 	help
 	This module enables testing of the different dumping mechanisms by
 	inducing system failures at predefined crash points.
-- 
2.17.1


-- 
Kees Cook
