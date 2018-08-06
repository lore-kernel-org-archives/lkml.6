Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DD7C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E40821A03
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E40821A03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbeHFMeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:34:08 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:57888 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727517AbeHFMeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:34:08 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76AOdxS025912;
        Mon, 6 Aug 2018 05:25:13 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2kn9j1j82s-1;
        Mon, 06 Aug 2018 05:25:12 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id E90E6611C8B1;
        Mon,  6 Aug 2018 05:26:34 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 6 Aug 2018
 11:25:11 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w76AP8J4008304; Mon,
 6 Aug 2018 11:25:08 +0100
Date:   Mon, 6 Aug 2018 11:25:08 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Stefan Popa <stefan.popa@analog.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Crestez Dan Leonard" <leonard.crestez@intel.com>
Subject: Re: [PATCH v3 3/6] regmap: Add regmap_noinc_read API
Message-ID: <20180806102508.GA32322@imbe.wolfsonmicro.main>
References: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
 <1533301341-26560-4-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1533301341-26560-4-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=663 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808060113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 04:02:18PM +0300, Stefan Popa wrote:
> From: Crestez Dan Leonard <leonard.crestez@intel.com>
> 
> The regmap API usually assumes that bulk read operations will read a
> range of registers but some I2C/SPI devices have certain registers for
> which a such a read operation will return data from an internal FIFO
> instead. Add an explicit API to support bulk read without range semantics.
> 
> Some linux drivers use regmap_bulk_read or regmap_raw_read for such
> registers, for example mpu6050 or bmi150 from IIO. This only happens to
> work because when caching is disabled a single regmap read op will map
> to a single bus read op (as desired). This breaks if caching is enabled and
> reg+1 happens to be a cacheable register.
> 
> Without regmap support refactoring a driver to enable regmap caching
> requires separate I2C and SPI paths. This is exactly what regmap is
> supposed to help avoid.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 4f38068..b6e6040 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -946,6 +946,8 @@ int regmap_raw_write_async(struct regmap *map, unsigned int reg,
>  int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
>  int regmap_raw_read(struct regmap *map, unsigned int reg,
>  		    void *val, size_t val_len);
> +int regmap_noinc_read(struct regmap *map, unsigned int reg,
> +		      void *val, size_t val_len);
>  int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
>  		     size_t val_count);
>  int regmap_update_bits_base(struct regmap *map, unsigned int reg,
> @@ -1196,6 +1198,13 @@ static inline int regmap_raw_read(struct regmap *map, unsigned int reg,
>  	return -EINVAL;
>  }
>  
> +static inline int regmap_pipe_read(struct regmap *map, unsigned int reg,
> +				   void *val, size_t val_len)
> +{
> +	WARN_ONCE(1, "regmap API is disabled");
> +	return -EINVAL;
> +}
> +

This is presumably supposed to be regmap_noinc_read.

Thanks,
Charles

