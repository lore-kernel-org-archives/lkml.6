Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755639AbeDZKnO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:43:14 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:58980 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754630AbeDZKnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:43:03 -0400
Subject: Re: [PATCH] net: dwc-xlgmac: fix xlgmac_xmit()'s return type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20180424131733.4510-1-luc.vanoostenryck@gmail.com>
CC: Jose Abreu <Jose.Abreu@synopsys.com>, <netdev@vger.kernel.org>
From: Jose Abreu <Jose.Abreu@synopsys.com>
Message-ID: <9521fd13-883b-51ae-de15-393a2da8e62e@synopsys.com>
Date: Thu, 26 Apr 2018 11:42:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180424131733.4510-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.31]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-04-2018 14:17, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
>
> Fix this by returning 'netdev_tx_t' in this driver too.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---

I wouldn't do this because of at least two reasons:
    - xlgmac_xmit() calls xlgmac_maybe_stop_tx_queue() and
xlgmac_prep_tso(), and this last one can return a negative error
code. I expect some others drivers to have similar behavior.
    - If you look along net subsystem you will see that this enum
is directly converted to an int in later stages.

So, and given that you sent a large number of patches about this,
perhaps it would be more clear to change the function definition?

Thanks and Best Regards,
Jose Miguel Abreu
