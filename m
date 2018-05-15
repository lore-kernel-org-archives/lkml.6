Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeEOTpl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 15:45:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43430 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeEOTpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 15:45:39 -0400
Subject: Re: [PATCH V2] mlx4_core: allocate ICM memory in page size chunks
To: Eric Dumazet <eric.dumazet@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>, davem@davemloft.net,
        haakon.bugge@oracle.com, yanjun.zhu@oracle.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180511192318.22342-1-qing.huang@oracle.com>
 <2797ac27-022c-0818-388c-e4a6131ad1ca@gmail.com>
 <ff9c44ca-eaae-cb3e-4c69-e9e3cbb72ca1@oracle.com>
 <1ded7d49-0ba2-3594-f840-74d7cf37a0eb@mellanox.com>
 <f4c5d8d3-1eea-8566-9921-a9dc48435f66@oracle.com>
 <f71278c2-a111-1bf6-2ff3-d9a8dd46bfbe@gmail.com>
From: Qing Huang <qing.huang@oracle.com>
Message-ID: <094279df-93c2-b06e-9f48-11be5cd78b69@oracle.com>
Date: Tue, 15 May 2018 12:45:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f71278c2-a111-1bf6-2ff3-d9a8dd46bfbe@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=909
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150192
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/15/2018 12:08 PM, Eric Dumazet wrote:
>
> On 05/15/2018 11:53 AM, Qing Huang wrote:
>>> This is control path so it is less latency-sensitive.
>>> Let's not produce unnecessary degradation here, please call kvzalloc so we maintain a similar behavior when contiguous memory is available, and a fallback for resiliency.
>> No sure what exactly degradation is caused by vzalloc here. I think it's better to keep physically contiguous pages
>> to other requests which really need them. Besides slow path/mem compacting can be really expensive.
>>
> Just use kvzalloc(), and you get the benefit of having contiguous memory if available,
> without expensive compact phase.
>
> This thing _automatically_ falls back to vmalloc(), thus your problem will be solved.
>
> If you are not sure, trust others.

Thanks for the review. There are many places in kernel and applications 
where physically contiguous pages are needed.
We saw quite a few issues when there were not enough contiguous phy mem 
available. My main concern here is that why
using physically contiguous pages when they are not really needed?
