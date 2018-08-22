Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4790C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A793214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QsQfpTl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A793214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeHVNMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:12:52 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:53050 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbeHVNMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:12:52 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 55FB610C0F1C;
        Wed, 22 Aug 2018 02:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1534931323; bh=BbyC9CD4q0CG4VG6AnUshrsSh9RVBJBI8SJUi7DRyW8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=QsQfpTl4Fm+s2NWkqPNygBkDX8geoSRFU40113CVqZv6iOgcr+ihftBB05Z/bBK4+
         t6lxSnOl8Z9gllggp2e94g0Tc5TESAuUE6xDsXTtM/JpI1lutKzfmXV5vH9YraHDjz
         qTdxEzKqFcCjrcALOF0Ol/XMtINRkj1utbaSND1jZxfQBP8rCAi3FTosRBHSp9+EKW
         dp3N/TL2F/5DUUsNDhul7FgGi/bkbsc6Vqnku4BZZThZh2V8W7Dw0GIl2ga8c+c6ou
         EtLWKFOfvrYCFhtZVwmkygbwUanybse4bWbgikjqzyVT7vE2UsbvlB8x9tQsnUdAJ6
         GEkmyE5B8zVyA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0E1E33A9B;
        Wed, 22 Aug 2018 02:48:43 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 22 Aug 2018 02:48:42 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 22 Aug 2018 11:48:40 +0200
Received: from [10.107.25.102] (10.107.25.102) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 22 Aug 2018 11:48:40 +0200
Subject: Re: [PATCH v2] PCI: dwc: fix scheduling while atomic issues
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20180821141512.368e3df2@xhacker.debian>
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <ae663623-6af5-9c53-0e4b-f48b9c517a46@synopsys.com>
Date:   Wed, 22 Aug 2018 10:45:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821141512.368e3df2@xhacker.debian>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.102]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng

On 21/08/2018 07:15, Jisheng Zhang wrote:
> When programming inbound/outbound atu, we call usleep_range() after
> each checking PCIE_ATU_ENABLE bit. Unfortunately, the atu programming
> can be called in atomic context:
> 
> inbound atu programming could be called through
> pci_epc_write_header()
>   =>dw_pcie_ep_write_header()
>     =>dw_pcie_prog_inbound_atu()
> 
> outbound atu programming could be called through
> pci_bus_read_config_dword()
>   =>dw_pcie_rd_conf()
>     =>dw_pcie_prog_outbound_atu()
> 
> Fix this issue by calling mdelay() instead.

Makes sense. Thanks.

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Regards,
Gustavo

> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
> 
> Since v1
>  - use mdelay() instead of udelay() to avoid __bad_udelay()
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 778c4f76a884..2153956a0b20 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -135,7 +135,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
>  		if (val & PCIE_ATU_ENABLE)
>  			return;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
>  }
> @@ -178,7 +178,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  		if (val & PCIE_ATU_ENABLE)
>  			return;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
>  }
> @@ -236,7 +236,7 @@ static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index,
>  		if (val & PCIE_ATU_ENABLE)
>  			return 0;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
>  
> @@ -282,7 +282,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
>  		if (val & PCIE_ATU_ENABLE)
>  			return 0;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 96126fd8403c..9f1a5e399b70 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -26,8 +26,7 @@
>  
>  /* Parameters for the waiting for iATU enabled routine */
>  #define LINK_WAIT_MAX_IATU_RETRIES	5
> -#define LINK_WAIT_IATU_MIN		9000
> -#define LINK_WAIT_IATU_MAX		10000
> +#define LINK_WAIT_IATU			9
>  
>  /* Synopsys-specific PCIe configuration registers */
>  #define PCIE_PORT_LINK_CONTROL		0x710
>
