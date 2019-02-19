Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E646EC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF4F21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfBSJWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:22:30 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:48768 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727961AbfBSJWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:22:30 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (uk.solarflare.com [193.34.186.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id C5D1EB00067;
        Tue, 19 Feb 2019 09:22:28 +0000 (UTC)
Received: from hgk-desktop.uk.solarflarecom.com (10.17.20.82) by
 ukex01.SolarFlarecom.com (10.17.10.4) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 09:22:23 +0000
Subject: Re: [PATCH AUTOSEL 3.18 12/16] sfc: suppress duplicate nvmem
 partition types in efx_ef10_mtd_probe
To:     Sasha Levin <sashal@kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
CC:     Edward Cree <ecree@solarflare.com>,
        "David S . Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
References: <20190215021546.179605-1-sashal@kernel.org>
 <20190215021546.179605-12-sashal@kernel.org>
From:   Bert Kenward <bkenward@solarflare.com>
Message-ID: <33b60bdb-8336-7ac0-4795-8cb3ceac167c@solarflare.com>
Date:   Tue, 19 Feb 2019 09:22:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190215021546.179605-12-sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.82]
X-ClientProxiedBy: ocex03.SolarFlarecom.com (10.20.40.36) To
 ukex01.SolarFlarecom.com (10.17.10.4)
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24438.003
X-TM-AS-Result: No-12.197600-8.000000-10
X-TMASE-MatchedRID: L8tZF6zWW2oOwH4pD14DsPHkpkyUphL9UAjrAJWsTe91/q26L79bTIiL
        OGSrOVCj0/tq6TtYaL2C0c/BwxTs6eF7Pq0Toovm9UVHiwLx0/IoUVkB7ifJnlIEge/2lT8AiqO
        LrgHmwxVOFu8ssjxG81dTP5dw4GERSOWjYlTyoLGiAZ3zAhQYgpHUt5D5WmclJLfQYoCQHFbX/y
        R7HIDNarOT0m5mbI8apcCRA28drskZ7Eu9TqPx8J4CIKY/Hg3AtOt1ofVlaoLUHQeTVDUrItRnE
        QCUU+jz9xS3mVzWUuA152LecOHHI58gti1SV0NX9KrZ3KtM1PrbI0PAS1eQZU2j09lMnQLQ09mI
        728lYDE=
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.197600-8.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24438.003
X-MDID: 1550568149-yxAu7RJMKLbO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2019 02:15, Sasha Levin wrote:
> From: Edward Cree <ecree@solarflare.com>
> 
> [ Upstream commit 3366463513f544c12c6b88c13da4462ee9e7a1a1 ]
> 
> Use a bitmap to keep track of which partition types we've already seen;
>  for duplicates, return -EEXIST from efx_ef10_mtd_probe_partition() and
>  thus skip adding that partition.
> Duplicate partitions occur because of the A/B backup scheme used by newer
>  sfc NICs.  Prior to this patch they cause sysfs_warn_dup errors because
>  they have the same name, causing us not to expose any MTDs at all.
> 
> Signed-off-by: Edward Cree <ecree@solarflare.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I don't think this particularly needs to go to stable, but if it does it
should be accompanied by:
  c65285428b6e ("sfc: initialise found bitmap in efx_ef10_mtd_probe")

Bert.

> ---
>  drivers/net/ethernet/sfc/ef10.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
> index 010009d64017..84a17b41313c 100644
> --- a/drivers/net/ethernet/sfc/ef10.c
> +++ b/drivers/net/ethernet/sfc/ef10.c
> @@ -3407,22 +3407,25 @@ static const struct efx_ef10_nvram_type_info efx_ef10_nvram_types[] = {
>  	{ NVRAM_PARTITION_TYPE_LICENSE,		   0,    0, "sfc_license" },
>  	{ NVRAM_PARTITION_TYPE_PHY_MIN,		   0xff, 0, "sfc_phy_fw" },
>  };
> +#define EF10_NVRAM_PARTITION_COUNT	ARRAY_SIZE(efx_ef10_nvram_types)
>  
>  static int efx_ef10_mtd_probe_partition(struct efx_nic *efx,
>  					struct efx_mcdi_mtd_partition *part,
> -					unsigned int type)
> +					unsigned int type,
> +					unsigned long *found)
>  {
>  	MCDI_DECLARE_BUF(inbuf, MC_CMD_NVRAM_METADATA_IN_LEN);
>  	MCDI_DECLARE_BUF(outbuf, MC_CMD_NVRAM_METADATA_OUT_LENMAX);
>  	const struct efx_ef10_nvram_type_info *info;
>  	size_t size, erase_size, outlen;
> +	int type_idx = 0;
>  	bool protected;
>  	int rc;
>  
> -	for (info = efx_ef10_nvram_types; ; info++) {
> -		if (info ==
> -		    efx_ef10_nvram_types + ARRAY_SIZE(efx_ef10_nvram_types))
> +	for (type_idx = 0; ; type_idx++) {
> +		if (type_idx == EF10_NVRAM_PARTITION_COUNT)
>  			return -ENODEV;
> +		info = efx_ef10_nvram_types + type_idx;
>  		if ((type & ~info->type_mask) == info->type)
>  			break;
>  	}
> @@ -3435,6 +3438,13 @@ static int efx_ef10_mtd_probe_partition(struct efx_nic *efx,
>  	if (protected)
>  		return -ENODEV; /* hide it */
>  
> +	/* If we've already exposed a partition of this type, hide this
> +	 * duplicate.  All operations on MTDs are keyed by the type anyway,
> +	 * so we can't act on the duplicate.
> +	 */
> +	if (__test_and_set_bit(type_idx, found))
> +		return -EEXIST;
> +
>  	part->nvram_type = type;
>  
>  	MCDI_SET_DWORD(inbuf, NVRAM_METADATA_IN_TYPE, type);
> @@ -3463,6 +3473,7 @@ static int efx_ef10_mtd_probe_partition(struct efx_nic *efx,
>  static int efx_ef10_mtd_probe(struct efx_nic *efx)
>  {
>  	MCDI_DECLARE_BUF(outbuf, MC_CMD_NVRAM_PARTITIONS_OUT_LENMAX);
> +	DECLARE_BITMAP(found, EF10_NVRAM_PARTITION_COUNT);
>  	struct efx_mcdi_mtd_partition *parts;
>  	size_t outlen, n_parts_total, i, n_parts;
>  	unsigned int type;
> @@ -3491,11 +3502,13 @@ static int efx_ef10_mtd_probe(struct efx_nic *efx)
>  	for (i = 0; i < n_parts_total; i++) {
>  		type = MCDI_ARRAY_DWORD(outbuf, NVRAM_PARTITIONS_OUT_TYPE_ID,
>  					i);
> -		rc = efx_ef10_mtd_probe_partition(efx, &parts[n_parts], type);
> -		if (rc == 0)
> -			n_parts++;
> -		else if (rc != -ENODEV)
> +		rc = efx_ef10_mtd_probe_partition(efx, &parts[n_parts], type,
> +						  found);
> +		if (rc == -EEXIST || rc == -ENODEV)
> +			continue;
> +		if (rc)
>  			goto fail;
> +		n_parts++;
>  	}
>  
>  	rc = efx_mtd_add(efx, &parts[0].common, n_parts, sizeof(*parts));
> 
