Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753208AbeEUQYD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:24:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:64975 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753130AbeEUQYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:24:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,426,1520924400";
   d="scan'208";a="57747998"
Date: Mon, 21 May 2018 09:24:00 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: <mst@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        jesse.brandeburg@intel.com
Subject: Re: [RFC PATCH net-next 01/12] vhost_net: introduce helper to
 initialize tx iov iter
Message-ID: <20180521092400.00004c68@intel.com>
In-Reply-To: <1526893473-20128-2-git-send-email-jasowang@redhat.com>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
        <1526893473-20128-2-git-send-email-jasowang@redhat.com>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.30; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason, a few nits. 

On Mon, 21 May 2018 17:04:22 +0800 Jason wrote:
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/net.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index c4b49fc..15d191a 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -459,6 +459,26 @@ static bool vhost_exceeds_maxpend(struct vhost_net *net)
>  	       min_t(unsigned int, VHOST_MAX_PEND, vq->num >> 2);
>  }
>  
> +static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
> +			    size_t hdr_size, int out)
> +{
> +	/* Skip header. TODO: support TSO. */
> +	size_t len = iov_length(vq->iov, out);
> +
> +	iov_iter_init(iter, WRITE, vq->iov, out, len);
> +	iov_iter_advance(iter, hdr_size);
> +	/* Sanity check */
> +	if (!iov_iter_count(iter)) {
> +		vq_err(vq, "Unexpected header len for TX: "
> +			"%zd expected %zd\n",
> +			len, hdr_size);

ok, it was like this before, but please unwrap the string in " ", there
should be no line breaks in string declarations and they are allowed to
go over 80 characters.

> +		return -EFAULT;
> +	}
> +	len = iov_iter_count(iter);
> +
> +	return len;
> +}
> +
>  /* Expects to be always run from workqueue - which acts as
>   * read-size critical section for our kind of RCU. */
>  static void handle_tx(struct vhost_net *net)
> @@ -521,18 +541,10 @@ static void handle_tx(struct vhost_net *net)
>  			       "out %d, int %d\n", out, in);
>  			break;
>  		}
> -		/* Skip header. TODO: support TSO. */
> -		len = iov_length(vq->iov, out);
> -		iov_iter_init(&msg.msg_iter, WRITE, vq->iov, out, len);
> -		iov_iter_advance(&msg.msg_iter, hdr_size);
> -		/* Sanity check */
> -		if (!msg_data_left(&msg)) {
> -			vq_err(vq, "Unexpected header len for TX: "
> -			       "%zd expected %zd\n",
> -			       len, hdr_size);
> +
> +		len = init_iov_iter(vq, &msg.msg_iter, hdr_size, out);
> +		if (len < 0)

len is declared as size_t, which is unsigned, and can never be
negative.  I'm pretty sure this is a bug.


>  			break;
> -		}
> -		len = msg_data_left(&msg);
>  
>  		zcopy_used = zcopy && len >= VHOST_GOODCOPY_LEN
>  				   && !vhost_exceeds_maxpend(net)
