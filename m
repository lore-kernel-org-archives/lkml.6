Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FD5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5A021722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5A021722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeH0KpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:45:09 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28784 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbeH0KpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:45:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41zN6h1v41z9ttmB;
        Mon, 27 Aug 2018 08:59:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id I1jt9baKNlhn; Mon, 27 Aug 2018 08:59:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41zN6h1P4Sz9ttlx;
        Mon, 27 Aug 2018 08:59:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 182EF8B7A5;
        Mon, 27 Aug 2018 08:59:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id y2kBnQE0Xfng; Mon, 27 Aug 2018 08:59:48 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E29D98B74B;
        Mon, 27 Aug 2018 08:59:47 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id AD9D4714FC; Mon, 27 Aug 2018 06:59:47 +0000 (UTC)
Message-Id: <392eeae782302ee8812a3c932a602035deed1609.1535351453.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] checkpatch: remove GCC_BINARY_CONSTANT warning
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 27 Aug 2018 06:59:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning was there to avoid the use of 0bxxx values
as they are not supported by gcc prior to v4.3

Since commit cafa0010cd51f ("Raise the minimum required gcc
version to 4.6"), it's not an issue anymore and using
such values can increase readability of code.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 scripts/checkpatch.pl | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5219280bf7ff..d98650790722 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4933,17 +4933,6 @@ sub process {
 		while ($line =~ m{($Constant|$Lval)}g) {
 			my $var = $1;
 
-#gcc binary extension
-			if ($var =~ /^$Binary$/) {
-				if (WARN("GCC_BINARY_CONSTANT",
-					 "Avoid gcc v4.3+ binary constant extension: <$var>\n" . $herecurr) &&
-				    $fix) {
-					my $hexval = sprintf("0x%x", oct($var));
-					$fixed[$fixlinenr] =~
-					    s/\b$var\b/$hexval/;
-				}
-			}
-
 #CamelCase
 			if ($var !~ /^$Constant$/ &&
 			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
-- 
2.13.3

