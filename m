Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70ABC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A87D20659
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A87D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeK0C6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:58:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726210AbeK0C6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:58:16 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAQFxkFD102148
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:03:43 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p0jp2vdgr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:03:42 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Mon, 26 Nov 2018 16:03:42 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 26 Nov 2018 16:03:40 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAQG3dDh27721804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 16:03:39 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2492528073;
        Mon, 26 Nov 2018 16:03:39 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A337028059;
        Mon, 26 Nov 2018 16:03:38 +0000 (GMT)
Received: from [9.41.179.222] (unknown [9.41.179.222])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 26 Nov 2018 16:03:38 +0000 (GMT)
Subject: Re: [PATCH] fsi: occ: fix a NULL vs IS_ERR() check
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20181126081115.hmsplacwvcdvpvxn@kili.mountain>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Mon, 26 Nov 2018 10:03:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181126081115.hmsplacwvcdvpvxn@kili.mountain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18112616-0064-0000-0000-0000037B6B4D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010124; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123077; UDB=6.00582988; IPR=6.00903207;
 MB=3.00024337; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-26 16:03:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112616-0065-0000-0000-00003B76D2C7
Message-Id: <88940a85-8271-eeff-ee8d-4e7a2f3ea4cb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/2018 02:11 AM, Dan Carpenter wrote:
> The platform_device_register_full() function doesn't return NULL, it
> returns error pointers.
>
> Fixes: 4e01f5644463 ("fsi: Add On-Chip Controller (OCC) driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks.

Reviewed-by: Eddie James <eajames@linux.ibm.com>

> ---
>   drivers/fsi/fsi-occ.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index a2301cea1cbb..d8695f67622f 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -546,7 +546,7 @@ static int occ_probe(struct platform_device *pdev)
>
>   	hwmon_dev_info.id = occ->idx;
>   	hwmon_dev = platform_device_register_full(&hwmon_dev_info);
> -	if (!hwmon_dev)
> +	if (IS_ERR(hwmon_dev))
>   		dev_warn(dev, "failed to create hwmon device\n");
>
>   	return 0;

