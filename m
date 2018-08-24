Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EBBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AD82157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AD82157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeHXLdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:33:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727134AbeHXLdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:33:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7O7wprR061309
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 03:59:32 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m2cgyupvn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 03:59:32 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 24 Aug 2018 08:59:30 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Aug 2018 08:59:24 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7O7xN8R41091182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Aug 2018 07:59:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EAAD11C04A;
        Fri, 24 Aug 2018 10:59:22 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8766211C06C;
        Fri, 24 Aug 2018 10:59:21 +0100 (BST)
Received: from oc3784624756.ibm.com (unknown [9.152.212.155])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Aug 2018 10:59:21 +0100 (BST)
Subject: Re: [PATCH] perf annotate: fix parsing aarch64 branch instructions
 after objdump update
To:     Kim Phillips <kim.phillips@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Anton Blanchard <anton@samba.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Taeung Song <treeze.taeung@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        perf group <linux-perf-users@vger.kernel.org>
References: <20180823191047.9260992844205984b75e6721@arm.com>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Fri, 24 Aug 2018 09:59:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823191047.9260992844205984b75e6721@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18082407-0028-0000-0000-000002EF1383
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082407-0029-0000-0000-000023A85C1A
Message-Id: <18abf031-f803-b8e6-129e-ed50c63e73d0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-24_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808240086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/2018 02:10 AM, Kim Phillips wrote:
> Starting with binutils 2.28, aarch64 objdump adds comments to the
> disassembly output to show the alternative names of a condition code [1].
> 
> It is assumed that commas in objdump comments could occur in other arches
> now or in the future, so this fix is arch-independent.
> 
> The fix could have been done with arm64 specific jump__parse and
> jump__scnprintf functions, but the jump__scnprintf instruction would
> have to have its comment character be a literal, since the scnprintf
> functions cannot receive a struct arch easily.
> 
> This inconvenience also applies to the generic jump__scnprintf, which
> is why we add a raw_comment pointer to struct ins_operands, so the
> __parse function assigns it to be re-used by its corresponding __scnprintf
> function.
> 
> Example differences in 'perf annotate --stdio2' output on an
> aarch64 perf.data file:
> 
> BEFORE: → b.cs   ffff200008133d1c <unwind_frame+0x18c>  // b.hs, dffff7ecc47b
> AFTER : ↓ b.cs   18c
> 
> BEFORE: → b.cc   ffff200008d8d9cc <get_alloc_profile+0x31c>  // b.lo, b.ul, dffff727295b
> AFTER : ↓ b.cc   31c
> 
> The branch target labels 18c and 31c also now appear in the output:
> 
> BEFORE:        add    x26, x29, #0x80
> AFTER : 18c:   add    x26, x29, #0x80
> 
> BEFORE:        add    x21, x21, #0x8
> AFTER : 31c:   add    x21, x21, #0x8
> 
> The Fixes: tag below is added so stable branches will get the update; it
> doesn't necessarily mean that commit was broken at the time, rather it
> didn't withstand the aarch64 objdump update.
> 
> Tested no difference in output for sample x86_64, power arch perf.data files.

Tested,  no difference in output on s390. Just to let you know.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

