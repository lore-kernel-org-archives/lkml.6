Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B098DC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4952133F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nbVRQjSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4952133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbeLNLeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:34:22 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52277 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbeLNLeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:34:20 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181214113418euoutp0278c632b4c58f6b534acb6fdb63589afe~wL9PCw0Ne2204822048euoutp02i;
        Fri, 14 Dec 2018 11:34:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181214113418euoutp0278c632b4c58f6b534acb6fdb63589afe~wL9PCw0Ne2204822048euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544787258;
        bh=AKUsgv6gspXAloJymujKie5fq7hFCRFBHPM2TOJW0T4=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=nbVRQjSgjY2RUFDc+x5qoysZRJRxC9Zht/guYqsSSaoLxlo+vChlEDDnXJeBns3Yz
         I1LhIL1ECKBDZYFYmanvkSoNaiK7zPuxUCnyWtYVZWRpLmyKl7RhCx//oUS3lnE1M8
         P1/Y4dQWOhXmwM+WG8NjwQfP6W7HHCKQDxdNwcz8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181214113418eucas1p2ff658c4880042d855f26d9e0363ee681~wL9OlUefb1030910309eucas1p2V;
        Fri, 14 Dec 2018 11:34:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E2.59.04294.935931C5; Fri, 14
        Dec 2018 11:34:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181214113417eucas1p2624705c077ae79267082bbf4628951ed~wL9NvhCZz1806618066eucas1p2-;
        Fri, 14 Dec 2018 11:34:17 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-26-5c1395397274
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9B.D8.04284.935931C5; Fri, 14
        Dec 2018 11:34:17 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PJQ004655GZZA10@eusync3.samsung.com>;
        Fri, 14 Dec 2018 11:34:17 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/4] tty: serial: samsung: Properly set flags in autoCTS
 mode
Date:   Fri, 14 Dec 2018 12:34:08 +0100
Message-id: <20181214113410.22848-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181214113410.22848-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7djPc7qWU4VjDBb+MrLYOGM9q8XpT9vY
        LZoXr2ezOH9+A7vF/a9HGS0u75rDZjHj/D4mizOLe9kt1h65y25x+E07q8WMyS/ZHLg9Nq3q
        ZPO4c20Pm8f+uWvYPfq2rGL0+LxJLoA1issmJTUnsyy1SN8ugStj/o/17AVLuCqunFvM3MB4
        mqOLkZNDQsBE4t2CZ+xdjFwcQgIrGCVOv17HCuF8ZpSYueEME0zV9IfboaqWMUp8fvkFymlg
        kri9ajlYFZuAoUTX2y42EFtEIFni2dwjjCBFzAIPmSQ6Ln5jAUkIC/hL/G97BmazCKhKbOza
        CTSJg4NXwFZi32p5iG3yEqs3HGAGsTkF7CSObdkEtkxCYAWbxKFHn1ghilwk3k2ZwQhhC0u8
        Or6FHcKWkejsOMgE0dDMKNE+YxZUdw+jxNY5O9ggqqwlDh+/CDaJWYBPYtK26cwgV0gI8Ep0
        tAlBmB4S5xY7QHw5kVFi3YXVLBMYJRcwMqxiFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQI
        jNXT/45/2cG460/SIUYBDkYlHt6MSUIxQqyJZcWVuYcYJTiYlUR4w1qFY4R4UxIrq1KL8uOL
        SnNSiw8xSnOwKInzVjM8iBYSSE8sSc1OTS1ILYLJMnFwSjUwhtpnnzr2Z8MNt8T7+4z9fK/u
        2CE596/LundbmV5tTbzp8rRL8B+r7genOnaz4G/3OWoO6U52KlshMnFDd97dOYuvznGU2rFj
        3fYtyaofH4ocsn4kNWPZu2uzeTYo7IpU+ZR2XLdgs2iP4WX7dUZWTYK15+WN1gjK5fp1nb0n
        yP/Zvqr8xbFj6kosxRmJhlrMRcWJAKw8FWnRAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t/xq7qWU4VjDI4dE7TYOGM9q8XpT9vY
        LZoXr2ezOH9+A7vF/a9HGS0u75rDZjHj/D4mizOLe9kt1h65y25x+E07q8WMyS/ZHLg9Nq3q
        ZPO4c20Pm8f+uWvYPfq2rGL0+LxJLoA1issmJTUnsyy1SN8ugStj/o/17AVLuCqunFvM3MB4
        mqOLkZNDQsBEYvrD7exdjFwcQgJLGCUeNd5ggXCamCR6NvSygVSxCRhKdL3tArNFBJIldv19
        wQpSxCzwmEliSssLFpCEsICvxML2SUwgNouAqsTGrp1AYzk4eAVsJfatlofYJi+xesMBZhCb
        U8BO4tiWTewgthBQydfpXxgnMPIsYGRYxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERhk2479
        3LyD8dLG4EOMAhyMSjy8B6YIxQixJpYVV+YeYpTgYFYS4Q1rFY4R4k1JrKxKLcqPLyrNSS0+
        xCjNwaIkznveoDJKSCA9sSQ1OzW1ILUIJsvEwSnVwBhid7k3L8bz9CPmOY3Pc/zu/K75YCC4
        1fN+p2bR0ZaDZRc+LNqVsej/tbAv03Nkzqy2jg22vPxkfrfKQ2ktlw+vD4Ys5rvuxHEwuXCd
        /k+eBxO739jp7goqsP0n/9ey/MbJK3aljs8Mt/obf4k647w8xnOhX/TGdZWL7xw3Upuu7iJ7
        Kf1W9XolluKMREMt5qLiRAA3Ez3eLgIAAA==
X-CMS-MailID: 20181214113417eucas1p2624705c077ae79267082bbf4628951ed
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214113417eucas1p2624705c077ae79267082bbf4628951ed
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
        <CGME20181214113417eucas1p2624705c077ae79267082bbf4628951ed@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beomho Seo <beomho.seo@samsung.com>

Commit 391f93f2ec9f ("serial: core: Rework hw-assited flow control support")
has changed the way the autoCTS mode is handled.

According to that change, serial drivers which enable H/W autoCTS mode must
set UPSTAT_AUTOCTS to prevent the serial core from inadvertently disabling
TX. This patch adds proper handling of UPSTAT_AUTOCTS flag.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
[mszyprow: rephrased commit message]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/tty/serial/samsung.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index da1bd4bba8a9..2a49b6d876b8 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1365,11 +1365,14 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	wr_regl(port, S3C2410_ULCON, ulcon);
 	wr_regl(port, S3C2410_UBRDIV, quot);
 
+	port->status &= ~UPSTAT_AUTOCTS;
+
 	umcon = rd_regl(port, S3C2410_UMCON);
 	if (termios->c_cflag & CRTSCTS) {
 		umcon |= S3C2410_UMCOM_AFC;
 		/* Disable RTS when RX FIFO contains 63 bytes */
 		umcon &= ~S3C2412_UMCON_AFC_8;
+		port->status = UPSTAT_AUTOCTS;
 	} else {
 		umcon &= ~S3C2410_UMCOM_AFC;
 	}
-- 
2.17.1

