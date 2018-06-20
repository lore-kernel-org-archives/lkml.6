Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D77C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B1B20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qfqh7bw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B1B20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbeFTKMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:12:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37962 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753930AbeFTKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:12:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KA8cQJ109223;
        Wed, 20 Jun 2018 10:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=g/QnWL633DATk/D0Ttai9VtCMe1kqYKn1pLuJll4508=;
 b=Qfqh7bw0H9TevJUshUfxX4olN8RaIRdMgo5M51eEwEMmiiLSuZhjSU77pS4T0MB9Rniz
 V9pIypmlOPFhvpBlY3RROCAvGmvaa96dm6F0gtwOLktCjzt/ZUUKXnRwosckjYYGz8Pi
 CovbYKNkr8vYWArkeevWt6yV6LfhLgRibQrO6HpbEvqs2JaM4A4TzbPrZxAELgWRMRNe
 MH7UcpIYSEvgehSFpf48Rnhl5Muv3+C3tGSnvLeatWkkdDD1WMDJydJu1EOxpRUB+k/7
 zMuaZsCw/69XMz0f7YC9JOik4pxV3UkMXmcQZKQDR0IdxXgVEX1+tk8cvVIf7cxRl8+/ gA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jmt01kugg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 10:12:18 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5KACIXW011951
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 10:12:18 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5KACIXf031816;
        Wed, 20 Jun 2018 10:12:18 GMT
Received: from mwanda (/197.157.34.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 03:12:17 -0700
Date:   Wed, 20 Jun 2018 13:12:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     gregkh@linuxfoundation.org, jananis37@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Fix a possible
 sleep-in-atomic-context bug in rtw_disassoc_cmd()
Message-ID: <20180620101208.whqtae6o6tcnmgyl@mwanda>
References: <20180620100119.8740-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620100119.8740-1-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=525
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

regards,
dan carpenter

