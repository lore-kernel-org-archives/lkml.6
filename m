Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DB4ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BEC21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VYDopYxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BEC21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeJRI7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:59:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41384 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeJRI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:59:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9I109nv130767;
        Thu, 18 Oct 2018 01:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=7dt1x6KECeiQ/Wp8AWdh90If0ZXe41zzWCYCpUVs0bs=;
 b=VYDopYxwcgZuEWIDoZDNEG3OgFChdmtOHcKpwinmbEe9BrgdrRKHKrTpLusrLwvfG2ND
 HJmFL+2MzNGl7PE+tOXVOJmJuZKr+4vQeqhet4DiVb3gpgVhnB8fjkcS9xNJdSGO9vTP
 XBLztm2cnjBgMm89u8xuVKaIv8Oo4aAV4+H3fWT2BHj7sVLFPMSfdCTjg3/Ch7dg3Vso
 JB8F1tl6xYJgWvcjMb474LrVnS39lymaEKOx2oB0f67U/K/BnHmvO7f3hUaSjPiyImBR
 ew4/XOl41M7JkBayZqXibvHK1IpNFKlL0c0YiJWh2UZWUE7/dRFbVKdQWBBH8vJGAPxe 9w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2n384uaadt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 01:01:10 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9I114kY021739
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 01:01:04 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9I113Wn001056;
        Thu, 18 Oct 2018 01:01:04 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Oct 2018 18:01:03 -0700
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ips: fix missing break in switch
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181016091223.GA19765@embeddedor.com>
        <yq1ftx5sgw1.fsf@oracle.com>
        <alpine.LNX.2.21.1810170922480.130@nippy.intranet>
        <yq1r2gppdyf.fsf@oracle.com>
        <alpine.LNX.2.21.1810171327290.8@nippy.intranet>
Date:   Wed, 17 Oct 2018 21:01:01 -0400
In-Reply-To: <alpine.LNX.2.21.1810171327290.8@nippy.intranet> (Finn Thain's
        message of "Wed, 17 Oct 2018 14:24:47 +1100 (AEDT)")
Message-ID: <yq1tvlkkr02.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9049 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=605
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810180008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Finn,

>> See the case statements above for another fast exit scenario.
>> 
>
> But that's an error path.

Look further down. Several other SCSI commands are completed as NOPs the
same way.

Also, I don't see how the case statement for TUR/INQUIRY would do
anything meaningful in terms of preparing a START STOP UNIT for the
firmware.

-- 
Martin K. Petersen	Oracle Linux Engineering
