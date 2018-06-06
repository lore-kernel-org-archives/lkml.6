Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbVfK70k"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E89260767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752333AbeFFOET (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:04:19 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37446 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751951AbeFFOES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:04:18 -0400
X-Google-Smtp-Source: ADUXVKJMt82kvQqmqYrDaVM7JVzgzy0dycDzWlrKKn5i3h0t/EbQAkYj1WpGTuwcxbb1yhpkfqooPw==
Reply-To: minyard@acm.org
Subject: Re: [PATCH] fix NULL device in ipmi_si error message
To: Meelis Roos <mroos@linux.ee>,
        openipmi-developer@lists.sourceforge.net
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <alpine.LRH.2.21.1806061604580.20960@math.ut.ee>
From: Corey Minyard <minyard@acm.org>
Message-ID: <14953c8b-e461-15d1-798f-39a1adbac0a6@acm.org>
Date: Wed, 6 Jun 2018 09:04:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1806061604580.20960@math.ut.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 08:11 AM, Meelis Roos wrote:
> I noticed that 4.17.0 logs the follwing during ipmi_si setup:
>
>   ipmi_si 0000:01:04.6: probing via PCI
>   (NULL device *): Could not setup I/O space
>   ipmi_si 0000:01:04.6: [mem 0xf5ef0000-0xf5ef00ff] regsize 1 spacing 1 irq 21
>
> Fix the "NULL device *) by moving io.dev assignment before its potential
> use by ipmi_pci_probe_regspacing().
>
> Result:
>   ipmi_si 0000:01:04.6: probing via PCI
>   ipmi_si 0000:01:04.6: Could not setup I/O space
>   ipmi_si 0000:01:04.6: [mem 0xf5ef0000-0xf5ef00ff] regsize 1 spacing 1 irq 21

Looks good, queued for next release.

It does raise the question of why the I/O space setup is failing on some 
system (other have
reported this, too).  I'm working on that.

Thanks,

-corey

> Signed-off-by: Meelis Roos <mroos@linux.ee>
>
> diff --git a/drivers/char/ipmi/ipmi_si_pci.c b/drivers/char/ipmi/ipmi_si_pci.c
> index f54ca6869ed2..022e03634ce2 100644
> --- a/drivers/char/ipmi/ipmi_si_pci.c
> +++ b/drivers/char/ipmi/ipmi_si_pci.c
> @@ -120,6 +120,8 @@ static int ipmi_pci_probe(struct pci_dev *pdev,
>   	}
>   	io.addr_data = pci_resource_start(pdev, 0);
>   
> +	io.dev = &pdev->dev;
> +
>   	io.regspacing = ipmi_pci_probe_regspacing(&io);
>   	io.regsize = DEFAULT_REGSIZE;
>   	io.regshift = 0;
> @@ -128,8 +130,6 @@ static int ipmi_pci_probe(struct pci_dev *pdev,
>   	if (io.irq)
>   		io.irq_setup = ipmi_std_irq_setup;
>   
> -	io.dev = &pdev->dev;
> -
>   	dev_info(&pdev->dev, "%pR regsize %d spacing %d irq %d\n",
>   		&pdev->resource[0], io.regsize, io.regspacing, io.irq);
>   
>
