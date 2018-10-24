Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5FDC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2481220651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hB2267xQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2481220651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeJXLNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:13:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42064 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJXLNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:13:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9O2ikwq128584;
        Wed, 24 Oct 2018 02:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=i1VOWOkgi2lYOaz4JEox1jTgNt1yJ/q6gaiwdQbttE0=;
 b=hB2267xQqM1LzPL5Ua0UtXWiHh/FUX1O7rPbh26G5tgCf69qloMEpgtVHELRSLU3/ZDZ
 CtOzYaXW/kj02TNqedt5q3EXiv62mDHAz0Gq59LirqwvIB4PzYSpRFMA336qfVn+e+Ft
 fs7fEcWJ7PoLQCzG86xQbiNsoFzxR2fvn0SJK5a2X3TWTgDFpAtCl65nJOOy6ZbTSZKu
 ooa7je/QfgcT9CTE7OoRSRLAYSGTdnG2xlUq5ub6kwd+ElpKRzIWWxri1FHqmu9HWYj/
 b8t0w0k2d/5l1mEjE6VoU/ZzuoVw89l/Px1rqqwqfD75yg1ummt6X26t0YUSSkbIEih0 mA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2n7usu8ujj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 02:47:26 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9O2lO2S021896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 02:47:25 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9O2lNMB016702;
        Wed, 24 Oct 2018 02:47:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 19:47:23 -0700
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Wei Li <liwei213@huawei.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>
Subject: Re: [RFC][PATCH v2] scsi: ufs: Fix hynix ufs bug with quirk on hi36xx SoC
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1540254710-26936-1-git-send-email-john.stultz@linaro.org>
Date:   Tue, 23 Oct 2018 22:47:21 -0400
In-Reply-To: <1540254710-26936-1-git-send-email-john.stultz@linaro.org> (John
        Stultz's message of "Mon, 22 Oct 2018 17:31:50 -0700")
Message-ID: <yq1d0s0f4cm.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=745
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

Thanks for tweaking this.

> Not sure if this is the preferred way of scoping the quirk to
> the controller or not. Feedback would be greatly appreciated!

I think my preference would be to add:

       UFS_FIX(UFS_VENDOR_SKHYNIX, "hB8aL1",
                UFS_DEVICE_QUIRK_HOST_VS_DEBUG),

to ufs_fixups[] and then key off of that in the driver. That's how we do
it in SCSI but the UFS folks may have a different opinion.

-- 
Martin K. Petersen	Oracle Linux Engineering
