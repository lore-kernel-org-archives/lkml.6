Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F52BECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CEE21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gvovrSQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CEE21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbeIRUmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:42:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42442 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbeIRUmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:42:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8IF4koB162109;
        Tue, 18 Sep 2018 15:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=669eREKKnk6r37HEedNqQHnRGDwd+drMKzScpG9b6s4=;
 b=gvovrSQs8gaiCtvqTxOn1gxDAh0vBmAVGZVfGSEk3SH1ZI6tRBgdfjxhSK5mydWGGrWx
 XZo8utEe7sX+g+8DGCVCHXnAmbo8oHNkrhJ53LgZ92l2ofIh+tSFtjvYLd4dExx9K3Dg
 AVlvDpQi52W+1Rgdc51I8+yA7k0iQ/JgX5kBOqxrBhewBTbHxm43A+cpu0yx3zsYcMH1
 MJSerPrwjkdAF1I8Rh3aGm6opNUHtFG5CMcO+rD8E8hyaQw0iki0RUg7Z/5SJslb7zez
 udc0HqeJ9MA2gsiHhmii/evnnH+BYhnWGQ8nFuy/D7UKH3LMBnKHC7bePrYqXomBBEJU fg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mgsgtn7hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 15:09:28 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8IF9RVT005948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 15:09:28 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8IF9REh025813;
        Tue, 18 Sep 2018 15:09:27 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Sep 2018 08:09:26 -0700
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, <martin.petersen@oracle.com>,
        <Don.Brace@microchip.com>, <don.brace@microsemi.com>,
        <jejb@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] scsi: Use vmemdup_user to replace the open code
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1534164200-28408-1-git-send-email-zhongjiang@huawei.com>
        <BYAPR11MB28555A88771594AA31AC7596E1390@BYAPR11MB2855.namprd11.prod.outlook.com>
        <5B7E9CCE.5010007@huawei.com> <5BA11315.4060908@huawei.com>
Date:   Tue, 18 Sep 2018 11:09:24 -0400
In-Reply-To: <5BA11315.4060908@huawei.com> (zhong jiang's message of "Tue, 18
        Sep 2018 23:00:37 +0800")
Message-ID: <yq11s9qrgez.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9019 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=411
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809180152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Zhong,

> Can you pick up the patch?

Please submit SCSI patches to linux-scsi@vger.kernel.org so they get
tracked in patchwork.

Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
