Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65649C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C60F20840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rFxn8qfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C60F20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbeKIIVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:21:03 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47588 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbeKIIVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:21:02 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA8MYRRC076459;
        Thu, 8 Nov 2018 22:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=hPfxeBShALN7/wlmB4+CmitM5K785Dx7J+z/aocFeAk=;
 b=rFxn8qfVMs++TUaMMqr/bVhZk+Koh2ZW+yKlIq0MvQb/TiL+8tYnwsrGvPxIV45c30EJ
 Hk1u4ZmahZXWuE4HrksCRNe2FHGiAOU57qwP8HNRD0S3HoUp4TiHw3kHFsU9K7xnGHuM
 epYlyXkrPvc0yKGzoP9sepa+fjyDuNTlJyc0eDgKV0JBfMBrAhAscP5xKriorHKF0X0c
 syw6u7Ed6tqkjIaW2H3sS64D5G034ijl8dqr9KMGIERa4TCSt8AJmXzEzz1oBf2sWTMB
 g+FUCtUeHVoc9AK6zQxf3mAIP8bOZTg+iQ6HpYbAZRLh787goL44b0ZeFlswm9D4FjRM 3Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nh33uc79f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Nov 2018 22:43:09 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA8Mh7eI009217
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Nov 2018 22:43:08 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA8Mh6l8031696;
        Thu, 8 Nov 2018 22:43:06 GMT
Received: from [10.132.93.93] (/10.132.93.93)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Nov 2018 14:43:06 -0800
Subject: Re: [driver-core PATCH v6 3/9] device core: Consolidate locking and
 unlocking of parent and device
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     len.brown@intel.com, bvanassche@acm.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, jiangshanlai@gmail.com,
        linux-nvdimm@lists.01.org, pavel@ucw.cz, zwisler@kernel.org,
        tj@kernel.org, akpm@linux-foundation.org
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170041590.12967.4367086895437513524.stgit@ahduyck-desk1.jf.intel.com>
From:   jane.chu@oracle.com
Organization: Oracle Corporation
Message-ID: <791408d3-bf97-0f54-adc5-9b06540015c6@oracle.com>
Date:   Thu, 8 Nov 2018 14:43:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154170041590.12967.4367086895437513524.stgit@ahduyck-desk1.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9071 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811080190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alex,


On 11/08/2018 10:06 AM, Alexander Duyck wrote:
> +/*
> + * __device_driver_lock - release locks needed to manipulate dev->drv

You meant to say __device_driver_unlock, right?

> + * @dev: Device we will update driver info for
> + * @parent: Parent device. Needed if the bus requires parent lock
> + *
> + * This function will release the required locks for manipulating dev->drv.
> + * Normally this will just be the the @dev lock, but when called for a
> + * USB interface, @parent lock will be released as well.
> + */
> +static void __device_driver_unlock(struct device *dev, struct device *parent)
> +{
> +	device_unlock(dev);
> +	if (parent && dev->bus->need_parent_lock)
> +		device_unlock(parent);
> +}

-jane
