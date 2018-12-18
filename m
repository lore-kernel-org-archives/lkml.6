Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEB4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFF2214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nvn1dIgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeLRIVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:21:37 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50880 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRIVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:21:36 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBI8J21X049407;
        Tue, 18 Dec 2018 08:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=Vg98UVBL9wjw/2YDWYfUFH0iQHJcgDQcIIxZzb40BA0=;
 b=Nvn1dIgKI8HnYnjZTWwBSe7c4GygyVT4go1OmxcbtQ7HJJvxVMnyQrHA1D4s5+hMykyO
 V4mBqSu1mpUTfdYaQj5Eqp5F0QeRGdyg26/KsmcNmF0vnC5jZl9WMYrtuUY4jGc3z8sT
 aQpaTYYe9Ye29o6kMHwZp9Ur8zNyTxkorzfNXnHP3RBCM/rvsAdiztp7efNG9ie2YMf9
 5NDi7TWczGA4zdf4AY14+hCkrc6uYgMk2hkjH84cj93h2nULgStR9ifP6SldbXMInQYz
 XjthQQsZcZwnqf2t7Ojms1pgxMnN9unIMzCe4GmZeQ5dRmC9U+Megv2dYOyo8YKgVm49 ug== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2pcq4dsvv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 08:21:30 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBI8LUsJ000528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 08:21:30 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBI8LUcM002921;
        Tue, 18 Dec 2018 08:21:30 GMT
Received: from kadam (/197.157.0.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Dec 2018 00:21:29 -0800
Date:   Tue, 18 Dec 2018 11:21:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Timur Tabi <timur@freescale.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Mihai Caraman <mihai.caraman@freescale.com>,
        Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/2] fsl_hypervisor: prevent integer overflow in ioctl
Message-ID: <20181218082129.GE32567@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218082003.GD32567@kadam>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9110 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=814
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "param.count" value is a u64 thatcomes from the user.  The code
later in the function assumes that param.count is at least one and if
it's not then it leads to an Oops when we dereference the ZERO_SIZE_PTR.

Also the addition can have an integer overflow which would lead us to
allocate a smaller "pages" array than required.  I can't immediately
tell what the possible run times implications are, but it's safest to
prevent the overflow.

Fixes: 6db7199407ca ("drivers/virt: introduce Freescale hypervisor management driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/virt/fsl_hypervisor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index 7b7f8e9a2801..1bbd910d4ddb 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -215,6 +215,9 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 	 * hypervisor.
 	 */
 	lb_offset = param.local_vaddr & (PAGE_SIZE - 1);
+	if (param.count == 0 ||
+	    param.count > U64_MAX - lb_offset - PAGE_SIZE + 1)
+		return -EINVAL;
 	num_pages = (param.count + lb_offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	/* Allocate the buffers we need */
-- 
2.17.1

