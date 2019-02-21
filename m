Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3C820855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfBUN26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:28:58 -0500
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:51306 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725845AbfBUN26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:28:58 -0500
Received: from lanttu.localdomain (lanttu.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::c1:2])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id D1E80634C7B;
        Thu, 21 Feb 2019 15:28:44 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michael Forney <forney@google.com>, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/1] headers_install.sh: Support __aligned(x) for uAPI headers
Date:   Thu, 21 Feb 2019 15:28:53 +0200
Message-Id: <20190221132853.32043-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The headers-install.sh already supports __packed conversion to
__attribute__((packed)) for uAPI headers but it does not support similar
__aligned(x) conversion.

Add support for __aligned(x).

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 scripts/headers_install.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index 593f8879c641..9ed490f33a3a 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -36,6 +36,7 @@ do
 		-e 's/__attribute_const__([[:space:]]|$)/\1/g' \
 		-e 's@^#include <linux/compiler(|_types).h>@@' \
 		-e 's/(^|[^a-zA-Z0-9])__packed([^a-zA-Z0-9_]|$)/\1__attribute__((packed))\2/g' \
+		-e 's/(^|[^a-zA-Z0-9])__aligned(\([0-9 ]*\))([^a-zA-Z0-9_]|$)/\1__attribute__((aligned\2))\3/g' \
 		-e 's/(^|[[:space:](])(inline|asm|volatile)([[:space:](]|$)/\1__\2__\3/g' \
 		-e 's@#(ifndef|define|endif[[:space:]]*/[*])[[:space:]]*_UAPI@#\1 @' \
 		"$SRCDIR/$i" > "$OUTDIR/$FILE.sed" || exit 1
-- 
2.11.0

