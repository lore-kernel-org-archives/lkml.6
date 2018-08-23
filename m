Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C51C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB6621564
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aPw7aH/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB6621564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeHWVXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:23:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeHWVXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pTwZEqK7L4HmY/ielVFKdHJ4fesrN/xdPijmlaOLLCE=; b=aPw7aH/DJqc3HINwbjlvbJAEy
        m2TQ1mIhXtz/FlMd9yKiEw4jYc6aVk5Gp3OuOAzGr/SD4h/j8m+CA8erIh+cUyjWRDWneRIfAulXg
        hi5Waq8gjt7YeVrQMcFD/89TEv8VvtHKFJTG2XiVA7fBGWmWN3pfUkOviRRSqPk99Zu+EKgbQ47xq
        QdoWEJuH2rvr3EnBOf5UTRUX2A4/tx2oENYapZ5s8j9JKRTErpbibjYJvREFMq0MVUPt6L8ZitTrp
        x1izut6MdobNI/FcFdXoecgLb9hPu9/dMaUrwS5qjTc98OEWxVwLC1/WaoXMZhHotlg89tVNOx3GU
        45yyWQ/wQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fstmh-0001yN-Ty; Thu, 23 Aug 2018 17:52:39 +0000
Subject: [PATCH v2] modules_install: make missing $DEPMOD a warning instead of
 error
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
References: <490A46D5-834E-46A9-9106-A31F94344F99@goldelico.com>
 <d5093e14-c826-9183-cd94-ecb99a799fc8@infradead.org>
 <CAK7LNAQDRj7aKMNqkTL3XxbsFHUuYwOaPn8buh=b9O9+CaKjig@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <61369202-8425-4cb7-aa9d-b83f15c528e0@infradead.org>
Date:   Thu, 23 Aug 2018 10:52:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQDRj7aKMNqkTL3XxbsFHUuYwOaPn8buh=b9O9+CaKjig@mail.gmail.com>
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
---
v2: add missing "exit 0" and update the commit message (no Error).

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

