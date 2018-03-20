Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeCTCbP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:31:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750850AbeCTCbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:31:13 -0400
Subject: Re: [PATCH v2] virtio_balloon: export hugetlb page allocation counts
To: Jonathan Helman <jonathan.helman@oracle.com>, mst@redhat.com
Cc: virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
References: <1521497654-24807-1-git-send-email-jonathan.helman@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <db6371af-f93d-4409-c910-2ff712196c5b@redhat.com>
Date: Tue, 20 Mar 2018 10:31:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521497654-24807-1-git-send-email-jonathan.helman@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月20日 06:14, Jonathan Helman wrote:
> Export the number of successful and failed hugetlb page
> allocations via the virtio balloon driver. These 2 counts
> come directly from the vm_events HTLB_BUDDY_PGALLOC and
> HTLB_BUDDY_PGALLOC_FAIL.
>
> Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>

Reviewed-by: Jason Wang <jasowang@redhat.com>

> ---
>   drivers/virtio/virtio_balloon.c     | 6 ++++++
>   include/uapi/linux/virtio_balloon.h | 4 +++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index dfe5684..6b237e3 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -272,6 +272,12 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
>   				pages_to_bytes(events[PSWPOUT]));
>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
> +#ifdef CONFIG_HUGETLB_PAGE
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
> +		    events[HTLB_BUDDY_PGALLOC]);
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGFAIL,
> +		    events[HTLB_BUDDY_PGALLOC_FAIL]);
> +#endif
>   #endif
>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
>   				pages_to_bytes(i.freeram));
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index 4e8b830..40297a3 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -53,7 +53,9 @@ struct virtio_balloon_config {
>   #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
>   #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
>   #define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
> -#define VIRTIO_BALLOON_S_NR       8
> +#define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
> +#define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
> +#define VIRTIO_BALLOON_S_NR       10
>   
>   /*
>    * Memory statistics structure.

Not for this patch, but it looks to me that exporting such nr through 
uapi is fragile.

Thanks
