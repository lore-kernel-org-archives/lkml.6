Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB96C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1824C2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfAGSnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:43:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726718AbfAGSni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:43:38 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x07IY85R119446
        for <linux-kernel@vger.kernel.org>; Mon, 7 Jan 2019 13:43:37 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pvba2uerm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 13:43:37 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Mon, 7 Jan 2019 18:43:36 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Jan 2019 18:43:33 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x07IhWbU22872174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 18:43:32 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE7FEAC060;
        Mon,  7 Jan 2019 18:43:32 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BDDAAC062;
        Mon,  7 Jan 2019 18:43:31 +0000 (GMT)
Received: from [9.41.179.222] (unknown [9.41.179.222])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  7 Jan 2019 18:43:31 +0000 (GMT)
Subject: Re: [PATCH] hwmon (occ): Fix potential integer overflow
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190107183431.GA12428@embeddedor>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Mon, 7 Jan 2019 12:43:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190107183431.GA12428@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19010718-0072-0000-0000-000003E5D0DF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010362; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000273; SDB=6.01143142; UDB=6.00595100; IPR=6.00923392;
 MB=3.00025019; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-07 18:43:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010718-0073-0000-0000-00004AB85C93
Message-Id: <c77ba012-e793-a4c0-00d5-90d4faa3d72a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/07/2019 12:34 PM, Gustavo A. R. Silva wrote:
> Cast get_unaligned_be32(...) to u64 in order to give the compiler
> complete information about the proper arithmetic to use and avoid
> a potential integer overflow.
>
> Notice that such function call is used in contexts that expect
> expressions of type u64 (64 bits, unsigned); and the following
> expressions are currently being evaluated using 32-bit
> arithmetic:
>
> val = get_unaligned_be32(&power->update_tag) *
>                          occ->powr_sample_time_us;
>
> val = get_unaligned_be32(&power->vdn.update_tag) *
>                          occ->powr_sample_time_us;

Thanks,

Reviewed-by: Eddie James <eajames@linux.ibm.com>

>
> Addresses-Coverity-ID: 1442357 ("Unintentional integer overflow")
> Addresses-Coverity-ID: 1442476 ("Unintentional integer overflow")
> Addresses-Coverity-ID: 1442508 ("Unintentional integer overflow")
> Fixes: ff692d80b2e2 ("hwmon (occ): Add sensor types and versions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/hwmon/occ/common.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index 423903f87955..391118c8aae8 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -380,8 +380,8 @@ static ssize_t occ_show_power_1(struct device *dev,
>   		val *= 1000000ULL;
>   		break;
>   	case 2:
> -		val = get_unaligned_be32(&power->update_tag) *
> -			occ->powr_sample_time_us;
> +		val = (u64)get_unaligned_be32(&power->update_tag) *
> +			   occ->powr_sample_time_us;
>   		break;
>   	case 3:
>   		val = get_unaligned_be16(&power->value) * 1000000ULL;
> @@ -425,8 +425,8 @@ static ssize_t occ_show_power_2(struct device *dev,
>   				       &power->update_tag);
>   		break;
>   	case 2:
> -		val = get_unaligned_be32(&power->update_tag) *
> -			occ->powr_sample_time_us;
> +		val = (u64)get_unaligned_be32(&power->update_tag) *
> +			   occ->powr_sample_time_us;
>   		break;
>   	case 3:
>   		val = get_unaligned_be16(&power->value) * 1000000ULL;
> @@ -463,8 +463,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
>   				       &power->system.update_tag);
>   		break;
>   	case 2:
> -		val = get_unaligned_be32(&power->system.update_tag) *
> -			occ->powr_sample_time_us;
> +		val = (u64)get_unaligned_be32(&power->system.update_tag) *
> +			   occ->powr_sample_time_us;
>   		break;
>   	case 3:
>   		val = get_unaligned_be16(&power->system.value) * 1000000ULL;
> @@ -477,8 +477,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
>   				       &power->proc.update_tag);
>   		break;
>   	case 6:
> -		val = get_unaligned_be32(&power->proc.update_tag) *
> -			occ->powr_sample_time_us;
> +		val = (u64)get_unaligned_be32(&power->proc.update_tag) *
> +			   occ->powr_sample_time_us;
>   		break;
>   	case 7:
>   		val = get_unaligned_be16(&power->proc.value) * 1000000ULL;
> @@ -491,8 +491,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
>   				       &power->vdd.update_tag);
>   		break;
>   	case 10:
> -		val = get_unaligned_be32(&power->vdd.update_tag) *
> -			occ->powr_sample_time_us;
> +		val = (u64)get_unaligned_be32(&power->vdd.update_tag) *
> +			   occ->powr_sample_time_us;
>   		break;
>   	case 11:
>   		val = get_unaligned_be16(&power->vdd.value) * 1000000ULL;
> @@ -505,8 +505,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
>   				       &power->vdn.update_tag);
>   		break;
>   	case 14:
> -		val = get_unaligned_be32(&power->vdn.update_tag) *
> -			occ->powr_sample_time_us;
> +		val = (u64)get_unaligned_be32(&power->vdn.update_tag) *
> +			   occ->powr_sample_time_us;
>   		break;
>   	case 15:
>   		val = get_unaligned_be16(&power->vdn.value) * 1000000ULL;

