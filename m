Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeCZTCb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 15:02:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41282 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeCZTC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 15:02:29 -0400
Date: Mon, 26 Mar 2018 15:01:30 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 0/8] Packed ring for vhost
Message-ID: <20180326190130.GE6928@char.us.oracle.com>
References: <1522035533-11786-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522035533-11786-1-git-send-email-jasowang@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803260185
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 11:38:45AM +0800, Jason Wang wrote:
> Hi all:
> 
> This RFC implement packed ring layout. The code were tested with pmd
> implement by Jens at
> http://dpdk.org/ml/archives/dev/2018-January/089417.html. Minor change
> was needed for pmd codes to kick virtqueue since it assumes a busy
> polling backend.
> 
> Test were done between localhost and guest. Testpmd (rxonly) in guest
> reports 2.4Mpps. Testpmd (txonly) repots about 2.1Mpps.

And how does it compare to older ring layout?

> 
> Notes: The event suppression /indirect descriptor support is complied
>        test only because of lacked driver support.
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
> Thanks
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
>  drivers/vhost/net.c                | 138 ++-----
>  drivers/vhost/scsi.c               |  62 +--
>  drivers/vhost/vhost.c              | 818 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h              |  46 ++-
>  drivers/vhost/vsock.c              |  42 +-
>  include/uapi/linux/virtio_config.h |   9 +
>  include/uapi/linux/virtio_ring.h   |  32 ++
>  7 files changed, 921 insertions(+), 226 deletions(-)
> 
> -- 
> 2.7.4
> 
