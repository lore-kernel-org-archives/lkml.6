Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F877ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A9020657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fsro5ZD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A9020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeKASeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:34:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55646 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeKASeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:34:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA19Nl38035120;
        Thu, 1 Nov 2018 09:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=pItNDgZFIe15JKymUX/BrGnulAnqKxz3iMke+9Sq0y4=;
 b=fsro5ZD6JdHP3kARz3hXJRng6U78KuFwcrHXRJpdyQBue2JrTNRaXEPUCvULBIve9IsV
 64qn6d9i/ddaNg/TrdCsN9OOybOCCC/f3JJ6BoQwdkFrhG2LKvveDu7ZVcNe8ZbK/n3S
 5SsQiXi0LsUoBVOaXHTXE2D27kXCJGRloSmP15XLzYckrPjMp9Dnkd5W6q8/q2ja577j
 42Zy7yNTxo16yiYn8X5Fikvq18YOg6gGbvM8jsQZfsOMiT3eJ4yIC+uFavc3ULRKdsAD
 FH2r06UibQGpyGO0xOKk43z4mPx8J9mFVZesD+LZ7Rw4RSOZ+Fr3+MAnZOKVDL9aO6VB +A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2ncfyq7tmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Nov 2018 09:31:50 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA19Vib3006305
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Nov 2018 09:31:44 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA19VhgO024415;
        Thu, 1 Nov 2018 09:31:43 GMT
MIME-Version: 1.0
Message-ID: <b570b2f3-28fe-4ab4-b94a-875b5622e882@default>
Date:   Thu, 1 Nov 2018 02:31:43 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     Srinivas REDDY Eeda <srinivas.eeda@oracle.com>,
        <yamada.masahiro@socionext.com>, Peterz <peterz@infradead.org>
Subject: [PATCH v2 0/2] Enable retpoline only when compiler support
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9063 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=589
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811010083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Peter Zijlstra's suggestion in https://lkml.org/lkml/2018/9/18=
/1016,
hard bind retpoline with compiler support and remove minimal stuff.

Tested with both CONFIG_RETPOLINE enabled and disabled.

-v2:
Add compiler support check in Kconfig [Masahiro]
Drop 3rd patch as __insn_is_indirect_jump() may be used in some corner case=
.[PeterZ]

Zhenzhong Duan (2):
  retpolines: Only enable retpoline when compiler support it
  retpolines: Remove the minimal stuff of retpoline support

 arch/x86/Kconfig                     |  6 ++----
 arch/x86/Makefile                    |  4 +---
 arch/x86/include/asm/nospec-branch.h | 12 ++++++------
 arch/x86/kernel/cpu/bugs.c           | 13 ++-----------
 scripts/Makefile.build               |  2 --
 5 files changed, 11 insertions(+), 26 deletions(-)

--=20
1.8.3.1
