Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeBFSUM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:20:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50304 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752702AbeBFSUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:20:04 -0500
Subject: Re: [RFC PATCH v1 13/13] mm: splice local lists onto the front of the
 LRU
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: aaron.lu@intel.com, ak@linux.intel.com, akpm@linux-foundation.org,
        Dave.Dice@oracle.com, dave@stgolabs.net, khandual@linux.vnet.ibm.com,
        mgorman@suse.de, mhocko@kernel.org, pasha.tatashin@oracle.com,
        steven.sistare@oracle.com, yossi.lev@oracle.com
References: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
 <20180131230413.27653-14-daniel.m.jordan@oracle.com>
 <765238a2-8970-e05d-4fe3-cdcb796aa399@linux.vnet.ibm.com>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Organization: Oracle Corporation
Message-ID: <a9518500-cc2a-ce15-76a4-73a31b744852@oracle.com>
Date: Tue, 6 Feb 2018 13:18:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <765238a2-8970-e05d-4fe3-cdcb796aa399@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8796 signatures=668662
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802060231
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 10:22 AM, Laurent Dufour wrote:
> On 01/02/2018 00:04, daniel.m.jordan@oracle.com wrote:
...snip...
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 99a54df760e3..6911626f29b2 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2077,6 +2077,7 @@ static void lock_page_lru(struct page *page, int *isolated)
>>
>>   		lruvec = mem_cgroup_page_lruvec(page, zone->zone_pgdat);
>>   		ClearPageLRU(page);
>> +		smp_rmb(); /* Pairs with smp_wmb in __pagevec_lru_add */
> 
> Why not include the call to smp_rmb() in del_page_from_lru_list() instead
> of spreading smp_rmb() before calls to del_page_from_lru_list() ?

Yes, this is what I should have done.  The memory barriers came from 
another patch I squashed in and I didn't look back to see how obvious 
the encapsulation was.
