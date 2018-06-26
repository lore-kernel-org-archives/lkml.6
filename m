Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C210BC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B252664B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B252664B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbeFZHzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:55:35 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:62563 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbeFZHze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:55:34 -0400
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="13456002"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Jun 2018 00:55:34 -0700
Received: from [10.145.6.69] (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.352.0; Tue, 26 Jun 2018
 00:55:32 -0700
Subject: Re: [PATCH v2] staging: wilc1000: Use common structs to parse ip
 packets
To:     Thibaut Robert <thibaut.robert@gmail.com>,
        Aditya Shankar <aditya.shankar@microchip.com>,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
References: <20180604105549.04031722@ajaysk-VirtualBox>
 <20180619184419.10304-1-thibaut.robert@gmail.com>
From:   Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <333f9414-9541-dc33-9c69-4054b5966eaa@microchip.com>
Date:   Tue, 26 Jun 2018 10:55:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619184419.10304-1-thibaut.robert@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>

On 19.06.2018 21:44, Thibaut Robert wrote:
> Use structs ethhdr, iphdr and tcphdr instead of manual parsing in
> tcp_process.
> This commit fix handling of ip packets containing options.
> It also fixes the following sparse warning:
> 
> drivers/staging/wilc1000//wilc_wlan.c:201:19: warning: cast to restricted __be16
> 
> Signed-off-by: Thibaut Robert <thibaut.robert@gmail.com>
> ---
>  drivers/staging/wilc1000/wilc_wlan.c | 43 ++++++++++------------------
>  1 file changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/wilc1000/wilc_wlan.c b/drivers/staging/wilc1000/wilc_wlan.c
> index 55755d7fbb30..85af36595e69 100644
> --- a/drivers/staging/wilc1000/wilc_wlan.c
> +++ b/drivers/staging/wilc1000/wilc_wlan.c
> @@ -1,4 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/if_ether.h>
> +#include <linux/ip.h>
>  #include "wilc_wfi_netdevice.h"
>  #include "wilc_wlan_cfg.h"
>  
> @@ -150,9 +152,8 @@ static inline int add_tcp_pending_ack(u32 ack, u32 session_index,
>  
>  static inline void tcp_process(struct net_device *dev, struct txq_entry_t *tqe)
>  {
> -	u8 *eth_hdr_ptr;
> -	u8 *buffer = tqe->buffer;
> -	unsigned short h_proto;
> +	void *buffer = tqe->buffer;
> +	const struct ethhdr *eth_hdr_ptr = buffer;
>  	int i;
>  	unsigned long flags;
>  	struct wilc_vif *vif;
> @@ -163,37 +164,23 @@ static inline void tcp_process(struct net_device *dev, struct txq_entry_t *tqe)
>  
>  	spin_lock_irqsave(&wilc->txq_spinlock, flags);
>  
> -	eth_hdr_ptr = &buffer[0];
> -	h_proto = ntohs(*((unsigned short *)&eth_hdr_ptr[12]));
> -	if (h_proto == ETH_P_IP) {
> -		u8 *ip_hdr_ptr;
> -		u8 protocol;
> +	if (eth_hdr_ptr->h_proto == htons(ETH_P_IP)) {
> +		const struct iphdr *ip_hdr_ptr = buffer + ETH_HLEN;
>  
> -		ip_hdr_ptr = &buffer[ETHERNET_HDR_LEN];
> -		protocol = ip_hdr_ptr[9];
> -
> -		if (protocol == 0x06) {
> -			u8 *tcp_hdr_ptr;
> +		if (ip_hdr_ptr->protocol == IPPROTO_TCP) {
> +			const struct tcphdr *tcp_hdr_ptr;
>  			u32 IHL, total_length, data_offset;
>  
> -			tcp_hdr_ptr = &ip_hdr_ptr[IP_HDR_LEN];
> -			IHL = (ip_hdr_ptr[0] & 0xf) << 2;
> -			total_length = ((u32)ip_hdr_ptr[2] << 8) +
> -					(u32)ip_hdr_ptr[3];
> -			data_offset = ((u32)tcp_hdr_ptr[12] & 0xf0) >> 2;
> +			IHL = ip_hdr_ptr->ihl << 2;
> +			tcp_hdr_ptr = buffer + ETH_HLEN + IHL;
> +			total_length = ntohs(ip_hdr_ptr->tot_len);
> +
> +			data_offset = tcp_hdr_ptr->doff << 2;
>  			if (total_length == (IHL + data_offset)) {
>  				u32 seq_no, ack_no;
>  
> -				seq_no = ((u32)tcp_hdr_ptr[4] << 24) +
> -					 ((u32)tcp_hdr_ptr[5] << 16) +
> -					 ((u32)tcp_hdr_ptr[6] << 8) +
> -					 (u32)tcp_hdr_ptr[7];
> -
> -				ack_no = ((u32)tcp_hdr_ptr[8] << 24) +
> -					 ((u32)tcp_hdr_ptr[9] << 16) +
> -					 ((u32)tcp_hdr_ptr[10] << 8) +
> -					 (u32)tcp_hdr_ptr[11];
> -
> +				seq_no = ntohl(tcp_hdr_ptr->seq);
> +				ack_no = ntohl(tcp_hdr_ptr->ack_seq);
>  				for (i = 0; i < tcp_session; i++) {
>  					u32 j = ack_session_info[i].seq_num;
>  
> 
