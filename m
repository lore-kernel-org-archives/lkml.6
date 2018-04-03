Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbeDCN0R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:26:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750728AbeDCN0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:26:15 -0400
Date: Tue, 3 Apr 2018 16:26:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?aGFpYmluemhhbmco5byg5rW35paMKQ==?=
        <haibinzhang@tencent.com>
Cc: Jason Wang <jasowang@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?bGlkb25nY2hlbijpmYjnq4vkuJwp?= <lidongchen@tencent.com>,
        =?utf-8?B?eXVuZmFuZ3RhaSjlj7Dov5Dmlrkp?= <yunfangtai@tencent.com>
Subject: Re: [PATCH] vhost-net: add limitation of sent packets for tx polling
Message-ID: <20180403161645-mutt-send-email-mst@kernel.org>
References: <88D661ADF6AFBF42B2AB88D8E7682B0901FC465B@EXMBX-SZMAIL011.tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88D661ADF6AFBF42B2AB88D8E7682B0901FC465B@EXMBX-SZMAIL011.tencent.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 12:29:47PM +0000, haibinzhang(张海斌) wrote:
> 
> >On Tue, Apr 03, 2018 at 08:08:26AM +0000, haibinzhang wrote:
> >> handle_tx will delay rx for a long time when tx busy polling udp packets
> >> with small length(e.g. 1byte udp payload), because setting VHOST_NET_WEIGHT
> >> takes into account only sent-bytes but no single packet length.
> >> 
> >> Tests were done between two Virtual Machines using netperf(UDP_STREAM, len=1),
> >> then another machine pinged the client. Result shows as follow:
> >> 
> >> Packet#       Ping-Latency(ms)
> >>               min     avg     max
> >> Origin      3.319  18.489  57.503
> >> 64          1.643   2.021   2.552
> >> 128         1.825   2.600   3.224
> >> 256         1.997   2.710   4.295
> >> 512*        1.860   3.171   4.631
> >> 1024        2.002   4.173   9.056
> >> 2048        2.257   5.650   9.688
> >> 4096        2.093   8.508  15.943
> >> 
> >> 512 is selected, which is multi-VRING_SIZE
> >
> >There's no guarantee vring size is 256.
> >
> >Could you pls try with a different tx ring size?
> >
> >I suspect we want:
> >
> >#define VHOST_NET_PKT_WEIGHT(vq) ((vq)->num * 2)
> >
> >
> >> and close to VHOST_NET_WEIGHT/MTU.
> >
> >Puzzled by this part.  Does tweaking MTU change anything?
> 
> The MTU of ethernet is 1500, so VHOST_NET_WEIGHT/MTU equals 0x80000/1500=350.

We should include the 12 byte header so it's a bit lower.

> Then sent-bytes cannot reach VHOST_NET_WEIGHT in one handle_tx even with 1500-bytes 
> frame if packet# is less than 350. So packet# must be bigger than 350.
> 512 meets this condition

What you seem to say is this:

	imagine MTU sized buffers. With these we stop after 350
	packets. Thus adding another limit > 350 will not
	slow us down.

	Fair enough but won't apply with smaller packet
	sizes, will it?

	I still think a simpler argument carries more weight:

ring size is a hint from device about a burst size
it can tolerate. Based on benchmarks, we tweak
the limit to 2 * vq size as that seems to
perform a bit better, and is still safer
than no limit on # of packets as is done now.

	but this needs testing with another ring size.
	Could you try that please?

	
> and is also DEFAULT VRING_SIZE aligned.

Neither Linux nor virtio have a default vring size. It's a historical
construct that exists in qemu for qemu compatibility
reasons.

> >
> >> To evaluate this change, another tests were done using netperf(RR, TX) between
> >> two machines with Intel(R) Xeon(R) Gold 6133 CPU @ 2.50GHz. Result as follow
> >> does not show obvious changes:
> >> 
> >> TCP_RR
> >> 
> >> size/sessions/+thu%/+normalize%
> >>    1/       1/  -7%/        -2%
> >>    1/       4/  +1%/         0%
> >>    1/       8/  +1%/        -2%
> >>   64/       1/  -6%/         0%
> >>   64/       4/   0%/        +2%
> >>   64/       8/   0%/         0%
> >>  256/       1/  -3%/        -4%
> >>  256/       4/  +3%/        +4%
> >>  256/       8/  +2%/         0%
> >> 
> >> UDP_RR
> >> 
> >> size/sessions/+thu%/+normalize%
> >>    1/       1/  -5%/        +1%
> >>    1/       4/  +4%/        +1%
> >>    1/       8/  -1%/        -1%
> >>   64/       1/  -2%/        -3%
> >>   64/       4/  -5%/        -1%
> >>   64/       8/   0%/        -1%
> >>  256/       1/  +7%/        +1%
> >>  256/       4/  +1%/        +1%
> >>  256/       8/  +2%/        +2%
> >> 
> >> TCP_STREAM
> >> 
> >> size/sessions/+thu%/+normalize%
> >>   64/       1/   0%/        -3%
> >>   64/       4/  +3%/        -1%
> >>   64/       8/  +9%/        -4%
> >>  256/       1/  +1%/        -4%
> >>  256/       4/  -1%/        -1%
> >>  256/       8/  +7%/        +5%
> >>  512/       1/  +1%/         0%
> >>  512/       4/  +1%/        -1%
> >>  512/       8/  +7%/        -5%
> >> 1024/       1/   0%/        -1%
> >> 1024/       4/  +3%/         0%
> >> 1024/       8/  +8%/        +5%
> >> 2048/       1/  +2%/        +2%
> >> 2048/       4/  +1%/         0%
> >> 2048/       8/  -2%/         0%
> >> 4096/       1/  -2%/         0%
> >> 4096/       4/  +2%/         0%
> >> 4096/       8/  +9%/        -2%
> >> 
> >> Signed-off-by: Haibin Zhang <haibinzhang@tencent.com>
> >> Signed-off-by: Yunfang Tai <yunfangtai@tencent.com>
> >> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> >> ---
> >>  drivers/vhost/net.c | 8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >> index 8139bc70ad7d..13a23f3f3ea4 100644
> >> --- a/drivers/vhost/net.c
> >> +++ b/drivers/vhost/net.c
> >> @@ -44,6 +44,10 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
> >>   * Using this limit prevents one virtqueue from starving others. */
> >>  #define VHOST_NET_WEIGHT 0x80000
> >>  
> >> +/* Max number of packets transferred before requeueing the job.
> >> + * Using this limit prevents one virtqueue from starving rx. */
> >> +#define VHOST_NET_PKT_WEIGHT 512
> >> +
> >>  /* MAX number of TX used buffers for outstanding zerocopy */
> >>  #define VHOST_MAX_PEND 128
> >>  #define VHOST_GOODCOPY_LEN 256
> >> @@ -473,6 +477,7 @@ static void handle_tx(struct vhost_net *net)
> >>  	struct socket *sock;
> >>  	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
> >>  	bool zcopy, zcopy_used;
> >> +	int sent_pkts = 0;
> >>  
> >>  	mutex_lock(&vq->mutex);
> >>  	sock = vq->private_data;
> >> @@ -580,7 +585,8 @@ static void handle_tx(struct vhost_net *net)
> >>  		else
> >>  			vhost_zerocopy_signal_used(net, vq);
> >>  		vhost_net_tx_packet(net);
> >> -		if (unlikely(total_len >= VHOST_NET_WEIGHT)) {
> >> +		if (unlikely(total_len >= VHOST_NET_WEIGHT) ||
> >> +		    unlikely(++sent_pkts >= VHOST_NET_PKT_WEIGHT)) {
> >>  			vhost_poll_queue(&vq->poll);
> >>  			break;
> >>  		}
> >> -- 
> >> 2.12.3
> >> 
> 
