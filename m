Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33E9C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8127E22AC6
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8127E22AC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932778AbeGGAQQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 20:16:16 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:58102 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeGGAQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 20:16:14 -0400
Received: from 89-71-158-145.dynamic.chello.pl ([89.71.158.145] helo=umbar.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1fbatC-0000bG-L3; Sat, 07 Jul 2018 02:15:55 +0200
Received: from kilobyte by umbar.angband.pl with local (Exim 4.91)
        (envelope-from <kilobyte@umbar.angband.pl>)
        id 1fbatB-0005hR-TB; Sat, 07 Jul 2018 02:15:49 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org,
        Paul Menzel <pmenzel+linux-kernel@molgen.mpg.de>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Sat,  7 Jul 2018 02:15:48 +0200
Message-Id: <20180707001548.21854-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.18.0
X-SA-Exim-Connect-IP: 89.71.158.145
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH resend] scripts: teach extract-vmlinux about LZ4 and ZSTD
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that the LZ4 signature is different than that of modern LZ4 as we
use the "legacy" format which suffers from some downsides like inability
to disable compression.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
The first time this was sent I managed to screw up both the subject and
scissors line, so it's likely whatever filter you're using didn't notice
the patch inside a thread.

ZSTD compression for vmlinux is not yet in, but being able to unpack it
can't hurt.  LZ4 is in for quite a while.


 scripts/extract-vmlinux | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/extract-vmlinux b/scripts/extract-vmlinux
index 5061abcc2540..e6239f39abad 100755
--- a/scripts/extract-vmlinux
+++ b/scripts/extract-vmlinux
@@ -57,6 +57,8 @@ try_decompress '\3757zXZ\000' abcde unxz
 try_decompress 'BZh'          xy    bunzip2
 try_decompress '\135\0\0\0'   xxx   unlzma
 try_decompress '\211\114\132' xy    'lzop -d'
+try_decompress '\002!L\030'   xxx   'lz4 -d'
+try_decompress '(\265/\375'   xxx   unzstd
 
 # Bail out:
 echo "$me: Cannot find vmlinux." >&2
-- 
2.18.0

