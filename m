Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F9BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DCF21908
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfBHECO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 23:02:14 -0500
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:51281 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726775AbfBHECN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 23:02:13 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 665A9100E86C0;
        Fri,  8 Feb 2019 04:02:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ink59_4d4b9afe06c0a
X-Filterd-Recvd-Size: 2510
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 Feb 2019 04:02:11 +0000 (UTC)
Message-ID: <e88429e686bc9aacca915500b261bc105bd7093c.camel@perches.com>
Subject: Re: [PATCH][next] Bluetooth: hci_event: Use struct_size() helper
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Feb 2019 20:02:10 -0800
In-Reply-To: <20190208004033.GA15609@embeddedor>
References: <20190208004033.GA15609@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-07 at 18:40 -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, change the following form:
> 
> sizeof(*ev) + ev->num_hndl * sizeof(struct hci_comp_pkts_info)
> 
>  to :
> 
> struct_size(ev, handles, ev->num_hndl)
> 
> This code was detected with the help of Coccinelle.
[]
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
[]
> @@ -3556,8 +3556,8 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  		return;
>  	}
>  
> -	if (skb->len < sizeof(*ev) || skb->len < sizeof(*ev) +
> -	    ev->num_hndl * sizeof(struct hci_comp_pkts_info)) {
> +	if (skb->len < sizeof(*ev) ||
> +	    skb->len < struct_size(ev, handles, ev->num_hndl)) {
>  		BT_DBG("%s bad parameters", hdev->name);
>  		return;
>  	}
> @@ -3644,8 +3644,8 @@ static void hci_num_comp_blocks_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  		return;
>  	}
>  
> -	if (skb->len < sizeof(*ev) || skb->len < sizeof(*ev) +
> -	    ev->num_hndl * sizeof(struct hci_comp_blocks_info)) {
> +	if (skb->len < sizeof(*ev) ||
> +	    skb->len < struct_size(ev, handles, ev->num_hndl)) {

Unless these are in a real fast path where skb->len < sizeof(*ev)
is pretty likely, it seems a bit redundant as the multiplication
is pretty cheap and num_hndl is unsigned (actually __u8)

This could/should be simply

	if (skb->len < struct_size(...))


