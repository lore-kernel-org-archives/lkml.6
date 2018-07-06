Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A95C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D668F23FAD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UA8wMAoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D668F23FAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753578AbeGFJcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:32:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51864 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753061AbeGFJcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:32:01 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w669VneF119633;
        Fri, 6 Jul 2018 04:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530869509;
        bh=uaE0qAiH7NdBhKjA+u3R3aypZTrx5R5zIPtucxmW+IY=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=UA8wMAoaBYz+aQOBx4oCK1yP2MXzbxTuswNyKB3ZJXDvRan+QdCODIZvuD5DXeDL5
         q2clskOBrG/TZmbtbkB7PEuStBngmSFSci7bqlOZrnH8JLxJnTKmJmnttO46XrFAW6
         IizvtZESzEahon1wrmhqGm76pqN7Wx6FHJ1Z4lPg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w669VnQS020122;
        Fri, 6 Jul 2018 04:31:49 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 6 Jul
 2018 04:31:49 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 6 Jul 2018 04:31:49 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w669VjHW009972;
        Fri, 6 Jul 2018 04:31:46 -0500
Subject: Re: [PATCH v6 11/11] PCI: endpoint: Add MSI set maximum restriction.
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>,
        <shawn.lin@rock-chips.com>
References: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
 <5bceea0ec98a7436ac5960635898ddfbec2cf6e1.1529595907.git.gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <3a33b9b2-0afa-3639-12af-cea1083e2714@ti.com>
Date:   Fri, 6 Jul 2018 15:01:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <5bceea0ec98a7436ac5960635898ddfbec2cf6e1.1529595907.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 21 June 2018 09:31 PM, Gustavo Pimentel wrote:
> Add pci_epc_set_msi() maximum 32 interrupts validation.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Change v4->v5:
>  - New patch file.
> Change v5->v6:
>  - Nothing changed, just to follow the patch set version.
> 
>  drivers/pci/endpoint/pci-epc-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index c72e656..094dcc3 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -201,7 +201,8 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts)
>  	u8 encode_int;
>  	unsigned long flags;
>  
> -	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> +	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
> +	    interrupts > 32)
>  		return -EINVAL;
>  
>  	if (!epc->ops->set_msi)
> 
