Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F0FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C892075E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C892075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbeGLM7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:59:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:39614 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbeGLM7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:59:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 05:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,343,1526367600"; 
   d="scan'208";a="55991527"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga007.jf.intel.com with SMTP; 12 Jul 2018 05:50:14 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 12 Jul 2018 15:50:13 +0300
From:   Ville Syrjala <ville.syrjala@linux.intel.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [RFC][PATCH] kconfig: Add "m or y" and "y or m" answers for oldconfig
Date:   Thu, 12 Jul 2018 15:50:13 +0300
Message-Id: <20180712125013.14285-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Make it possible to answer "m or y" or "y or m" to
oldconfig so that scripted kernel builds can easily
enable new features not present in the existing .config.

The particular use case I have in mind is continuous integration
where you probably want to test build any new features. Currently
you would have to either blindly try both 'y' and 'm' answers
or parse the output to know which one will be accepted.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 scripts/kconfig/conf.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 671ff5364497..8038f9a6b9f4 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -201,15 +201,33 @@ static int conf_sym(struct menu *menu)
 			continue;
 		case 'm':
 		case 'M':
-			newval = mod;
-			if (!line[1])
+			if (!strcmp(line, "m or y") ||
+			    !strcmp(line, "M or Y")) {
+				if (sym_tristate_within_range(sym, mod))
+					newval = mod;
+				else
+					newval = yes;
 				break;
+			} else {
+				newval = mod;
+				if (!line[1])
+					break;
+			}
 			continue;
 		case 'y':
 		case 'Y':
-			newval = yes;
-			if (!line[1] || !strcmp(&line[1], "es"))
+			if (!strcmp(line, "y or m") ||
+			    !strcmp(line, "Y or M")) {
+				if (sym_tristate_within_range(sym, yes))
+					newval = yes;
+				else
+					newval = mod;
 				break;
+			} else {
+				newval = yes;
+				if (!line[1] || !strcmp(&line[1], "es"))
+					break;
+			}
 			continue;
 		case 0:
 			newval = oldval;
-- 
2.16.4

