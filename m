Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7ABC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D317F2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T6j7Q8LR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D317F2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeK2LAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:00:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40960 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeK2LAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:00:15 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wASNsM2J175359;
        Wed, 28 Nov 2018 23:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=wwFzzGWpwxAbPnm2agQcDPNhkBySkCNV9hy9+YSIiAk=;
 b=T6j7Q8LRFXKAqhArFDit+b1oBHpbZIqyAcyJkA0XjPn1mxsor93EBswZMLtVd6UlukEF
 EpUfZhqTntx5Dyykra4LkbsrYboHNBXnx1Wa2cpJwXXaUWJd9hIQaDqX4nV5zQOCM+w0
 Qu7y26sb1VlqRy5VWsCHwvlOyHOa4H1r9OKL3IahpNjFQ8kFMB/YjPT2yUbgYZaf8lbd
 oSNYL763C40f4o9ufYgaaR74ePVB1Ocew8fEFlFud2WUNEKzVOrM9Sh5+p2xQcTeYfIZ
 x87ChtDFM/1t4NdN0pvI0RFqEmktOM+uBDF6Ve8A5aFlfswKtIsUfxkUXb/cvC3HVkjp gg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nxy9rd9tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 23:56:46 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wASNujSD012466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 23:56:45 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wASNuiY9005796;
        Wed, 28 Nov 2018 23:56:44 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Nov 2018 15:56:44 -0800
To:     Cathy Avery <cavery@redhat.com>
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hch@lst.de,
        jgill@vmware.com, emilne@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: vmw_pscsi: Rearrange code to avoid multiple calls to free_irq during unload
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1543346933-440-1-git-send-email-cavery@redhat.com>
Date:   Wed, 28 Nov 2018 18:56:41 -0500
In-Reply-To: <1543346933-440-1-git-send-email-cavery@redhat.com> (Cathy
        Avery's message of "Tue, 27 Nov 2018 14:28:53 -0500")
Message-ID: <yq14lc03gee.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=859
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Cathy,

> Currently pvscsi_remove calls free_irq more than once as
> pvscsi_release_resources and __pvscsi_shutdown both call
> pvscsi_shutdown_intr. This results in a 'Trying to free
> already-free IRQ' warning and stack trace. To solve the problem
> pvscsi_shutdown_intr has been moved out of pvscsi_release_resources.

Applied to 4.20/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
