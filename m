Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeC0Jkj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:40:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751173AbeC0Jkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:40:37 -0400
Subject: Re: [PATCH] vhost-net: add time limitation for tx polling
To: =?UTF-8?B?aGFpYmluemhhbmco5byg5rW35paMKQ==?=
        <haibinzhang@tencent.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <88D661ADF6AFBF42B2AB88D8E7682B0901FC4059@EXMBX-SZMAIL011.tencent.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <182a4eaf-205d-b2b7-6f10-a23ec597f840@redhat.com>
Date: Tue, 27 Mar 2018 17:40:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <88D661ADF6AFBF42B2AB88D8E7682B0901FC4059@EXMBX-SZMAIL011.tencent.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月27日 17:12, haibinzhang(张海斌) wrote:
> handle_tx() will delay rx for a long time when busy tx polling udp packets
> with short length(ie: 1byte udp payload), because setting VHOST_NET_WEIGHT
> takes into account only sent-bytes but no time.

Interesting.

Looking at vhost_can_busy_poll() it tries to poke pending vhost work and 
exit the busy loop if it found one. So I believe something block the 
work queuing. E.g did reverting 8241a1e466cd56e6c10472cac9c1ad4e54bc65db 
fix the issue?

>   It's not fair for handle_rx(),
> so needs to limit max time of tx polling.
>
> Signed-off-by: Haibin Zhang <haibinzhang@tencent.com>
> ---
>   drivers/vhost/net.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 8139bc70ad7d..dc9218a3a75b 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -473,6 +473,7 @@ static void handle_tx(struct vhost_net *net)
>   	struct socket *sock;
>   	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
>   	bool zcopy, zcopy_used;
> +	unsigned long start = jiffies;

Checking jiffies is tricky, need to convert it to ms or whatever others.

>   
>   	mutex_lock(&vq->mutex);
>   	sock = vq->private_data;
> @@ -580,7 +581,7 @@ static void handle_tx(struct vhost_net *net)
>   		else
>   			vhost_zerocopy_signal_used(net, vq);
>   		vhost_net_tx_packet(net);
> -		if (unlikely(total_len >= VHOST_NET_WEIGHT)) {
> +		if (unlikely(total_len >= VHOST_NET_WEIGHT) || unlikely(jiffies - start >= 1)) {

How value 1 is determined here? And we need a complete test to make sure 
this won't affect other use cases.

Another thought is introduce another limit of #packets, but this need 
benchmark too.

Thanks

>   			vhost_poll_queue(&vq->poll);
>   			break;
>   		}
