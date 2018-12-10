Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3340C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33472086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33472086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeLJLS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:18:58 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39800 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeLJLS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:18:57 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBABIamf104994;
        Mon, 10 Dec 2018 05:18:36 -0600
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBABIaW7007476
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 05:18:36 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 05:18:36 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 05:18:36 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBABIWup012385;
        Mon, 10 Dec 2018 05:18:33 -0600
Subject: Re: [PATCH 3/3] mtd: spi-nor: cadence-quadspi: Add support for Octal
 SPI controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181003165603.2579-1-vigneshr@ti.com>
 <20181003165603.2579-4-vigneshr@ti.com> <20181210094513.6282d55e@bbrezillon>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <f6c3a649-f580-513d-644d-5010b3b5cf0b@ti.com>
Date:   Mon, 10 Dec 2018 16:49:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210094513.6282d55e@bbrezillon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/18 2:15 PM, Boris Brezillon wrote:
> On Wed, 3 Oct 2018 22:26:03 +0530
> Vignesh R <vigneshr@ti.com> wrote:
> 
>> Cadence OSPI controller IP supports Octal IO (x8 IO lines),
>> It also has an integrated PHY. IP register layout is very
>> similar to existing QSPI IP except for additional bits to support Octal
>> and Octal DDR mode. Therefore, extend current driver to support Octal
>> mode.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  drivers/mtd/spi-nor/cadence-quadspi.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
>> index e24db817154e..48b00e75a879 100644
>> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
>> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
>> @@ -101,6 +101,7 @@ struct cqspi_st {
>>  #define CQSPI_INST_TYPE_SINGLE			0
>>  #define CQSPI_INST_TYPE_DUAL			1
>>  #define CQSPI_INST_TYPE_QUAD			2
>> +#define CQSPI_INST_TYPE_OCTAL			3
>>  
>>  #define CQSPI_DUMMY_CLKS_PER_BYTE		8
>>  #define CQSPI_DUMMY_BYTES_MAX			4
>> @@ -898,6 +899,9 @@ static int cqspi_set_protocol(struct spi_nor *nor, const int read)
>>  		case SNOR_PROTO_1_1_4:
>>  			f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
>>  			break;
>> +		case SNOR_PROTO_1_1_8:
>> +			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
>> +			break;
>>  		default:
>>  			return -EINVAL;
>>  		}
>> @@ -1205,6 +1209,7 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
>>  			SNOR_HWCAPS_READ_FAST |
>>  			SNOR_HWCAPS_READ_1_1_2 |
>>  			SNOR_HWCAPS_READ_1_1_4 |
>> +			SNOR_HWCAPS_READ_1_1_8 |
> 
> Is this really supported on qspi versions of this IP? I guess not given
> the description in the commit message and the name of the new
> compatible (ospi instead of qspi).

No, qspi version does not support Octal mode. I guess you are pointing
out its logically wrong for driver with "*-qspi" compatible to declare
SNOR_HWCAPS_READ_1_1_8 capability.
Will update patch to declare SNOR_HWCAPS_READ_1_1_8 based on compatible.

> 
>>  			SNOR_HWCAPS_PP,
>>  	};
>>  	struct platform_device *pdev = cqspi->pdev;
>> @@ -1456,6 +1461,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
>>  		.compatible = "ti,k2g-qspi",
>>  		.data = (void *)CQSPI_NEEDS_WR_DELAY,
>>  	},
>> +	{
>> +		.compatible = "ti,am654-ospi",
>> +		.data = (void *)CQSPI_NEEDS_WR_DELAY,
>> +	},
>>  	{ /* end of table */ }
>>  };
>>  
> 

-- 
Regards
Vignesh
