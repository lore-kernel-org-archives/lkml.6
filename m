Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbeC1JVU convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 05:21:20 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:29032 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbeC1JVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 05:21:17 -0400
X-IronPort-AV: E=Sophos;i="5.48,370,1517875200";
   d="scan'208";a="70671663"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: "'Dongli Zhang'" <dongli.zhang@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Wei Liu <wei.liu2@citrix.com>
Subject: RE: [PATCH 1/1] xen-netback: process malformed sk_buff correctly to
 avoid BUG_ON()
Thread-Topic: [PATCH 1/1] xen-netback: process malformed sk_buff correctly to
 avoid BUG_ON()
Thread-Index: AQHTxiUb7JBzUH4YQUaQM55JWztC5aPlXBYw
Date: Wed, 28 Mar 2018 09:21:15 +0000
Message-ID: <dd9faa8b39b64482bcdcb959298d9a69@AMSPEX02CL03.citrite.net>
References: <1522194136-11985-1-git-send-email-dongli.zhang@oracle.com>
In-Reply-To: <1522194136-11985-1-git-send-email-dongli.zhang@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Dongli Zhang [mailto:dongli.zhang@oracle.com]
> Sent: 28 March 2018 00:42
> To: xen-devel@lists.xenproject.org; linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org; Wei Liu <wei.liu2@citrix.com>; Paul Durrant
> <Paul.Durrant@citrix.com>
> Subject: [PATCH 1/1] xen-netback: process malformed sk_buff correctly to
> avoid BUG_ON()
> 
> The "BUG_ON(!frag_iter)" in function xenvif_rx_next_chunk() is triggered if
> the received sk_buff is malformed, that is, when the sk_buff has pattern
> (skb->data_len && !skb_shinfo(skb)->nr_frags). Below is a sample call
> stack:
> 
> [  438.652658] ------------[ cut here ]------------
> [  438.652660] kernel BUG at drivers/net/xen-netback/rx.c:325!
> [  438.652714] invalid opcode: 0000 [#1] SMP NOPTI
> [  438.652813] CPU: 0 PID: 2492 Comm: vif1.0-q0-guest Tainted: G           O
> 4.16.0-rc6+ #1
> [  438.652896] RIP: e030:xenvif_rx_skb+0x3c2/0x5e0 [xen_netback]
> [  438.652926] RSP: e02b:ffffc90040877dc8 EFLAGS: 00010246
> [  438.652956] RAX: 0000000000000160 RBX: 0000000000000022 RCX:
> 0000000000000001
> [  438.652993] RDX: ffffc900402890d0 RSI: 0000000000000000 RDI:
> ffffc90040889000
> [  438.653029] RBP: ffff88002b460040 R08: ffffc90040877de0 R09:
> 0100000000000000
> [  438.653065] R10: 0000000000007ff0 R11: 0000000000000002 R12:
> ffffc90040889000
> [  438.653100] R13: ffffffff80000000 R14: 0000000000000022 R15:
> 0000000080000000
> [  438.653149] FS:  00007f15603778c0(0000) GS:ffff880030400000(0000)
> knlGS:0000000000000000
> [  438.653188] CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  438.653219] CR2: 0000000001832a08 CR3: 0000000029c12000 CR4:
> 0000000000042660
> [  438.653262] Call Trace:
> [  438.653284]  ? xen_hypercall_event_channel_op+0xa/0x20
> [  438.653313]  xenvif_rx_action+0x41/0x80 [xen_netback]
> [  438.653341]  xenvif_kthread_guest_rx+0xb2/0x2a8 [xen_netback]
> [  438.653374]  ? __schedule+0x352/0x700
> [  438.653398]  ? wait_woken+0x80/0x80
> [  438.653421]  kthread+0xf3/0x130
> [  438.653442]  ? xenvif_rx_action+0x80/0x80 [xen_netback]
> [  438.653470]  ? kthread_destroy_worker+0x40/0x40
> [  438.653497]  ret_from_fork+0x35/0x40
> 
> The issue is hit by xen-netback when there is bug with other networking
> interface (e.g., dom0 physical NIC), who has generated and forwarded
> malformed sk_buff to dom0 vifX.Y. It is possible to reproduce the issue on
> purpose with below sample code in a kernel module:
> 
> skb->dev = dev; // dev of vifX.Y
> skb->len = 386;
> skb->data_len = 352;
> skb->tail = 98;
> skb->end = 384;
> dev->netdev_ops->ndo_start_xmit(skb, dev);
> 
> This patch stops processing sk_buff immediately if it is detected as
> malformed, that is, pkt->frag_iter is NULL but there is still remaining
> pkt->remaining_len.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  drivers/net/xen-netback/rx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/xen-netback/rx.c b/drivers/net/xen-netback/rx.c
> index b1cf7c6..289cc82 100644
> --- a/drivers/net/xen-netback/rx.c
> +++ b/drivers/net/xen-netback/rx.c
> @@ -369,6 +369,14 @@ static void xenvif_rx_data_slot(struct xenvif_queue
> *queue,
>  		offset += len;
>  		pkt->remaining_len -= len;
> 
> +		if (unlikely(!pkt->frag_iter && pkt->remaining_len)) {
> +			pkt->remaining_len = 0;
> +			pkt->extra_count = 0;
> +			pr_err_ratelimited("malformed sk_buff at %s\n",
> +					   queue->name);
> +			break;
> +		}
> +

This looks fine, but I think it would also be good to indicate the error to the frontend by setting rsp->status below. That should cause the frontend to bin the packet.

  Paul

>  	} while (offset < XEN_PAGE_SIZE && pkt->remaining_len > 0);
> 
>  	if (pkt->remaining_len > 0)
> --
> 2.7.4
