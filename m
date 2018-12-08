Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AE2C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA6720868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TvTjW60i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA6720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbeLHClJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 21:41:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34742 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeLHClI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 21:41:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB82YFGu030286;
        Sat, 8 Dec 2018 02:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=q69DHhA+10LNdi++VBHYfVPULsStaw+rz3DQ1DHiGGk=;
 b=TvTjW60isFPWYD0hRAN5DFUqAzxAD1QoGsfJH/HRAUoIervdu341uRjeDnQa42bKEQnp
 isnFclqYzrRDV/RtDi+jk5YevBBkrBE7eiBK196Lx8RSTbVMeUjVATs8Pr6HYjZRMegz
 9gztcHUjJ1WUzMIM/lhUics0ePADsH5NWWAuZjmG+d3XicwV9IUHtIYn+ubn07zqaFYj
 022uayXDPCllUVKL/MV2wylQ9jrP5Y52psMlO14zAjN5i5G8E8XBfrzI92b2q0aywKtr
 u14Qxtls0sA0kigX/+UE7PQ8APrmlxKQjdub7EGlpIvWhtNd+1G8hN02uEM7H65rqjxb Wg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p3jxs0g0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Dec 2018 02:40:48 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB82ekjH007467
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Dec 2018 02:40:47 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB82ejpt001665;
        Sat, 8 Dec 2018 02:40:45 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Dec 2018 18:40:45 -0800
To:     Thomas Meyer <thomas@m3y3r.de>
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: megaraid_sas: NULL check before some freeing functions is not needed.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
        <1543760930052-918941928-10-diffsplit-thomas@m3y3r.de>
Date:   Fri, 07 Dec 2018 21:40:42 -0500
In-Reply-To: <1543760930052-918941928-10-diffsplit-thomas@m3y3r.de> (Thomas
        Meyer's message of "Sun, 02 Dec 2018 21:52:11 +0100")
Message-ID: <yq1h8fon3kl.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9100 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=532
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812080022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas,

> NULL check before some freeing functions is not needed.

Applied to 4.21/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
