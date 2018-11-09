Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436ECC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB06D20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mOtM/6gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB06D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbeKIMIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:08:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52132 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbeKIMIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:08:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA92TahP050782;
        Fri, 9 Nov 2018 02:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=iYIasrzaWFmQrXYARrdfIrbhfC9Z27/vGkaT8CIuk94=;
 b=mOtM/6ghUnMtmWpBJJm3IIvp/RdZZVbHNkaEFJo/FYWtcRGl1Py1Ipqoc2/0nCM8eQcn
 KP/YizL3MZtL6s7JXzZwJjJhcAL/+ZUAUSpiRHGbH9i3csNYmG2b1vUU4loi85zyEhgC
 5ijdHG3/S0RDL7liJ0XboIEMbMjRydOr1da5qPWXsIRN7KdstyO26SetZKD+sGm/hM8O
 0/u3GqwKoyrUU+Ir/+Eb24pnjhlhCvI53+eA2IItDDkyI2oTOgz8uwQ7RUuenkMAzGkB
 7kgm/9JRhTREgHnYzy2lzUWywQGNoSqIoUIxID18wW518TlQFvZ/HG0NErrqxDSO7nLw Rg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2nh3mq4sm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Nov 2018 02:29:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA92TZRU021235
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Nov 2018 02:29:35 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA92TYjj027327;
        Fri, 9 Nov 2018 02:29:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Nov 2018 18:29:34 -0800
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Wei Li <liwei213@huawei.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>
Subject: Re: [RESEND][PATCH v3] scsi: ufs: Fix hynix ufs bug with quirk on hi36xx SoC
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1541696909-31620-1-git-send-email-john.stultz@linaro.org>
Date:   Thu, 08 Nov 2018 21:29:24 -0500
In-Reply-To: <1541696909-31620-1-git-send-email-john.stultz@linaro.org> (John
        Stultz's message of "Thu, 8 Nov 2018 09:08:29 -0800")
Message-ID: <yq1pnvfvv97.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9071 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=525
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811090021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> Hynix ufs has deviations on hi36xx platform which will result in ufs
> bursts transfer failures.

Applied to 4.20/scsi-fixes. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
