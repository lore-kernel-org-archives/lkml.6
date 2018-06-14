Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C4C98C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AD72086A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AD72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755533AbeFNQJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:09:33 -0400
Received: from osg.samsung.com ([64.30.133.232]:43890 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755243AbeFNQJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:09:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 24A5A20F17;
        Thu, 14 Jun 2018 09:09:29 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W_mk4Lniad5y; Thu, 14 Jun 2018 09:09:28 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.114.220.dynamic.adsl.gvt.net.br [177.41.114.220])
        by osg.samsung.com (Postfix) with ESMTPSA id 9515A20EA8;
        Thu, 14 Jun 2018 09:09:16 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fTUoE-0005TB-7T; Thu, 14 Jun 2018 13:09:14 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 14/27] scripts/documentation-file-ref-check: get rid of false-positives
Date:   Thu, 14 Jun 2018 13:08:59 -0300
Message-Id: <3a5376cd3cd95b8c72fcdeb4dba4b83354f215d4.1528990947.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the number of broken refs are smaller, improve the logic
that gets rid of false-positives.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/documentation-file-ref-check | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
index d132f756d31d..047f463cdf4b 100755
--- a/scripts/documentation-file-ref-check
+++ b/scripts/documentation-file-ref-check
@@ -38,16 +38,31 @@ while (<IN>) {
 	my $f = $1;
 	my $ln = $2;
 
-	# Makefiles contain nasty expressions to parse docs
-	next if ($f =~ m/Makefile/);
+	# Makefiles and scripts contain nasty expressions to parse docs
+	next if ($f =~ m/Makefile/ || $f =~ m/\.sh$/);
+
 	# Skip this script
 	next if ($f eq $scriptname);
 
-	if ($ln =~ m,\b(\S*)(Documentation/[A-Za-z0-9\_\.\,\~/\*\[\]\?+-]*),) {
+	if ($ln =~ m,\b(\S*)(Documentation/[A-Za-z0-9\_\.\,\~/\*\[\]\?+-]*)(.*),) {
 		my $prefix = $1;
 		my $ref = $2;
 		my $base = $2;
+		my $extra = $3;
 
+		# some file references are like:
+		# /usr/src/linux/Documentation/DMA-{API,mapping}.txt
+		# For now, ignore them
+		next if ($extra =~ m/^{/);
+
+		# Remove footnotes at the end like:
+		# Documentation/devicetree/dt-object-internal.txt[1]
+		$ref =~ s/(txt|rst)\[\d+]$/$1/;
+
+		# Remove ending ']' without any '['
+		$ref =~ s/\].*// if (!($ref =~ m/\[/));
+
+		# Remove puntuation marks at the end
 		$ref =~ s/[\,\.]+$//;
 
 		my $fulref = "$prefix$ref";
-- 
2.17.1

