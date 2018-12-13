Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BF1C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC312086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ncPdZiBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC312086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbeLMN3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:29:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58360 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbeLMN3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:29:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBDDITx1026042;
        Thu, 13 Dec 2018 13:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=v95cChzHaDHBtuhjlWIaenMjNKhGDJocW3FiFh6Qn8w=;
 b=ncPdZiBURaGhXdSU+7HuSrABGE6puBaw0OtUmKlbl1Ycm50W1b9x/KqCaw+dEzWyYAoS
 9OejSry27E345LH74QGgBT3ow7hpvZ5dAEPoR5wW/VP44esnqZVIChaj6/6Lih1Rt4g8
 g9yYGu91Fw0AeMkcdW5kkQIyP5JOwJY8WBNh6O1/OOi+R7Za/nW7fZNsBN4NdGs5IeLe
 sd+YUZDdAlm2ROkcX9+KYqOvgNfXKQFC3L+GSRsPxNB3nA+GrRotNnuuPMbA/oxKU18J
 Zc1sKWlMuuV7ZZCtLAlkTlcLFZGdxIa4NQIOXkM3HMfrSzq0OvrRgErh7jvNss5q2yIf tw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2pb3n75t06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Dec 2018 13:29:06 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBDDT5ZI020939
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Dec 2018 13:29:06 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBDDT5vX009338;
        Thu, 13 Dec 2018 13:29:05 GMT
Received: from kadam (/41.202.241.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Dec 2018 05:29:04 -0800
Date:   Thu, 13 Dec 2018 16:28:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de, stefan.popa@analog.co
Subject: Re: [PATCH 05/11] staging: iio: adc: ad7606: Add support for
 threaded irq
Message-ID: <20181213132853.GT3116@kadam>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
 <1544705183-13288-6-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544705183-13288-6-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9105 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812130117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 02:46:17PM +0200, Stefan Popa wrote:
> +static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	reinit_completion(&st->completion);
> +	gpiod_set_value(st->gpio_convst, 1);
> +	ret = wait_for_completion_timeout(&st->completion,
> +					  msecs_to_jiffies(1000));

We don't use this "ret".  It will introduce a set but not used warning
on new GCCs or static checkers or something.

> +	gpiod_set_value(st->gpio_convst, 0);
> +
> +	return iio_triggered_buffer_predisable(indio_dev);
> +}

regards,
dan carpenter
