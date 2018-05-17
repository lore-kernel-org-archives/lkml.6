Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeEQVpg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 17:45:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50258 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeEQVpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 17:45:34 -0400
From: Qing Huang <qing.huang@oracle.com>
Subject: Re: [PATCH v3] mlx4_core: allocate ICM memory in page size chunks
To: Eric Dumazet <eric.dumazet@gmail.com>, tariqt@mellanox.com,
        davem@davemloft.net, haakon.bugge@oracle.com, yanjun.zhu@oracle.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, gi-oh.kim@profitbricks.com
References: <20180517205343.8401-1-qing.huang@oracle.com>
 <e6c470f0-f2ae-5efd-09ed-0c9562a4a764@gmail.com>
Message-ID: <19b7818e-16f6-2349-dc34-245c2f215f6f@oracle.com>
Date: Thu, 17 May 2018 14:45:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e6c470f0-f2ae-5efd-09ed-0c9562a4a764@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8896 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=958
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805170202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2018 2:14 PM, Eric Dumazet wrote:
> On 05/17/2018 01:53 PM, Qing Huang wrote:
>> When a system is under memory presure (high usage with fragments),
>> the original 256KB ICM chunk allocations will likely trigger kernel
>> memory management to enter slow path doing memory compact/migration
>> ops in order to complete high order memory allocations.
>>
>> When that happens, user processes calling uverb APIs may get stuck
>> for more than 120s easily even though there are a lot of free pages
>> in smaller chunks available in the system.
>>
>> Syslog:
>> ...
>> Dec 10 09:04:51 slcc03db02 kernel: [397078.572732] INFO: task
>> oracle_205573_e:205573 blocked for more than 120 seconds.
>> ...
>>
> NACK on this patch.
>
> You have been asked repeatedly to use kvmalloc()
>
> This is not a minor suggestion.
>
> Take a look athttps://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d8c13f2271ec5178c52fbde072ec7b562651ed9d

Would you please take a look at how table->icm is being used in the mlx4 
driver? It's a meta data used for individual pointer variable referencing,
not as data frag or in/out buffer. It has no need for contiguous phy. 
memory.

Thanks.

> And you'll understand some people care about this.
>
> Strongly.
>
> Thanks.
>
