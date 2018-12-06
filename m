Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00012C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C4F20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a14vI2Q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C4F20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbeLFOME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:12:04 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48087 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbeLFOMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:12:03 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181206141200euoutp0162e1d842a61caf2a426b615b3a1ab52f~tw8o_6wfH2332023320euoutp01i;
        Thu,  6 Dec 2018 14:12:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181206141200euoutp0162e1d842a61caf2a426b615b3a1ab52f~tw8o_6wfH2332023320euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544105520;
        bh=lMLWrX+5Bsf84uPOArjJkoCJCh1Tz0mxK8Q0pSp56L4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=a14vI2Q+bZrsVnYud+XMK0jTtIZn7pVc0iiuake/EYdI7NbhaoITd/2tH4MnWuarj
         hp1VV7V30p7jJWwCy+46GkjOq5/b1vt54e4E+Ejn6NKVSJd0jRT7yECr8R8qU4ilC+
         mmr8UqT8SL1CzgDKkRXfv7bU6sJ7OSqbFGslHfsw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181206141159eucas1p2b3b19e805788d77562301acd5aad3c0c~tw8oRe9d13178231782eucas1p25;
        Thu,  6 Dec 2018 14:11:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9C.13.04441.F2E290C5; Thu,  6
        Dec 2018 14:11:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181206141159eucas1p2d8855194db968d33f30a82f0fe1ae638~tw8noC6oa3179831798eucas1p22;
        Thu,  6 Dec 2018 14:11:59 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-74-5c092e2fcdd2
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 11.69.04128.F2E290C5; Thu,  6
        Dec 2018 14:11:59 +0000 (GMT)
Received: from AMDC3748.DIGITAL.local ([106.120.43.17]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PJB009DDJFYZ760@eusync1.samsung.com>;
        Thu, 06 Dec 2018 14:11:59 +0000 (GMT)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: [PATCH] component: do not stop components lookup after first fail
Date:   Thu, 06 Dec 2018 15:11:47 +0100
Message-id: <20181206141147.15375-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7djPc7r6epwxBl29qha31p1jtdg4Yz2r
        RfPi9WwWl3fNYbM4NHUvo8XaI3fZLeZ+mcrswO5x+dpFZo9NqzrZPPbPXcPu0bdlFaPH501y
        AaxRXDYpqTmZZalF+nYJXBmrVq9mKtjKXrHv43bWBsZ+ti5GTg4JAROJX1u+A9lcHEICKxgl
        Wt/OZoJwPjNKXNl9gxmmqu3XJxaIxDJGiWs3e6Cq/jNKHGrZC1bFJqAp8XfzTbC5IgJxElv/
        LWIFKWIWeMAosWPJBLAiYQEvidcTP7CA2CwCqhIXL8xi72Lk4OAVsJC4cUkaYpu8xOoNB5hB
        eiUE3rJKfOi5wAqRcJFYfOEJC4QtLPHq+BZ2CFtG4vLkbqh4vUTTzCtQzR2MEicWL4f61Fri
        8PGLYIOYBfgkJm2bzgyyWEKAV6KjTQiixEOie8NHsHIhgViJf3euMk9glFjAyLCKUTy1tDg3
        PbXYMC+1XK84Mbe4NC9dLzk/dxMjMNJO/zv+aQfj10tJhxgFOBiVeHhfPGCPEWJNLCuuzD3E
        KMHBrCTCy6DHESPEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpiSWp2ampBahFMlomD
        U6qBUagp1vJ8zt3DWlOOSE1z+XVtRdGptaYzfjjUJei5/eo9Upz6brN1UKvn/nuKi7nKGdky
        KoXCbDSbP/yXOxj381tB05KXO94LatksnCG6WyeO5eP32xNmToiOVd1iHnVpOzcDo+yF7U8z
        3eRedIgLGfz7qybhLMY4oV7YefqcsFkXn3WpxTAsUmIpzkg01GIuKk4EAPRcSyuwAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHJMWRmVeSWpSXmKPExsVy+t/xy7r6epwxBm8OcFvcWneO1WLjjPWs
        Fs2L17NZXN41h83i0NS9jBZrj9xlt5j7ZSqzA7vH5WsXmT02repk89g/dw27R9+WVYwenzfJ
        BbBGcdmkpOZklqUW6dslcGWsWr2aqWAre8W+j9tZGxj72boYOTkkBEwk2n59Yuli5OIQEljC
        KHHr8iRmCKeRSeJjw0ewKjYBTYm/m28C2RwcIgJxEgv2lILUMAs8YJQ4f/kJI0iNsICXxOuJ
        H1hAbBYBVYmLF2axg9TzClhI3LgkDbFMXmL1hgPMExi5FjAyrGIUSS0tzk3PLTbSK07MLS7N
        S9dLzs/dxAgMhW3Hfm7Zwdj1LvgQowAHoxIP74sH7DFCrIllxZW5hxglOJiVRHgZ9DhihHhT
        EiurUovy44tKc1KLDzFKc7AoifOeN6iMEhJITyxJzU5NLUgtgskycXBKNTDac/f6T7TcKDHp
        C7fYbE9ZjRlr38U+vZvHkZfW6SvxSU3D/oFnq3V4YfiixXPPO9m0HX++/XvMsZz+X6fz9LPl
        xS2tFxz1mVperV7ssfBge3iheFzsneNnC5MM4379/BJYcjqm7tjD7C/vfmqe2N0ksul5hUvL
        3eicTUGxjUZPHy4RXc9+2kGJpTgj0VCLuag4EQD/AEWuAQIAAA==
X-CMS-MailID: 20181206141159eucas1p2d8855194db968d33f30a82f0fe1ae638
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181206141159eucas1p2d8855194db968d33f30a82f0fe1ae638
References: <CGME20181206141159eucas1p2d8855194db968d33f30a82f0fe1ae638@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently showing content of /sys/kernel/debug/device_component/*
works partially, in case one of the components is not available this and
all remaining components have status not-registered, but the problem
is only with the first one.
Allowing to finish lookup for other components in case one is missing
solves the issue.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/base/component.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index e8d676fad0c9..e9572b37d5cf 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -179,7 +179,7 @@ static int find_components(struct master *master)
 		c = find_component(master, mc->compare, mc->data);
 		if (!c) {
 			ret = -ENXIO;
-			break;
+			continue;
 		}
 
 		dev_dbg(master->dev, "found component %s, duplicate %u\n", dev_name(c->dev), !!c->master);
-- 
2.17.1

