Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44650C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A65A2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfABJ0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:26:17 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:37548 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728451AbfABJ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:26:16 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (uk.solarflare.com [193.34.186.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us4.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 01833B40068;
        Wed,  2 Jan 2019 09:26:15 +0000 (UTC)
Received: from hgk-desktop.uk.solarflarecom.com (10.17.20.82) by
 ukex01.SolarFlarecom.com (10.17.10.4) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 2 Jan 2019 09:26:08 +0000
Subject: Re: [PATCH] net: sfc: checks status of efx_mcdi_rpc
To:     Kangjie Lu <kjlu@umn.edu>
CC:     <pakki001@umn.edu>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181226050517.74381-1-kjlu@umn.edu>
From:   Bert Kenward <bkenward@solarflare.com>
Message-ID: <59347b7d-3b71-348a-9fba-c8a4cc73af3f@solarflare.com>
Date:   Wed, 2 Jan 2019 09:26:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181226050517.74381-1-kjlu@umn.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.82]
X-ClientProxiedBy: ocex03.SolarFlarecom.com (10.20.40.36) To
 ukex01.SolarFlarecom.com (10.17.10.4)
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24330.003
X-TM-AS-Result: No-5.956300-8.000000-10
X-TMASE-MatchedRID: pBwXUM+nCwsOwH4pD14DsPHkpkyUphL9vtVce6w5+K+pFqY8JHz7MIpb
        wG9fIuITrmdCENzlRmI5r9xVI8WH2z6e2U7joGs6XP5rFAucBUEF15s6prCIuwpcq1+LTpsUo8W
        MkQWv6iUD0yuKrQIMCBBWOoA5nlyNC24oEZ6SpSk6XEE7Yhw4Fk0eY87ooSGMUEeSIWllgkC6OR
        Df9cbUkpcUhpaXW2NDe5Y0uE82u9s=
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.956300-8.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24330.003
X-MDID: 1546421175-YPLAg4_GMMLT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 26/12/18 05:05, Kangjie Lu wrote:
> efx_mcdi_rpc() could fail. The fix checks its status and issues an error
> message if it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/net/ethernet/sfc/mcdi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
> index dfad93fca0a6..9486e6534dea 100644
> --- a/drivers/net/ethernet/sfc/mcdi.c
> +++ b/drivers/net/ethernet/sfc/mcdi.c
> @@ -1819,6 +1819,9 @@ void efx_mcdi_set_id_led(struct efx_nic *efx, enum efx_led_mode mode)
>  
>  	rc = efx_mcdi_rpc(efx, MC_CMD_SET_ID_LED, inbuf, sizeof(inbuf),
>  			  NULL, 0, NULL);
> +	if (rc)
> +		netif_err(efx, hw, efx->net_dev, "%s: failed rc=%d\n",
> +				__func__, rc);
>  }

efx_mcdi_rpc() already issues an error message on failure, so this doesn't add
anything beyond that.

Are you trying to address a particular issue with this patch?

Thanks,

Bert.
