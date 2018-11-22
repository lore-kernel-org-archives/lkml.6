Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7557C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6635720684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6635720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405496AbeKVVty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:49:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:59522 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405477AbeKVVty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:49:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 03:10:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,265,1539673200"; 
   d="scan'208";a="88380920"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga008.fm.intel.com with ESMTP; 22 Nov 2018 03:10:58 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTPS id 23C40202E4;
        Thu, 22 Nov 2018 13:10:57 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1gPms5-0005e5-9Y; Thu, 22 Nov 2018 13:10:09 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michael Forney <forney@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] headers_install.sh: Support __aligned(x) for uAPI headers
Date:   Thu, 22 Nov 2018 13:10:09 +0200
Message-Id: <20181122111009.21663-1-sakari.ailus@linux.intel.com>
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
index 593f8879c6410..9ed490f33a3ac 100755
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

