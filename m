Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeEUQ31 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:29:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:40329 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752882AbeEUQ3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:29:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,426,1520924400";
   d="scan'208";a="57749291"
Date: Mon, 21 May 2018 09:29:23 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: <mst@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        jesse.brandeburg@intel.com
Subject: Re: [RFC PATCH net-next 02/12] vhost_net: introduce
 vhost_exceeds_weight()
Message-ID: <20180521092923.00005cec@intel.com>
In-Reply-To: <1526893473-20128-3-git-send-email-jasowang@redhat.com>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
        <1526893473-20128-3-git-send-email-jasowang@redhat.com>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.30; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2018 17:04:23 +0800 Jason wrote:
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/net.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 15d191a..de544ee 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -479,6 +479,12 @@ static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
>  	return len;
>  }
>  
> +static bool vhost_exceeds_weight(int pkts, int total_len)
> +{
> +	return unlikely(total_len >= VHOST_NET_WEIGHT) ||
> +	       unlikely(pkts >= VHOST_NET_PKT_WEIGHT);

I was going to say just one unlikely, but then the caller of this
function also says unlikely(vhost_exceeds...), so I think you should
just drop the unlikely statements here (both of them)

> +}
> +
>  /* Expects to be always run from workqueue - which acts as
>   * read-size critical section for our kind of RCU. */
>  static void handle_tx(struct vhost_net *net)
> @@ -570,7 +576,6 @@ static void handle_tx(struct vhost_net *net)
>  			msg.msg_control = NULL;
>  			ubufs = NULL;
>  		}
> -

unrelated whitespace changes?

>  		total_len += len;
>  		if (total_len < VHOST_NET_WEIGHT &&
>  		    !vhost_vq_avail_empty(&net->dev, vq) &&
> @@ -600,8 +605,7 @@ static void handle_tx(struct vhost_net *net)
>  		else
>  			vhost_zerocopy_signal_used(net, vq);
>  		vhost_net_tx_packet(net);
> -		if (unlikely(total_len >= VHOST_NET_WEIGHT) ||
> -		    unlikely(++sent_pkts >= VHOST_NET_PKT_WEIGHT)) {
> +		if (unlikely(vhost_exceeds_weight(++sent_pkts, total_len))) {
>  			vhost_poll_queue(&vq->poll);
>  			break;
>  		}
> @@ -887,8 +891,7 @@ static void handle_rx(struct vhost_net *net)
>  		if (unlikely(vq_log))
>  			vhost_log_write(vq, vq_log, log, vhost_len);
>  		total_len += vhost_len;
> -		if (unlikely(total_len >= VHOST_NET_WEIGHT) ||
> -		    unlikely(++recv_pkts >= VHOST_NET_PKT_WEIGHT)) {
> +		if (unlikely(vhost_exceeds_weight(++recv_pkts, total_len))) {
>  			vhost_poll_queue(&vq->poll);
>  			goto out;
>  		}
