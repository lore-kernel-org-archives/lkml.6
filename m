Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E475C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F41121902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498881;
	bh=Xy79+Y0swae0Jrq7l+QmWyptXY+iZ1NxFtDND5jcjoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xPtFN3TuvQrqtElxnGR9aDgeqjCnBrtnWmMs+ZsdK8FYOs1BMeC12aJgb0hHRd+aW
	 pPZ8NRFSmaL+OaxHpRZvYhRSF0Lii0S85L6l3HMyeOGe60pR4hSg4mK0m+hgRD8kki
	 PsEWarHPKmR84KLsT+nV0D59q0V3tUPod46XiSNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390828AbfBROIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:08:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390808AbfBROHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:07:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA9E221902;
        Mon, 18 Feb 2019 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498874;
        bh=Xy79+Y0swae0Jrq7l+QmWyptXY+iZ1NxFtDND5jcjoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NfjtA0DhmrsNZj6KsoHTUEPrjBQl70IbTfI12zi4wOQ5rdburXkZcSgbPIJ8nNYbM
         oYzMtqV+8mFgKnF4d6yEXXUsD1PALZldJ7QnAZUje/sHf4TyBBTAcnp87e9+pXY4HJ
         uzXG8aeOVnrEG2eymmxZjCK8m/t+T8170L0tfm6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 130/143] Input: bma150 - register input device after setting private data
Date:   Mon, 18 Feb 2019 14:44:18 +0100
Message-Id: <20190218133533.737543498@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Bakker <xc-racer2@live.ca>

commit 90cc55f067f6ca0e64e5e52883ece47d8af7b67b upstream.

Otherwise we introduce a race condition where userspace can request input
before we're ready leading to null pointer dereference such as

input: bma150 as /devices/platform/i2c-gpio-2/i2c-5/5-0038/input/input3
Unable to handle kernel NULL pointer dereference at virtual address 00000018
pgd = (ptrval)
[00000018] *pgd=55dac831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] PREEMPT ARM
Modules linked in: bma150 input_polldev [last unloaded: bma150]
CPU: 0 PID: 2870 Comm: accelerometer Not tainted 5.0.0-rc3-dirty #46
Hardware name: Samsung S5PC110/S5PV210-based board
PC is at input_event+0x8/0x60
LR is at bma150_report_xyz+0x9c/0xe0 [bma150]
pc : [<80450f70>]    lr : [<7f0a614c>]    psr: 800d0013
sp : a4c1fd78  ip : 00000081  fp : 00020000
r10: 00000000  r9 : a5e2944c  r8 : a7455000
r7 : 00000016  r6 : 00000101  r5 : a7617940  r4 : 80909048
r3 : fffffff2  r2 : 00000000  r1 : 00000003  r0 : 00000000
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 54e34019  DAC: 00000051
Process accelerometer (pid: 2870, stack limit = 0x(ptrval))
Stackck: (0xa4c1fd78 to 0xa4c20000)
fd60:                                                       fffffff3 fc813f6c
fd80: 40410581 d7530ce3 a5e2817c a7617f00 a5e29404 a5e2817c 00000000 7f008324
fda0: a5e28000 8044f59c a5fdd9d0 a5e2945c a46a4a00 a5e29668 a7455000 80454f10
fdc0: 80909048 a5e29668 a5fdd9d0 a46a4a00 806316d0 00000000 a46a4a00 801df5f0
fde0: 00000000 d7530ce3 a4c1fec0 a46a4a00 00000000 a5fdd9d0 a46a4a08 801df53c
fe00: 00000000 801d74bc a4c1fec0 00000000 a4c1ff70 00000000 a7038da8 00000000
fe20: a46a4a00 801e91fc a411bbe0 801f2e88 00000004 00000000 80909048 00000041
fe40: 00000000 00020000 00000000 dead4ead a6a88da0 00000000 ffffe000 806fcae8
fe60: a4c1fec8 00000000 80909048 00000002 a5fdd9d0 a7660110 a411bab0 00000001
fe80: dead4ead ffffffff ffffffff a4c1fe8c a4c1fe8c d7530ce3 20000013 80909048
fea0: 80909048 a4c1ff70 00000001 fffff000 a4c1e000 00000005 00026038 801eabd8
fec0: a7660110 a411bab0 b9394901 00000006 a696201b 76fb3000 00000000 a7039720
fee0: a5fdd9d0 00000101 00000002 00000096 00000000 00000000 00000000 a4c1ff00
ff00: a6b310f4 805cb174 a6b310f4 00000010 00000fe0 00000010 a4c1e000 d7530ce3
ff20: 00000003 a5f41400 a5f41424 00000000 a6962000 00000000 00000003 00000002
ff40: ffffff9c 000a0000 80909048 d7530ce3 a6962000 00000003 80909048 ffffff9c
ff60: a6962000 801d890c 00000000 00000000 00020000 a7590000 00000004 00000100
ff80: 00000001 d7530ce3 000288b8 00026320 000288b8 00000005 80101204 a4c1e000
ffa0: 00000005 80101000 000288b8 00026320 000288b8 000a0000 00000000 00000000
ffc0: 000288b8 00026320 000288b8 00000005 7eef3bac 000264e8 00028ad8 00026038
ffe0: 00000005 7eef3300 76f76e91 76f78546 800d0030 000288b8 00000000 00000000
[<80450f70>] (input_event) from [<a5e2817c>] (0xa5e2817c)
Code: e1a08148 eaffffa8 e351001f 812fff1e (e590c018)
---[ end trace 1c691ee85f2ff243 ]---

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/misc/bma150.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -482,13 +482,14 @@ static int bma150_register_input_device(
 	idev->close = bma150_irq_close;
 	input_set_drvdata(idev, bma150);
 
+	bma150->input = idev;
+
 	error = input_register_device(idev);
 	if (error) {
 		input_free_device(idev);
 		return error;
 	}
 
-	bma150->input = idev;
 	return 0;
 }
 
@@ -511,15 +512,15 @@ static int bma150_register_polled_device
 
 	bma150_init_input_device(bma150, ipoll_dev->input);
 
+	bma150->input_polled = ipoll_dev;
+	bma150->input = ipoll_dev->input;
+
 	error = input_register_polled_device(ipoll_dev);
 	if (error) {
 		input_free_polled_device(ipoll_dev);
 		return error;
 	}
 
-	bma150->input_polled = ipoll_dev;
-	bma150->input = ipoll_dev->input;
-
 	return 0;
 }
 


