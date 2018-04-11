Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeDKSPa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 14:15:30 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34772 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeDKSP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 14:15:29 -0400
X-Google-Smtp-Source: AIpwx4/7hARMHdvF32v830ADT1DOnm/X/nzWs04MbOCDweJMYqT/UOcbTWIHV/mh+EcWBOp83t/inA==
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Jones <pjones@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: rpm-pkg: use kernel-install as a fallback for new-kernel-pkg
Date: Wed, 11 Apr 2018 20:15:24 +0200
Message-Id: <20180411181525.23902-1-javierm@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new-kernel-pkg script is only present when grubby is installed, but it
may not always be the case. So if the script isn't present, attempt to use
the kernel-install script as a fallback instead.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

 scripts/package/mkspec | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 61427c6f2209..e05646dc24dc 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -118,6 +118,8 @@ $S$M	ln -sf /usr/src/kernels/$KERNELRELEASE source
 	%preun
 	if [ -x /sbin/new-kernel-pkg ]; then
 	new-kernel-pkg --remove $KERNELRELEASE --rminitrd --initrdfile=/boot/initramfs-$KERNELRELEASE.img
+	elif [ -x /usr/bin/kernel-install ]; then
+	kernel-install remove $KERNELRELEASE
 	fi
 
 	%postun
-- 
2.14.3
