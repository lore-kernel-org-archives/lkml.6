Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B00C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF372088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OSBJxSqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF372088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeH1Xw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:52:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46198 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbeH1Xw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RqlT9UoZGGguMxi6s1wQDNc8RkFqwZPH6cYvIHEMh40=; b=OSBJxSqp0mp3sjGZuqj6+DFlKx
        0G+fjAZAQKDnQcMzq16kWRrMa+pEz/roh7HmnJHMBH38ein5vK7TecckI6Ivq3SrHqCCkgm4EEEq2
        /+2TRgqLlKid2yz0SnB8EA8tKChrOS8vY/2ODRH1fK9jH9Rv4QnFTsNemgpeu5EnS06046GaihTAa
        HYcNIu7ztKEqWeNPVRW2ChMKn616xGrsspTsswvkChWxZKa6jQ8gB62fDTiZAShbe2t7sMR+FG+7s
        E9yTGackXsyrcZtZ9wyn8W46eSvAKww6PZBHwbENEDEdnbsy1xvmMMdZkXMboX3JR0KQUOYuFO4FM
        lkgJ6s4Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuk8u-0004kD-Nv; Tue, 28 Aug 2018 19:59:13 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>, stable@vger.kernel.org,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4] modules_install: make missing $DEPMOD a Warning instead of
 an Error
Message-ID: <07334982-98f0-561e-f8a1-ba42e36da80e@infradead.org>
Date:   Tue, 28 Aug 2018 12:59:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

When $DEPMOD is not found, only print a warning instead of exiting
with an error message and error status:

Warning: 'make modules_install' requires /sbin/depmod. Please install it.
This is probably in the kmod package.

Change the Error to a Warning because "not all build hosts for cross
compiling Linux are Linux systems and are able to provide a working
port of depmod, especially at the file patch /sbin/depmod."

I.e., "make modules_install" may be used to copy/install the
loadable modules files to a target directory on a build system and
then transferred to an embedded device where /sbin/depmod is run
instead of it being run on the build system.

Fixes: 934193a654c1 ("kbuild: verify that $DEPMOD is installed")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Chih-Wei Huang <cwhuang@linux.org.tw>
Cc: H. Nikolaus Schaller <hns@goldelico.com>
---
v2: add missing "exit 0" and update the commit message (no Error).
v3: add Fixes: and Cc: stable
v4: add Reported-by: and more explanation for the patch.

 scripts/depmod.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-418.orig/scripts/depmod.sh
+++ lnx-418/scripts/depmod.sh
@@ -15,9 +15,9 @@ if ! test -r System.map ; then
 fi
 
 if [ -z $(command -v $DEPMOD) ]; then
-	echo "'make modules_install' requires $DEPMOD. Please install it." >&2
+	echo "Warning: 'make modules_install' requires $DEPMOD. Please install it." >&2
 	echo "This is probably in the kmod package." >&2
-	exit 1
+	exit 0
 fi
 
 # older versions of depmod require the version string to start with three


