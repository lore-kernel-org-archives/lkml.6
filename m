Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C392ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CCD20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="YKKPLOcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CCD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeGTIfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:35:39 -0400
Received: from services.gouders.net ([141.101.32.176]:54496 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeGTIfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:35:38 -0400
Received: from lena.gouders.net ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w6K7mGpI031540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 20 Jul 2018 09:48:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1532072908; bh=RC4mWJZYhMl7JHiAjT75Qx//tBV/boReNxyhISHoMpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YKKPLOcY2E80z9PPM/4YD/X3m451h/l/A28KuPSVLT4Rz+l1blBeu823sE9C2P31k
         dDoWoNIHfC2TOqBLeXNpnSfehanM5blHOYbz37/SBg1Vacaiun9VXNpTawt2xi1UNu
         FSytM3hjhbd46oKP0tIPV1bJ5Hn5dRtlL47shfXw=
From:   Dirk Gouders <dirk@gouders.net>
To:     Joe Perches <joe@perches.com>
Cc:     Dirk Gouders <dirk@gouders.net>,
        Andy Whitcroft <apw@canonical.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] checkpatch: kbuild: if_changed: check for multiple calls in targets
Date:   Fri, 20 Jul 2018 09:48:04 +0200
Message-Id: <20180720074804.4160-1-dirk@gouders.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <ghy3eafbrf.fsf@lena.gouders.net>
References: <ghy3eafbrf.fsf@lena.gouders.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kbuild function if_changed should not be called more than once for
a target.

Because that function writes the command line to a .cmd file for later
tests, multiple calls of it within a target would result in overwrites
of previous values and effectively render the command line test
meaningless, resulting in flip-flop behaviour.

Add a check for makefiles and kbuild files and produce an error for
targets with multiple calls to if_changed.

Three examples that now could be detected:

98f78525371b55ccd (x86/boot: Refuse to build with data relocations)
6a8dfe1cac5c591ae (microblaze: support U-BOOT image format)
684151a75bf25f5ae (sparc32: added U-Boot build target: uImage)

Reviewed-by: Joe Perches <joe@perches.com>
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
v2: rework commit message and regular expression
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 447857ffaf6b..437e98414f74 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2911,6 +2911,14 @@ sub process {
 			     "Use of $flag is deprecated, please use \`$replacement->{$flag} instead.\n" . $herecurr) if ($replacement->{$flag});
 		}
 
+		# Check for multiple calls of if_changed within a target in Makefiles
+		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
+		    ($prevline =~ /^[ +]\t\s*\$\(call\s+if_changed,/) &&
+		    ($line =~ /^[ +]\t\s*\$\(call\s+if_changed,/)) {
+				ERROR("MULTIPLE_IF_CHANGED",
+				      "Multiple calls of if_changed within a target.\n" . $herecurr);
+		}
+
 # check for DT compatible documentation
 		if (defined $root &&
 			(($realfile =~ /\.dtsi?$/ && $line =~ /^\+\s*compatible\s*=\s*\"/) ||
-- 
2.16.1

