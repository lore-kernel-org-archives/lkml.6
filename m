Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3022BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED63121582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Sj62++nW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED63121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbeKOPN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:13:59 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41095 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeKOPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:13:58 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181115050739euoutp023eab5ebcf506070356f6b48684a59f08~nM_XlEOyX0729607296euoutp02Y;
        Thu, 15 Nov 2018 05:07:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181115050739euoutp023eab5ebcf506070356f6b48684a59f08~nM_XlEOyX0729607296euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542258459;
        bh=5LRIQh9YHvh62I5JA0g7iDNlkANNGmFUQHYraxvpNoU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Sj62++nWhqtzDaZaUW9Gm1n0RMTAAySAQyp4Qg9by2BZrNxAD27/shjga9G/Axytd
         oaMS6pdF7/1jHuHMrmfu9spreX+eM9M9U+88+ytklaqNq++W7iDJQ9gD0cQ55WU5yV
         vmu8IyVkE2TjqMxDhYgoEn96crfHqzlTmufvqbMk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181115050739eucas1p2b9f9bcfc189627e216e40de1444f9f45~nM_XQww-r0053400534eucas1p2e;
        Thu, 15 Nov 2018 05:07:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C9.D5.04806.B1FFCEB5; Thu, 15
        Nov 2018 05:07:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181115050737eucas1p104ccec527d0713f9414bc75e0959feb6~nM_VcPYZ_0711807118eucas1p1i;
        Thu, 15 Nov 2018 05:07:37 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-99-5becff1bdd30
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 97.81.04128.91FFCEB5; Thu, 15
        Nov 2018 05:07:37 +0000 (GMT)
Received: from localhost.localdomain ([10.88.99.240]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PI7001RJY8JV850@eusync1.samsung.com>; Thu, 15 Nov
        2018 05:07:37 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Huijin Park <huijin.park@samsung.com>, bbanghj.park@gmail.com
Subject: [PATCH v2] mtd: spi-nor: cast to u64 to avoid uint overflows
Date:   Thu, 15 Nov 2018 00:07:29 -0500
Message-id: <1542258449-19930-1-git-send-email-huijin.park@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7djPc7rS/99EGzQc5bN4ufcQs8W+U/0s
        Fh0XXSwu75rDZrG7aRm7xdE995gd2Dzmran22DnrLrvH5iX1Hn1bVjF6fN4kF8AaxWWTkpqT
        WZZapG+XwJXR8eMCc0ELR8XhnytZGhgfsXUxcnJICJhI3NjYzNLFyMUhJLCCUeLC4VWsEM5n
        RonpHy+xwlR9bOhlhEgsY5T4/vkklPOXUWLdqXfsIFVsAtoS19duZQSxRQQMJVZObQGbyyyw
        nFHi3YkZYAlhAVeJbYe2MIHYLAKqElsOLgA6hIODV8Bd4nezPcQ2OYmb5zqZQXolBB6ySrR9
        ngx1rIvE9RMzoGxhiVfHt7BD2DISlyd3s0DY2RK/HrWygMyUEKiQeDtPBSJsLPHu7VpmEJtZ
        gE9i0rbpzBAlvBIdbUIQJR4SKx9tALtMSCBWYmHLH5YJjBILGBlWMYqnlhbnpqcWG+ellusV
        J+YWl+al6yXn525iBEbV6X/Hv+5g3Pcn6RCjAAejEg/vDY830UKsiWXFlbmHGCU4mJVEeBfU
        AIV4UxIrq1KL8uOLSnNSiw8xSnOwKInzVjM8iBYSSE8sSc1OTS1ILYLJMnFwSjUwVtpfz7/n
        5MWfoyu+4rmS5puqr1uZynVVu1MbWjaEC1pdjzy8cc7OJN+f2wwt9srcmL7GyHb1XK+P+erP
        jrduFDKYkv9k6qXFRQt1OwSeBh8QrhBbb/m88f3+paJ2r/dfmGZSbMbGFeb60C2xrzxKN/lQ
        irKe5a9NrFf0OOzj7Wt9X0RFL/qoxFKckWioxVxUnAgA0R7Sq6YCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGJMWRmVeSWpSXmKPExsVy+t/xy7qS/99EG6zYJGLxcu8hZot9p/pZ
        LDouulhc3jWHzWJ30zJ2i6N77jE7sHnMW1PtsXPWXXaPzUvqPfq2rGL0+LxJLoA1issmJTUn
        syy1SN8ugSuj48cF5oIWjorDP1eyNDA+Yuti5OSQEDCR+NjQy9jFyMUhJLCEUWLxqtmsEM5/
        RonXL++wgFSxCWhLXF+7lRHEFhEwlFg5tQUsziywnFHiwhUbEFtYwFVi26EtTCA2i4CqxJaD
        C4A2cHDwCrhL/G62h1gmJ3HzXCfzBEauBYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJ9
        v+3Yzy07GLveBR9iFOBgVOLhPWH1JlqINbGsuDL3EKMEB7OSCO+CGqAQb0piZVVqUX58UWlO
        avEhRmkOFiVx3vMGlVFCAumJJanZqakFqUUwWSYOTqkGxkimvyUhFduqz4nEPs35prRgw8kL
        b0ulz0ftF471jX/2Uspvyyv/Ux/OXd/Spjtt4ubUtCu2ml83yO6MqfqZPsv19ptjrj5+37Ot
        3p9PeRg9p83vnKbzYWvJNet+Tn0T6j1l6zSVmI5HAX/2xgWEt8Y5fDbV3Ly7WsbqUfnX37WL
        J80Pii94w63EUpyRaKjFXFScCADPDZtj+QEAAA==
X-CMS-MailID: 20181115050737eucas1p104ccec527d0713f9414bc75e0959feb6
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181115050737eucas1p104ccec527d0713f9414bc75e0959feb6
References: <CGME20181115050737eucas1p104ccec527d0713f9414bc75e0959feb6@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huijin.park" <huijin.park@samsung.com>

The "params->size" is defined as "u64".
And "info->sector_size" and "info->n_sectors" are defined as
unsigned int and u16.
Thus, u64 data might have strange data(loss data) if the result
overflows an unsigned int.
This patch casts "info->sector_size" and "info->n_sectors" to an u64.

Signed-off-by: huijin.park <huijin.park@samsung.com>
---
 drivers/mtd/spi-nor/spi-nor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d9c368c..527f281 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2459,7 +2459,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	memset(params, 0, sizeof(*params));
 
 	/* Set SPI NOR sizes. */
-	params->size = info->sector_size * info->n_sectors;
+	params->size = (u64)info->sector_size * (u64)info->n_sectors;
 	params->page_size = info->page_size;
 
 	/* (Fast) Read settings. */
-- 
1.7.9.5

