Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DDEC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5F82081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GlC2Stmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5F82081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbeKBRwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 13:52:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33700 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeKBRwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 13:52:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA28jN35133834;
        Fri, 2 Nov 2018 08:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=1Eupju32Mi0/55TYZX39qjJCz+9E5zh9MCOXLcesDO0=;
 b=GlC2StmdLKm3Bih959rdmlyudryij2je4IxiEPE6+jdHdxIkIBhKMldzrAd5oBVFviZd
 zkmMtW5GISKutbiXSvE4zFmSMqQGCyL8RU15ZzylgDxpEwW+3vYBLWN1ELbbme5N8/bb
 r1mZw15IbecLJ+pM449G2H+xXu/k+ykrZBTZMTQEYIvg39A6ZZoxsKbOG/khDRncQA/s
 tJ8oX4Nk7KHq0bFArHAZymjfNvAfL1SY8fd2PsiYtlR1sQBj4z/guKc7kwFWwzv321oX
 XX2/z80NTtAGIgSQlLI89s92la5ceR6x7pBM4Lu2A2m/urxqYFe7wDR36cuDEyDgWpcR 8Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2ncfyqd8tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Nov 2018 08:45:48 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA28jfcv006313
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Nov 2018 08:45:42 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA28jfZA026820;
        Fri, 2 Nov 2018 08:45:41 GMT
MIME-Version: 1.0
Message-ID: <7ba46cbd-826d-459b-98d4-b9f4e08dbcda@default>
Date:   Fri, 2 Nov 2018 01:45:40 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     <mingo@redhat.com>, <tglx@linutronix.de>, <dwmw@amazon.co.uk>,
        <srinivas.eeda@oracle.com>, <yamada.masahiro@socionext.com>,
        <peterz@infradead.org>
Subject: [PATCH v3 0/2] Enable retpoline support only when compiler support
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9064 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=565
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811020083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to PeterZ's suggestion in https://lkml.org/lkml/2018/9/18/1016,
hard bind retpoline with compiler support and remove minimal stuff.

Tested with both CONFIG_RETPOLINE enabled and disabled.

-v3:
Add Suggested-by[Ingo]
Break build if compiler doesn't support retpoline[Dwmw,Tglx,Ingo]

-v2:
Add compiler support check in Kconfig [Masahiro]
Drop 3rd patch as __insn_is_indirect_jump() may be used in some corner case=
.[PeterZ]

Zhenzhong Duan (2):
  retpolines: Only enable retpoline when compiler support it
  retpolines: Remove the minimal stuff of retpoline support

 arch/x86/Kconfig                     |  4 ----
 arch/x86/Makefile                    |  5 +++--
 arch/x86/include/asm/nospec-branch.h | 12 ++++++------
 arch/x86/kernel/cpu/bugs.c           | 13 ++-----------
 scripts/Makefile.build               |  2 --
 5 files changed, 11 insertions(+), 25 deletions(-)

--=20
1.8.3.1
