Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C86C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7000221903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c0f5fT+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbeLUAuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 19:50:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40884 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732110AbeLUAut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 19:50:49 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBL0it4P072447;
        Fri, 21 Dec 2018 00:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=/rbeopccLGkyPguoaRSfb6tcj4+0yAkFzC/RMd/KK2o=;
 b=c0f5fT+VGXHViub3Mtm0lDcTdCJOk9ZVuARx9aQ2qDg9E5SrJ0U9Lq7mq70Bimmah8aM
 fuIeLuLMRA5e/yStnNFR/rt+b5ccyt3e2/JChmJRyxKU9jaJa9IkcSxOGjJryiyRgPE0
 rOuKPuFY5rTaIxVKQt4pWI54FXuWD3ImZR4s+22ZkRBNhqnus4nmvtdENMFiRoG+zCij
 gG+qnMmUEP52RszNGW8omIgAESKbqnEdtMWcbbjIbRWYUF+1YMg1ysyZ9wlLki+hE276
 OzbgiUnzttQNdgxEXbGRMuccO7GtVWtrVLsDsrbB4MYvIpIk+yZaAqqpidsWuEShwxix VA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2pfn200ve1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 00:50:40 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBL0ocfQ030453
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 00:50:38 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBL0obPl023427;
        Fri, 21 Dec 2018 00:50:37 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Dec 2018 16:50:37 -0800
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        thenzl@redhat.com, hch@lst.de, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] megaraid: fix out-of-bound array accesses
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181206212252.36732-1-cai@lca.pw>
        <20181213132727.57058-1-cai@lca.pw>
Date:   Thu, 20 Dec 2018 19:50:34 -0500
In-Reply-To: <20181213132727.57058-1-cai@lca.pw> (Qian Cai's message of "Thu,
        13 Dec 2018 08:27:27 -0500")
Message-ID: <yq1va3nbt45.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9113 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=27 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=564
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812210003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Qian,

> UBSAN reported those with MegaRAID SAS-3 3108,

Applied to 4.21/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
