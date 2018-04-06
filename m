Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeDFLFQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 07:05:16 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37153 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeDFLFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 07:05:14 -0400
X-Google-Smtp-Source: AIpwx4/PaUboWx9mYy9oCdADMxswDRfFCpcxXN99xlEBV6mnHSe/nO1Dr2+FAey1JhJeM2ZgFcOVZw==
From: Esben Haabendal <esben.haabendal@gmail.com>
To: David Miller <davem@davemloft.net>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, richardcochran@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rasmus.villemoes@prevas.dk
Subject: Re: [PATCH 2/2] net: phy: dp83640: Read strapped configuration settings
References: <95678797-bd17-ba3f-8a70-a00b4792a258@gmail.com>
        <87d0zdjszu.fsf@haabendal.dk> <20180405204049.GD17495@lunn.ch>
        <20180405.222437.1573582680811455269.davem@davemloft.net>
Date: Fri, 06 Apr 2018 13:05:06 +0200
In-Reply-To: <20180405.222437.1573582680811455269.davem@davemloft.net> (David
        Miller's message of "Thu, 05 Apr 2018 22:24:37 -0400 (EDT)")
Message-ID: <87h8oo61el.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> writes:

> From: Andrew Lunn <andrew@lunn.ch>
> Date: Thu, 5 Apr 2018 22:40:49 +0200
>
>> Or could it still contain whatever state the last boot of Linux, or
>> maybe the bootloader, left the PHY in?
>
> Right, this is my concern as well.

I don't think that should happen.
With config_init() being called (in phy_init_hw()) after soft_reset(),
any state set by software should be cleared.

>From DP83620 datasheet description of what happens when BMCR_RESET is
set:

    The software reset will reset the device such that all registers
    will be reset to default values and the hardware configuration
    values will be maintained.

But something else that could be a concern is the risk that there is
boards out there with wrong hardware configuration, which works with
current Linux (because it ignores hardware configuration).  Such designs
could break with this patch.

If we need to safeguard against that, maybe we could just keep the
genphy_read_config() function in the kernel, and let board specific code
use it as a phy_fixup where hardware configuration is to be respected.

Would that be a better approach?

/Esben
