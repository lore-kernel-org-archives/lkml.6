Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1FDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C50D21473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C50D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbeHPVoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:44:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbeHPVoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:44:01 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B9E5FCB7;
        Thu, 16 Aug 2018 18:43:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.4 05/13] kbuild: verify that $DEPMOD is installed
Date:   Thu, 16 Aug 2018 20:41:52 +0200
Message-Id: <20180816171628.796560029@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171628.554317013@linuxfoundation.org>
References: <20180816171628.554317013@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

commit 934193a654c1f4d0643ddbf4b2529b508cae926e upstream.

Verify that 'depmod' ($DEPMOD) is installed.
This is a partial revert of commit 620c231c7a7f
("kbuild: do not check for ancient modutils tools").

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
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/Changes |   17 ++++++-----------
 scripts/depmod.sh     |    8 +++++++-
 2 files changed, 13 insertions(+), 12 deletions(-)

--- a/Documentation/Changes
+++ b/Documentation/Changes
@@ -25,7 +25,7 @@ o  GNU C                  3.2
 o  GNU make               3.80                    # make --version
 o  binutils               2.12                    # ld -v
 o  util-linux             2.10o                   # fdformat --version
-o  module-init-tools      0.9.10                  # depmod -V
+o  kmod                   13                      # depmod -V
 o  e2fsprogs              1.41.4                  # e2fsck -V
 o  jfsutils               1.1.3                   # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V
@@ -132,12 +132,6 @@ is not build with CONFIG_KALLSYMS and yo
 reproduce the Oops with that option, then you can still decode that Oops
 with ksymoops.
 
-Module-Init-Tools
------------------
-
-A new module loader is now in the kernel that requires module-init-tools
-to use.  It is backward compatible with the 2.4.x series kernels.
-
 Mkinitrd
 --------
 
@@ -319,14 +313,15 @@ Util-linux
 ----------
 o  <ftp://ftp.kernel.org/pub/linux/utils/util-linux/>
 
+Kmod
+----
+o  <https://www.kernel.org/pub/linux/utils/kernel/kmod/>
+o  <https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git>
+
 Ksymoops
 --------
 o  <ftp://ftp.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/>
 
-Module-Init-Tools
------------------
-o  <ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules/>
-
 Mkinitrd
 --------
 o  <https://code.launchpad.net/initrd-tools/main>
--- a/scripts/depmod.sh
+++ b/scripts/depmod.sh
@@ -10,10 +10,16 @@ DEPMOD=$1
 KERNELRELEASE=$2
 SYMBOL_PREFIX=$3
 
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
 # older versions of depmod don't support -P <symbol-prefix>
 # support was added in module-init-tools 3.13
 if test -n "$SYMBOL_PREFIX"; then


