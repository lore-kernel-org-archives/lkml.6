Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C87EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D3D2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D3D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeLDN36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:29:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbeLDN35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:29:57 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB4DP3OU102985
        for <linux-kernel@vger.kernel.org>; Tue, 4 Dec 2018 08:29:57 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p5swwj10y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:29:56 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Tue, 4 Dec 2018 13:29:54 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Dec 2018 13:29:51 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB4DToF258065098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Dec 2018 13:29:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD94A5204E;
        Tue,  4 Dec 2018 13:29:50 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.51.227])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 2F47152052;
        Tue,  4 Dec 2018 13:29:49 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 4/5] mm/hugetlb: Add prot_modify_start/commit sequence for hugetlb update
In-Reply-To: <d7ee1b8c-2f45-f430-b413-9d511e7d78c4@linux.ibm.com>
References: <20181128143438.29458-1-aneesh.kumar@linux.ibm.com> <20181128143438.29458-5-aneesh.kumar@linux.ibm.com> <20181128141051.ff38f23023f652759b06f828@linux-foundation.org> <d7ee1b8c-2f45-f430-b413-9d511e7d78c4@linux.ibm.com>
Date:   Tue, 04 Dec 2018 18:59:43 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18120413-0028-0000-0000-00000325DD23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120413-0029-0000-0000-000023E1E5DE
Message-Id: <87va495sjc.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=634 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812040115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> On 11/29/18 3:40 AM, Andrew Morton wrote:
>> On Wed, 28 Nov 2018 20:04:37 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>> 
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> 
>> Some explanation of the motivation would be useful.
>
> I will update the commit message.
>

Is this good?

    mm/hugetlb: Add prot_modify_start/commit sequence for hugetlb update
    
    Architectures like ppc64 requires to do a conditional tlb flush based on the old
    and new value of pte. Follow the regular pte change protection sequence for
    hugetlb too. This allow the architectures to override the update sequence.

-aneesh

