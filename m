Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757345AbeD0D4S (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 23:56:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751279AbeD0D4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 23:56:17 -0400
Subject: Re: [RFC v3 0/5] virtio: support packed ring
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com
References: <20180425051550.24342-1-tiwei.bie@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5ad1ca01-1e5c-7105-f303-7e8d42f6a068@redhat.com>
Date: Fri, 27 Apr 2018 11:56:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425051550.24342-1-tiwei.bie@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月25日 13:15, Tiwei Bie wrote:
> Hello everyone,
>
> This RFC implements packed ring support in virtio driver.
>
> Some simple functional tests have been done with Jason's
> packed ring implementation in vhost:
>
> https://lkml.org/lkml/2018/4/23/12
>
> Both of ping and netperf worked as expected (with EVENT_IDX
> disabled). But there are below known issues:
>
> 1. Reloading the guest driver will break the Tx/Rx;

Will have a look at this issue.

> 2. Zeroing the flags when detaching a used desc will
>     break the guest -> host path.

I still think zeroing flags is unnecessary or even a bug. At host, I 
track last observed avail wrap counter and detect avail like (what is 
suggested in the example code in the spec):

static bool desc_is_avail(struct vhost_virtqueue *vq, __virtio16 flags)
{
        bool avail = flags & cpu_to_vhost16(vq, DESC_AVAIL);

        return avail == vq->avail_wrap_counter;
}

So zeroing wrap can not work with this obviously.

Thanks

>
> Some simple functional tests have also been done with
> Wei's packed ring implementation in QEMU:
>
> http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg00342.html
>
> Both of ping and netperf worked as expected (with EVENT_IDX
> disabled). Reloading the guest driver also worked as expected.
>
> TODO:
> - Refinements (for code and commit log) and bug fixes;
> - Discuss/fix/test EVENT_IDX support;
> - Test devices other than net;
>
> RFC v2 -> RFC v3:
> - Split into small patches (Jason);
> - Add helper virtqueue_use_indirect() (Jason);
> - Just set id for the last descriptor of a list (Jason);
> - Calculate the prev in virtqueue_add_packed() (Jason);
> - Fix/improve desc suppression code (Jason/MST);
> - Refine the code layout for XXX_split/packed and wrappers (MST);
> - Fix the comments and API in uapi (MST);
> - Remove the BUG_ON() for indirect (Jason);
> - Some other refinements and bug fixes;
>
> RFC v1 -> RFC v2:
> - Add indirect descriptor support - compile test only;
> - Add event suppression supprt - compile test only;
> - Move vring_packed_init() out of uapi (Jason, MST);
> - Merge two loops into one in virtqueue_add_packed() (Jason);
> - Split vring_unmap_one() for packed ring and split ring (Jason);
> - Avoid using '%' operator (Jason);
> - Rename free_head -> next_avail_idx (Jason);
> - Add comments for virtio_wmb() in virtqueue_add_packed() (Jason);
> - Some other refinements and bug fixes;
>
> Thanks!
>
> Tiwei Bie (5):
>    virtio: add packed ring definitions
>    virtio_ring: support creating packed ring
>    virtio_ring: add packed ring support
>    virtio_ring: add event idx support in packed ring
>    virtio_ring: enable packed ring
>
>   drivers/virtio/virtio_ring.c       | 1271 ++++++++++++++++++++++++++++--------
>   include/linux/virtio_ring.h        |    8 +-
>   include/uapi/linux/virtio_config.h |   12 +-
>   include/uapi/linux/virtio_ring.h   |   36 +
>   4 files changed, 1049 insertions(+), 278 deletions(-)
>
