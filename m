Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C05FC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619FD20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WXAdPrM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619FD20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJ3Pr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:47:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39122 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeJ3Pr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:47:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9U6rja0064348;
        Tue, 30 Oct 2018 06:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=ZasPdyyfMaoTYYtoXzlqo83MGm65M1bUrdZ9blzatFc=;
 b=WXAdPrM1pAhiZ75Pktqa646VDuk//nIyrReuwtNQuvJorg647W/H8RgiL0e+eJGvV1ni
 8E/L8qtaoPxjYDJ37WSHWJeruSLW7M6egJuAzSdQE7aRKfpkUfBLeh6hZImrYKgajqJJ
 R5GuPxODb4AHS69NeuEXjE/hShS3oDrosc3tBBqCf96zYEX2qj3/umyccT2f/b7tRJnw
 TOVBgrmplXqcUgGYPoXjg8l9iwjh9pGhkvjTw5ry3Y5c9XY9dqK1Cz+xoMlFj2YUZTVj
 VnpjiVNzqfrTHJkIgEfD81EikL/GQNtKgnmK2kDzlF17vM9liliJ7PjcFUM/+6TiobeJ 8g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ncgnqsxht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 06:55:07 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9U6t7A1021281
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 06:55:07 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9U6t6RZ030589;
        Tue, 30 Oct 2018 06:55:06 GMT
MIME-Version: 1.0
Message-ID: <dd9fce0a-e7e8-427b-bd11-7ec65ddb2ea7@default>
Date:   Mon, 29 Oct 2018 23:55:06 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     <mingo@redhat.com>, <konrad.wilk@oracle.com>, <dwmw@amazon.co.uk>,
        <tglx@linutronix.de>,
        Srinivas REDDY Eeda <srinivas.eeda@oracle.com>, <bp@suse.de>,
        <peterz@infradead.org>, <hpa@zytor.com>
Subject: [PATCH 2/3] retpolines: Remove the minimal stuff of retpoline support
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9061 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810300060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that CONFIG_RETPOLINE hard depends on compiler support, there is no
reason for minimal stuff to still exist.

This change is based on suggestion in https://lkml.org/lkml/2018/9/18/1016

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/include/asm/nospec-branch.h |  2 --
 arch/x86/kernel/cpu/bugs.c           | 13 ++-----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/no=
spec-branch.h
index 8b09cbb..c202a64 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -221,8 +221,6 @@
 /* The Spectre V2 mitigation variants */
 enum spectre_v2_mitigation {
 =09SPECTRE_V2_NONE,
-=09SPECTRE_V2_RETPOLINE_MINIMAL,
-=09SPECTRE_V2_RETPOLINE_MINIMAL_AMD,
 =09SPECTRE_V2_RETPOLINE_GENERIC,
 =09SPECTRE_V2_RETPOLINE_AMD,
 =09SPECTRE_V2_IBRS_ENHANCED,
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d0108fb..7f6d815 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -135,8 +135,6 @@ enum spectre_v2_mitigation_cmd {
=20
 static const char *spectre_v2_strings[] =3D {
 =09[SPECTRE_V2_NONE]=09=09=09=3D "Vulnerable",
-=09[SPECTRE_V2_RETPOLINE_MINIMAL]=09=09=3D "Vulnerable: Minimal generic AS=
M retpoline",
-=09[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]=09=3D "Vulnerable: Minimal AMD ASM r=
etpoline",
 =09[SPECTRE_V2_RETPOLINE_GENERIC]=09=09=3D "Mitigation: Full generic retpo=
line",
 =09[SPECTRE_V2_RETPOLINE_AMD]=09=09=3D "Mitigation: Full AMD retpoline",
 =09[SPECTRE_V2_IBRS_ENHANCED]=09=09=3D "Mitigation: Enhanced IBRS",
@@ -250,11 +248,6 @@ static void __init spec2_print_if_secure(const char *r=
eason)
 =09=09pr_info("%s selected on command line.\n", reason);
 }
=20
-static inline bool retp_compiler(void)
-{
-=09return __is_defined(CONFIG_RETPOLINE);
-}
-
 static inline bool match_option(const char *arg, int arglen, const char *o=
pt)
 {
 =09int len =3D strlen(opt);
@@ -417,14 +410,12 @@ static void __init spectre_v2_select_mitigation(void)
 =09=09=09pr_err("Spectre mitigation: LFENCE not serializing, switching to =
generic retpoline\n");
 =09=09=09goto retpoline_generic;
 =09=09}
-=09=09mode =3D retp_compiler() ? SPECTRE_V2_RETPOLINE_AMD :
-=09=09=09=09=09 SPECTRE_V2_RETPOLINE_MINIMAL_AMD;
+=09=09mode =3D SPECTRE_V2_RETPOLINE_AMD;
 =09=09setup_force_cpu_cap(X86_FEATURE_RETPOLINE_AMD);
 =09=09setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 =09} else {
 =09retpoline_generic:
-=09=09mode =3D retp_compiler() ? SPECTRE_V2_RETPOLINE_GENERIC :
-=09=09=09=09=09 SPECTRE_V2_RETPOLINE_MINIMAL;
+=09=09mode =3D SPECTRE_V2_RETPOLINE_GENERIC;
 =09=09setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 =09}
=20
--=20
1.8.3.1
