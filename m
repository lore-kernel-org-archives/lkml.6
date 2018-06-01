Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeFAAdh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 20:33:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51613 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751031AbeFAAdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 20:33:35 -0400
X-ME-Proxy: <xmx:XpQQW_GEux3gGwZmM7hjz7yVKGq77Fws39jr9GK_due0sc84EqQVeg>
X-ME-Proxy: <xmx:XpQQW4wfp-3G97IA7TbZiKgVGNyHEDG3YkjPgBhw0xY1hruw9gXcIg>
X-ME-Proxy: <xmx:XpQQW46-Noyw7RwLqi4XndTmQWKXGjNu5Kvx4zhbIFswjAuUyWM3vA>
X-ME-Proxy: <xmx:XpQQW98QsP2wyUr0LSMyj4fQ77eT7adEEIHQfPJikFl9Om-aDMUCRA>
X-ME-Proxy: <xmx:XpQQW8ofs1KtZrPKqLLzZr5wpcbCMBLF9Z0dRxPKqy_ZZpJPsfzhAg>
X-ME-Proxy: <xmx:XpQQW1mpnTpKgJNVn3kNSEGygf7YRPCOx27zeQOspf5t_mAT-4H_bg>
X-ME-Sender: <xms:XpQQWzls2OmqRBrXbtxtFRML8dcgSLJ_37SUzrFJ4Lk5Ir6pbENeUQ>
Message-ID: <c8013f0894299c6aedfbcd5e35f5fa33b858d915.camel@mendozajonas.com>
Subject: Re: [PATCH net-next] net/ncsi: Avoid GFP_KERNEL in response handler
From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
To: Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Date: Fri, 01 Jun 2018 10:33:27 +1000
In-Reply-To: <69fcb143-00a2-2ddf-e2d4-c692b650f292@gmail.com>
References: <20180531070254.28878-1-sam@mendozajonas.com>
         <69fcb143-00a2-2ddf-e2d4-c692b650f292@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-31 at 04:50 -0400, Eric Dumazet wrote:
> 
> On 05/31/2018 03:02 AM, Samuel Mendoza-Jonas wrote:
> > ncsi_rsp_handler_gc() allocates the filter arrays using GFP_KERNEL in
> > softirq context, causing the below backtrace. This allocation is only a
> > few dozen bytes during probing so allocate with GFP_ATOMIC instead.
> > 
> 
> Hi Samuel
> 
> You forgot to add
> 
> Fixes: 062b3e1b6d4f ("net/ncsi: Refactor MAC, VLAN filters")
> 
> size = (rsp->uc_cnt + rsp->mc_cnt + rsp->mixed_cnt) * ETH_ALEN;
> 
> -> seems to be able to reach more than few dozen bytes...

Hi Eric,

The NCSI spec (at least in the v1.1.0 version I'm looking at) sets the
total number of MAC address filters at 8, so we would be looking at a
maximum of 8 * ETH_ALEN = 48 bytes.
That said it shouldn't be too arduous to move the allocation to later in
the probe/configure cycle so if needed we could do that.

> 
> Also, what prevents ncsi_rsp_handler_gc() to be called multiples times ?
> 
> nc->mac_filter.addrs & nc->vlan_filter.vids would be re-allocated and memory would leak.
> 

Good point, we should put a check there just in case to see if it's
allocated. We should be safe though as ncsi_rsp_handler_gc() should only
be called via ncsi_probe_channel() which only happens through
ncsi_start_dev(), and addrs/vids is cleaned up in ncsi_remove_channel().
Rogue packets shouldn't hit the ncsi_rsp_handler_gc() handler without an
outstanding request.. but it probably is safer to check regardless.

Regards,
Sam
