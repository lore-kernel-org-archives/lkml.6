Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96E5C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8D9208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LJ03/EK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8D9208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeJPL3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 07:29:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42528 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeJPL3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 07:29:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9G3cejP019329;
        Tue, 16 Oct 2018 03:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=oPDNqahVt0C+FUTeERe8AqUQVv424rVBipOZaVXmxG4=;
 b=LJ03/EK1j93G4Mvz0wllbPSClZRU0zKqbmGxe6txOi0hBcIUTmJFGf5q53M21e9FecU9
 yK8rMeyrki0Ksbs+M+fOxCdaKh/G/fQM2uE6CnclonmtyT4oPA9HYlyaNYvko5+lqSKu
 +s/Ic7AnWVTL5uqNeRDTurj9bc3GNboetcLaFqxokrlRn4qKOVYflOIjPw5kUZ+Yrd6n
 8kCXAfFa/QCyfLeFFJQRaSGo1CKLQKzf8Sab1XP9q5PWR3LLhjgcbvmMqyZHaRzduITm
 VUMnhpyCIhdgmFhgpOOfhzN0aMj2KKENsn8umEyaTG7oG6kQRmHIHT/DmI3znySKItfW KA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n39br5u4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 03:41:10 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9G3fAqQ013301
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 03:41:10 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9G3f9lL019698;
        Tue, 16 Oct 2018 03:41:09 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Oct 2018 20:41:08 -0700
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Wei Li <liwei213@huawei.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>
Subject: Re: [RESEND][PATCH] scsi: ufs: Fix hynix ufs bug with quirk on hi36xx SoC
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1538434698-1042-1-git-send-email-john.stultz@linaro.org>
Date:   Mon, 15 Oct 2018 23:41:06 -0400
In-Reply-To: <1538434698-1042-1-git-send-email-john.stultz@linaro.org> (John
        Stultz's message of "Mon, 1 Oct 2018 15:58:18 -0700")
Message-ID: <yq17eiiwobx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=779
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> Hynix ufs has deviations on hi36xx platform which will result in ufs
> bursts transfer failures.

Is this specific to the particular implementation on hi36xx or all SK
Hynix implementations?

> +	UFS_FIX(UFS_VENDOR_SKHYNIX, UFS_ANY_MODEL,
> +		UFS_DEVICE_QUIRK_HOST_VS_DEBUGSAVECONFIGTIME),

I am not so keen on matching on all current and future models.

-- 
Martin K. Petersen	Oracle Linux Engineering
