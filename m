Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C88DECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7E72084E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="UiGZcpN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7E72084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbeGPNHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:07:05 -0400
Received: from services.gouders.net ([141.101.32.176]:36140 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbeGPNHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:07:05 -0400
Received: from lena.gouders.net ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w6GCdRnG011181
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 16 Jul 2018 14:39:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1531744778; bh=Pp7yxRotF0kC0fYRR8X3GkFpaswQe84KPuVwD7sYPxw=;
        h=From:To:Cc:Subject:Date;
        b=UiGZcpN/Q9vBniot+WReOrW52b8JdHvMXog+aa/k5yAL+Jc2vw7E4E9mwlkBY6428
         lFViJt/Eagu+4xRO9O0Jr9erJldlRGBwoqMXTlUslGt9OQDp5lzq4xaXfTvJGH6/S4
         h5OtMH7pJn1YFiWcu7JBIrh7m7bXHF3TXPHppioE=
From:   Dirk Gouders <dirk@gouders.net>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Dirk Gouders <dirk@gouders.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: if_changed: check for multiple calls in targets
Date:   Mon, 16 Jul 2018 14:39:02 +0200
Message-Id: <20180716123902.5337-1-dirk@gouders.net>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the kbuild function if_changed writes the command line to a
.cmd file for later tests, multiple calls of that function within a
target would result in overwrites of previous values and effectively
render the command line test meaningless, resulting in flip-flop
behaviour.

Produce an error for targets with multiple calls to if_changed.

Three examples that would now be detected:

98f78525371b55ccd (x86/boot: Refuse to build with data relocations)
6a8dfe1cac5c591ae (microblaze: support U-BOOT image format)
684151a75bf25f5ae (sparc32: added U-Boot build target: uImage)

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 447857ffaf6b..b0aadf23148e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2911,6 +2911,14 @@ sub process {
 			     "Use of $flag is deprecated, please use \`$replacement->{$flag} instead.\n" . $herecurr) if ($replacement->{$flag});
 		}
 
+		# Check for multiple calls of if_changed within a target in Makefiles
+		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
+		    ($prevline =~ /^[ +]\t\$\(call if_changed,/) &&
+		    ($line =~ /^[ +]\t\$\(call if_changed,/)) {
+				ERROR("MULTIPLE_IF_CHANGED",
+				      "Multiple calls of if_changed within a target.\n" . $herecurr);
+		}
+
 # check for DT compatible documentation
 		if (defined $root &&
 			(($realfile =~ /\.dtsi?$/ && $line =~ /^\+\s*compatible\s*=\s*\"/) ||
-- 
2.17.1

