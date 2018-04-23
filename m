Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932464AbeDWTcE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 15:32:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46548 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932235AbeDWTb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 15:31:58 -0400
Date: Mon, 23 Apr 2018 15:31:20 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tiwei.bie@intel.com,
        jfreimann@redhat.com, wexu@redhat.com
Subject: Re: [RFC V3 PATCH 0/8] Packed ring for vhost
Message-ID: <20180423193120.GD30033@char.us.oracle.com>
References: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8872 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804230194
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 01:34:52PM +0800, Jason Wang wrote:
> Hi all:
> 
> This RFC implement packed ring layout. The code were tested with
> Tiwei's RFC V2 a thttps://lkml.org/lkml/2018/4/1/48. Some fixups and
> tweaks were needed on top of Tiwei's code to make it run. TCP stream
> and pktgen does not show obvious difference compared with split ring.

I have to ask then - what is the benefit of this?

> 
> Changes from V2:
> - do not use & in checking desc_event_flags
> - off should be most significant bit
> - remove the workaround of mergeable buffer for dpdk prototype
> - id should be in the last descriptor in the chain
> - keep _F_WRITE for write descriptor when adding used
> - device flags updating should use ADDR_USED type
> - return error on unexpected unavail descriptor in a chain
> - return false in vhost_ve_avail_empty is descriptor is available
> - track last seen avail_wrap_counter
> - correctly examine available descriptor in get_indirect_packed()
> - vhost_idx_diff should return u16 instead of bool
> 
> Changes from V1:
> 
> - Refactor vhost used elem code to avoid open coding on used elem
> - Event suppression support (compile test only).
> - Indirect descriptor support (compile test only).
> - Zerocopy support.
> - vIOMMU support.
> - SCSI/VSOCK support (compile test only).
> - Fix several bugs
> 
> For simplicity, I don't implement batching or other optimizations.
> 
> Please review.
> 
> Jason Wang (8):
>   vhost: move get_rx_bufs to vhost.c
>   vhost: hide used ring layout from device
>   vhost: do not use vring_used_elem
>   vhost_net: do not explicitly manipulate vhost_used_elem
>   vhost: vhost_put_user() can accept metadata type
>   virtio: introduce packed ring defines
>   vhost: packed ring support
>   vhost: event suppression for packed ring
> 
>  drivers/vhost/net.c                | 136 ++----
>  drivers/vhost/scsi.c               |  62 +--
>  drivers/vhost/vhost.c              | 824 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h              |  47 ++-
>  drivers/vhost/vsock.c              |  42 +-
>  include/uapi/linux/virtio_config.h |   9 +
>  include/uapi/linux/virtio_ring.h   |  32 ++
>  7 files changed, 926 insertions(+), 226 deletions(-)
> 
> -- 
> 2.7.4
> 
