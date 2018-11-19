Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B09C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C160F20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YLPygiRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C160F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbeKSXEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:04:49 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:40292 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbeKSXEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:04:49 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BF76A10C1605;
        Mon, 19 Nov 2018 04:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542631278; bh=F/lL5bPeEpK1wkZhlwxly1NwJSypToXOf9t0LA+Tm/4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=YLPygiReVpSV8nNFqgslHsFftdYF5/xmsLuFG//NF2FnKupCLUcprA5NaQjvhe5Gx
         IKhF7QMm7Y5ctjiRopIDw4uKpVavs2hkkpb1BHc6ke669MTfnpTbkI3fs9WbPN2tbz
         6pKkOU+WdOynuL0uIYykxNtR0E/bIUDbfwFfjEkOOls27VvxCQAjI8caviGerkN7YP
         6GwnklhxzB+r00FBjoz2r7BI+9jLzxXSZLVcyGrdzjSIAf0Q6WCwG355RQKW/bEAEQ
         WxsMFxm0LDLXRhDKdrepGbWV8zNlpx65aCl7CH5I3iBkyHDGrn3xhpkC5jVhIbJVEW
         z3yCBv8hgTHdw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 84BE23A1E;
        Mon, 19 Nov 2018 04:41:18 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 19 Nov 2018 04:41:18 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 19 Nov 2018 13:41:15 +0100
Received: from [10.0.2.15] (10.107.19.165) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 19 Nov
 2018 13:41:14 +0100
Subject: Re: [PATCH][i3c-next] i3c: master: fix mask operation by using the
 correct operator
To:     Colin King <colin.king@canonical.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181116184223.28240-1-colin.king@canonical.com>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <7d569740-e5d3-b8a6-79cf-9885039e53de@synopsys.com>
Date:   Mon, 19 Nov 2018 12:41:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116184223.28240-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.19.165]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Coling,


Thanks for your report.

On 16/11/18 18:42, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The masking operation on status is using a bitwise 'or' rather than
> a bitwise 'and' operator, and hence the result is always non-zero
> which is probably not what is intended. Fix this by using the correct
> operator.
>
> Detected by CoverityScan, CID#1475523 ("Wrong operator used")
>
> Fixes: 88acc98a712a ("i3c: master: Add driver for Synopsys DesignWare IP")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/i3c/master/dw-i3c-master.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 0153e6e9de52..b532e2c9cf5c 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -1085,7 +1085,7 @@ static irqreturn_t dw_i3c_master_irq_handler(int irq, void *dev_id)
>   
>   	spin_lock(&master->xferqueue.lock);
>   	dw_i3c_master_end_xfer_locked(master, status);
> -	if (status | INTR_TRANSFER_ERR_STAT)
> +	if (status & INTR_TRANSFER_ERR_STAT)
>   		writel(INTR_TRANSFER_ERR_STAT, master->regs + INTR_STATUS);
>   	spin_unlock(&master->xferqueue.lock);
>   
Acked-by: Vitor Soares <vitor.soares@synopsys.com>
