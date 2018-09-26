Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84031C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B2E2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="URV++VXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B2E2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeIZGza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 02:55:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54528 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeIZGz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 02:55:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8Q0iMrg188087;
        Wed, 26 Sep 2018 00:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=JL6NBRksQqRxvivNTU570LUzSfCFvQQYxnhTllGBtFs=;
 b=URV++VXw/P/AIXn51615PI0hBfBitW/pJGapuMGljE9L9RTexpMZSUS1hI2SW7Mrvet2
 rrzbnKjDn3VQZZwALWT0jU1MRh1Nt1BrFA5QgXPhmBkuE9LHJKPRr13z+XFf6YA7qwDG
 AF8LbECJeHA0nXCbML2d47M3WzVS7877PI1oebXAB1C9BGVn4dF0hjscezf90/Y2qDL1
 EvVtdSGb8mYyZUN0DM+l5bsxENjuiZH1v/y60B2H67Ps6bPdCurzUNZrrKbTrbJF2I3t
 bOR88ejv9lltxYlTAdPFEIUXWEdbR7Fvabsm98KrJSfk64RQxjJ+LmdnDzeiPLkT0BtM QA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mnvtup5b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 00:45:09 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8Q0j87F009881
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 00:45:09 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8Q0j7fH027482;
        Wed, 26 Sep 2018 00:45:08 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Sep 2018 17:45:07 -0700
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     <martin.petersen@oracle.com>, <don.brace@microsemi.com>,
        <jejb@linux.vnet.ibm.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] scsi: Use vmemdup_user to replace the open code
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1537286081-63081-1-git-send-email-zhongjiang@huawei.com>
Date:   Tue, 25 Sep 2018 20:45:05 -0400
In-Reply-To: <1537286081-63081-1-git-send-email-zhongjiang@huawei.com> (zhong
        jiang's message of "Tue, 18 Sep 2018 23:54:41 +0800")
Message-ID: <yq17ej9hysu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9027 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=397
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809260006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


zhong,

> vmemdup_user is better than duplicating its implementation, So just
> replace the open code.

Applied to 4.20/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
