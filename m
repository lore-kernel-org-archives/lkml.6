Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C1BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE3120851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE3120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeLEL1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:27:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727094AbeLEL1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:27:42 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB5BOjs7142554
        for <linux-kernel@vger.kernel.org>; Wed, 5 Dec 2018 06:27:40 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p6d5bt46f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:27:40 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 5 Dec 2018 11:27:39 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Dec 2018 11:27:30 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB5BRTZQ19464264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Dec 2018 11:27:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDA79B2066;
        Wed,  5 Dec 2018 11:27:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED22AB205F;
        Wed,  5 Dec 2018 11:27:18 +0000 (GMT)
Received: from [9.85.68.152] (unknown [9.85.68.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  5 Dec 2018 11:27:18 +0000 (GMT)
Subject: Re: [RFC PATCH 00/14] Heterogeneous Memory System (HMS) and hbind()
To:     Jerome Glisse <jglisse@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Paul Blinzer <Paul.Blinzer@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Vivek Kini <vkini@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Ben Woodard <woodard@redhat.com>, linux-acpi@vger.kernel.org
References: <20181203233509.20671-1-jglisse@redhat.com>
 <9d745b99-22e3-c1b5-bf4f-d3e83113f57b@intel.com>
 <20181204184919.GD2937@redhat.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Wed, 5 Dec 2018 16:57:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181204184919.GD2937@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18120511-0068-0000-0000-0000036C9C17
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010175; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01127298; UDB=6.00585524; IPR=6.00907433;
 MB=3.00024457; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-05 11:27:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120511-0069-0000-0000-000046A91A6D
Message-Id: <d90b88f6-b414-a0f9-d572-35c4d2bb1579@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=958 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812050105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 12:19 AM, Jerome Glisse wrote:

> Above example is for migrate. Here is an example for how the
> topology is use today:
> 
>      Application knows that the platform is running on have 16
>      GPU split into 2 group of 8 GPUs each. GPU in each group can
>      access each other memory with dedicated mesh links between
>      each others. Full speed no traffic bottleneck.
> 
>      Application splits its GPU computation in 2 so that each
>      partition runs on a group of interconnected GPU allowing
>      them to share the dataset.
> 
> With HMS:
>      Application can query the kernel to discover the topology of
>      system it is running on and use it to partition and balance
>      its workload accordingly. Same application should now be able
>      to run on new platform without having to adapt it to it.
> 

Will the kernel be ever involved in decision making here? Like the 
scheduler will we ever want to control how there computation units get 
scheduled onto GPU groups or GPU?

> This is kind of naive i expect topology to be hard to use but maybe
> it is just me being pesimistics. In any case today we have a chicken
> and egg problem. We do not have a standard way to expose topology so
> program that can leverage topology are only done for HPC where the
> platform is standard for few years. If we had a standard way to expose
> the topology then maybe we would see more program using it. At very
> least we could convert existing user.
> 
> 

I am wondering whether we should consider HMAT as a subset of the ideas
mentioned in this thread and see whether we can first achieve HMAT 
representation with your patch series?

-aneesh

