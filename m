Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26645C64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80832081C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80832081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLHREw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:04:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbeLHREw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:04:52 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB8H3vPm058212
        for <linux-kernel@vger.kernel.org>; Sat, 8 Dec 2018 12:04:51 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p8bbpuj1g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 12:04:50 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Sat, 8 Dec 2018 17:04:50 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Dec 2018 17:04:46 -0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB8H4j4F28246060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 8 Dec 2018 17:04:45 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56BD66A054;
        Sat,  8 Dec 2018 17:04:45 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8635C6A04F;
        Sat,  8 Dec 2018 17:04:41 +0000 (GMT)
Received: from [9.85.88.56] (unknown [9.85.88.56])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat,  8 Dec 2018 17:04:41 +0000 (GMT)
Subject: Re: [PATCH V4 0/3] * mm/kvm/vfio/ppc64: Migrate compound pages out of
 CMA region
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, mpe@ellerman.id.au,
        paulus@samba.org, David Gibson <david@gibson.dropbear.id.au>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20181121092259.16482-1-aneesh.kumar@linux.ibm.com>
 <20181207151226.cb00ace433738cf550e66885@linux-foundation.org>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Sat, 8 Dec 2018 22:34:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207151226.cb00ace433738cf550e66885@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18120817-0004-0000-0000-000014BF473F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010194; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01128851; UDB=6.00586455; IPR=6.00908982;
 MB=3.00024605; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-08 17:04:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120817-0005-0000-0000-000089C87F21
Message-Id: <7a14631d-8077-e20f-d8a9-740710406168@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812080160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/18 4:42 AM, Andrew Morton wrote:
> On Wed, 21 Nov 2018 14:52:56 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> 
>> Subject: [PATCH V4 0/3] * mm/kvm/vfio/ppc64: Migrate compound pages out of CMA region
> 
> Asterisk in title is strange?

My mistake while editing git-format-patch cover-letter.

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
>>   hugetlb migration we can end up allocating compound pages from CMA region. This
>> patch series add support for migrating compound pages. The first path adds the helper
>> get_user_pages_cma_migrate() which pin the page making sure we migrate them out of
>> CMA region before incrementing the reference count.
> 
> Very little review activity.  Perhaps Andrey and/or Michal can find the
> time..
> 
>> mm/migrate.c            | 108 ++++++++++++++++++++++++++++++++++++++++
> 
> can we make this code disappear when CONFIG_CMA=n?
> 


We can definitely do

static inline int get_user_pages_cma_migrate(unsigned long start, int 
nr_pages, int write,  struct page **pages)
{
	
	return get_user_pages_fast(start, nr_pages, write, pages);
}

with #ifdef CONFIG_CMA around but that is unnecessary #ifdef in the 
code. If CMA config is disabled, we will not be doing any migrate. Hence 
wondering whether we need an alternative definition for CONFIG_CMA=n

-aneesh

