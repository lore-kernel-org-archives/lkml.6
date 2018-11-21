Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1567C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F77F21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F77F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbeKUVTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:19:21 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:20916 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbeKUVTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:19:20 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 430K3P5wcTz9vF7K;
        Wed, 21 Nov 2018 11:45:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id anB1K_LhuOkF; Wed, 21 Nov 2018 11:45:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 430K3P5Pw8z9vF7R;
        Wed, 21 Nov 2018 11:45:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 67FAC8B808;
        Wed, 21 Nov 2018 11:45:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lC8aQVMCjNZT; Wed, 21 Nov 2018 11:45:26 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F26F8B809;
        Wed, 21 Nov 2018 11:45:26 +0100 (CET)
Subject: Re: [PATCH 2/4] soc/fsl/qe: fix potential NULL pointer dereference in
 ucc_of_parse_tdm
To:     Wen Yang <wen.yang99@zte.com.cn>, qiang.zhao@nxp.com
Cc:     wang.yi59@zte.com.cn, zhong.weidong@zte.com.cn,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <1542786111-18648-1-git-send-email-wen.yang99@zte.com.cn>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d69e7c77-e9fa-470a-db9f-ff9cd0476334@c-s.fr>
Date:   Wed, 21 Nov 2018 11:45:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1542786111-18648-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/11/2018 à 08:41, Wen Yang a écrit :
> This patch fixes a possible null pointer dereference in
> ucc_of_parse_tdm, detected by the semantic patch
> deref_null.cocci, with the following warning:
> 
> ./drivers/soc/fsl/qe/qe_tdm.c:177:21-24: ERROR: pdev is NULL but dereferenced.
> 
> The following code has potential null pointer references:
>          pdev = of_find_device_by_node(np2);
>          if (!pdev) {
>                  ret = -EINVAL;
>                  pr_err("%pOFn: failed to lookup pdev\n", np2);
>                  of_node_put(np2);
>                  goto err_miss_siram_property;
>          }
> ...
> err_miss_siram_property:
>          devm_iounmap(&pdev->dev, utdm->si_regs);
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
> CC: Julia Lawall <julia.lawall@lip6.fr>
> ---
>   drivers/soc/fsl/qe/qe_tdm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
> index f78c346..166378b 100644
> --- a/drivers/soc/fsl/qe/qe_tdm.c
> +++ b/drivers/soc/fsl/qe/qe_tdm.c
> @@ -174,7 +174,8 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
>   	return ret;
>   
>   err_miss_siram_property:
> -	devm_iounmap(&pdev->dev, utdm->si_regs);
> +	if (pdev)
> +		devm_iounmap(&pdev->dev, utdm->si_regs);

You are just hiding the issue, not fixing it.

The problem is that pdev gets modified, so in any case that 
devm_iounmap() will fail even when the new pdev is valid, because the 
iomap was done with a different pdev.

Christophe



>   	return ret;
>   }
>   EXPORT_SYMBOL(ucc_of_parse_tdm);
> 
