Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAC5C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DDA20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5d77/9HM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DDA20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbeLMBgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:36:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52006 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbeLMBgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:36:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBD1YgZI065164;
        Thu, 13 Dec 2018 01:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=xmV0A5TV/8mtaXlyW0PSnS7zQx8tYQMuwW+IDObcZSg=;
 b=5d77/9HME2u3ssjcjcbbcL/3q2Q3N6ObJzcbJ7hkud5S/1lyv1O8OIwonuZKe7dYT9hs
 pUa5esUGvMgwWeHezFcHVNPqM0r2wO0YEFx7lgcyFQFIW77gZC81aou2mhVNqg3d9e2S
 f6gB4WvEJeKKzOoGWsmeZF7RIAPZMP+J+quLjTYjDJza40debOr18QhOGjhd0cVHkub+
 CnVNbzU4Nr7rJnodHbPjgpnlZoQjXzEBMfGWuFrPkD/QWgIpfYL8JYuSKcqecEbVFJfn
 PUOrpLrBv7mKW+ZaNqcmyWw4svM+J4VtAk18xBtMpJwGFt1nuB7GNwFhWHV5NJmA9cMf sA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2pb7tf1cyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Dec 2018 01:36:12 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBD1aBBQ021982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Dec 2018 01:36:12 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBD1aB60032672;
        Thu, 13 Dec 2018 01:36:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Dec 2018 17:36:10 -0800
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>,
        Prasad B Munirathnam <prasad.munirathnam@microsemi.com>,
        Dave Carroll <david.carroll@microsemi.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: aacraid: change wait_sem to a completion
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181210213301.1065510-1-arnd@arndb.de>
Date:   Wed, 12 Dec 2018 20:36:07 -0500
In-Reply-To: <20181210213301.1065510-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Mon, 10 Dec 2018 22:32:40 +0100")
Message-ID: <yq1wooegqd4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9105 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=848
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812130012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> The wait_sem member is used like a completion, so we should use the
> respective API. The behavior is unchanged.

Applied to 4.21/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
