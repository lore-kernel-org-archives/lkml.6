Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DADC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAD92082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zq4ZxR2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAD92082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeKBUcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:32:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33810 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBUcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:32:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA2BOISK015038;
        Fri, 2 Nov 2018 11:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=LRLpuofZrBJiGm2oYNzmyqEO9RpsM9D96kgljpEoBao=;
 b=zq4ZxR2r56sjpms3axzZRjsTVmsvChxJWWBoWAHgBFXEsBavGu6vWTtlfy3NUnVzo+13
 BcbDo7pddDPtjwRtVJMl9VjWYMbR0PZqt+Grp1/NCNvYgM0juemGoUPtAu5cZxqXPFC7
 j5AiLfE7zOkKk9Nu8qcFYx8bkytOZM1qRl1v0odTKgxac6uwUxGNifMuAQ+QbGs6ZnHW
 RZqy5l8XKt/OM7XrREtecwganvwhFkaHB1wE5SdPDdytSGQ2hQEFoyJAPx/nesESoDz+
 EwpTn9y4DFze1o1PBtP+uPyXNqqi0ufxGuCzR+aRRem/NiWqL3JxkIOKmdwnOZKBnKzH wQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2ncgnrdx53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Nov 2018 11:25:56 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA2BPtSN021382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Nov 2018 11:25:55 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA2BPsVZ007983;
        Fri, 2 Nov 2018 11:25:54 GMT
MIME-Version: 1.0
Message-ID: <3e40ec15-3a8c-444d-8d32-35ef587f3980@default>
Date:   Fri, 2 Nov 2018 04:25:54 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     <linux-kernel@vger.kernel.org>, <linux-kbuild@vger.kernel.org>
Cc:     Srinivas REDDY Eeda <srinivas.eeda@oracle.com>,
        <yamada.masahiro@socionext.com>, <michal.lkml@markovi.net>
Subject: [PATCH] kbuild: rpm-pkg: fix two build breaks when O= is used
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9064 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=889
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811020107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running 'make O=3D/build/kernel binrpm-pkg' failed with below two errors.

Makefile:600: include/config/auto.conf: No such file or directory

+ cp make -C /mnt/root/kernel O=3D/build/kernel image_name make -f
/mnt/root/kernel/Makefile ...
cp: invalid option -- 'C'
Try 'cp --help' for more information.

Export KBUILD_OUTPUT when O=3D is used so that it could be used in locating
include/config/auto.conf

Use $srctree to locate source dir when generating image name, no matter
if O=3D is used.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 Makefile               | 5 +++++
 scripts/package/mkspec | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9aa352b..df316e5 100644
--- a/Makefile
+++ b/Makefile
@@ -135,6 +135,7 @@ KBUILD_OUTPUT :=3D $(shell mkdir -p $(KBUILD_OUTPUT) &&=
 cd $(KBUILD_OUTPUT) \
 $(if $(KBUILD_OUTPUT),, \
      $(error failed to create output directory "$(saved-output)"))
=20
+export KBUILD_OUTPUT
 # Look for make include files relative to root of kernel src
 #
 # This does not become effective immediately because MAKEFLAGS is re-parse=
d
@@ -597,7 +598,11 @@ virt-y=09=09:=3D virt/
 endif # KBUILD_EXTMOD
=20
 ifeq ($(dot-config),1)
+ifeq ($(KBUILD_OUTPUT),)
 include include/config/auto.conf
+else
+include $(KBUILD_OUTPUT)/include/config/auto.conf
+endif
 endif
=20
 # The all: target is the default when no target is given on the
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index e05646d..3b4e5e4 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -84,10 +84,10 @@ $S
 =09mkdir -p %{buildroot}/boot
 =09%ifarch ia64
 =09mkdir -p %{buildroot}/boot/efi
-=09cp \$(make image_name) %{buildroot}/boot/efi/vmlinuz-$KERNELRELEASE
+=09cp \$(make -C \$srctree image_name) %{buildroot}/boot/efi/vmlinuz-$KERN=
ELRELEASE
 =09ln -s efi/vmlinuz-$KERNELRELEASE %{buildroot}/boot/
 =09%else
-=09cp \$(make image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
+=09cp \$(make -C \$srctree image_name) %{buildroot}/boot/vmlinuz-$KERNELRE=
LEASE
 =09%endif
 $M=09make %{?_smp_mflags} INSTALL_MOD_PATH=3D%{buildroot} KBUILD_SRC=3D mo=
dules_install
 =09make %{?_smp_mflags} INSTALL_HDR_PATH=3D%{buildroot}/usr KBUILD_SRC=3D =
headers_install
--=20
1.8.3.1
