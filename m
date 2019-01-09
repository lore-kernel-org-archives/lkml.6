Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB67C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB0420821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfAIIli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:41:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729708AbfAIIli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:41:38 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x098cmuH010157
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 03:41:37 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwcfqtvyu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 03:41:36 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 9 Jan 2019 08:41:34 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 08:41:31 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x098fUg75505350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 08:41:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EEE952052;
        Wed,  9 Jan 2019 08:41:30 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.42.126])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1CA2F5204E;
        Wed,  9 Jan 2019 08:41:27 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrea Arcangeli <aarcange@redhat.com>, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V6 0/4] mm/kvm/vfio/ppc64: Migrate compound pages out of CMA region
In-Reply-To: <20190108115620.6ec22e7d60b86d5f609d5a87@linux-foundation.org>
References: <20190108045110.28597-1-aneesh.kumar@linux.ibm.com> <20190108115620.6ec22e7d60b86d5f609d5a87@linux-foundation.org>
Date:   Wed, 09 Jan 2019 14:11:25 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19010908-0028-0000-0000-000003365D68
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010908-0029-0000-0000-000023F36D69
Message-Id: <875zuyjk96.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=622 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue,  8 Jan 2019 10:21:06 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>
>> ppc64 use CMA area for the allocation of guest page table (hash page table). We won't
>> be able to start guest if we fail to allocate hash page table. We have observed
>> hash table allocation failure because we failed to migrate pages out of CMA region
>> because they were pinned. This happen when we are using VFIO. VFIO on ppc64 pins
>> the entire guest RAM. If the guest RAM pages get allocated out of CMA region, we
>> won't be able to migrate those pages. The pages are also pinned for the lifetime of the
>> guest.
>> 
>> Currently we support migration of non-compound pages. With THP and with the addition of
>>  hugetlb migration we can end up allocating compound pages from CMA region. This
>> patch series add support for migrating compound pages. The first path adds the helper
>> get_user_pages_cma_migrate() which pin the page making sure we migrate them out of
>> CMA region before incrementing the reference count. 
>
> Does this code do anything for architectures other than powerpc?  If
> not, should we be adding the ifdefs to avoid burdening other
> architectures with unused code?

Any architecture enabling CMA may need this. I will move most of this below
CONFIG_CMA.

-aneesh

