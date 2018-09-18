Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B228C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DD3214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r0+MPGou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DD3214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbeIRUSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:18:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36254 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeIRUSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:18:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8IEikxl140102;
        Tue, 18 Sep 2018 14:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=JJ9oRzm3p75bA1zb7y6gGPfXcxkB66BT/pPAdPc9118=;
 b=r0+MPGoudwA3HT6xTuweWktV1w/wH0x/HspcDtcFIRC/MVlrG/HxmAeHzjE/e3JxNEOj
 0kh32SEgSMaXs4jkxRybFKirOLy44G3p8xY7lt5icoIThM0f6tIJj/KjLjsGi5K9C2n3
 vWygEj9NCiKzBhi6+gqGuKlZH3Lp8i5u/HRs69+i4p+3kl9fmKT9BlEVbxlGiPSPPv2K
 sM/hl9E9lyqzNJ5whYDwjtO5zvXzFM6ekfbefyYoD/mAX90R6hwhQR6WHmK5BowgXfai
 5iho+m0HPrJ4QerZpGxx9wxyX2FHKFlKGBzH0qx+WufrCaV7HxzHLkYEwWhs0oCWYgdK ow== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mgsgtn1r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 14:45:03 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8IEj27r016466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 14:45:02 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8IEj15Y022171;
        Tue, 18 Sep 2018 14:45:01 GMT
MIME-Version: 1.0
Message-ID: <c3975665-173e-4d70-8dee-06c926ac26ee@default>
Date:   Tue, 18 Sep 2018 07:45:00 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     <mingo@redhat.com>, <dhaval.giani@oracle.com>,
        <konrad.wilk@oracle.com>, <x86@kernel.org>, <tglx@linutronix.de>,
        <dwmw@amazon.co.uk>, <bp@suse.de>, <srinivas.eeda@oracle.com>,
        <hpa@zytor.com>
Subject: [PATCH v2] x86/speculation: Add RETPOLINE_AMD support to the
 inline-asm CALL_NOSPEC
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9019 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=831
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809180148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

..so that they match the asm CALL_NOSPEC.

Add the missing ANNOTATE_NOSPEC_ALTERNATIVE in CALL_NOSPEC.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 arch/x86/include/asm/nospec-branch.h |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/no=
spec-branch.h
index b5b6f8c..b0e80e0 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -170,11 +170,15 @@
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
 #elif defined(CONFIG_X86_32) && defined(CONFIG_RETPOLINE)
@@ -184,7 +188,8 @@
  * here, anyway.
  */
 # define CALL_NOSPEC=09=09=09=09=09=09\
-=09ALTERNATIVE(=09=09=09=09=09=09\
+=09ANNOTATE_NOSPEC_ALTERNATIVE=09=09=09=09\
+=09ALTERNATIVE_2(=09=09=09=09=09=09\
 =09ANNOTATE_RETPOLINE_SAFE=09=09=09=09=09\
 =09"call *%[thunk_target]\n",=09=09=09=09\
 =09"       jmp    904f;\n"=09=09=09=09=09\
@@ -199,7 +204,11 @@
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
