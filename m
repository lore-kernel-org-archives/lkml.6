Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F8DC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66768223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K+ym0fRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66768223F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeHJJuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:50:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42982 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeHJJuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:50:25 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7A7JNmP001356;
        Fri, 10 Aug 2018 07:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=2gkbcH0Y8qS+V1m/ydlCgT5QB0ezMdRDwLCDFAZLDp8=;
 b=K+ym0fRdCa+e7wHEC/+BkKYU7fyH1d6KwvabHo7afxw+qrsfiVmr83+QWvQHDTt/S0Tq
 qhuymh4pZgY3oAk3oqWSsp/3iRppM6fmtcHX31qBg2na7MuO2uFlzuGxY/cEqLyxLbX3
 4MwVwIkfz7coSv+q3WTQuHp3NBlq1qfTa5hUpR0DiGlisHCGA+5uV1jZXFSotSQn4J9t
 R4hg7R7SDLZvfM1m+tnYm1wO7qoGlnlowzuHfF4ynW4C6b4PlOExwajQg1WzLNPm5Ail
 5MRP5GbgcSiIV5P7DEMjsPy0abymVGHYRoXP0ScA/F+6lBfzDMnRQrUFq+jVvQshRjoa cA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2kn1nde89r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Aug 2018 07:21:09 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7A7L7S3004573
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Aug 2018 07:21:08 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7A7L40M010450;
        Fri, 10 Aug 2018 07:21:05 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Aug 2018 00:21:04 -0700
Date:   Fri, 10 Aug 2018 10:20:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Stefan Popa <stefan.popa@analog.com>
Cc:     kbuild-all@01.org, jic23@kernel.org, broonie@kernel.org,
        Stefan Popa <stefan.popa@analog.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] iio:adxl372: Add FIFO and interrupts support
Message-ID: <20180810072054.vemdubi6kna3bx2k@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533557087-10401-5-git-send-email-stefan.popa@analog.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8980 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808100080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

I love your patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Stefan-Popa/iio-accel-Add-adxl372-driver/20180807-050955
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg

smatch warnings:
drivers/iio/accel/adxl372.c:704 adxl372_buffer_postenable() error: buffer overflow 'adxl372_axis_lookup_table' 7 <= 7 (assuming for loop doesn't break)

# https://github.com/0day-ci/linux/commit/021923033c19a85fa8f99993de6591691ee67b1a
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 021923033c19a85fa8f99993de6591691ee67b1a
vim +704 drivers/iio/accel/adxl372.c

02192303 Stefan Popa 2018-08-06  686  
02192303 Stefan Popa 2018-08-06  687  static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
02192303 Stefan Popa 2018-08-06  688  {
02192303 Stefan Popa 2018-08-06  689  	struct adxl372_state *st = iio_priv(indio_dev);
02192303 Stefan Popa 2018-08-06  690  	unsigned int mask;
02192303 Stefan Popa 2018-08-06  691  	int i, ret;
02192303 Stefan Popa 2018-08-06  692  
02192303 Stefan Popa 2018-08-06  693  	ret = adxl372_set_interrupts(st, ADXL372_INT1_MAP_FIFO_FULL_MSK, 0);
02192303 Stefan Popa 2018-08-06  694  	if (ret < 0)
02192303 Stefan Popa 2018-08-06  695  		return ret;
02192303 Stefan Popa 2018-08-06  696  
02192303 Stefan Popa 2018-08-06  697  	mask = *indio_dev->active_scan_mask;
02192303 Stefan Popa 2018-08-06  698  
02192303 Stefan Popa 2018-08-06  699  	for (i = 0; i < ARRAY_SIZE(adxl372_axis_lookup_table); i++) {
02192303 Stefan Popa 2018-08-06  700  		if (mask == adxl372_axis_lookup_table[i].bits)
02192303 Stefan Popa 2018-08-06  701  			break;
02192303 Stefan Popa 2018-08-06  702  	}
02192303 Stefan Popa 2018-08-06  703  
02192303 Stefan Popa 2018-08-06 @704  	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
02192303 Stefan Popa 2018-08-06  705  	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
02192303 Stefan Popa 2018-08-06  706  					  indio_dev->masklength);
02192303 Stefan Popa 2018-08-06  707  	/*
02192303 Stefan Popa 2018-08-06  708  	 * The 512 FIFO samples can be allotted in several ways, such as:
02192303 Stefan Popa 2018-08-06  709  	 * 170 sample sets of concurrent 3-axis data
02192303 Stefan Popa 2018-08-06  710  	 * 256 sample sets of concurrent 2-axis data (user selectable)
02192303 Stefan Popa 2018-08-06  711  	 * 512 sample sets of single-axis data
02192303 Stefan Popa 2018-08-06  712  	 */
02192303 Stefan Popa 2018-08-06  713  	if ((st->watermark * st->fifo_set_size) > ADXL372_FIFO_SIZE)
02192303 Stefan Popa 2018-08-06  714  		st->watermark = (ADXL372_FIFO_SIZE  / st->fifo_set_size);
02192303 Stefan Popa 2018-08-06  715  
02192303 Stefan Popa 2018-08-06  716  	st->fifo_mode = ADXL372_FIFO_STREAMED;
02192303 Stefan Popa 2018-08-06  717  
02192303 Stefan Popa 2018-08-06  718  	ret = adxl372_configure_fifo(st);
02192303 Stefan Popa 2018-08-06  719  	if (ret < 0) {
02192303 Stefan Popa 2018-08-06  720  		st->fifo_mode = ADXL372_FIFO_BYPASSED;
02192303 Stefan Popa 2018-08-06  721  		adxl372_set_interrupts(st, 0, 0);
02192303 Stefan Popa 2018-08-06  722  		return ret;
02192303 Stefan Popa 2018-08-06  723  	}
02192303 Stefan Popa 2018-08-06  724  
02192303 Stefan Popa 2018-08-06  725  	return iio_triggered_buffer_postenable(indio_dev);
02192303 Stefan Popa 2018-08-06  726  }
02192303 Stefan Popa 2018-08-06  727  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
