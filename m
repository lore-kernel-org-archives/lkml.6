Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359AAC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3552081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fu1jrOVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3552081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeKERKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:10:25 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:62528 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeKERKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:10:25 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wA57prBd021536;
        Mon, 5 Nov 2018 16:51:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wA57prBd021536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541404313;
        bh=Ky64pjkITSG1WadKggZwWDNiCTTYsg8LtsnvMFTT3xc=;
        h=From:To:Cc:Subject:Date:From;
        b=fu1jrOVw4dkKdpNF7o8XtLFeEA+FhKXg0ASr6J5//Q26SPMMMm1KTrPw5X7L5JzQ1
         uyYJXaLgs/CFTqXQshdjpnnqlZEDrJ8ykoWFxODu5bkQwz5NO1lur2iepB/NRO4z9p
         4dPAJy1D5pMHHljkSOsDDw7H6NC71S0w3F7wkru9zMigXCYJePOPEsr4mDz8vyoi7i
         QjRiaUHWlmcEukdxfcrQMVquaYi2+5OFHBc2NgLLruUWgerAqj800eefMf2oLd/wF+
         gTMxp3wYEQ9NIINu+16to+FJs7yVthpTz82MfWArv9k7KsQWiYF5CmEIalgygr2nuq
         /GuZBV7c9LWCQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: rpm-pkg: fix binrpm-pkg breakage when O= is used
Date:   Mon,  5 Nov 2018 16:51:49 +0900
Message-Id: <1541404309-30210-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhenzhong Duan reported that running 'make O=/build/kernel binrpm-pkg'
failed with the following errors:

  Running 'make O=/build/kernel binrpm-pkg' failed with below two errors.

  Makefile:600: include/config/auto.conf: No such file or directory

  + cp make -C /mnt/root/kernel O=/build/kernel image_name make -f
  /mnt/root/kernel/Makefile ...
  cp: invalid option -- 'C'
  Try 'cp --help' for more information.

Prior to commit 80463f1b7bf9 ("kbuild: add --include-dir flag only
for out-of-tree build"), both objtree and srctree were added to
--include-dir, and the wrong code 'make image_name' was working
relying on that. Now, the potential issue that had previously been
hidden just showed up.

'make image_name' recurses to the generated $(objtree)/Makefile and
ends up with running in srctree, which is incorrect. It should be
invoked with '-f $srctree/Makefile' (or KBUILD_SRC=) to be executed
in objtree.

Fixes: 80463f1b7bf9 ("kbuild: add --include-dir flag only for out-of-tree build")
Reported-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/package/mkspec | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index e05646d..009147d 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -12,6 +12,7 @@
 # how we were called determines which rpms we build and how we build them
 if [ "$1" = prebuilt ]; then
 	S=DEL
+	MAKE="$MAKE -f $srctree/Makefile"
 else
 	S=
 fi
@@ -78,19 +79,19 @@ $S	%prep
 $S	%setup -q
 $S
 $S	%build
-$S	make %{?_smp_mflags} KBUILD_BUILD_VERSION=%{release}
+$S	$MAKE %{?_smp_mflags} KBUILD_BUILD_VERSION=%{release}
 $S
 	%install
 	mkdir -p %{buildroot}/boot
 	%ifarch ia64
 	mkdir -p %{buildroot}/boot/efi
-	cp \$(make image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
+	cp \$($MAKE image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
 	ln -s efi/vmlinuz-$KERNELRELEASE %{buildroot}/boot/
 	%else
-	cp \$(make image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
+	cp \$($MAKE image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
 	%endif
-$M	make %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} KBUILD_SRC= modules_install
-	make %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr KBUILD_SRC= headers_install
+$M	$MAKE %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} modules_install
+	$MAKE %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
 	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
 	cp .config %{buildroot}/boot/config-$KERNELRELEASE
 	bzip2 -9 --keep vmlinux
-- 
2.7.4

