Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C78ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C805E20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pN3mQq9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C805E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbeGTCvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:51:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39002 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeGTCvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:51:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6K23aUx158467;
        Fri, 20 Jul 2018 02:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=OQDjLhjdbwS16ZCrq3o0MYgdqIHJNnmqBjSf+msb/I0=;
 b=pN3mQq9d+urpOnvxMPuCYTR98CM/FkW4mx0Dm7U4BuJ0/gFpAMpReRU768bEOUxZr8Mu
 jJavEaUDWcim3eBvPJY1T5ONmZKAyYeb9egYQroAzCshsVqASxZNHR4OEPODM6qnKGPx
 cU05HilKYrO17pH2bFDY6QsfUqZmMEh75xFmIj2QFegl/OaIlbU0ZoCveatqTeE37aS1
 Vq+zjrlcbzfMNVNbSemiH1Mvk4TKMGxt47O5bWnj+pRsNlh4gwPgHjBdsmbxSQkqwKt6
 e0Kq8K3AgHSBm4UrBL6Zfg0rCQJMTEOcBprLtDHTRbXWomReIfredm7mk2R6jxr4rWdO Uw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2k9yjx9e4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jul 2018 02:04:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6K24YHn007031
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jul 2018 02:04:34 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6K24TjA018763;
        Fri, 20 Jul 2018 02:04:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 19:04:29 -0700
To:     Li Wei <liwei213@huawei.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <khilman@baylibre.com>,
        <arnd@arndb.de>, <gregory.clement@free-electrons.com>,
        <thomas.petazzoni@free-electrons.com>,
        <yamada.masahiro@socionext.com>, <riku.voipio@linaro.org>,
        <treding@nvidia.com>, <krzk@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <zangleigang@hisilicon.com>,
        <gengjianfeng@hisilicon.com>, <sunzhaosheng@hisilicon.com>,
        <ian.rickards@arm.com>, <guodong.xu@linaro.org>,
        <puck.chen@hisilicon.com>, <john.stultz@linaro.org>,
        <fengbaopeng@hisilicon.com>
Subject: Re: [PATCH v11 0/4] [RESEND] scsi: ufs: add ufs driver code for Hisilicon Hi3660 SoC
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180717093659.103263-1-liwei213@huawei.com>
Date:   Thu, 19 Jul 2018 22:04:24 -0400
In-Reply-To: <20180717093659.103263-1-liwei213@huawei.com> (Li Wei's message
        of "Tue, 17 Jul 2018 17:36:55 +0800")
Message-ID: <yq1r2jy8xxz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8959 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=525
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807200022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Li,

> This patchset adds driver support for UFS for Hi3660 SoC. It is
> verified on HiKey960 board.

Applied to 4.19/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
