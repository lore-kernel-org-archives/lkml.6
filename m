Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932099AbeE3Rj3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 13:39:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33188 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeE3Rj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 13:39:26 -0400
Subject: Re: [PATCH V4] mlx4_core: allocate ICM memory in page size chunks
To: Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>
Cc: tariqt@mellanox.com, haakon.bugge@oracle.com, yanjun.zhu@oracle.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, gi-oh.kim@profitbricks.com
References: <20180523232246.20445-1-qing.huang@oracle.com>
 <20180525.102321.858995452200286788.davem@davemloft.net>
 <7a353b65-6b7f-1aee-1c48-e83c8e02f693@gmail.com>
 <0e11e0fc-6ccf-aa93-9c4f-b9eae1b90643@gmail.com>
 <cdf0d1a9-378a-8b09-544e-a4918acb57fe@gmail.com>
From: Qing Huang <qing.huang@oracle.com>
Message-ID: <05a97a57-2a25-34b5-e8eb-6452d6bb419a@oracle.com>
Date: Wed, 30 May 2018 10:39:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <cdf0d1a9-378a-8b09-544e-a4918acb57fe@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8909 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805300186
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/2018 8:49 PM, Eric Dumazet wrote:
>
> On 05/29/2018 11:44 PM, Eric Dumazet wrote:
>
>> And I will add this simple fix, this really should address your initial concern much better.
>>
>> @@ -99,6 +100,8 @@ static int mlx4_alloc_icm_pages(struct scatterlist *mem, int order,
>>   {
>>          struct page *page;
>>   
>> +       if (order)
>> +               gfp_mask |= __GFP_NORETRY;
>      and also      gfp_mask &= ~__GFP_DIRECT_RECLAIM
>

Would this just fail the allocation without trying to reclaim memory 
under memory pressure? We've tried something similar but it didn't fix 
the original problem we were facing.


>>          page = alloc_pages_node(node, gfp_mask, order);
>>          if (!page) {
>>                  page = alloc_pages(gfp_mask, order);
>>
