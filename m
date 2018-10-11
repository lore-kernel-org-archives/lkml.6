Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F191BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5FB20644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QM0+N7Tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5FB20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeJKKCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 06:02:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34442 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeJKKCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 06:02:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9B2Y3xs038976;
        Thu, 11 Oct 2018 02:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=tf7NkfKrH48e2kFu04yEKxEYj6d+2rO23TWBDgAE/9Y=;
 b=QM0+N7TvWXVEqe6xZuaJ89cJOeKBIX358NRuM9ZnstQ/jDLv6tGBfX8at+kb+I6Eecob
 y1ZNWHa6l452rpSEi9EzZaN3J6T1LyyoI1p5L/9DSqGv5KZrYO8nVpAAVGkIYneZN9o2
 Lhbv3t9dA5eJhKXzd07n5msYyGfjJ7Qg9LMEaq6qBsgel2tmHicFcZK4uYgRkJzBz/5R
 y6y8IaqGbCo5TyoUv2I9sNlA60sMKt6uwThuEoFqlsrUT7YifYQP0uqskU/pdRZ7LRpM
 xhqA47+u5vpB7jDqy5DjxSdvPS0UN8lBq7I9lFUx1CpcFvIdyg6zBGjhRiXyFraxU9Gv iQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mxmftypd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 02:37:40 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9B2bcEJ025948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 02:37:39 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9B2bbGE020948;
        Thu, 11 Oct 2018 02:37:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 02:37:37 +0000
To:     Lance Roy <ldr709@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 09/16] scsi: Replace spin_is_locked() with lockdep
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181003053902.6910-1-ldr709@gmail.com>
        <20181003053902.6910-10-ldr709@gmail.com>
Date:   Wed, 10 Oct 2018 22:37:34 -0400
In-Reply-To: <20181003053902.6910-10-ldr709@gmail.com> (Lance Roy's message of
        "Tue, 2 Oct 2018 22:38:55 -0700")
Message-ID: <yq1ftxd2opd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=448
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lance,

> lockdep_assert_held() is better suited to checking locking
> requirements, since it won't get confused when someone else holds the
> lock. This is also a step towards possibly removing spin_is_locked().

Applied to 4.20/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
