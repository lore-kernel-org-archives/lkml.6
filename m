Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeCBWQT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 17:16:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60590 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbeCBWQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 17:16:18 -0500
Subject: Re: [PATCH] virtio_balloon: export huge page allocation statistics
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1518846272-5216-1-git-send-email-jonathan.helman@oracle.com>
 <20180227170250-mutt-send-email-mst@kernel.org>
From: Jonathan Helman <jonathan.helman@oracle.com>
Organization: Oracle Corporation
Message-ID: <9d7e605f-5a91-1431-61e4-78c9110bf4f2@oracle.com>
Date: Fri, 2 Mar 2018 14:16:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227170250-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8820 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020261
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/27/2018 07:20 AM, Michael S. Tsirkin wrote:
> On Fri, Feb 16, 2018 at 09:44:32PM -0800, Jonathan Helman wrote:
>> Export statistics for successful and failed huge page allocations
>> from the virtio balloon driver. These 2 stats come directly from
>> the vm_events HTLB_BUDDY_PGALLOC and HTLB_BUDDY_PGALLOC_FAIL.
>> Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
> 
> Any host/guest intergace changes need to be copied to
> the virtio TC mailing list (subscriber-only, sorry about that):
> virtio-dev@lists.oasis-open.org
> 

Sorry, will do on v2.

>> ---
>>   drivers/virtio/virtio_balloon.c     | 6 ++++++
>>   include/uapi/linux/virtio_balloon.h | 4 +++-
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index dfe5684..6b237e3 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -272,6 +272,12 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
>>   				pages_to_bytes(events[PSWPOUT]));
>>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
>>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
>> +		    events[HTLB_BUDDY_PGALLOC]);
>> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGFAIL,
>> +		    events[HTLB_BUDDY_PGALLOC_FAIL]);
>> +#endif
>>   #endif
>>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
>>   				pages_to_bytes(i.freeram));
>> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
>> index 4e8b830..e3e8071 100644
>> --- a/include/uapi/linux/virtio_balloon.h
>> +++ b/include/uapi/linux/virtio_balloon.h
>> @@ -53,7 +53,9 @@ struct virtio_balloon_config {
>>   #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
>>   #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
>>   #define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
>> -#define VIRTIO_BALLOON_S_NR       8
>> +#define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Number of htlb pgalloc successes */
>> +#define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Number of htlb pgalloc failures */
>> +#define VIRTIO_BALLOON_S_NR       10
> 
> Can you clarify the comments pls? Eschew abbreviation.

Sure. How about the following instead? Hoping it makes things clearer, 
without going over the 80 character limit ;)

#define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
#define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation 
failures */

If this is better, I'll send out a v2.

Thanks,
Jon

> 
>>   
>>   /*
>>    * Memory statistics structure.
>> -- 
>> 1.8.3.1
