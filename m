Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70108C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABB720849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O2xdfgiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABB720849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeLLIX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:23:56 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55770 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeLLIX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:23:56 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBC8ItJT022607;
        Wed, 12 Dec 2018 08:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=EVauG/4yYiU14o01eHgkFQHILvaYWkMARZraDchJbmM=;
 b=O2xdfgiHmtjX+Y6Ys1+2XHPROESHpRF/4L3Dli9Ec1mlhpLCNsONPo7PRDA0vQsjsXj5
 hj2Z7IXIAAybxf/36Awr54KWGurdvlihmdoZ0GtoInlumeKgDAozyC2SRXvxWAmrQ8cy
 U05USUQHouG6pBLrK8y15Sk8BAqOMbpMbSAJKoXckDtLa3a4f6PYfZEGsVylFjtpU4za
 +7/vH7i2NhzvpyuWl81lDwDWlu47ubGogUhU210I3XvdlqO3kj4plymmOS3u7y3KAKiT
 DbvQi+yvJK4fuqXVKqahjyT71dZsMJGasJxqmqJ3z5OSb6TLi8b1kQtfUvQlE4BwIkhf Xg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2pawwp079h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 08:23:27 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBC8NQav032462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 08:23:26 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBC8NPwa021475;
        Wed, 12 Dec 2018 08:23:25 GMT
Received: from kadam (/197.157.0.38)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Dec 2018 00:23:24 -0800
Date:   Wed, 12 Dec 2018 11:23:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH 04/11] staging: iio: adt7316: fix handling of dac high
 resolution option
Message-ID: <20181212082315.GI3116@kadam>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
 <20181212005503.28054-5-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212005503.28054-5-jeremyfertic@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9104 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=884
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812120074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 05:54:56PM -0700, Jeremy Fertic wrote:
> @@ -651,10 +649,12 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
>  	u8 config3;
>  	int ret;
>  
> +	if (chip->id == ID_ADT7318 || chip->id == ID_ADT7519)
> +		return -EPERM;

return -EINVAL is more appropriate than -EPERM.

regards,
dan carpenter

