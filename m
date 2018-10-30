Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CF2C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6124120657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nVKnSuEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6124120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeJ3PrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:47:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49224 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeJ3PrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:47:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9U6s2EV110902
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=/cD1fwO2hli7g9nGagtj5uNLahU+D5bvAw7qUX1v08g=;
 b=nVKnSuEoCun6xOMg2y072joWI49JFOAnm+ggeRQp0cQptDF0aDrUMWXWlaI/pH5+UES3
 aRwn7kbejSqRs5s/JW32yiF/9VwEyg6HkO/+egrY6wYP51u8Adb/FZc4OEmyXqd2y48l
 U54KfeDSlnNwdu4rNB/aL7TQuCWbWmiOaSPRe6euW1q4Z0bAEP49kYjXkF+9CmDpBznX
 YxdsL6WVWdLiBvFMd/yfkrnDgJjr1akJokNEIwbksLXDabtncC6JtJFo0cpUgGef1uR2
 zEA9tEYG1Ay/qZYLomJoHqNXoWRzX6e+HxMqQmGiHKYx28zvBaWW9QpjWwOz5diYpXCX ug== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2nduckxmbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:55:04 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9U6t4pd017703
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:55:04 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9U6t3Cu008468
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:55:03 GMT
MIME-Version: 1.0
Message-ID: <834642d4-d92c-4502-8d74-66fc19885b43@default>
Date:   Mon, 29 Oct 2018 23:55:03 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     Srinivas REDDY Eeda <srinivas.eeda@oracle.com>
Subject: [PATCH 0/3] Enable retpoline only when compiler support
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9061 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=813
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810300060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Peter Zijlstra's suggestion in https://lkml.org/lkml/2018/9/18=
/1016,
hard bind retpoline with compiler support and remove minimal stuff.

Tested with both CONFIG_RETPOLIN_SUPPORT enabled and disabled.

Zhenzhong Duan (3):
  retpolines: Only enable retpoline when compiler support it
  retpolines: Remove the minimal stuff of retpoline support
  kprobes/x86: Simplify indirect-jump check in retpoline case

 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/x86/Kconfig                                |  8 ++++----
 arch/x86/Makefile                               |  5 +++--
 arch/x86/entry/vdso/Makefile                    |  4 ++--
 arch/x86/include/asm/nospec-branch.h            | 12 ++++++------
 arch/x86/kernel/cpu/bugs.c                      | 13 ++-----------
 arch/x86/kernel/kprobes/opt.c                   | 14 ++++++--------
 arch/x86/kernel/vmlinux.lds.S                   |  2 +-
 arch/x86/lib/Makefile                           |  2 +-
 arch/x86/lib/retpoline.S                        |  2 ++
 scripts/Makefile.build                          |  2 +-
 11 files changed, 29 insertions(+), 37 deletions(-)

--=20
1.8.3.1
