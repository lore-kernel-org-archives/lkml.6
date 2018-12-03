Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360AFC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09C420848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CmR716NO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09C420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeLCPwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:52:10 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54240 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeLCPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:52:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB3Fq4Cv069988;
        Mon, 3 Dec 2018 09:52:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543852324;
        bh=/EduC2HRNa2VQ0Sarzoc8J7zuv2bCGETbM1ad0cRdcY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=CmR716NOf3r5BlsUhEFJArZyAHCPt6qAHGYjTwqlAPB9xtKiTAFd1cpxFQvMwoLu0
         xmHHE0RPtFyI17Ks+kr/knkRGcrtqRSpdIJt/jfmHPfjRv3QSxu4hTw+nfvbaAzKru
         ZFX52XPGViEB+RjwzV472+hCPbla+1um9TNWgLMY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB3Fq4bW064719
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 09:52:04 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 3
 Dec 2018 09:52:03 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 3 Dec 2018 09:52:03 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB3Fq3oZ029419;
        Mon, 3 Dec 2018 09:52:03 -0600
Date:   Mon, 3 Dec 2018 09:51:50 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] mailbox: ti-msgmgr: Off by one in ti_msgmgr_of_xlate()
Message-ID: <20181203155150.ohsc42cbbkkgrvsm@kahuna>
References: <20181203145011.7s3udfz4cug3ph3k@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181203145011.7s3udfz4cug3ph3k@kili.mountain>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:50-20181203, Dan Carpenter wrote:
> The > comparison should be >= or we access one element beyond the end
> of the array.
> 
> (The inst->qinsts[] array is allocated in the ti_msgmgr_probe() function
> and it has ->num_valid_queues elements.)
> 
> Fixes: a2b79838b891 ("mailbox: ti-msgmgr: Add support for Secure Proxy")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/mailbox/ti-msgmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
> index 713d701b6568..6f6addd51d14 100644
> --- a/drivers/mailbox/ti-msgmgr.c
> +++ b/drivers/mailbox/ti-msgmgr.c
> @@ -547,7 +547,7 @@ static struct mbox_chan *ti_msgmgr_of_xlate(struct mbox_controller *mbox,
>  	}
>  
>  	if (d->is_sproxy) {
> -		if (req_pid > d->num_valid_queues)
> +		if (req_pid >= d->num_valid_queues)
>  			goto err;
>  		qinst = &inst->qinsts[req_pid];
>  		return qinst->chan;
> -- 
> 2.11.0
> 

OOpps.. Thanks for catching it.

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
