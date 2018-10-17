Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24046C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3E4214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UdX+Sin8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3E4214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeJQJ1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:27:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55486 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbeJQJ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:27:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9H1YD4J128986;
        Wed, 17 Oct 2018 01:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=GrKAH/yG3vcpnvHiaK6AZDuAeOY78PYQLN568l3z2aM=;
 b=UdX+Sin8qCwKByWy77UQfyy6SmZQgwcyAYHgErBL/QW1XZDJ4/DwfcML7k2rpTKBbLOv
 GY/rMe/okDYsauBD1CiBR9qBnB80DY4vhE9Rf84Q5+2E0AcHo7z0F9dBvS7V3VK6PjEj
 D38E8kDCVQtfx7z6k4JDfJ3kxXH4shYGib5OuPSq4sW3n/QBfswOw/YRW2x7T+9HxIzO
 hJq7oRbBpbBiPG6gqMOMONyySUh/RHIb8GIvJVPyaFXNutx5ZU7xNuEBadRD/hsEN2Fy
 El1BVCODrcbPK9ko/yF1JPYPkEBXSw1UwYSsEXRTJup/UKy56+gGskzjJ0FdZvzklGdb CQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2n39brbxr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 01:34:13 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9H1Y6tM005284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 01:34:06 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9H1Y3fo010735;
        Wed, 17 Oct 2018 01:34:03 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Oct 2018 18:34:03 -0700
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <matthew@wil.cx>, <hare@suse.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH -next] advansys: use correct srb_tag in adv_isr_callback
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180926114107.13532-1-yuehaibing@huawei.com>
Date:   Tue, 16 Oct 2018 21:34:00 -0400
In-Reply-To: <20180926114107.13532-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Wed, 26 Sep 2018 19:41:07 +0800")
Message-ID: <yq1murdpd9z.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=5 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=5 mlxscore=5 mlxlogscore=127
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810170012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yue Haibing,

>  	srb_tag = le32_to_cpu(scsiqp->srb_tag);
> -	scp = scsi_host_find_tag(boardp->shost, scsiqp->srb_tag);
> +	scp = scsi_host_find_tag(boardp->shost, srb_tag);

Maybe I'm missing something, but I don't see where in the code
scsiqp->srb_tag is being converted to le32. srb_tag is beyond the memory
accessed by the controller and thus wouldn't need to be little endian.

-- 
Martin K. Petersen	Oracle Linux Engineering
