Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F33AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB5121871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3rJ+zKvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfADGMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:12:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60984 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfADGMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 01:12:03 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0469DNf120714;
        Fri, 4 Jan 2019 06:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=8zIchHV4RQyk+6MQv0cOkh7RiQWpg8cazpdY8JNeqoI=;
 b=3rJ+zKvprXsprmcPrlvEAYLSL3x6qTppLfGHicSBD7jjMzJwhO8GzEYyHehypEq3HMiY
 biq3FfbJ+cabkEb33nvbq8uroZjES4jo3JAwL/5zgcmMalO/KxEwPuQCXXb0Z4HCZHA+
 7Nw+nuNcwRvIb+LHm9Xua2OUFl4o2m/R5uA+yaPtP7IPoVD3iPSYu1qSEk+AVSwbh8tF
 U42K/dfA+IXXWljj5ntKmcbydZalNLHY0zbfQ7WRZPIVCEbUbNp/IjUPg65zFnr7IXtH
 RRz4btqpq5pdLSQcq9SCJT5oQ+CT8iJ7apL/jL0Kdd4EP9K5EUdw858/M/XWSzEIr4zg NA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2pnxeeapu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jan 2019 06:11:54 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x046Brwi028394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jan 2019 06:11:53 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x046BqK9022808;
        Fri, 4 Jan 2019 06:11:52 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 22:11:51 -0800
To:     Randall Huang <ihhuang@abmail.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        jejb@linux.vnet.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, huangrandall@google.com
Subject: Re: [PATCH] scsi: associate bio write hint with WRITE CDB
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181226041504.66283-1-huangrandall@google.com>
        <20190103075133.GA5141@infradead.org>
        <20190103094755.GA96532@google.com>
        <e5bc96cd-1b48-3b7e-706f-4cbbd1a040a4@interlog.com>
        <6152b478ea77dacf57eef6f758ba795f756cd3da.camel@redhat.com>
        <yq1ef9t81fh.fsf@oracle.com> <20190104052251.GA205256@google.com>
Date:   Fri, 04 Jan 2019 01:11:49 -0500
In-Reply-To: <20190104052251.GA205256@google.com> (Randall Huang's message of
        "Fri, 4 Jan 2019 13:22:51 +0800")
Message-ID: <yq15zv56jfe.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9125 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=907
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901040054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Randall,

> I am working on Android phone.

> The idea is to enable write hint for Turbo write UFS feature.  Turbo
> write feature in UFS 3.x is under discussion in JEDEC JC-64.  This
> patch is the under-lying framework for supporting this feature.

OK, but we can't blindly go setting GROUP NUMBER to a non-zero value.
That'll break a massive amount of devices which will fail READ/WRITE
commands with INVALID FIELD IN CDB.

So aside from requiring the device to report GROUP_SUP=1, we'll need
some sort of indication that this device supports the UFS Turbo Write
feature. If you are engaged with JEDEC on this, please tell them we'll
need a VPD page, a mode page, or something similar to use as trigger to
entertain enabling this feature.

-- 
Martin K. Petersen	Oracle Linux Engineering
