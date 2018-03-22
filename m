Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeCVSkx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:40:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47156 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCVSkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:40:52 -0400
Subject: Re: [RFC PATCH v2 2/4] mm/__free_one_page: skip merge for order-0
 page unless compaction failed
To: Matthew Wilcox <willy@infradead.org>, Aaron Lu <aaron.lu@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20180320085452.24641-1-aaron.lu@intel.com>
 <20180320085452.24641-3-aaron.lu@intel.com>
 <7b1988e9-7d50-d55e-7590-20426fb257af@suse.cz>
 <20180320141101.GB2033@intel.com>
 <20180322171503.GH28468@bombadil.infradead.org>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Organization: Oracle
Message-ID: <9ab5a6dd-c1b2-8da3-31f1-dd2237ea0f44@oracle.com>
Date: Thu, 22 Mar 2018 14:39:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322171503.GH28468@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8840 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/22/2018 01:15 PM, Matthew Wilcox wrote:
> On Tue, Mar 20, 2018 at 10:11:01PM +0800, Aaron Lu wrote:
>>>> A new document file called "struct_page_filed" is added to explain
>>>> the newly reused field in "struct page".
>>>
>>> Sounds rather ad-hoc for a single field, I'd rather document it via
>>> comments.
>>
>> Dave would like to have a document to explain all those "struct page"
>> fields that are repurposed under different scenarios and this is the
>> very start of the document :-)
>>
>> I probably should have explained the intent of the document more.
> 
> Dave and I are in agreement on "Shouldn't struct page be better documented".
> I came up with this a few weeks ago; never quite got round to turning it
> into a patch:
> 
> +---+-----------+-----------+--------------+----------+--------+--------------+
> | B | slab      | pagecache | tail 1       | anon     | tail 1 | hugetlb      |
> +===+===========+===========+==============+==========+========+==============+
> | 0 | flags                                                                   |
> +---+                                                                         |
> | 4 |                                                                         |
> +---+-----------+-----------+--------------+----------+--------+--------------+
> | 8 | s_mem     | mapping   | cmp_mapcount | anon_vma | defer  | mapping      |
> +---+           |           +--------------+          | list   |              |
> |12 |           |           |              |          |        |              |
> +---+-----------+-----------+--------------+----------+        +--------------+
> |16 | freelist  | index                               |        | index        |
> +---+           |                                     |        | (shifted)    |
> |20 |           |                                     |        |              |
> +---+-----------+-------------------------------------+--------+--------------+
> |24 | counters  | mapcount                                                    |
> +---+           +-----------+--------------+----------+--------+--------------+
> |28 |           | refcount  |              |          |        | refcount     |
> +---+-----------+-----------+--------------+----------+--------+--------------+
> |32 | next      | lru       | cmpd_head    |                   | lru          |
> +---+           |           |              +-------------------+              +
> |36 |           |           |              |                   |              |
> +---+-----------+           +--------------+-------------------+              +
> |40 | pages     |           | dtor / order |                   |              |
> +---+-----------+           +--------------+-------------------+              +
> |44 | pobjects  |           |              |                   |              |
> +---+-----------+-----------+--------------+----------------------------------+
> |48 | slb_cache | private   |              |                                  |
> +---+           |           +--------------+----------------------------------+
> |52 |           |           |              |                                  |
> +---+-----------+-----------+--------------+----------------------------------+

Shouldn't the anon column also contain lru?
