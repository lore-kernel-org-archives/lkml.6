Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C79C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BA52077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BA52077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeIERPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:15:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbeIERPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:15:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6446240216E3;
        Wed,  5 Sep 2018 12:45:09 +0000 (UTC)
Received: from [10.43.2.69] (unknown [10.43.2.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 305C52142F20;
        Wed,  5 Sep 2018 12:45:08 +0000 (UTC)
Subject: Re: [PATCH net] be2net: Fix memory leak in
 be_cmd_get_profile_config()
To:     Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc:     Sathya Perla <sathya.perla@broadcom.com>,
        Ajit Khaparde <ajit.khaparde@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <20180905123746.7399-1-poros@redhat.com>
From:   Ivan Vecera <ivecera@redhat.com>
Message-ID: <4d28cb4d-a4e1-520d-27ee-ade1d4fb4fe4@redhat.com>
Date:   Wed, 5 Sep 2018 14:45:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905123746.7399-1-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 12:45:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 12:45:09 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ivecera@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.9.2018 14:37, Petr Oros wrote:
> DMA allocated memory is lost in be_cmd_get_profile_config() when we
> call it with non-NULL port_res parameter.
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/emulex/benet/be_cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
> index ff92ab1daeb8..1e9d882c04ef 100644
> --- a/drivers/net/ethernet/emulex/benet/be_cmds.c
> +++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
> @@ -4500,7 +4500,7 @@ int be_cmd_get_profile_config(struct be_adapter *adapter,
>  				port_res->max_vfs += le16_to_cpu(pcie->num_vfs);
>  			}
>  		}
> -		return status;
> +		goto err;
>  	}
>  
>  	pcie = be_get_pcie_desc(resp->func_param, desc_count,
> 

Good catch, Petr.

Reviewed-by: Ivan Vecera <ivecera@redhat.com>
