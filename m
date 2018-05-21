Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753181AbeEUQqw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:46:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:49136 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752247AbeEUQqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:46:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,426,1520924400";
   d="scan'208";a="57754209"
Date: Mon, 21 May 2018 09:46:46 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: <mst@redhat.com>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, jesse.brandeburg@intel.com
Subject: Re: [RFC PATCH net-next 04/12] vhost_net: split out datacopy logic
Message-ID: <20180521094646.00002dee@intel.com>
In-Reply-To: <1526893473-20128-5-git-send-email-jasowang@redhat.com>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
        <1526893473-20128-5-git-send-email-jasowang@redhat.com>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.30; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2018 17:04:25 +0800 Jason wrote:
> Instead of mixing zerocopy and datacopy logics, this patch tries to
> split datacopy logic out. This results for a more compact code and
> specific optimization could be done on top more easily.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/net.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 102 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 4ebac76..4682fcc 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -492,9 +492,95 @@ static bool vhost_has_more_pkts(struct vhost_net *net,
>  	       likely(!vhost_exceeds_maxpend(net));
>  }
>  
> +static void handle_tx_copy(struct vhost_net *net)
> +{
> +	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_TX];
> +	struct vhost_virtqueue *vq = &nvq->vq;
> +	unsigned out, in;

move "out" and "in" down to inside the for loop as well.

> +	int head;

move this "head" declaration inside for-loop below.

> +	struct msghdr msg = {
> +		.msg_name = NULL,
> +		.msg_namelen = 0,
> +		.msg_control = NULL,
> +		.msg_controllen = 0,
> +		.msg_flags = MSG_DONTWAIT,
> +	};
> +	size_t len, total_len = 0;
> +	int err;
> +	size_t hdr_size;
> +	struct socket *sock;
> +	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
> +	int sent_pkts = 0;

why do we need so many locals?

> +
> +	mutex_lock(&vq->mutex);
> +	sock = vq->private_data;
> +	if (!sock)
> +		goto out;
> +
> +	if (!vq_iotlb_prefetch(vq))
> +		goto out;
> +
> +	vhost_disable_notify(&net->dev, vq);
> +	vhost_net_disable_vq(net, vq);
> +
> +	hdr_size = nvq->vhost_hlen;
> +
> +	for (;;) {
> +		head = vhost_net_tx_get_vq_desc(net, vq, vq->iov,
> +						ARRAY_SIZE(vq->iov),
> +						&out, &in);
> +		/* On error, stop handling until the next kick. */
> +		if (unlikely(head < 0))
> +			break;
> +		/* Nothing new?  Wait for eventfd to tell us they refilled. */
> +		if (head == vq->num) {
> +			if (unlikely(vhost_enable_notify(&net->dev, vq))) {
> +				vhost_disable_notify(&net->dev, vq);
> +				continue;
> +			}
> +			break;
> +		}
> +		if (in) {
> +			vq_err(vq, "Unexpected descriptor format for TX: "
> +			       "out %d, int %d\n", out, in);

don't break strings, keep all the bits between " " together, even if it
is longer than 80 chars.

> +			break;
> +		}
> +
> +		len = init_iov_iter(vq, &msg.msg_iter, hdr_size, out);
> +		if (len < 0)
> +			break;

same comment as previous patch, len is a size_t which is unsigned.

> +
> +		total_len += len;
> +		if (total_len < VHOST_NET_WEIGHT &&
> +		    vhost_has_more_pkts(net, vq)) {
> +			msg.msg_flags |= MSG_MORE;
> +		} else {
> +			msg.msg_flags &= ~MSG_MORE;
> +		}

don't need { } here.

> +
> +		/* TODO: Check specific error and bomb out unless ENOBUFS? */
> +		err = sock->ops->sendmsg(sock, &msg, len);
> +		if (unlikely(err < 0)) {
> +			vhost_discard_vq_desc(vq, 1);
> +			vhost_net_enable_vq(net, vq);
> +			break;
> +		}
> +		if (err != len)
> +			pr_debug("Truncated TX packet: "
> +				 " len %d != %zd\n", err, len);

single line " " string please
