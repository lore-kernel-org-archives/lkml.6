Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeCTE0w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 00:26:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34622 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeCTE0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 00:26:49 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] virtio_balloon: export hugetlb page allocation counts
From: Jonathan Helman <jonathan.helman@oracle.com>
In-Reply-To: <db6371af-f93d-4409-c910-2ff712196c5b@redhat.com>
Date: Mon, 19 Mar 2018 21:26:41 -0700
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
Message-Id: <6ED6CAC9-FAD9-4A27-A9B1-C6EFC7627D68@oracle.com>
References: <1521497654-24807-1-git-send-email-jonathan.helman@oracle.com>
 <db6371af-f93d-4409-c910-2ff712196c5b@redhat.com>
To: Jason Wang <jasowang@redhat.com>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8837 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200006
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2K4Qw62001408


> On Mar 19, 2018, at 7:31 PM, Jason Wang <jasowang@redhat.com> wrote:
> 
> 
> 
> On 2018年03月20日 06:14, Jonathan Helman wrote:
>> Export the number of successful and failed hugetlb page
>> allocations via the virtio balloon driver. These 2 counts
>> come directly from the vm_events HTLB_BUDDY_PGALLOC and
>> HTLB_BUDDY_PGALLOC_FAIL.
>> 
>> Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
> 
> Reviewed-by: Jason Wang <jasowang@redhat.com>

Thanks.

> 
>> ---
>>  drivers/virtio/virtio_balloon.c     | 6 ++++++
>>  include/uapi/linux/virtio_balloon.h | 4 +++-
>>  2 files changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index dfe5684..6b237e3 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -272,6 +272,12 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
>>  				pages_to_bytes(events[PSWPOUT]));
>>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
>>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
>> +		    events[HTLB_BUDDY_PGALLOC]);
>> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGFAIL,
>> +		    events[HTLB_BUDDY_PGALLOC_FAIL]);
>> +#endif
>>  #endif
>>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
>>  				pages_to_bytes(i.freeram));
>> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
>> index 4e8b830..40297a3 100644
>> --- a/include/uapi/linux/virtio_balloon.h
>> +++ b/include/uapi/linux/virtio_balloon.h
>> @@ -53,7 +53,9 @@ struct virtio_balloon_config {
>>  #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
>>  #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
>>  #define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
>> -#define VIRTIO_BALLOON_S_NR       8
>> +#define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
>> +#define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
>> +#define VIRTIO_BALLOON_S_NR       10
>>    /*
>>   * Memory statistics structure.
> 
> Not for this patch, but it looks to me that exporting such nr through uapi is fragile.

Sorry, can you explain what you mean here?

Jon

> 
> Thanks
