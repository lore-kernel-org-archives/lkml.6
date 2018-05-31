Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754099AbeEaIua (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:50:30 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35397 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754040AbeEaIuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:50:24 -0400
X-Google-Smtp-Source: ADUXVKIKu4W7UCIdmRYGLWi9z2ODkxcAbJu+WmCYtA3hDASYwslNe++F59i54tU3ubgCTFqDAatHvQ==
Subject: Re: [PATCH net-next] net/ncsi: Avoid GFP_KERNEL in response handler
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
References: <20180531070254.28878-1-sam@mendozajonas.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <69fcb143-00a2-2ddf-e2d4-c692b650f292@gmail.com>
Date: Thu, 31 May 2018 04:50:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180531070254.28878-1-sam@mendozajonas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/31/2018 03:02 AM, Samuel Mendoza-Jonas wrote:
> ncsi_rsp_handler_gc() allocates the filter arrays using GFP_KERNEL in
> softirq context, causing the below backtrace. This allocation is only a
> few dozen bytes during probing so allocate with GFP_ATOMIC instead.
> 

Hi Samuel

You forgot to add

Fixes: 062b3e1b6d4f ("net/ncsi: Refactor MAC, VLAN filters")

size = (rsp->uc_cnt + rsp->mc_cnt + rsp->mixed_cnt) * ETH_ALEN;

-> seems to be able to reach more than few dozen bytes...

Also, what prevents ncsi_rsp_handler_gc() to be called multiples times ?

nc->mac_filter.addrs & nc->vlan_filter.vids would be re-allocated and memory would leak.
