Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146D8C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC88120892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zit6uncD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC88120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbeLNLeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:34:37 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38136 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNLeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:34:20 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181214113419euoutp01ce202c09a08d450a78507e47c3fbfa69~wL9Ph1LzR0527705277euoutp01U;
        Fri, 14 Dec 2018 11:34:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181214113419euoutp01ce202c09a08d450a78507e47c3fbfa69~wL9Ph1LzR0527705277euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544787259;
        bh=jvAUlilNmzd+AU7UdE4TPhi5W8/jx5JGRVZQCh47OGo=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Zit6uncDILQkdVRZrspaXi7NO8I1BnKEHmEgVc5AnsLfFWHyTv2UdO64ucVzHmi39
         yRDSsewxzKLeIw9wFizIEwJkJmxrLS34daO3BHhfC+8K2olrqGqoH+2sha2DQ8UGdg
         phbjHBi/GEf8yCV05l2Euls6/o5o0LuWFzmykmaA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181214113418eucas1p23008a61b8b3951444b32157ecbc15a10~wL9PEqZkN0065800658eucas1p2I;
        Fri, 14 Dec 2018 11:34:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DF.27.04441.A35931C5; Fri, 14
        Dec 2018 11:34:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181214113418eucas1p2bfb6f0d04010e73f6ca35c3a6664b316~wL9OYpndm2195821958eucas1p2S;
        Fri, 14 Dec 2018 11:34:18 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-4d-5c13953a858b
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6C.D8.04284.935931C5; Fri, 14
        Dec 2018 11:34:18 +0000 (GMT)
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
Subject: [PATCH 3/4] tty: serial: samsung: Increase maximum baudrate
Date:   Fri, 14 Dec 2018 12:34:09 +0100
Message-id: <20181214113410.22848-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181214113410.22848-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7djPc7pWU4VjDLa2yVtsnLGe1eL0p23s
        Fs2L17NZnD+/gd3i/tejjBaXd81hs5hxfh+TxZnFvewWa4/cZbc4/Kad1WLG5JdsDtwem1Z1
        snncubaHzWP/3DXsHn1bVjF6fN4kF8AaxWWTkpqTWZZapG+XwJXR9uAtS8FqjoonH9eyNzC2
        sHcxcnJICJhItM4/zdTFyMUhJLCCUWLxhrfsEM5nRoneudMYYarOzJgMZgsJLGOUeH3cH6Ko
        gUni9qrlTCAJNgFDia63XWwgtohAssSzuUcYQYqYBR4ySXRc/MYCkhAWcJE43NUGVsQioCrx
        c+9asDt4BWwlHszqZ4LYJi+xesMBZhCbU8BO4tiWTWAnSQgsYZOYeLwN6iQXiQ9NR1ggbGGJ
        V8e3QD0kI9HZcZAJoqGZUaJ9xiyo7h5Gia1zdrBBVFlLHD5+kRXEZhbgk5i0bTrQOg6gOK9E
        R5sQRImHxJdX3WwQf05klPi7qpVtAqPkAkaGVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmb
        GIHRevrf8U87GL9eSjrEKMDBqMTDmzFJKEaINbGsuDL3EKMEB7OSCG9Yq3CMEG9KYmVValF+
        fFFpTmrxIUZpDhYlcd5qhgfRQgLpiSWp2ampBalFMFkmDk6pBsYdRx3/ODImHw3RuJoWd4bv
        3VTTR2WNTrmr1fninBf1zS0L2iu13jp3/dW0n4uULpYtDu47uJJRYXPUCrn2WT9/q7g4Mv0o
        sYifz/+yQWuqxr/57jt1RMXe+kes5uxPe7jq+rPpRWZ8gfrPyhun/PA8eWdSfs8K05ubPmlM
        2vZOtFSt3vbgwSYlluKMREMt5qLiRACSK1j20gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsVy+t/xq7pWU4VjDFb1MFpsnLGe1eL0p23s
        Fs2L17NZnD+/gd3i/tejjBaXd81hs5hxfh+TxZnFvewWa4/cZbc4/Kad1WLG5JdsDtwem1Z1
        snncubaHzWP/3DXsHn1bVjF6fN4kF8AaxWWTkpqTWZZapG+XwJXR9uAtS8FqjoonH9eyNzC2
        sHcxcnJICJhInJkxmbGLkYtDSGAJo8S+e11QThOTRM+GXjaQKjYBQ4mut11gtohAssSuvy9Y
        QYqYBR4zSUxpecECkhAWcJE43NUGVsQioCrxc+9asBW8ArYSD2b1M0Gsk5dYveEAM4jNKWAn
        cWzLJrAaIaCar9O/ME5g5FnAyLCKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMMy2Hfu5eQfj
        pY3BhxgFOBiVeHgPTBGKEWJNLCuuzD3EKMHBrCTCG9YqHCPEm5JYWZValB9fVJqTWnyIUZqD
        RUmc97xBZZSQQHpiSWp2ampBahFMlomDU6qBcZZu1JZt7zIyXjqc3PJ+602eTqn0lizp/MVb
        f94W2LpoxuLobZ//aPzKd39ho6X5wkjkdmqSj47pxvcuLzLS9h28pBkjmqFZq/GRb+eK3JVL
        q1amX3abd2Dx0sPTVJRXus+5aOV9TGzByXW8r6cwLjFvZK2r0nn83ieb//p1/Zbj3AXfvjx8
        oaTEUpyRaKjFXFScCABIe2pDLwIAAA==
X-CMS-MailID: 20181214113418eucas1p2bfb6f0d04010e73f6ca35c3a6664b316
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214113418eucas1p2bfb6f0d04010e73f6ca35c3a6664b316
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
        <CGME20181214113418eucas1p2bfb6f0d04010e73f6ca35c3a6664b316@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seung-Woo Kim <sw0312.kim@samsung.com>

This driver can be used to communicate with Bluetooth chip in high-speed
UART mode, so increase the maximum baudrate to 3Mbps.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
[mszyprow: rephrased commit message]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/tty/serial/samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 2a49b6d876b8..9fc3559f80d9 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1287,7 +1287,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	 * Ask the core to calculate the divisor for us.
 	 */
 
-	baud = uart_get_baud_rate(port, termios, old, 0, 115200*8);
+	baud = uart_get_baud_rate(port, termios, old, 0, 3000000);
 	quot = s3c24xx_serial_getclk(ourport, baud, &clk, &clk_sel);
 	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST)
 		quot = port->custom_divisor;
-- 
2.17.1

