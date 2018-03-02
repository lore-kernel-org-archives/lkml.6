Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936121AbeCBHFW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 02:05:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935925AbeCBHFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 02:05:21 -0500
Date: Fri, 2 Mar 2018 08:05:17 +0100
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.fastabend@gmail.com, brouer@redhat.com
Subject: Re: [PATCH net] virtio-net: re enable XDP_REDIRECT for mergeable
 buffer
Message-ID: <20180302080517.4526f384@redhat.com>
In-Reply-To: <1519971929-15148-1-git-send-email-jasowang@redhat.com>
References: <1519971929-15148-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Mar 2018 14:25:29 +0800
Jason Wang <jasowang@redhat.com> wrote:

> @@ -770,6 +774,19 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  				goto err_xdp;
>  			rcu_read_unlock();
>  			goto xdp_xmit;
> +		case XDP_REDIRECT:
> +			err = xdp_do_redirect(dev, &xdp, xdp_prog);
> +			if (err) {
> +				trace_xdp_exception(vi->dev, xdp_prog, act);

Do not add a trace_xdp_exception here... this is handled inside
xdp_do_redirect() invocation.

> +				if (unlikely(xdp_page != page))
> +					put_page(xdp_page);
> +				goto err_xdp;
> +			}
> +			*xdp_xmit = true;
> +			if (unlikely(xdp_page != page))
> +				goto err_xdp;
> +			rcu_read_unlock();
> +			goto xdp_xmit;



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
