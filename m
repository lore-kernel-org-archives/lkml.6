Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85490C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3312084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3312084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeLERCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:02:23 -0500
Received: from mail.netline.ch ([148.251.143.178]:43559 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbeLERCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:02:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 246082A604C;
        Wed,  5 Dec 2018 17:56:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id b476zuukV2dg; Wed,  5 Dec 2018 17:56:22 +0100 (CET)
Received: from kaveri (39.1.199.178.dynamic.wline.res.cust.swisscom.ch [178.199.1.39])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 892332A604B;
        Wed,  5 Dec 2018 17:56:22 +0100 (CET)
Received: from daenzer by kaveri with local (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1gUaTF-0001WN-UA; Wed, 05 Dec 2018 17:56:21 +0100
From:   =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm: Only #define DEBUG if CONFIG_DYNAMIC_DEBUG is disabled
Date:   Wed,  5 Dec 2018 17:56:20 +0100
Message-Id: <20181205165621.5805-1-michel@daenzer.net>
X-Mailer: git-send-email 2.20.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michel Dänzer <michel.daenzer@amd.com>

The following cases are possible for pr_debug():

1. CONFIG_DYNAMIC_DEBUG disabled
   a) DEBUG not defined: pr_debug() translates to no_printk(...), i.e.
      it never generates any output.
   b) DEBUG defined: pr_debug() translates to printk(KERN_DEBUG ...),
      i.e. it generates output which doesn't appear in dmesg by default,
      can be enabled dynamically.

2. CONFIG_DYNAMIC_DEBUG enabled: pr_debug() translates to
   dynamic_pr_debug()
   a) DEBUG not defined: dynamic_pr_debug() generates no output by
      default, can be enabled dynamically.
   b) DEBUG defined: dynamic_pr_debug() generates output by default,
      can be disabled dynamically.

The intention for drm_debug_printer() is to generate output which
doesn't appear in dmesg by default, but can be enabled dynamically, i.e.
cases 1b) and 2a). However, defining DEBUG unconditionally gave us 2b)
instead of 2a) with CONFIG_DYNAMIC_DEBUG enabled.

Fixes: 79a5ad2fdb3c ("drm: Enable pr_debug() for drm_printer")
Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
---
 drivers/gpu/drm/drm_print.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 0e7fc3e7dfb4..ee56e4a1b343 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -23,11 +23,13 @@
  * Rob Clark <robdclark@gmail.com>
  */
 
-#define DEBUG /* for pr_debug() */
-
 #include <stdarg.h>
 #include <linux/seq_file.h>
 #include <drm/drmP.h>
+
+#ifndef CONFIG_DYNAMIC_DEBUG
+#define DEBUG /* for pr_debug() */
+#endif
 #include <drm/drm_print.h>
 
 void __drm_puts_coredump(struct drm_printer *p, const char *str)
-- 
2.20.0.rc2

