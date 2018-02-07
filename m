Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeBGDAr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 22:00:47 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:52742 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeBGDAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 22:00:46 -0500
Date: Wed, 7 Feb 2018 03:00:41 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: idt77252: Replace mdelay with usleep_range in
 idt77252_preset
In-Reply-To: <1516938138-27259-1-git-send-email-baijiaju1990@gmail.com>
Message-ID: <alpine.LFD.2.21.1802070237090.20018@eddie.linux-mips.org>
References: <1516938138-27259-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2018, Jia-Ju Bai wrote:

> diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
> index 0277f36..cea4bf2 100644
> --- a/drivers/atm/idt77252.c
> +++ b/drivers/atm/idt77252.c
> @@ -3563,7 +3563,7 @@ static int idt77252_preset(struct idt77252_dev *card)
>  
>  	/* Software reset */
>  	writel(SAR_CFG_SWRST, SAR_REG_CFG);
> -	mdelay(1);
> +	usleep_range(500, 1000);
>  	writel(0, SAR_REG_CFG);
>  
>  	IPRINTK("%s: Software resetted.\n", card->name);

 This is only called from the driver's ->probe method, so it looks to me 
indeed safe to sleep here.  A similar, more extensive clean-up seems due 
for 77252 older brother's driver nicstar.c.

 Out of curiosity I have looked up the SAR manual and it requires the 
SWRST bit to be asserted for at least 2 PCI clock cycles for the reset to 
be valid, so having the lower bound of .5ms still looks completely safe if 
not an overkill to me for real world applications where PCI is driven in 
the MHz clock range.

Reviewed-by: Maciej W. Rozycki <macro@linux-mips.org>

  Maciej
