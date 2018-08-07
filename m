Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6301C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA932151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA932151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404471AbeHGVMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:12:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33908 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732347AbeHGVMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:12:07 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 31A44D14;
        Tue,  7 Aug 2018 18:56:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stewart Smith <stewart@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 11/85] hvc_opal: dont set tb_ticks_per_usec in udbg_init_opal_common()
Date:   Tue,  7 Aug 2018 20:51:13 +0200
Message-Id: <20180807172357.778317977@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stewart Smith <stewart@linux.ibm.com>

[ Upstream commit 447808bf500a7cc92173266a59f8a494e132b122 ]

time_init() will set up tb_ticks_per_usec based on reality.
time_init() is called *after* udbg_init_opal_common() during boot.

from arch/powerpc/kernel/time.c:
  unsigned long tb_ticks_per_usec = 100; /* sane default */

Currently, all powernv systems have a timebase frequency of 512mhz
(512000000/1000000 == 0x200) - although there's nothing written
down anywhere that I can find saying that we couldn't make that
different based on the requirements in the ISA.

So, we've been (accidentally) thwacking the (currently) correct
(for powernv at least) value for tb_ticks_per_usec earlier than
we otherwise would have.

The "sane default" seems to be adequate for our purposes between
udbg_init_opal_common() and time_init() being called, and if it isn't,
then we should probably be setting it somewhere that isn't hvc_opal.c!

Signed-off-by: Stewart Smith <stewart@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/hvc/hvc_opal.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -337,7 +337,6 @@ static void udbg_init_opal_common(void)
 	udbg_putc = udbg_opal_putc;
 	udbg_getc = udbg_opal_getc;
 	udbg_getc_poll = udbg_opal_getc_poll;
-	tb_ticks_per_usec = 0x200; /* Make udelay not suck */
 }
 
 void __init hvc_opal_init_early(void)


