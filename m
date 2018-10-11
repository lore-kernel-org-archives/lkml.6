Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CC9C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285542087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IVwTSqzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285542087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeJKQKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:10:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40686 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeJKQKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:10:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9B8i8Y2043911;
        Thu, 11 Oct 2018 08:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=+DTx6A7pQHoBGR608TwcJkRlnmPCOICviT0wPy/UOK8=;
 b=IVwTSqzSBKsjRKH2byzbb6s+yJVqg3QLlHpgUP78y4MBOCab1PdCOc+VBBS2V5efsbEl
 WoQcug71AJXnnnQxiAkfp1QP2A+RapyLcNbBncOS84XKgSlqIOu9wG1pHqEiR7EgccF2
 VYkjf0CcNwHXM4lX3+RHZEMWBfb4LWI4JkRo9EHyQXtGCQ9mdwyBNv+F4IHChFM8XHms
 +qDcVF15bUwbHcPyuvs6Bov2KujA7v3w0WFxe0pqpvdLNGpJUgb8dhwV53EUrNp6udes
 v2rYxnY6ROu866tRb0D7k09udMmVmgLsyMs19EjvqU3fQceBlHxHcCsb/zCMrFKYQbsv Pw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mxnprakst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 08:44:22 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9B8iMdv004999
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 08:44:22 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9B8iLn5025307;
        Thu, 11 Oct 2018 08:44:21 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 08:44:21 +0000
Date:   Thu, 11 Oct 2018 11:44:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH] staging: erofs: harden inode lookup for 32-bit platforms
Message-ID: <20181011084413.3sovzgsj6pzyrml7@mwanda>
References: <20181009140713.29629-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009140713.29629-1-gaoxiang25@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=512
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 10:07:13PM +0800, Gao Xiang wrote:
> This patch introduces inode hash function, test and set callbacks,
> and iget5_locked to find the right inode for 32-bit platforms.
> 

The way I read this changelog, we're trying to deal with corrupt file
systems?  Is that correct?  Presumably in the current code it could lead
to a Oops or something?

regards,
dan carpenter

