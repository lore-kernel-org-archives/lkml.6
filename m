Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A08DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E6E20651
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NvjQZHCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfAQC2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 21:28:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53746 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfAQC2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 21:28:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0H2OMjh031541;
        Thu, 17 Jan 2019 02:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=+HEw9IuhPiwzjj+Ev4qasNXV6SV5pqUqrHk4ex3X8+4=;
 b=NvjQZHCDk+GBvfsKaklt9KLmPbs7c6m0DBklMRThcbrMgCoEU8bkyQcvVIa9wNxjbeds
 bLqcgKSy6v/Q3tE2U4jVcWmyMmOy6cKzBRXw/HgZO3K6aTqK2Et4OXK4utdowHzZwyG2
 /xZB88YFg9tKewTroYwMkNKtH/UnVSevb31YO8AikvuztJDo8vAxTJd/p+784devhdWH
 ME4KEeG+qOtZlFe/vK5yc0ZVMFacEak4Y73WytXLFuF+WbKszNmb5tRT2UyghuFvWrRZ
 OfSS2OoMs9Rhy60sajCRJIB++nH3LT/HkdI1BEnGws8ZA75Zgg0yZ2UpSyDTM7SIVeTA JA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2pybkcnbg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 02:28:12 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0H2SB81014252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 02:28:11 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0H2SBBZ011591;
        Thu, 17 Jan 2019 02:28:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Jan 2019 18:28:11 -0800
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 5/8] scsi: ufs: qcom: Expose the reset controller for PHY
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190111230129.127037-1-evgreen@chromium.org>
        <20190111230129.127037-6-evgreen@chromium.org>
        <a289d841-858d-5583-ce9a-8dc0f2d18a78@ti.com>
Date:   Wed, 16 Jan 2019 21:28:07 -0500
In-Reply-To: <a289d841-858d-5583-ce9a-8dc0f2d18a78@ti.com> (Kishon Vijay
        Abraham, I's message of "Wed, 16 Jan 2019 14:22:25 +0530")
Message-ID: <yq1imyoqaq0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9138 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=732
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901170015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kishon,

> On 12/01/19 4:31 AM, Evan Green wrote:
>> Expose a reset controller that the phy can use to perform its
>> initialization in a single callback.
>> 
>> Also, change the use of the phy functions from ufs-qcom such that
>> phy_poweron actually fires up the phy, and phy_poweroff actually
>> powers it down.
>> 
>> Signed-off-by: Evan Green <evgreen@chromium.org>
>
> Can I get Ack for this patch from SCSI MAINTAINERS?

No objection from me if there is general consensus that moving reset to
the phy is the right thing to do.

-- 
Martin K. Petersen	Oracle Linux Engineering
