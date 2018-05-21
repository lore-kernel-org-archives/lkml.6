Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeEUCds (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 22:33:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751094AbeEUCdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 22:33:45 -0400
Subject: Re: [RFC V4 PATCH 0/8] Packed ring layout for vhost
To: Wei Xu <wexu@redhat.com>
Cc: mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jfreimann@redhat.com,
        tiwei.bie@intel.com
References: <1526473941-16199-1-git-send-email-jasowang@redhat.com>
 <20180520162514.GA21958@wei-ubt>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9a8425be-5c39-eff7-d808-836b825ed890@redhat.com>
Date: Mon, 21 May 2018 10:33:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180520162514.GA21958@wei-ubt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月21日 00:25, Wei Xu wrote:
> On Wed, May 16, 2018 at 08:32:13PM +0800, Jason Wang wrote:
>> Hi all:
>>
>> This RFC implement packed ring layout. The code were tested with
>> Tiwei's RFC V3 ahttps://lkml.org/lkml/2018/4/25/34. Some fixups and
>> tweaks were needed on top of Tiwei's code to make it run for event
>> index.
> Could you please show the change based on Tiwei's code to easy other's
> test?

Please try Tiwei's V4 instead of just waiting for the fixup. It should 
work unless you don't try zerocopy and vIOMMU.


>> Pktgen reports about 20% improvement on PPS (event index is off). More
>> testing is ongoing.
>>
>> Notes for tester:
>>
>> - Start from this version, vhost need qemu co-operation to work
>>    correctly. Or you can comment out the packed specific code for
>>    GET/SET_VRING_BASE.
> Do you mean the code in vhost_virtqueue_start/stop?

For qemu, probably.

> Both Tiwei's and your v3
> work fortunately correctly which should be avoided since the ring should be
> definitely different.

I don't understand this, you mean reset work?

Thanks

>
> Wei
>
>> Changes from V3:
>> - Fix math on event idx checking
>> - Sync last avail wrap counter through GET/SET_VRING_BASE
>> - remove desc_event prefix in the driver/device structure
>>
>> Changes from V2:
>> - do not use & in checking desc_event_flags
>> - off should be most significant bit
>> - remove the workaround of mergeable buffer for dpdk prototype
>> - id should be in the last descriptor in the chain
>> - keep _F_WRITE for write descriptor when adding used
>> - device flags updating should use ADDR_USED type
>> - return error on unexpected unavail descriptor in a chain
>> - return false in vhost_ve_avail_empty is descriptor is available
>> - track last seen avail_wrap_counter
>> - correctly examine available descriptor in get_indirect_packed()
>> - vhost_idx_diff should return u16 instead of bool
>>
>> Changes from V1:
>>
>> - Refactor vhost used elem code to avoid open coding on used elem
>> - Event suppression support (compile test only).
>> - Indirect descriptor support (compile test only).
>> - Zerocopy support.
>> - vIOMMU support.
>> - SCSI/VSOCK support (compile test only).
>> - Fix several bugs
>>
>> Jason Wang (8):
>>    vhost: move get_rx_bufs to vhost.c
>>    vhost: hide used ring layout from device
>>    vhost: do not use vring_used_elem
>>    vhost_net: do not explicitly manipulate vhost_used_elem
>>    vhost: vhost_put_user() can accept metadata type
>>    virtio: introduce packed ring defines
>>    vhost: packed ring support
>>    vhost: event suppression for packed ring
>>
>>   drivers/vhost/net.c                | 136 ++----
>>   drivers/vhost/scsi.c               |  62 +--
>>   drivers/vhost/vhost.c              | 861 ++++++++++++++++++++++++++++++++-----
>>   drivers/vhost/vhost.h              |  47 +-
>>   drivers/vhost/vsock.c              |  42 +-
>>   include/uapi/linux/virtio_config.h |   9 +
>>   include/uapi/linux/virtio_ring.h   |  32 ++
>>   7 files changed, 928 insertions(+), 261 deletions(-)
>>
>> -- 
>> 2.7.4
>>
