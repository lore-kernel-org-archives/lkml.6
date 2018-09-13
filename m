Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B67F8183A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B5221522
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B5221522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeIMVKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:10:13 -0400
Received: from ale.deltatee.com ([207.54.116.67]:44102 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbeIMVKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:10:13 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g0U2D-0000rp-Px; Thu, 13 Sep 2018 10:00:02 -0600
To:     Wesley.Sheng@microchip.com, kurt.schwemmer@microsemi.com,
        Kurt.Schwemmer@microchip.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <DM2PR11MB0105EC547AFBB2DFA9D05A17951A0@DM2PR11MB0105.namprd11.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <fc563e88-7ab0-822a-9238-859cf8c08fbe@deltatee.com>
Date:   Thu, 13 Sep 2018 10:00:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DM2PR11MB0105EC547AFBB2DFA9D05A17951A0@DM2PR11MB0105.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, Kurt.Schwemmer@microchip.com, kurt.schwemmer@microsemi.com, Wesley.Sheng@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] switchtec: Remove immediate status check after submit a
 MRPC command
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/09/18 12:43 AM, Wesley.Sheng@microchip.com wrote:
> From: Wesley Sheng <Wesley.Sheng@microchip.com>

You've done something wrong here. The sign-off line below says its
signed off by Kelvin, who was the original author (on the github repo)
but the From: line indicates you were the author. Also, please start
using 'git send-email' as your patches are being mangled by your email
client.

> To avoid this, the immediate check of status is removed
> in this patch, and driver delays the status check to the
> occurrence of MSIx or MRPC timeout. In the meanwhile, user
> must not initiate any gas access during a firmware download.

s/meanwhile/meantime/

> Note: For NTB function, the memory window access is handled
> by switchtec hardware. So it's not affected by this firmware
> limitation. But the GAS accesses, like for doorbell registers,
> in the NTB function are affected by this firmware limitation.
> 
> Signed-off-by: Kelvin Cao <Kelvin.Cao@microchip.com>

We also need a Signed-off-by from you. Anyone who handled the patch
needs to sign off on it.

At least for the contents of the changes, modulo the above fixes:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/pci/switch/switchtec.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 4591f15..b759228 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -142,10 +142,6 @@ static void mrpc_cmd_submit(struct switchtec_dev *stdev)
>  		    stuser->data, stuser->data_len);
>  	iowrite32(stuser->cmd, &stdev->mmio_mrpc->cmd);
>  
> -	stuser->status = ioread32(&stdev->mmio_mrpc->status);
> -	if (stuser->status != SWITCHTEC_MRPC_STATUS_INPROGRESS)
> -		mrpc_complete_cmd(stdev);
> -
>  	schedule_delayed_work(&stdev->mrpc_timeout,
>  			      msecs_to_jiffies(500));
>  }
> 
