Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE9CC46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597112075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WBll5ADx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597112075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbeJXLgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:36:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59118 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeJXLgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:36:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9O39YlB144604;
        Wed, 24 Oct 2018 03:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=EXmYwreS8zoKhJkKwNpLxH8fTN75MG0mDN4uE9R13qk=;
 b=WBll5ADxfeQYI1pWt1aPV4gE2tfGpGt4E+R2Tf+4AZwET1VhQ/FHD40415MNRzxHJGoy
 LoiHN84Cb03qHtUHEwY6yC60PZXmzVQvnN16FOUGk1eWri/kfzDhFaVgy+VdVR08+dHj
 NNeDa75PJoeyjcD704Doohlolu2PGrMts3+tAdUg4OtNPwMSG6mBsSMIgFW6In5iKlCI
 TtrQOhBEzWKC+48oY0RVS16O99eP3Kih/onse7eKGCbpLOH6Jb+H8I0dzFEYZ/CxTCNM
 nXXRqOsYLopoVYMg7i/T+UBhtTXkAoShYbCqt5V+MS/HW4w5A/hRuIY1GOij8qVK/gZ9 ww== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2n7usu8w68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 03:09:58 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9O39vn4005414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 03:09:57 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9O39uYx002194;
        Wed, 24 Oct 2018 03:09:56 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 20:09:56 -0700
To:     John Stultz <john.stultz@linaro.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Wei Li <liwei213@huawei.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>
Subject: Re: [RFC][PATCH v2] scsi: ufs: Fix hynix ufs bug with quirk on hi36xx SoC
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1540254710-26936-1-git-send-email-john.stultz@linaro.org>
        <yq1d0s0f4cm.fsf@oracle.com>
        <CALAqxLX7d8adR6x14EbdhySE1SuoeFwxj6BFG=zitUKZEs75Tg@mail.gmail.com>
Date:   Tue, 23 Oct 2018 23:09:53 -0400
In-Reply-To: <CALAqxLX7d8adR6x14EbdhySE1SuoeFwxj6BFG=zitUKZEs75Tg@mail.gmail.com>
        (John Stultz's message of "Tue, 23 Oct 2018 20:02:36 -0700")
Message-ID: <yq14ldcf3b2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=573
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> Ok. Yea, I saw something similar in the qcom code, but I wasn't sure
> if folks would want host specific quirks isolated to host code.

Yeah, that's why I thought it would be good for the UFS folks to chime
in.

-- 
Martin K. Petersen	Oracle Linux Engineering
