Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243F2ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF08A2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF08A2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbeITHae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:30:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731366AbeITHae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:30:34 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C9DCDF80D2F6B;
        Thu, 20 Sep 2018 09:49:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 09:49:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Paul Mackerras" <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-serial@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] tty: serial: remove set but not used variable 'error'
Date:   Thu, 20 Sep 2018 01:59:16 +0000
Message-ID: <1537408756-196431-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/tty/serial/pmac_zilog.c: In function 'pmz_receive_chars':
drivers/tty/serial/pmac_zilog.c:222:30: warning:
 variable 'error' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/tty/serial/pmac_zilog.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index a4ec22d..a9d4098 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -219,7 +219,7 @@ static void pmz_interrupt_control(struct uart_pmac_port *uap, int enable)
 static bool pmz_receive_chars(struct uart_pmac_port *uap)
 {
 	struct tty_port *port;
-	unsigned char ch, r1, drop, error, flag;
+	unsigned char ch, r1, drop, flag;
 	int loops = 0;
 
 	/* Sanity check, make sure the old bug is no longer happening */
@@ -231,7 +231,6 @@ static bool pmz_receive_chars(struct uart_pmac_port *uap)
 	port = &uap->port.state->port;
 
 	while (1) {
-		error = 0;
 		drop = 0;
 
 		r1 = read_zsreg(uap, R1);
@@ -273,7 +272,6 @@ static bool pmz_receive_chars(struct uart_pmac_port *uap)
 		uap->port.icount.rx++;
 
 		if (r1 & (PAR_ERR | Rx_OVR | CRC_ERR | BRK_ABRT)) {
-			error = 1;
 			if (r1 & BRK_ABRT) {
 				pmz_debug("pmz: got break !\n");
 				r1 &= ~(PAR_ERR | CRC_ERR);

