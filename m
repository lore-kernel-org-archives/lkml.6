Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE699C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE39B21738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C1qAtII0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfBTAak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:30:40 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33508 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbfBTAaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:30:39 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1K0OETo099996;
        Wed, 20 Feb 2019 00:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=6qp06mEP2j4d1IHMOjTQwoeB7xkMftoXiYjoQNED7As=;
 b=C1qAtII0Ni4yV/YRTgxe93KX+MCd9Yrl6HW2Ev/cmjk/kj5bhvlHxjnlV9rFN3EYHuCi
 mT4kq1jCvHaOsoNnXwYKTucDxXqp9G+Ho5pRX2pMqOKJWfneFI3OWiT+hr8vcc+spq3e
 xbFLP6e4Wb87mbgQ0Mz1RO8yefP7A+nBQoeUMKy8XZFevl/1XPsHRNDrbSW+V67m1rxE
 +KSjkt0nTQ+YxAaMIXms89VnXMN3+Qq3R5LOkGlC5tkY+6/WIU9haDIGg4SD+j/JW2Rk
 uoGarU3+xASqhhmGyaigp3+48hcQw2p9tGQimOmbvkRH/jUEkh82C9zGzN/jZ1gq0cK/ uw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qp81e6ruy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 00:30:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1K0UZle010516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 00:30:35 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1K0UYh3022456;
        Wed, 20 Feb 2019 00:30:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Feb 2019 16:30:34 -0800
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v4 3/3] scsi: ufs-bsg: Allow reading descriptors
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1548572868-12589-1-git-send-email-avri.altman@wdc.com>
        <1548572868-12589-4-git-send-email-avri.altman@wdc.com>
        <CAE=gft6mLsW-iEBZ9pFRWWyDQz_gCs20_4JBoBzxL1tYv0rbYg@mail.gmail.com>
        <SN6PR04MB49259233067FBEC4AFA35963FC680@SN6PR04MB4925.namprd04.prod.outlook.com>
        <yq1bm3nzmmu.fsf@oracle.com>
        <SN6PR04MB4925FBBBAC3356886A02F46FFC7C0@SN6PR04MB4925.namprd04.prod.outlook.com>
Date:   Tue, 19 Feb 2019 19:30:31 -0500
In-Reply-To: <SN6PR04MB4925FBBBAC3356886A02F46FFC7C0@SN6PR04MB4925.namprd04.prod.outlook.com>
        (Avri Altman's message of "Tue, 19 Feb 2019 11:44:27 +0000")
Message-ID: <yq1pnrnjo7s.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=646 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Avri,

> A kind reminder.

It's expired from patchwork so now is an excellent time to repost.

Generally speaking, resubmitting patches is superior to pinging. While I
personally dig through the archives to revisit older patches, I can
almost guarantee that no other potential reviewers will do the same. The
best way to get a patch back on people's radar is to repost it.

-- 
Martin K. Petersen	Oracle Linux Engineering
