Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A437C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49464208AC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49464208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbeG0QVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:21:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730561AbeG0QVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:21:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6REs8pX122560
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:58:47 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kg3mkdk1j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:58:47 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Fri, 27 Jul 2018 10:58:45 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 10:58:40 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6REwdL81900864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 14:58:39 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76525AC05B;
        Fri, 27 Jul 2018 10:59:22 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29C89AC059;
        Fri, 27 Jul 2018 10:59:17 -0400 (EDT)
Received: from kermit-br-ibm-com.ibmmodules.com (unknown [9.80.82.251])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jul 2018 10:59:16 -0400 (EDT)
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Alastair D'Silva" <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 00/10] powerpc: Modernize unhandled signals message
Date:   Fri, 27 Jul 2018 11:58:01 -0300
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18072714-0052-0000-0000-000003146013
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009438; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066907; UDB=6.00548186; IPR=6.00844773;
 MB=3.00022354; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-27 14:58:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072714-0053-0000-0000-00005D82CE88
Message-Id: <20180727145811.12334-1-muriloo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=634 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone.

This series was inspired by the need to modernize and display more
informative messages about unhandled signals.

The "unhandled signal NN" is not very informative.  We thought it would be
helpful adding a human-readable message describing what the signal number
means, printing the VMA address, and dumping the instructions.

We can add more informative messages, like informing what each code of a
SIGSEGV signal means.  We are open to suggestions.

Before this series:

    pandafault[5815]: unhandled signal 11 at 00000000100007d0 nip 000000001000061c lr 00003fff87ff5100 code 2

After this series:

    pandafault[10850]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fff9f3e5100 code 2 in pandafault[10000000+10000]
    pandafault[10850]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
    pandafault[10850]: code: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

Link to v1:

    https://lore.kernel.org/lkml/20180724192720.32417-1-muriloo@linux.ibm.com/

v1..v2:

    - Broke patch 7 down into patches 7-9
    - Added proper copyright in arch/powerpc/include/asm/stacktrace.h
    - show_instructions(): prefixed lines with current->comm and current->pid

Cheers!

Murilo Opsfelder Araujo (10):
  powerpc/traps: Print unhandled signals in a separate function
  powerpc/traps: Return early in show_signal_msg()
  powerpc/reg: Add REG_FMT definition
  powerpc/traps: Use REG_FMT in show_signal_msg()
  powerpc/traps: Print VMA for unhandled signals
  powerpc/traps: Print signal name for unhandled signals
  powerpc: Do not call __kernel_text_address() in show_instructions()
  powerpc: Add stacktrace.h header
  powerpc/traps: Show instructions on exceptions
  powerpc/traps: Add line prefix in show_instructions()

 arch/powerpc/include/asm/reg.h        |  6 +++
 arch/powerpc/include/asm/stacktrace.h | 13 +++++
 arch/powerpc/kernel/process.c         | 35 ++++++-------
 arch/powerpc/kernel/traps.c           | 73 +++++++++++++++++++++++----
 4 files changed, 100 insertions(+), 27 deletions(-)
 create mode 100644 arch/powerpc/include/asm/stacktrace.h

--
2.17.1

