Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C68C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E347021773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfBLPqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:46:34 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:36759 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfBLPqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:46:34 -0500
Received: from cpe-2606-a000-111b-405a-9816-2c85-c514-8f7a.dyn6.twc.com ([2606:a000:111b:405a:9816:2c85:c514:8f7a] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1gtaGS-0001CA-Ka; Tue, 12 Feb 2019 10:46:30 -0500
Date:   Tue, 12 Feb 2019 10:46:01 -0500
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "hange-folder>?" <toggle-mailboxes@hmswarspite.think-freely.org>
Subject: Re: [PATCH net] sctp: call gso_reset_checksum when computing
 checksum in sctp_gso_segment
Message-ID: <20190212123456.GA8267@hmswarspite.think-freely.org>
References: <5b8187d1eabd52e4db7d3e4506d98c33571c1c83.1549968450.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b8187d1eabd52e4db7d3e4506d98c33571c1c83.1549968450.git.lucien.xin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 06:47:30PM +0800, Xin Long wrote:
> Jianlin reported a panic when running sctp gso over gre over vlan device:
> 
>   [   84.772930] RIP: 0010:do_csum+0x6d/0x170
>   [   84.790605] Call Trace:
>   [   84.791054]  csum_partial+0xd/0x20
>   [   84.791657]  gre_gso_segment+0x2c3/0x390
>   [   84.792364]  inet_gso_segment+0x161/0x3e0
>   [   84.793071]  skb_mac_gso_segment+0xb8/0x120
>   [   84.793846]  __skb_gso_segment+0x7e/0x180
>   [   84.794581]  validate_xmit_skb+0x141/0x2e0
>   [   84.795297]  __dev_queue_xmit+0x258/0x8f0
>   [   84.795949]  ? eth_header+0x26/0xc0
>   [   84.796581]  ip_finish_output2+0x196/0x430
>   [   84.797295]  ? skb_gso_validate_network_len+0x11/0x80
>   [   84.798183]  ? ip_finish_output+0x169/0x270
>   [   84.798875]  ip_output+0x6c/0xe0
>   [   84.799413]  ? ip_append_data.part.50+0xc0/0xc0
>   [   84.800145]  iptunnel_xmit+0x144/0x1c0
>   [   84.800814]  ip_tunnel_xmit+0x62d/0x930 [ip_tunnel]
>   [   84.801699]  gre_tap_xmit+0xac/0xf0 [ip_gre]
>   [   84.802395]  dev_hard_start_xmit+0xa5/0x210
>   [   84.803086]  sch_direct_xmit+0x14f/0x340
>   [   84.803733]  __dev_queue_xmit+0x799/0x8f0
>   [   84.804472]  ip_finish_output2+0x2e0/0x430
>   [   84.805255]  ? skb_gso_validate_network_len+0x11/0x80
>   [   84.806154]  ip_output+0x6c/0xe0
>   [   84.806721]  ? ip_append_data.part.50+0xc0/0xc0
>   [   84.807516]  sctp_packet_transmit+0x716/0xa10 [sctp]
>   [   84.808337]  sctp_outq_flush+0xd7/0x880 [sctp]
> 
> It was caused by SKB_GSO_CB(skb)->csum_start not set in sctp_gso_segment.
> sctp_gso_segment() calls skb_segment() with 'feature | NETIF_F_HW_CSUM',
> which causes SKB_GSO_CB(skb)->csum_start not to be set in skb_segment().
> 
> For TCP/UDP, when feature supports HW_CSUM, CHECKSUM_PARTIAL will be set
> and gso_reset_checksum will be called to set SKB_GSO_CB(skb)->csum_start.
> 
> So SCTP should do the same as TCP/UDP, to call gso_reset_checksum() when
> computing checksum in sctp_gso_segment.
> 
> Reported-by: Jianlin Shi <jishi@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/sctp/offload.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/sctp/offload.c b/net/sctp/offload.c
> index 123e9f2..edfcf16 100644
> --- a/net/sctp/offload.c
> +++ b/net/sctp/offload.c
> @@ -36,6 +36,7 @@ static __le32 sctp_gso_make_checksum(struct sk_buff *skb)
>  {
>  	skb->ip_summed = CHECKSUM_NONE;
>  	skb->csum_not_inet = 0;
> +	gso_reset_checksum(skb, ~0);
>  	return sctp_compute_cksum(skb, skb_transport_offset(skb));
>  }
>  
> -- 
> 2.1.0
> 
> 
> 
Acked-by: Neil Horman <nhorman@tuxdriver.com>

