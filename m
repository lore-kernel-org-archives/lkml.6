Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6512ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7F82086B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mLQanqBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7F82086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeIRKsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 06:48:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44568 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbeIRKsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 06:48:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8I5Dsj5030569;
        Tue, 18 Sep 2018 05:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=cdWcMx6ND7zzdPlSyfk60kJ95dLyBCyOh8iDiAfI9AM=;
 b=mLQanqBCHNcnX585srGiUXSfZmEWcSRYq9/IJibqXQiwPgaIK44a+EonvA884fDc39qT
 A3Kkorf8iRWQzeH7/iqHw+0bjyOR7g12pi/oWAHwF4zPYcRiXBP548KeOKxCaCcz4nVy
 59Ws3PVz8SOUNQ3K5PABoFYEP2NU7DhditjiSKhIH0fDDMLc6ZOAyW6Q6j8Q/Kh7Ecfi
 GTE1GHIii/UnscuytcJwEhCisBAxmRzWsLEtviXeMb8z+nJuCaLoapj+18f1S7q75yQc
 ezrXO+S8FSkOB8dnyx0adcnWptMMrp+HIbLiz1GclTNxl8x75RJwrRBzzUPpYUVMqceq YQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mgt1phyxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 05:17:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8I5HWLt029574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 05:17:32 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8I5HUYp032427;
        Tue, 18 Sep 2018 05:17:31 GMT
MIME-Version: 1.0
Message-ID: <87411705-893f-46d3-b899-b09ed9fa8d1b@default>
Date:   Mon, 17 Sep 2018 22:17:30 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     <mingo@redhat.com>, <konrad.wilk@oracle.com>, <x86@kernel.org>,
        <dwmw@amazon.co.uk>, <tglx@linutronix.de>,
        Srinivas REDDY Eeda <srinivas.eeda@oracle.com>, <bp@suse.de>,
        <hpa@zytor.com>
Subject: [PATCH] x86/speculation: Use AMD specific retpoline for inline asm on
 AMD
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9019 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=873
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809180053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lfence is preferred than general retpoline on AMD, add this option
in C / inline asm just as the ASM code does.

For x86_64, it still help to have minimal retpoline for kernel even
if gcc doesn't support it, change the inline asm for x86 so that it
could also be used by x86_64.

Add ANNOTATE_NOSPEC_ALTERNATIVE for i386 to avoid below warning:
"warning: objtool: .altinstr_replacement+0x10: unsupported
intra-function call"
"warning: objtool: If this is a retpoline, please patch it
in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE."

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 arch/x86/include/asm/nospec-branch.h |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/no=
spec-branch.h
index fd2a8c1..2d49eab 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -170,21 +170,26 @@
  */
 # define CALL_NOSPEC=09=09=09=09=09=09\
 =09ANNOTATE_NOSPEC_ALTERNATIVE=09=09=09=09\
-=09ALTERNATIVE(=09=09=09=09=09=09\
+=09ALTERNATIVE_2(=09=09=09=09=09=09\
 =09ANNOTATE_RETPOLINE_SAFE=09=09=09=09=09\
 =09"call *%[thunk_target]\n",=09=09=09=09\
 =09"call __x86_indirect_thunk_%V[thunk_target]\n",=09=09\
-=09X86_FEATURE_RETPOLINE)
+=09X86_FEATURE_RETPOLINE,=09=09=09=09=09\
+=09"lfence;\n"=09=09=09=09=09=09\
+=09ANNOTATE_RETPOLINE_SAFE=09=09=09=09=09\
+=09"call *%[thunk_target]\n",=09=09=09=09\
+=09X86_FEATURE_RETPOLINE_AMD)
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
=20
-#elif defined(CONFIG_X86_32) && defined(CONFIG_RETPOLINE)
+#elif defined(CONFIG_RETPOLINE)
 /*
  * For i386 we use the original ret-equivalent retpoline, because
  * otherwise we'll run out of registers. We don't care about CET
  * here, anyway.
  */
 # define CALL_NOSPEC=09=09=09=09=09=09\
-=09ALTERNATIVE(=09=09=09=09=09=09\
+=09ANNOTATE_NOSPEC_ALTERNATIVE=09=09=09=09\
+=09ALTERNATIVE_2(=09=09=09=09=09=09\
 =09ANNOTATE_RETPOLINE_SAFE=09=09=09=09=09\
 =09"call *%[thunk_target]\n",=09=09=09=09\
 =09"       jmp    904f;\n"=09=09=09=09=09\
@@ -194,12 +199,16 @@
 =09"    =09lfence;\n"=09=09=09=09=09\
 =09"       jmp    902b;\n"=09=09=09=09=09\
 =09"       .align 16\n"=09=09=09=09=09\
-=09"903:=09addl   $4, %%esp;\n"=09=09=09=09\
-=09"       pushl  %[thunk_target];\n"=09=09=09\
+=09"903:=09add   $4, %%" _ASM_SP ";\n"=09=09=09\
+=09"       push  %[thunk_target];\n"=09=09=09\
 =09"       ret;\n"=09=09=09=09=09=09\
 =09"       .align 16\n"=09=09=09=09=09\
 =09"904:=09call   901b;\n",=09=09=09=09\
-=09X86_FEATURE_RETPOLINE)
+=09X86_FEATURE_RETPOLINE,=09=09=09=09=09\
+=09"lfence;\n"=09=09=09=09=09=09\
+=09ANNOTATE_RETPOLINE_SAFE=09=09=09=09=09\
+=09"call *%[thunk_target]\n",=09=09=09=09\
+=09X86_FEATURE_RETPOLINE_AMD)
=20
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
 #else /* No retpoline for C / inline asm */
--=20
1.7.3
