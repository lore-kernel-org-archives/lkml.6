Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeBAIdw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:33:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751423AbeBAIdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:33:49 -0500
Subject: Re: [RFC] mm/migrate: Add new migration reason MR_HUGETLB
To: Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180130030714.6790-1-khandual@linux.vnet.ibm.com>
 <20180130075949.GN21609@dhcp22.suse.cz>
 <b4bd6cda-a3b7-96dd-b634-d9b3670c1ecf@linux.vnet.ibm.com>
 <20180131075852.GL21609@dhcp22.suse.cz>
 <20180131121217.4c80263d68a4ad4da7b170f0@linux-foundation.org>
 <20180131203242.GB21609@dhcp22.suse.cz>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 1 Feb 2018 13:58:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180131203242.GB21609@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020108-0020-0000-0000-000003F12846
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020108-0021-0000-0000-000042838F8A
Message-Id: <29b6db3a-f853-b81b-0632-c1841298ab87@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802010111
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2018 02:02 AM, Michal Hocko wrote:
> On Wed 31-01-18 12:12:17, Andrew Morton wrote:
>> On Wed, 31 Jan 2018 08:58:52 +0100 Michal Hocko <mhocko@kernel.org> wrote:
>>
>>> On Wed 31-01-18 07:55:05, Anshuman Khandual wrote:
>>>> On 01/30/2018 01:29 PM, Michal Hocko wrote:
>>>>> On Tue 30-01-18 08:37:14, Anshuman Khandual wrote:
>>>>>> alloc_contig_range() initiates compaction and eventual migration for
>>>>>> the purpose of either CMA or HugeTLB allocation. At present, reason
>>>>>> code remains the same MR_CMA for either of those cases. Lets add a
>>>>>> new reason code which will differentiate the purpose of migration
>>>>>> as HugeTLB allocation instead.
>>>>> Why do we need it?
>>>>
>>>> The same reason why we have MR_CMA (maybe some other ones as well) at
>>>> present, for reporting purpose through traces at the least. It just
>>>> seemed like same reason code is being used for two different purpose
>>>> of migration.
>>>
>>> But do we have any real user asking for this kind of information?
>>
>> It seems a reasonable cleanup: reusing MR_CMA for hugetlb just because
>> it happens to do the right thing is a bit hacky - the two things aren't
>> particularly related and a reader could be excused for feeling
>> confusion.
> 
> My bad! I thought this is a tracepoint thingy. But it seems to be only
> used as a migration reason for page_owner. Now it makes more sense.
>  
>> But the change seems incomplete:
>>
>>> +		if (migratetype == MIGRATE_CMA)
>>> +			migrate_reason = MR_CMA;
>>> +		else
>>> +			migrate_reason = MR_HUGETLB;
>>
>> If we're going to do this cleanup then shouldn't we go all the way and
>> add MIGRATE_HUGETLB?
> 
> Yes. We can expect more users of alloc_contig_range in future. Maybe we
> want to use MR_CONTIG_RANGE instead.

MR_CONTIG_RANGE can be a replacement for both MR_CMA and MR_HUGETLB.
