Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAD2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321812087E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321812087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbeHWPCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:02:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728982AbeHWPCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:02:22 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NBT10n082184
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:33:03 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m1ugn9ng2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:33:03 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <vaibhav@linux.ibm.com>;
        Thu, 23 Aug 2018 12:33:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 12:32:56 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NBWtco41156834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 11:32:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2940F11C04A;
        Thu, 23 Aug 2018 14:32:55 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9973611C052;
        Thu, 23 Aug 2018 14:32:51 +0100 (BST)
Received: from vajain21.in.ibm.com (unknown [9.109.223.99])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 23 Aug 2018 14:32:51 +0100 (BST)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 23 Aug 2018 17:02:51 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc:     "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Stewart Smith <stewart@linux.ibm.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [Skiboot] [PATCH] opal/hmi: Wakeup the cpu before reading core_fir
In-Reply-To: <20180821133842.1b13e972@roar.ozlabs.ibm.com>
References: <20180820183417.dejfsluih7elbclu@pburton-laptop> <20180820223618.22319-1-paul.burton@mips.com> <20180820223618.22319-2-paul.burton@mips.com> <20180820140605.11846-1-vaibhav@linux.ibm.com> <20180821133842.1b13e972@roar.ozlabs.ibm.com>
Date:   Thu, 23 Aug 2018 17:02:51 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18082311-0016-0000-0000-000001FAACB8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082311-0017-0000-0000-000032510788
Message-Id: <877ekhnwrg.fsf@vajain21.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=668 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing this patch Nick

Nicholas Piggin <npiggin@gmail.com> writes:
>
> Would it be feasible to enumerate the ranges of scoms that require
> special wakeup and check for those in xscom_read/write, and warn if
> spwkup was not set?
>
I think that might be racy (Vaidy please correct if I am wrong) as a
core can change its state when we read its sleep state and when we do
the actual xscom to read the core_fir.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

