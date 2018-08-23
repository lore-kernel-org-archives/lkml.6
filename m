Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE20C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FFF21566
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IQWL65TV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FFF21566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeHWVoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:44:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55028 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeHWVoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H8yrnYW3IXgnmy0c5LJcQAxczCJoIO7+FQgJh0VZRlM=; b=IQWL65TVXHC3AMO96xiFqSsHh
        z6IUD5LZNZV0ra0ProqWNLvGbqZh+baVW0Wya7vpY1tvJUBwRNpmVq1jzB5hIE8qaOkniGsGODlw2
        jHA+AIKVHb/RHMkxSsQThE+QbKxFotChJVCXHcaJEu+5jUB6IatO12zS0VmtSzGdn2mqBHu7RAFPJ
        KkunfGA3HFHVsL++HWqAR/mRe9aHaS3wfMW/lS2/jDk5tbGAJCdb0rz6sJ4meEQV1VyC3laPgkGjR
        fyI3X/P91OzXTa0qoCq1cFNgF1YYrrTNECmhPop0PaglWkHgGe9FJihLRp7wLacFHRs+2GSjPV5S7
        CGVh1lZug==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsu7K-00033W-51; Thu, 23 Aug 2018 18:13:58 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3] modules_install: make missing $DEPMOD a warning instead of
 an error
Message-ID: <4449cd91-fae5-caf1-a917-82e0c5f0aba8@infradead.org>
Date:   Thu, 23 Aug 2018 11:13:57 -0700
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
with an error message and error status.

Warning: 'make modules_install' requires /sbin/depmod. Please install it.
This is probably in the kmod package.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 934193a654c1 ("kbuild: verify that $DEPMOD is installed")
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

