Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeDSM1I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:27:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752597AbeDSM1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:27:06 -0400
Subject: Re: [PATCH v2 net 2/3] virtio_net: fix adding vids on big-endian
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>, Thomas Huth <thuth@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <1524115776-334953-1-git-send-email-mst@redhat.com>
 <1524115776-334953-3-git-send-email-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c7090eff-9bb7-a9a5-0d00-304fb73388d7@redhat.com>
Date: Thu, 19 Apr 2018 20:26:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524115776-334953-3-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月19日 13:30, Michael S. Tsirkin wrote:
> Programming vids (adding or removing them) still passes
> guest-endian values in the DMA buffer. That's wrong
> if guest is big-endian and when virtio 1 is enabled.
>
> Note: this is on top of a previous patch:
> 	virtio_net: split out ctrl buffer
>
> Fixes: 9465a7a6f ("virtio_net: enable v1.0 support")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/net/virtio_net.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3d0eff53..f84fe04 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -154,7 +154,7 @@ struct control_buf {
>   	struct virtio_net_ctrl_mq mq;
>   	u8 promisc;
>   	u8 allmulti;
> -	u16 vid;
> +	__virtio16 vid;
>   	u64 offloads;
>   };
>   
> @@ -1718,7 +1718,7 @@ static int virtnet_vlan_rx_add_vid(struct net_device *dev,
>   	struct virtnet_info *vi = netdev_priv(dev);
>   	struct scatterlist sg;
>   
> -	vi->ctrl->vid = vid;
> +	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
>   	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
>   
>   	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
> @@ -1733,7 +1733,7 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev,
>   	struct virtnet_info *vi = netdev_priv(dev);
>   	struct scatterlist sg;
>   
> -	vi->ctrl->vid = vid;
> +	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
>   	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
>   
>   	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,

Acked-by: Jason Wang <jasowang@redhat.com>
