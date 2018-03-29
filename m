Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbeC2EDo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 00:03:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42042 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeC2EDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 00:03:43 -0400
X-Google-Smtp-Source: AIpwx49io6tCw8bqMQ6/VtYxu9Hon9cMB/7QwQDpjN793lSYfTc13HH+bzyRvEpl0QFNM+5iL82P1g==
Subject: Re: [PATCH v2 1/1] xen-netback: process malformed sk_buff correctly
 to avoid BUG_ON()
To: Dongli Zhang <dongli.zhang@oracle.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, paul.durrant@citrix.com, wei.liu2@citrix.com
References: <1522295463-469-1-git-send-email-dongli.zhang@oracle.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <2c741a81-23b3-fa26-89b2-6c3d94b20b96@gmail.com>
Date: Wed, 28 Mar 2018 21:03:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522295463-469-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/28/2018 08:51 PM, Dongli Zhang wrote:
> The "BUG_ON(!frag_iter)" in function xenvif_rx_next_chunk() is triggered if
> the received sk_buff is malformed, that is, when the sk_buff has pattern
> (skb->data_len && !skb_shinfo(skb)->nr_frags). Below is a sample call
> stack:
> 
>...


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
> skb_shinfo(skb)->nr_frags = 0;
> dev->netdev_ops->ndo_start_xmit(skb, dev);
>

This would be a serious bug in the provider of such skb.

Are you sure you do not have instead an skb with a chain of skbs ?

(skb_shinfo(skb)->frag_list would be not NULL)

Maybe your driver is wrongly advertising NETIF_F_FRAGLIST

commit 2167ca029c244901831 would be the bug origin then...
