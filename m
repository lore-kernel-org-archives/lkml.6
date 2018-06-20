Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E172C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC6520874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC6520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754199AbeFTO0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:26:55 -0400
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:56610 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753619AbeFTO0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:26:53 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp1.it.da.ut.ee (Postfix) with ESMTP id 0D7699002E;
        Wed, 20 Jun 2018 17:26:51 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 59AC6220666; Wed, 20 Jun 2018 17:26:49 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 5380122009D;
        Wed, 20 Jun 2018 17:26:49 +0300 (EEST)
Date:   Wed, 20 Jun 2018 17:26:49 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     minyard@acm.org
cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] ipmi: Cleanup oops on initialization failure
In-Reply-To: <1529497606-3857-1-git-send-email-minyard@acm.org>
Message-ID: <alpine.LRH.2.21.1806201725520.28187@math.ut.ee>
References: <alpine.LRH.2.21.1806191553040.28622@math.ut.ee> <1529497606-3857-1-git-send-email-minyard@acm.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Commit 93c303d2045b3 "ipmi_si: Clean up shutdown a bit" didn't
> copy the behavior of the cleanup in one spot, it needed to
> check for a non-NULL interface before cleaning it up.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Tested-by: Meelis Roos <mroos@linux.ee>


The corresponding dmesg:

[    7.372830] IPMI System Interface driver.
[    7.373034] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[    7.373109] ipmi_si: SMBIOS: mem 0x0 regsize 1 spacing 1 irq 0
[    7.373182] ipmi_si: Adding SMBIOS-specified kcs state machine
[    7.373352] ipmi_si: Trying SMBIOS-specified kcs state machine at mem address 0x0, slave address 0x20, irq 0
[    7.373479] ipmi_si dmi-ipmi-si.0: Could not set up I/O space

> BTW, can you send me at least the IPMI portion of the output of
> dmidecode for your machine?  I have seen a lot of these where the
> address in the SMBIOS tables is incorrect, and I'm wondering if
> it's something in the driver, or if it's really the tables that
> are bad.

Handle 0x001B, DMI type 38, 18 bytes
IPMI Device Information
        Interface Type: KCS (Keyboard Control Style)
        Specification Version: 2.0
        I2C Slave Address: 0x10
        NV Storage Device: Not Present
        Base Address: 0x0000000000000000 (Memory-mapped)
        Register Spacing: Successive Byte Boundaries

> 
> Thanks for reporting this.  On your tested-by I'll send this up
> to Linus.
> 
> -corey
> 
>  drivers/char/ipmi/ipmi_si_intf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 3d0add6..a5987f8 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -2088,8 +2088,10 @@ static int try_smi_init(struct smi_info *new_smi)
>  	return 0;
>  
>  out_err:
> -	ipmi_unregister_smi(new_smi->intf);
> -	new_smi->intf = NULL;
> +	if (new_smi->intf) {
> +		ipmi_unregister_smi(new_smi->intf);
> +		new_smi->intf = NULL;
> +	}
>  
>  	kfree(init_name);
>  
> 

-- 
Meelis Roos (mroos@linux.ee)
