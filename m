Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3AFC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A752082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BosEaZ6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A752082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJ3Pr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:47:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39124 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbeJ3Pr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:47:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9U6rUqV064220;
        Tue, 30 Oct 2018 06:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=L3hPylc0rRV2wBjedQTZVcu/c0ihS12eOxda0ZXnqc8=;
 b=BosEaZ6PSB5vhvGhqEM2EUb110utZakCdSPkm3Zwq3yUYpOclo5BPjwOO0qmQvtGWeH9
 Fn9uxPmS7hdeqlzRKR0vNnFQ4YxyLbdXlZQiTQ3JWRLg0rTMTRZKOX+JpTtPOh0Eywmd
 WYkX64kugMU+FIvI6dWO/1w3nbgb3gAlCc1hmD19ypako1eEPngo1r3lJydG1TZbQvri
 onHKCEt5RNFWcHc+vp65bjV60MN3kF7OVoZwFFFF0NcOntEhamjdqx+H2x3/fHsGTZpU
 JX462N69EbCgoGThA4qJQRwW9ihEHHHFURwOaW5bGQ84sKhpBISr60PisDA4HXTWjNMl 2g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2ncgnqsxj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 06:55:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9U6t7dp007285
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 06:55:07 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9U6t6lM008483;
        Tue, 30 Oct 2018 06:55:06 GMT
MIME-Version: 1.0
Message-ID: <cc8f9981-f327-4238-8378-262579584db4@default>
Date:   Mon, 29 Oct 2018 23:55:06 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     <mingo@redhat.com>, <konrad.wilk@oracle.com>, <dwmw@amazon.co.uk>,
        <tglx@linutronix.de>,
        Srinivas REDDY Eeda <srinivas.eeda@oracle.com>, <bp@suse.de>,
        <peterz@infradead.org>, <hpa@zytor.com>
Subject: [PATCH 3/3] kprobes/x86: Simplify indirect-jump check in retpoline
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

Since CONFIG_RETPOLINE hard depends on compiler support now, so
replacing indirect-jump check with the range check is safe in that case.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/kernel/kprobes/opt.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 40b16b2..1136b29 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -203,6 +203,7 @@ static int copy_optimized_instructions(u8 *dest, u8 *sr=
c, u8 *real)
 =09return len;
 }
=20
+#ifndef CONFIG_RETPOLINE
 /* Check whether insn is indirect jump */
 static int __insn_is_indirect_jump(struct insn *insn)
 {
@@ -210,6 +211,7 @@ static int __insn_is_indirect_jump(struct insn *insn)
 =09=09(X86_MODRM_REG(insn->modrm.value) & 6) =3D=3D 4) || /* Jump */
 =09=09insn->opcode.bytes[0] =3D=3D 0xea);=09/* Segment based jump */
 }
+#endif
=20
 /* Check whether insn jumps into specified address range */
 static int insn_jump_into_range(struct insn *insn, unsigned long start, in=
t len)
@@ -240,20 +242,16 @@ static int insn_jump_into_range(struct insn *insn, un=
signed long start, int len)
=20
 static int insn_is_indirect_jump(struct insn *insn)
 {
-=09int ret =3D __insn_is_indirect_jump(insn);
+=09int ret;
=20
 #ifdef CONFIG_RETPOLINE
-=09/*
-=09 * Jump to x86_indirect_thunk_* is treated as an indirect jump.
-=09 * Note that even with CONFIG_RETPOLINE=3Dy, the kernel compiled with
-=09 * older gcc may use indirect jump. So we add this check instead of
-=09 * replace indirect-jump check.
-=09 */
-=09if (!ret)
+=09/* Jump to x86_indirect_thunk_* is treated as an indirect jump. */
 =09=09ret =3D insn_jump_into_range(insn,
 =09=09=09=09(unsigned long)__indirect_thunk_start,
 =09=09=09=09(unsigned long)__indirect_thunk_end -
 =09=09=09=09(unsigned long)__indirect_thunk_start);
+#else
+=09=09ret =3D __insn_is_indirect_jump(insn);
 #endif
 =09return ret;
 }
--=20
1.8.3.1
