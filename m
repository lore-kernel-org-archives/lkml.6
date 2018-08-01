Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38428C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E004720841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E004720841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387479AbeHAIOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:14:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:51030 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387419AbeHAIOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:14:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4EF48AEB9;
        Wed,  1 Aug 2018 06:30:14 +0000 (UTC)
Subject: Re: [PATCH 1/3] fcoe: fix use-after-free in fcoe_ctlr_els_send
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        ard <ard@kwaak.net>
References: <20180731134603.20089-1-jthumshirn@suse.de>
 <20180731134603.20089-2-jthumshirn@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <a3ad59a7-3ccb-46e7-60b6-6ce073417564@suse.de>
Date:   Wed, 1 Aug 2018 08:30:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731134603.20089-2-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 03:46 PM, Johannes Thumshirn wrote:
> KASAN reports a use-after-free in fcoe_ctlr_els_send() when we're
> sending a LOGO and have FIP debugging enabled. This is because we're
> first freeing the skb and then printing the frame's DID. But the DID
> is a member of the FC frame header which in turn is the skb's payload.
> 
> Exchange the debug print and kfree_skb() calls so we're not touching
> the freed data.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/scsi/fcoe/fcoe_ctlr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
> index ea23c8dffc25..ceb35ebbeb8f 100644
> --- a/drivers/scsi/fcoe/fcoe_ctlr.c
> +++ b/drivers/scsi/fcoe/fcoe_ctlr.c
> @@ -799,9 +799,9 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
>  	fip->send(fip, skb);
>  	return -EINPROGRESS;
>  drop:
> -	kfree_skb(skb);
>  	LIBFCOE_FIP_DBG(fip, "drop els_send op %u d_id %x\n",
>  			op, ntoh24(fh->fh_d_id));
> +	kfree_skb(skb);
>  	return -EINVAL;
>  }
>  EXPORT_SYMBOL(fcoe_ctlr_els_send);
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
