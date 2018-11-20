Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589E9C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B191E20989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KiMC24kH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B191E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbeKUIY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:24:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38311 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeKUIYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:24:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so2241706plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 13:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UEnpv5rx553fHzcPn6ookDJ2Y+2fbNcLHH1cRiibPDE=;
        b=KiMC24kHid3MFII1BR2VlK+gNeWQ8bsFHmnLevRJ29HA9lY3E6SNIhMpBxXtf0dCVf
         30O0m74Ia+P3Py6s3QWPm/nJH3LcbZNxy4oPmYYP5CwWeq4Q+/CdXzudLUdWmROqOT2k
         pwWlATsi3ioNRhw2VmvDiUbSsp7vlDgJvC4Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UEnpv5rx553fHzcPn6ookDJ2Y+2fbNcLHH1cRiibPDE=;
        b=q4hhTueYdYYJc7Mp0ResZiT/QtoHxS3Im1JVkpf36PH3wiW2cMPXwqfK9ilG6qxc/y
         tB1IF7HhoDNC/3geKWRziG3vLiuCnt/BEEuxzVGVl+WbVO0nwKhKFjGoNr1748a+p5Bh
         FTRMyVlB/bh63sb1YTloyIACWwhJ+NMBPeW/y7yKrdFNPK+nQXXzOSGxYxvHLab04F/x
         5ojDFBHkJU6OCSR0NyEeOVtdmm/sA84AoXC9YpCgUUDk4Xhz6YwtFj3mS6P+WvbqNUSc
         6OxLJ8At2XWMabVa7vFrp6hMz6emt8ZmYpn8/EWberpxB7qCo6osMpDie+gkTl+FGBp1
         YUtg==
X-Gm-Message-State: AGRZ1gKTKiqTGrTExGJj51XW3KstelDa61ew7PdqWIaqKu5udjImSp0s
        D7shDYeACiE72X1RZgZcVR8Ttg==
X-Google-Smtp-Source: AJdET5cuFs1hE9AGKvoMJB1O1SDDouELg8aHEu2SSRDvBXI51t9osZygRK9JTSwLeMgrYvgOuXI7gg==
X-Received: by 2002:a62:cf02:: with SMTP id b2mr4107411pfg.183.1542750818536;
        Tue, 20 Nov 2018 13:53:38 -0800 (PST)
Received: from [10.69.36.116] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id e123sm45110256pgc.58.2018.11.20.13.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 13:53:37 -0800 (PST)
Subject: Re: [PATCH] scsi/lpfc/lpfc_sli.c: Use dma_zalloc_coherent
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        dick.kennedy@broadcom.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     jrdr.linux@gmail.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
References: <5bf1797b.1c69fb81.2368c.1ccc@mx.google.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <80744ca9-8439-814b-5564-95cd4dff2094@broadcom.com>
Date:   Tue, 20 Nov 2018 13:53:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <5bf1797b.1c69fb81.2368c.1ccc@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/2018 6:38 AM, Sabyasachi Gupta wrote:
> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_sli.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
> index 783a154..3491ff7 100644
> --- a/drivers/scsi/lpfc/lpfc_sli.c
> +++ b/drivers/scsi/lpfc/lpfc_sli.c
> @@ -6229,7 +6229,7 @@ lpfc_sli4_ras_dma_alloc(struct lpfc_hba *phba,
>   			goto free_mem;
>   		}
>   
> -		dmabuf->virt = dma_alloc_coherent(&phba->pcidev->dev,
> +		dmabuf->virt = dma_zalloc_coherent(&phba->pcidev->dev,
>   						  LPFC_RAS_MAX_ENTRY_SIZE,
>   						  &dmabuf->phys,
>   						  GFP_KERNEL);
> @@ -6240,7 +6240,6 @@ lpfc_sli4_ras_dma_alloc(struct lpfc_hba *phba,
>   					"6187 DMA Alloc Failed FW logging");
>   			goto free_mem;
>   		}
> -		memset(dmabuf->virt, 0, LPFC_RAS_MAX_ENTRY_SIZE);
>   		dmabuf->buffer_tag = i;
>   		list_add_tail(&dmabuf->list, &ras_fwlog->fwlog_buff_list);
>   	}

Looks fine.

-- james

Reviewed-by:   James Smart   <jsmart2021@gmail.com>

