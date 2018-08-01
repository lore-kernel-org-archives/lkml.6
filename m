Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B24CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3812020841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3812020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbeHAXVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:21:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbeHAXVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:21:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LOApX040247
        for <linux-kernel@vger.kernel.org>; Wed, 1 Aug 2018 17:33:53 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kkjjd5e89-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:33:53 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Wed, 1 Aug 2018 17:33:51 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Aug 2018 17:33:47 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w71LXkFC9568736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Aug 2018 21:33:46 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50E32AC05F;
        Wed,  1 Aug 2018 17:34:24 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEDB2AC05B;
        Wed,  1 Aug 2018 17:34:19 -0400 (EDT)
Received: from kermit-br-ibm-com.ibmmodules.com (unknown [9.80.99.86])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  1 Aug 2018 17:34:19 -0400 (EDT)
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Alastair D'Silva" <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH v4 0/6] powerpc: Modernize unhandled signals message
Date:   Wed,  1 Aug 2018 18:33:14 -0300
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18080121-0040-0000-0000-00000456ECA5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009468; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068949; UDB=6.00549596; IPR=6.00847297;
 MB=3.00022446; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-01 21:33:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080121-0041-0000-0000-0000085D28D7
Message-Id: <20180801213320.11203-1-muriloo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=920 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1808010217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone.

This series was inspired by the need to modernize and display more
informative messages about unhandled signals.

The "unhandled signal NN" is not very informative.  We thought it would
be helpful adding a human-readable message describing what the signal
number means, printing the VMA address, and dumping the instructions.

Before this series:

  pandafault32[4724]: unhandled signal 11 at 100005e4 nip 10000444 lr 0fe31ef4 code 2

  pandafault64[4725]: unhandled signal 11 at 0000000010000718 nip 0000000010000574 lr 00007fff7faa7a6c code 2

After this series:

  pandafault32[4753]: segfault (11) at 100005e4 nip 10000444 lr fe31ef4 code 2 in pandafault32[10000000+10000]
  pandafault32[4753]: code: 4bffff3c 60000000 60420000 4bffff30 9421ffd0 93e1002c 7c3f0b78 3d201000
  pandafault32[4753]: code: 392905e4 913f0008 813f0008 39400048 <99490000> 39200000 7d234b78 397f0030

  pandafault64[4754]: segfault (11) at 10000718 nip 10000574 lr 7fffb0007a6c code 2 in pandafault64[10000000+10000]
  pandafault64[4754]: code: e8010010 7c0803a6 4bfffef4 4bfffef0 fbe1fff8 f821ffb1 7c3f0b78 3d22fffe
  pandafault64[4754]: code: 39298818 f93f0030 e93f0030 39400048 <99490000> 39200000 7d234b78 383f0050

Link to v3:

  https://lore.kernel.org/lkml/20180731145020.14009-1-muriloo@linux.ibm.com/

v3..v4:

  - Added new show_user_instructions() based on the existing
    show_instructions()
  - Updated commit messages
  - Replaced signals names table with a tiny function that returns a
    literal string for each signal number

Cheers!

Murilo Opsfelder Araujo (6):
  powerpc/traps: Print unhandled signals in a separate function
  powerpc/traps: Use an explicit ratelimit state for show_signal_msg()
  powerpc/traps: Use %lx format in show_signal_msg()
  powerpc/traps: Print VMA for unhandled signals
  powerpc: Add show_user_instructions()
  powerpc/traps: Show instructions on exceptions

 arch/powerpc/include/asm/stacktrace.h | 13 +++++++
 arch/powerpc/kernel/process.c         | 40 +++++++++++++++++++++
 arch/powerpc/kernel/traps.c           | 52 +++++++++++++++++++++------
 3 files changed, 95 insertions(+), 10 deletions(-)
 create mode 100644 arch/powerpc/include/asm/stacktrace.h

-- 
2.17.1

