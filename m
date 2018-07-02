Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DE6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68146256F9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UkDJ3o2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68146256F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933197AbeGBCqY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:46:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753092AbeGBCqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xAWqTSOGybjnvQmO55Epnh/ke6CGEzz986bkXT/RCko=; b=UkDJ3o2lA9ArXLBLLnifA9ysr
        L/m2q4GGxnpFT5hB8iKQB4fQaSZBkz+UZdNdH933bpEnITCjxK4iDW2nzCYvgurFwgXTJaDlpUudo
        rmHaVxFYVD28vBwTN1DYeImcIuS7SXDHoMi51JznOIAMKX1p4PcMSZ3XAJfK14lErCpE/GHXi68ko
        9OKa9kvvXNUWYbzzSV+Mu1aBmJerP6ZZof8vf5fK9CbsLeWs6AozyNlkbpMu8Hd0YSRNvYXsRs6X1
        IkK1KI6/GKngUY9KMcchqEXImkj76ny8VGshgLFlc8aNw8cll4nifM38NKHRP6vJg27GIGhQ8nqiY
        334B38SoQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZoqu-0000kc-3H; Mon, 02 Jul 2018 02:46:08 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] kbuild: verify that $DEPMOD is installed
Message-ID: <53a0c9d4-cf1c-fbcf-3706-742f5ad41178@infradead.org>
Date:   Sun, 1 Jul 2018 19:46:06 -0700
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

Also update Documentation/process/changes.rst to refer to
kmod instead of module-init-tools.

Fixes kernel bugzilla #198965:
https://bugzilla.kernel.org/show_bug.cgi?id=198965

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Chih-Wei Huang <cwhuang@linux.org.tw>
Cc: stable@vger.kernel.org # any kernel since 2012
---
v2:
- spell out that modules_install requires $DEPMOD
- remove references to module-init-tools from
  Documentation/process/changes.rst and add kmod

 Documentation/process/changes.rst |   19 +++++++------------
 scripts/depmod.sh                 |    8 +++++++-
 2 files changed, 14 insertions(+), 13 deletions(-)

--- lnx-418-rc3.orig/scripts/depmod.sh
+++ lnx-418-rc3/scripts/depmod.sh
@@ -10,10 +10,16 @@ fi
 DEPMOD=$1
 KERNELRELEASE=$2
 
-if ! test -r System.map -a -x "$DEPMOD"; then
+if ! test -r System.map ; then
 	exit 0
 fi
 
+if [ -z $(command -v $DEPMOD) ]; then
+	echo "'make modules_install' requires $DEPMOD. Please install it." >&2
+	echo "This is probably in the kmod package." >&2
+	exit 1
+fi
+
 # older versions of depmod require the version string to start with three
 # numbers, so we cheat with a symlink here
 depmod_hack_needed=true
--- lnx-418-rc3.orig/Documentation/process/changes.rst
+++ lnx-418-rc3/Documentation/process/changes.rst
@@ -35,7 +35,7 @@ binutils               2.20
 flex                   2.5.35           flex --version
 bison                  2.0              bison --version
 util-linux             2.10o            fdformat --version
-module-init-tools      0.9.10           depmod -V
+kmod                   13               depmod -V
 e2fsprogs              1.41.4           e2fsck -V
 jfsutils               1.1.3            fsck.jfs -V
 reiserfsprogs          3.6.3            reiserfsck -V
@@ -156,12 +156,6 @@ is not build with ``CONFIG_KALLSYMS`` an
 reproduce the Oops with that option, then you can still decode that Oops
 with ksymoops.
 
-Module-Init-Tools
------------------
-
-A new module loader is now in the kernel that requires ``module-init-tools``
-to use.  It is backward compatible with the 2.4.x series kernels.
-
 Mkinitrd
 --------
 
@@ -371,16 +365,17 @@ Util-linux
 
 - <https://www.kernel.org/pub/linux/utils/util-linux/>
 
+Kmod
+----
+
+- <https://www.kernel.org/pub/linux/utils/kernel/kmod/>
+- <https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git>
+
 Ksymoops
 --------
 
 - <https://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/>
 
-Module-Init-Tools
------------------
-
-- <https://www.kernel.org/pub/linux/utils/kernel/module-init-tools/>
-
 Mkinitrd
 --------
 

