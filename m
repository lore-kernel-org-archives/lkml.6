Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABA3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FAA217DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PTmIr3BH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FAA217DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeHVGkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 02:40:07 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50242 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeHVGkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 02:40:06 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7M3H91B015388;
        Tue, 21 Aug 2018 22:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534907829;
        bh=zC9hEUd65AchHZX3jNZ2mDhK0zmeSAZ4iVB/5yBIVus=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PTmIr3BHRo0anYTL58rFR0wup4BT1LZQUYQzLIA3c2+1oJ0tVyHPtdJC6sGdBztiD
         p+YkZfdN8EdKgezv/q24htI82xq6cA+n7ZbOT4BSzKs5GfBKu4zVzQnOwlOpiCsE4L
         jMW/HV0RwQFoRLoTl2Wz+Vb/o/obYCib1G8KteVM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7M3H9po014651;
        Tue, 21 Aug 2018 22:17:09 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 21
 Aug 2018 22:17:09 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 21 Aug 2018 22:17:08 -0500
Received: from [128.247.59.203] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7M3H8rx015289;
        Tue, 21 Aug 2018 22:17:08 -0500
Subject: Re: [PATCH] PM / OPP: Refactor counting of added OPPs for v2 to avoid
 unsupported OPPs
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Keerthy J <j-keerthy@ti.com>
References: <20180822031035.6937-1-d-gerlach@ti.com>
From:   Dave Gerlach <d-gerlach@ti.com>
Message-ID: <7ea15971-6e4e-b8f1-209b-4ca018bc1615@ti.com>
Date:   Tue, 21 Aug 2018 22:17:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180822031035.6937-1-d-gerlach@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 08/21/2018 10:10 PM, Dave Gerlach wrote:
> Currently the _of_add_opp_table_v2 call loops through the OPP nodes in
> the operating-points-v2 table in the device tree and calls
> _opp_add_static_v2 for each to add them to the table. It counts each
> iteration through this loop as an added OPP, however on platforms making
> use of the opp-supported-hw property, _opp_add_static_v2 does not add
> OPPs that are not seen as supported on the platform but still returns
> success, as this is valid. Because of this the count variable will
> contain the number of OPP nodes in the table in device tree but not
> necessarily the ones that are supported and actually added.
> 
> As this count value is what is checked to determine if there are any
> valid OPPs, if a platform has an operating-points-v2 table with all OPP
> nodes containing opp-supported-hw values that are not currently
> supported then _of_add_opp_table_v2 will fail to abort as it should due
> to an empty table.
> 
> Additionally, since commit 3ba98324e81a ("PM / OPP: Get
> performance state using genpd helper"), the same count variable is
> compared against the number of OPPs containing performance states and
> requires that either all or none have pstates set, however in the case
> of any opp table that has any entries that do not get added by
> _opp_add_static_v2 due to incompatible opp-supported-hw fields, these
> numbers will not match and _of_add_opp_table_v2 will incorrectly fail.
> 
> In order to ensure the count variable reflects the number of OPPs
> actually in the table, increment it during the existing loop which walks
> the opp table to check if pstate is set and then use that for the
> aforementioned checks.
> 
> Fixes: 3ba98324e81a ("PM / OPP: Get performance state using genpd helper")
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---

This is needed to fix cpufreq probe on TI am335x platforms. Seems that
arch/arm/boot/dts/am33xx.dtsi is the only operating-points-v2 table with
multiple opp-supported-hw entries which may not all be supported at once, and
this caused the count differences that led me here.

Regards,
Dave

>  drivers/opp/of.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 7af0ddec936b..f288f83a2e62 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -399,8 +399,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
>  
>  	/* We have opp-table node now, iterate over it and add OPPs */
>  	for_each_available_child_of_node(opp_np, np) {
> -		count++;
> -
>  		ret = _opp_add_static_v2(opp_table, dev, np);
>  		if (ret) {
>  			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
> @@ -411,15 +409,22 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
>  		}
>  	}
>  
> +	/*
> +	 * Iterate over the list of OPPs that were actually added, as
> +	 * OPPs not supported by the hardware will be ignored by
> +	 * _opp_add_static_v2 above.
> +	 */
> +	list_for_each_entry(opp, &opp_table->opp_list, node) {
> +		count++;
> +		pstate_count += !!opp->pstate;
> +	}
> +
>  	/* There should be one of more OPP defined */
>  	if (WARN_ON(!count)) {
>  		ret = -ENOENT;
>  		goto put_opp_table;
>  	}
>  
> -	list_for_each_entry(opp, &opp_table->opp_list, node)
> -		pstate_count += !!opp->pstate;
> -
>  	/* Either all or none of the nodes shall have performance state set */
>  	if (pstate_count && pstate_count != count) {
>  		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
> 

