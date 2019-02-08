Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04862C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BA721908
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBHEAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 23:00:47 -0500
Received: from smtprelay0019.hostedemail.com ([216.40.44.19]:46693 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726791AbfBHEAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 23:00:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 40BBF181D3368;
        Fri,  8 Feb 2019 04:00:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dock45_409a2f98a582f
X-Filterd-Recvd-Size: 2153
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 Feb 2019 04:00:43 +0000 (UTC)
Message-ID: <4faff31066c10285bab0afdb0c1f88f6d3d1a21b.camel@perches.com>
Subject: Re: [PATCH][next] Bluetooth: a2mp: Use struct_size() helper
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Feb 2019 20:00:42 -0800
In-Reply-To: <20190208002817.GA15338@embeddedor>
References: <20190208002817.GA15338@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-07 at 18:28 -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> size = sizeof(struct foo) + count * sizeof(struct boo);
> instance = alloc(size, GFP_KERNEL)
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> size = struct_size(instance, entry, count);
> instance = alloc(size, GFP_KERNEL)
> 
> This code was detected with the help of Coccinelle.
[]
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
[]
> @@ -174,7 +174,7 @@ static int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
>  			num_ctrl++;
>  	}
>  
> -	len = num_ctrl * sizeof(struct a2mp_cl) + sizeof(*rsp);
> +	len = struct_size(rsp, cl, num_ctrl);
>  	rsp = kmalloc(len, GFP_ATOMIC);
>  	if (!rsp) {
>  		read_unlock(&hci_dev_list_lock);

At least a weakness in this code is len is u16
and struct_size is size_t so there's a size
truncation possible.


