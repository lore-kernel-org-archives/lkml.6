Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD570C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858BF2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lPOXl7Ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858BF2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeH2U6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:58:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53172 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeH2U6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:58:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7TGwdRK119401;
        Wed, 29 Aug 2018 17:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=iVqs9FvoUPbucNRJIAwKNHnNwqVuyCxS5fyTCfHJ8vc=;
 b=lPOXl7OtK5TrhF23iQFyMZosj1b3GevplPs2/rwabtTWHDHUs5CEs4GPqzPooz+LViAB
 8U1APOQsbZnsjVFYsF3a8YbYj0Nku6wMOW5VNIeALTZcFm+42iChUEO43PabwJ9y+UP3
 eEeMYpw23QrqrUNIJU/Ni5S2N38VpFyGm6NYLvz+bC8kDR1jBdoyQg7jW4aoggOP6zuT
 ti8prguwE6Lmc4mEBPJVGLUyRpmYGIwcCMwf8uYFPNByJw5aTTMwI+Ms3brAWi/RjjGV
 O7nFlNhtxYQiaqYr2Z04pxVq0ZmowlRhrZNxv7thpRHgq+z+9jgh0yKckEt7cTA3x5HO bg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2m2yrqb08c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 17:00:08 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7TH06jt016839
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 17:00:07 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7TH054Z009788;
        Wed, 29 Aug 2018 17:00:05 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Aug 2018 10:00:05 -0700
Subject: Re: [PATCH net-next] rds: store socket timestamps as ktime_t
To:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Willem de Bruijn <willemb@google.com>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Avinash Repaka <avinash.repaka@oracle.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <20180829154732.844217-1-arnd@arndb.de>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <9758170c-d6f1-5d0a-b05c-12724ebaa0c6@oracle.com>
Date:   Wed, 29 Aug 2018 10:00:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829154732.844217-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=703
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808290173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/2018 8:47 AM, Arnd Bergmann wrote:
> rds is the last in-kernel user of the old do_gettimeofday()
> function. Convert it over to ktime_get_real() to make it
> work more like the generic socket timestamps, and to let
> us kill off do_gettimeofday().
> 
> A follow-up patch will have to change the user space interface
> to deal better with 32-bit tasks, which may use an incompatible
> layout for 'struct timespec'.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Thanks Arnd !!

FWIW,
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
