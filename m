Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE35C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6E0255E8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xan1wICk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6E0255E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965236AbeGARMw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:12:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965010AbeGARMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x5kXwPwTXSAp5NRLmSnXsrEsbaqAPQxaKURKHvXJedo=; b=Xan1wICkXfDLY8zMeLEkPUJUt
        ZP3Mm4BKTLNLtaK/IFOR+3L2uWGfMfPL5uPgiLIYJMHgvHbaEhHyfl9v5jK8C35upXiK3C85b5J5e
        WxRqUIMapLPzHl7e8dGhIDOWjTCxp49TUIB4xCfPI/bRWMPcZ6kE+ty+fDGxra1PSFrU2DfTj6iMV
        Ja4rYBIuepOvrb6oUUDVyaczC5XT7ElwH9Zkn2a01kHIiWlIzbIBr+ZBtfo3Kndh/R80yPBX4kW/2
        owmpmYq0/Qk2G8tnPnR5i5S+BEDZmKLz3dob6najzfbXm0miVALcz0ddwUs1WcIRWWBaE1ijrlKDm
        Q6yAL+2Sw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZfu1-0001C5-Qr; Sun, 01 Jul 2018 17:12:45 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Michal Marek <michal.lkml@markovi.net>,
        Chih-Wei Huang <cwhuang@linux.org.tw>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kbuild: check for /sbin/depmod installed
Message-ID: <1df7f847-484c-a368-9dc2-50d191f8be9b@infradead.org>
Date:   Sun, 1 Jul 2018 10:12:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Verify that 'depmod' ($DEPMOD) is installed.
This is a partial revert of 620c231c7a7f (from 2012):
  ("kbuild: do not check for ancient modutils tools")

Fixes kernel bugzilla #198965:
https://bugzilla.kernel.org/show_bug.cgi?id=198965

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Chih-Wei Huang <cwhuang@linux.org.tw>
Cc: stable@vger.kernel.org # any kernel since 2012
---
 scripts/depmod.sh |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- lnx-418-rc2.orig/scripts/depmod.sh
+++ lnx-418-rc2/scripts/depmod.sh
@@ -10,10 +10,16 @@ fi
 DEPMOD=$1
 KERNELRELEASE=$2
 
-if ! test -r System.map -a -x "$DEPMOD"; then
+if ! test -r System.map ; then
 	exit 0
 fi
 
+if [ -z $(command -v $DEPMOD) ]; then
+	echo "'make *install' requires $DEPMOD. Please install it." >&2
+	echo "This is probably in the module-init-tools package." >&2
+	exit 1
+fi
+
 # older versions of depmod require the version string to start with three
 # numbers, so we cheat with a symlink here
 depmod_hack_needed=true


